import React from "react";

interface FlagIconProps {
  country: string;
  className?: string;
}

export const FlagIcon: React.FC<FlagIconProps> = ({ country, className = "" }) => {
  const baseClass = `inline-block rounded-sm shadow-sm ${className}`;

  switch (country) {
    case "tr":
      return (
        <svg viewBox="0 0 30 20" className={baseClass} style={{ width: 28, height: 18 }}>
          <rect width="30" height="20" fill="#E30A17" />
          <circle cx="10.5" cy="10" r="4" fill="none" stroke="#FFFFFF" strokeWidth="1.4" />
          <path
            d="M14.5 10 L18.2 7.8 L17.3 10 L18.2 12.2 Z"
            fill="#FFFFFF"
          />
        </svg>
      );
    case "az":
      return (
        <svg viewBox="0 0 30 20" className={baseClass} style={{ width: 28, height: 18 }}>
          <rect width="30" height="6.67" fill="#0098c3" />
          <rect y="6.67" width="30" height="6.66" fill="#e1251b" />
          <rect y="13.33" width="30" height="6.67" fill="#00ae65" />
          <circle cx="15" cy="10" r="2.5" fill="none" stroke="#FFFFFF" strokeWidth="0.8" />
          <path d="M16.8 10 L19.5 8.3 L18.8 10 L19.5 11.7 Z" fill="#FFFFFF" />
        </svg>
      );
    case "kz":
      return (
        <svg viewBox="0 0 30 20" className={baseClass} style={{ width: 28, height: 18 }}>
          <rect width="30" height="20" fill="#00afca" />
          <circle cx="15" cy="7" r="2.5" fill="#fec50c" />
          <path d="M13 12 Q15 10 17 12 Q15 14 13 12" fill="#fec50c" />
        </svg>
      );
    case "kg":
      return (
        <svg viewBox="0 0 30 20" className={baseClass} style={{ width: 28, height: 18 }}>
          <rect width="30" height="20" fill="#e8112d" />
          <circle cx="15" cy="10" r="4" fill="#ffef00" />
          <path d="M15 7 L15.8 9.2 L18 9.2 L16.2 10.6 L16.8 12.8 L15 11.4 L13.2 12.8 L13.8 10.6 L12 9.2 L14.2 9.2 Z" fill="#e8112d" />
        </svg>
      );
    case "uz":
      return (
        <svg viewBox="0 0 30 20" className={baseClass} style={{ width: 28, height: 18 }}>
          <rect width="30" height="6.67" fill="#1eb53a" />
          <rect y="6.67" width="30" height="6.66" fill="#ffffff" />
          <rect y="13.33" width="30" height="6.67" fill="#0099b5" />
          <rect y="8.5" width="30" height="1" fill="#e1251b" opacity="0.6" />
          <rect y="10.5" width="30" height="1" fill="#e1251b" opacity="0.6" />
          <circle cx="7" cy="8" r="1.5" fill="none" stroke="#ffffff" strokeWidth="0.4" />
          <path d="M8 8 L9.5 7.2 L9 8 L9.5 8.8 Z" fill="#ffffff" />
        </svg>
      );
    case "tm":
      return (
        <svg viewBox="0 0 30 20" className={baseClass} style={{ width: 28, height: 18 }}>
          <rect width="30" height="20" fill="#00843d" />
          <rect x="6" width="1" height="20" fill="#e1251b" />
          <circle cx="19" cy="10" r="2.5" fill="none" stroke="#ffffff" strokeWidth="0.7" />
          <path d="M20.5 10 L22.5 9 L21.8 10 L22.5 11 Z" fill="#ffffff" />
        </svg>
      );
    default:
      return (
        <span className={className} role="img" aria-label={country}>
          {country}
        </span>
      );
  }
};
