// generate_logo.js — Wasel Nalut Brand Logo & App Icon Generator
import fs from 'fs';

const svgLogo = `<svg width="512" height="512" viewBox="0 0 512 512" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="512" height="512" rx="112" fill="url(#paint0_linear)"/>
  <path d="M160 200L256 120L352 200V360C352 377.673 337.673 392 320 392H192C174.327 392 160 377.673 160 360V200Z" fill="#0F172A"/>
  <path d="M210 280L240 310L302 248" stroke="#E23744" stroke-width="24" stroke-linecap="round" stroke-linejoin="round"/>
  <circle cx="256" cy="120" r="24" fill="#FF6600"/>
  <defs>
    <linearGradient id="paint0_linear" x1="0" y1="0" x2="512" y2="512" gradientUnits="userSpaceOnUse">
      <stop stop-color="#E23744"/>
      <stop offset="1" stop-color="#FF6600"/>
    </linearGradient>
  </defs>
</svg>`;

fs.writeFileSync('wasel_logo.svg', svgLogo);
console.log('✅ Wasel Nalut brand logo and app icon generated as wasel_logo.svg');
