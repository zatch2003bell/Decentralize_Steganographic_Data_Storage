# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

<ToastContainer
position="top-center"
autoClose={4823}
hideProgressBar={false}
newestOnTop={false}
closeOnClick={false}
rtl={false}
pauseOnFocusLoss
draggable
pauseOnHover
theme="dark"
transition={Zoom}
/>

toast.success('🦄 Wow so easy!', {
position: "top-center",
autoClose: 4823,
hideProgressBar: false,
closeOnClick: false,
pauseOnHover: true,
draggable: true,
progress: ,
theme: "dark",
transition: Zoom,
});

'use client';
import type { Variants } from 'motion/react';
import { motion, useAnimation } from 'motion/react';
import type { HTMLAttributes } from 'react';
import { forwardRef, useCallback, useImperativeHandle, useRef } from 'react';
import { cn } from '@/lib/utils';

export interface ArrowRightIconHandle {
startAnimation: () => void;
stopAnimation: () => void;
}

interface ArrowRightIconProps extends HTMLAttributes<HTMLDivElement> {
size?: number;
}

const pathVariants: Variants = {
normal: { d: 'M5 12h14' },
animate: {
d: ['M5 12h14', 'M5 12h9', 'M5 12h14'],
transition: {
duration: 0.4,
},
},
};

const secondaryPathVariants: Variants = {
normal: { d: 'm12 5 7 7-7 7', translateX: 0 },
animate: {
d: 'm12 5 7 7-7 7',
translateX: [0, -3, 0],
transition: {
duration: 0.4,
},
},
};

const ArrowRightIcon = forwardRef<ArrowRightIconHandle, ArrowRightIconProps>(
({ onMouseEnter, onMouseLeave, className, size = 28, ...props }, ref) => {
const controls = useAnimation();
const isControlledRef = useRef(false);

    useImperativeHandle(ref, () => {
      isControlledRef.current = true;

      return {
        startAnimation: () => controls.start('animate'),
        stopAnimation: () => controls.start('normal'),
      };
    });

    const handleMouseEnter = useCallback(
      (e: React.MouseEvent<HTMLDivElement>) => {
        if (!isControlledRef.current) {
          controls.start('animate');
        } else {
          onMouseEnter?.(e);
        }
      },
      [controls, onMouseEnter]
    );

    const handleMouseLeave = useCallback(
      (e: React.MouseEvent<HTMLDivElement>) => {
        if (!isControlledRef.current) {
          controls.start('normal');
        } else {
          onMouseLeave?.(e);
        }
      },
      [controls, onMouseLeave]
    );

    return (
      <div
        className={cn(
          `cursor-pointer select-none p-2 hover:bg-accent rounded-md transition-colors duration-200 flex items-center justify-center`,
          className
        )}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
        {...props}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width={size}
          height={size}
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          strokeLinecap="round"
          strokeLinejoin="round"
        >
          <motion.path
            d="M5 12h14"
            variants={pathVariants}
            animate={controls}
          />
          <motion.path
            d="m12 5 7 7-7 7"
            variants={secondaryPathVariants}
            animate={controls}
          />
        </svg>
      </div>
    );

}
);

ArrowRightIcon.displayName = 'ArrowRightIcon';

export { ArrowRightIcon };

npx shadcn@latest add "https://icons.pqoqubbw.dev/c/arrow-right.json"

npm install react-icons --save
