Return-Path: <netdev+bounces-16365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C474CEA6
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C5D1C209BC
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCEEA949;
	Mon, 10 Jul 2023 07:39:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F88837
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:39:07 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758EE55;
	Mon, 10 Jul 2023 00:38:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-682a5465e9eso616244b3a.1;
        Mon, 10 Jul 2023 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974732; x=1691566732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba+ud/bJX6+UuWaPNLfdYg9gMAViu7WzsURm7s3i/Pg=;
        b=EFbQDbnhug51h9KKjoZJ6DB1f2fsNMJsRufU7Z3Ld3xIXzU62rvvpz9EIJ/JBY0gtm
         qwXOUhowF7IgfQ15l7/QRJQrps/EgPX9dMKpb1HyFjBnjBkJStzyHTI4yre+c0LfguNF
         w2XhUyB3y1mem5dss4DYyzzFBKkCALDPBzjzQtUhGLl2Uya0Wge4jS3ke0YIa0u6peWw
         P5GbziIGlAoke7XZuWQACEx6vNbqxscCFNPGVi5HVxKVxm/59QjyQQIaOaLqWQDKBoDB
         pUid9t3DeDCKbP4ndBXjqWyiuOJExPKWwIzQeo2tlkNuVIvePcJ7dOwEisekE6xulYri
         NZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974732; x=1691566732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba+ud/bJX6+UuWaPNLfdYg9gMAViu7WzsURm7s3i/Pg=;
        b=AsDB5IXFB2l9HYzQ+E/L1b8MOkaGnZ7thgWwL3hofCQ+HnleLL6aF0fGpJO6n/Vncv
         NlKEiHCYNFBJV9jaEE2aWwqCd21stt7rvffws6Df7l1eOGrf/+xLxB4n7nhsRFHgp0E2
         Pz3KMkD/hnViZBqNkKXeKcTp14Z+D7PLRUvJ4pPt8u4Bc5qPXzYggi+fkirJP3bMoSh0
         prAGOycCpfHYTCk7mhyWZxpfsR21Y1P1n+QwbycLx9HyrfGzOZt0ssO1mAVuQx85DnF6
         9yZSmA8Mw/dAlq+bHiSLoHIfS1MyXEF8LheON3X4KydgJlLZ3WA9VPn+fdI72Lxs80Ru
         mh2A==
X-Gm-Message-State: ABy/qLa4Ge7l6F+Gs4MGRZ9EfEG2DjMqUZzAyax2OFyJedu9Ypmnd9Ja
	nY9dyE4OufLluPTicuP5Clv+5O7unHvPCA==
X-Google-Smtp-Source: APBJJlGVDh+uOTvpbLfWf2miYm1whjndxXzlFX6rmxpp2SWFOjqYZ4gLgOsQgd6Egjwkm0ZYi8a4cA==
X-Received: by 2002:a05:6a00:3387:b0:675:8627:a291 with SMTP id cm7-20020a056a00338700b006758627a291mr12242820pfb.3.1688974731893;
        Mon, 10 Jul 2023 00:38:51 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r20-20020a62e414000000b0063f2a5a59d1sm6514483pfh.190.2023.07.10.00.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:38:51 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew@lunn.ch,
	aliceryhl@google.com,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH v2 1/5] rust: core abstractions for network device drivers
Date: Mon, 10 Jul 2023 16:36:59 +0900
Message-Id: <20230710073703.147351-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710073703.147351-1-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds very basic abstractions to implement network device
drivers, corresponds to the kernel's net_device and net_device_ops
structs with support for register_netdev/unregister_netdev functions.

allows the const_maybe_uninit_zeroed feature for
core::mem::MaybeUinit::<T>::zeroed() in const function.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |  16 ++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/net.rs              |   5 +
 rust/kernel/net/dev.rs          | 330 ++++++++++++++++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/dev.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..468bf606f174 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,8 @@
  */
 
 #include <linux/errname.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index bb594da56137..70d50767ff4e 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,10 +24,26 @@
 #include <linux/errname.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
 
+#ifdef CONFIG_NET
+void *rust_helper_netdev_priv(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_netdev_priv);
+
+void rust_helper_skb_tx_timestamp(struct sk_buff *skb)
+{
+	skb_tx_timestamp(skb);
+}
+EXPORT_SYMBOL_GPL(rust_helper_skb_tx_timestamp);
+#endif
+
 __noreturn void rust_helper_BUG(void)
 {
 	BUG();
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..fc7d048d359d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -13,6 +13,7 @@
 
 #![no_std]
 #![feature(allocator_api)]
+#![feature(const_maybe_uninit_zeroed)]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
@@ -34,6 +35,8 @@
 pub mod error;
 pub mod init;
 pub mod ioctl;
+#[cfg(CONFIG_NET)]
+pub mod net;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
new file mode 100644
index 000000000000..28fe8f398463
--- /dev/null
+++ b/rust/kernel/net.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Networking core.
+
+pub mod dev;
diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
new file mode 100644
index 000000000000..fe20616668a9
--- /dev/null
+++ b/rust/kernel/net/dev.rs
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Network device.
+//!
+//! C headers: [`include/linux/etherdevice.h`](../../../../include/linux/etherdevice.h),
+//! [`include/linux/ethtool.h`](../../../../include/linux/ethtool.h),
+//! [`include/linux/netdevice.h`](../../../../include/linux/netdevice.h),
+//! [`include/linux/skbuff.h`](../../../../include/linux/skbuff.h),
+//! [`include/uapi/linux/if_link.h`](../../../../include/uapi/linux/if_link.h).
+
+use crate::{bindings, build_error, error::*, prelude::vtable, types::ForeignOwnable};
+use {core::ffi::c_void, core::marker::PhantomData};
+
+/// Corresponds to the kernel's `struct net_device`.
+///
+/// # Invariants
+///
+/// The `ptr` points to the contiguous memory for `struct net_device` and a pointer,
+/// which stores an address returned by `ForeignOwnable::into_foreign()`.
+pub struct Device<D: ForeignOwnable + Send + Sync> {
+    ptr: *mut bindings::net_device,
+    _p: PhantomData<D>,
+}
+
+impl<D: ForeignOwnable + Send + Sync> Device<D> {
+    /// Creates a new [`Device`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` must point to the contiguous memory
+    /// for `struct net_device` and a pointer, which stores an address returned
+    /// by `ForeignOwnable::into_foreign()`.
+    unsafe fn from_ptr(ptr: *mut bindings::net_device) -> Self {
+        // INVARIANT: The safety requirements ensure the invariant.
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Gets the private data of a device driver.
+    pub fn drv_priv_data(&self) -> D::Borrowed<'_> {
+        // SAFETY: The type invariants guarantee that self.ptr is valid and
+        // bindings::netdev_priv(self.ptr) returns a pointer that stores an address
+        // returned by `ForeignOwnable::into_foreign()`.
+        unsafe {
+            D::borrow(core::ptr::read(
+                bindings::netdev_priv(self.ptr) as *const *const c_void
+            ))
+        }
+    }
+}
+
+// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
+// from any thread. `struct net_device` stores a pointer to an object, which is `Sync`
+// so it's safe to sharing its pointer.
+unsafe impl<D: ForeignOwnable + Send + Sync> Send for Device<D> {}
+// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
+// from any thread. `struct net_device` stores a pointer to an object, which is `Sync`,
+// can be used from any thread too.
+unsafe impl<D: ForeignOwnable + Send + Sync> Sync for Device<D> {}
+
+/// Registration structure for a network device driver.
+///
+/// This allocates and owns a `struct net_device` object.
+/// Once the `net_device` object is registered via `register_netdev` function,
+/// the kernel calls various functions such as `struct net_device_ops` operations with
+/// the `net_device` object.
+///
+/// A driver must implement `struct net_device_ops` so the trait for it is tied.
+/// Other operations like `struct ethtool_ops` are optional.
+pub struct Registration<T: DeviceOperations> {
+    dev: Device<T>,
+    is_registered: bool,
+    _p: PhantomData<T>,
+}
+
+impl<T: DeviceOperations> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants of `Device` guarantee that `self.dev.ptr` is valid and
+        // bindings::netdev_priv(self.ptr) returns a pointer that stores an address
+        // returned by `ForeignOwnable::into_foreign()`.
+        unsafe {
+            let _ = T::from_foreign(core::ptr::read(
+                bindings::netdev_priv(self.dev.ptr) as *const *const c_void
+            ));
+        }
+        // SAFETY: The type invariants of `Device` guarantee that `self.dev.ptr` is valid.
+        unsafe {
+            if self.is_registered {
+                bindings::unregister_netdev(self.dev.ptr);
+            }
+            bindings::free_netdev(self.dev.ptr);
+        }
+    }
+}
+
+impl<T: DeviceOperations> Registration<T> {
+    /// Creates a new [`Registration`] instance for ethernet device.
+    ///
+    /// A device driver can pass private data.
+    pub fn try_new_ether(tx_queue_size: u32, rx_queue_size: u32, data: T) -> Result<Self> {
+        // SAFETY: Just an FFI call with no additional safety requirements.
+        let ptr = unsafe {
+            bindings::alloc_etherdev_mqs(
+                core::mem::size_of::<*const c_void>() as i32,
+                tx_queue_size,
+                rx_queue_size,
+            )
+        };
+        if ptr.is_null() {
+            return Err(code::ENOMEM);
+        }
+
+        // SAFETY: It's safe to write an address returned pointer
+        // from `netdev_priv()` because `alloc_etherdev_mqs()` allocates
+        // contiguous memory for `struct net_device` and a pointer.
+        unsafe {
+            let priv_ptr = bindings::netdev_priv(ptr) as *mut *const c_void;
+            core::ptr::write(priv_ptr, data.into_foreign());
+        }
+
+        // SAFETY: `ptr` points to contiguous memory for `struct net_device` and a pointer,
+        // which stores an address returned by `ForeignOwnable::into_foreign()`.
+        let dev = unsafe { Device::from_ptr(ptr) };
+        Ok(Registration {
+            dev,
+            is_registered: false,
+            _p: PhantomData,
+        })
+    }
+
+    /// Returns a network device.
+    ///
+    /// A device driver normally configures the device before registration.
+    pub fn dev_get(&mut self) -> &mut Device<T> {
+        &mut self.dev
+    }
+
+    /// Registers a network device.
+    pub fn register(&mut self) -> Result {
+        if self.is_registered {
+            return Err(code::EINVAL);
+        }
+        // SAFETY: The type invariants guarantee that `self.dev.ptr` is valid.
+        let ret = unsafe {
+            (*self.dev.ptr).netdev_ops = &Self::DEVICE_OPS;
+            bindings::register_netdev(self.dev.ptr)
+        };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            self.is_registered = true;
+            Ok(())
+        }
+    }
+
+    const DEVICE_OPS: bindings::net_device_ops = bindings::net_device_ops {
+        ndo_init: if <T>::HAS_INIT {
+            Some(Self::init_callback)
+        } else {
+            None
+        },
+        ndo_uninit: if <T>::HAS_UNINIT {
+            Some(Self::uninit_callback)
+        } else {
+            None
+        },
+        ndo_open: if <T>::HAS_OPEN {
+            Some(Self::open_callback)
+        } else {
+            None
+        },
+        ndo_stop: if <T>::HAS_STOP {
+            Some(Self::stop_callback)
+        } else {
+            None
+        },
+        ndo_start_xmit: if <T>::HAS_START_XMIT {
+            Some(Self::start_xmit_callback)
+        } else {
+            None
+        },
+        // SAFETY: The rest is zeroed out to initialize `struct net_device_ops`,
+        // set `Option<&F>` to be `None`.
+        ..unsafe { core::mem::MaybeUninit::<bindings::net_device_ops>::zeroed().assume_init() }
+    };
+
+    unsafe extern "C" fn init_callback(netdev: *mut bindings::net_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
+            let dev = unsafe { Device::from_ptr(netdev) };
+            T::init(dev)?;
+            Ok(0)
+        })
+    }
+
+    unsafe extern "C" fn uninit_callback(netdev: *mut bindings::net_device) {
+        // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
+        let dev = unsafe { Device::from_ptr(netdev) };
+        T::uninit(dev);
+    }
+
+    unsafe extern "C" fn open_callback(netdev: *mut bindings::net_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
+            let dev = unsafe { Device::from_ptr(netdev) };
+            T::open(dev)?;
+            Ok(0)
+        })
+    }
+
+    unsafe extern "C" fn stop_callback(netdev: *mut bindings::net_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
+            let dev = unsafe { Device::from_ptr(netdev) };
+            T::stop(dev)?;
+            Ok(0)
+        })
+    }
+
+    unsafe extern "C" fn start_xmit_callback(
+        skb: *mut bindings::sk_buff,
+        netdev: *mut bindings::net_device,
+    ) -> bindings::netdev_tx_t {
+        // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
+        let dev = unsafe { Device::from_ptr(netdev) };
+        // SAFETY: The C API guarantees that `skb` is valid until a driver releases the skb.
+        let skb = unsafe { SkBuff::from_ptr(skb) };
+        T::start_xmit(dev, skb) as bindings::netdev_tx_t
+    }
+}
+
+// SAFETY: `Registration` exposes only `Device` object which can be used from any thread.
+unsafe impl<T: DeviceOperations> Send for Registration<T> {}
+// SAFETY: `Registration` exposes only `Device` object which can be used from any thread.
+unsafe impl<T: DeviceOperations> Sync for Registration<T> {}
+
+/// Corresponds to the kernel's `enum netdev_tx`.
+#[repr(i32)]
+pub enum TxCode {
+    /// Driver took care of packet.
+    Ok = bindings::netdev_tx_NETDEV_TX_OK,
+    /// Driver tx path was busy.
+    Busy = bindings::netdev_tx_NETDEV_TX_BUSY,
+}
+
+/// Corresponds to the kernel's `struct net_device_ops`.
+///
+/// A device driver must implement this. Only very basic operations are supported for now.
+#[vtable]
+pub trait DeviceOperations: ForeignOwnable + Send + Sync {
+    /// Corresponds to `ndo_init` in `struct net_device_ops`.
+    fn init(_dev: Device<Self>) -> Result {
+        Ok(())
+    }
+
+    /// Corresponds to `ndo_uninit` in `struct net_device_ops`.
+    fn uninit(_dev: Device<Self>) {}
+
+    /// Corresponds to `ndo_open` in `struct net_device_ops`.
+    fn open(_dev: Device<Self>) -> Result {
+        Ok(())
+    }
+
+    /// Corresponds to `ndo_stop` in `struct net_device_ops`.
+    fn stop(_dev: Device<Self>) -> Result {
+        Ok(())
+    }
+
+    /// Corresponds to `ndo_start_xmit` in `struct net_device_ops`.
+    fn start_xmit(_dev: Device<Self>, _skb: SkBuff) -> TxCode {
+        TxCode::Busy
+    }
+}
+
+/// Corresponds to the kernel's `struct sk_buff`.
+///
+/// A driver manages `struct sk_buff` in two ways. In both ways, the ownership is transferred
+/// between C and Rust. The allocation and release are done asymmetrically.
+///
+/// On the tx side (`ndo_start_xmit` operation in `struct net_device_ops`), the kernel allocates
+/// a `sk_buff' object and passes it to the driver. The driver is responsible for the release
+/// after transmission.
+/// On the rx side, the driver allocates a `sk_buff` object then passes it to the kernel
+/// after receiving data.
+///
+/// A driver must explicitly call a function to drop a `sk_buff` object.
+/// The code to let a `SkBuff` object go out of scope can't be compiled.
+///
+/// # Invariants
+///
+/// The pointer is valid.
+pub struct SkBuff(*mut bindings::sk_buff);
+
+impl SkBuff {
+    /// Creates a new [`SkBuff`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` must be valid.
+    unsafe fn from_ptr(ptr: *mut bindings::sk_buff) -> Self {
+        // INVARIANT: The safety requirements ensure the invariant.
+        Self(ptr)
+    }
+
+    /// Provides a time stamp.
+    pub fn tx_timestamp(&mut self) {
+        // SAFETY: The type invariants guarantee that `self.0` is valid.
+        unsafe {
+            bindings::skb_tx_timestamp(self.0);
+        }
+    }
+
+    /// Consumes a [`sk_buff`] object.
+    pub fn consume(self) {
+        // SAFETY: The type invariants guarantee that `self.0` is valid.
+        unsafe {
+            bindings::kfree_skb_reason(self.0, bindings::skb_drop_reason_SKB_CONSUMED);
+        }
+        core::mem::forget(self);
+    }
+}
+
+impl Drop for SkBuff {
+    #[inline(always)]
+    fn drop(&mut self) {
+        build_error!("skb must be released explicitly");
+    }
+}
-- 
2.34.1


