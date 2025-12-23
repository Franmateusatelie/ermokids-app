import { useEffect } from "react";

export default function App() {
  useEffect(() => {
    document.body.style.margin = "0";
    document.body.style.padding = "0";
    document.body.style.overflow = "hidden";
  }, []);

  return (
    <iframe
      title="ErmoKids App"
      src="https://aventura-petandia-copy-76f74cfd.base44.app"
      style={{
        border: "none",
        width: "100vw",
        height: "100vh",
      }}
      allow="autoplay; fullscreen"
    />
  );
}


