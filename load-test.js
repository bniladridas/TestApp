import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '2m', target: 100 }, // Ramp up to 100 users over 2 minutes
    { duration: '5m', target: 100 }, // Stay at 100 users for 5 minutes
    { duration: '2m', target: 200 }, // Ramp up to 200 users over 2 minutes
    { duration: '5m', target: 200 }, // Stay at 200 users for 5 minutes
    { duration: '2m', target: 0 }, // Ramp down to 0 users over 2 minutes
  ],
  thresholds: {
    http_req_duration: ['p(99)<1500'], // 99% of requests should be below 1.5s
    http_req_failed: ['rate<0.1'], // Error rate should be below 10%
  },
};

const BASE_URL = 'http://localhost:3001';

export default function () {
  // Health check
  let response = http.get(`${BASE_URL}/api/health`);
  check(response, { 'health check status is 200': (r) => r.status === 200 });

  // Simulate user signup (if needed)
  // Note: In real load testing, you might want to create test users or use existing ones

  // Simulate AI chat request
  let payload = JSON.stringify({
    message: 'Hello, how are you?',
  });

  let headers = {
    'Content-Type': 'application/json',
    // Add authorization header if needed
    // 'Authorization': 'Bearer ' + token,
  };

  response = http.post(`${BASE_URL}/api/ask-test-ai`, payload, { headers });
  check(response, {
    'AI chat status is 200': (r) => r.status === 200,
    'response time < 2000ms': (r) => r.timings.duration < 2000,
  });

  sleep(1); // Wait 1 second between iterations
}
