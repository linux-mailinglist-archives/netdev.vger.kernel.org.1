Return-Path: <netdev+bounces-40361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9397C6E93
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E919128272B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FF27EC8;
	Thu, 12 Oct 2023 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqNmqQ0H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868725107;
	Thu, 12 Oct 2023 12:54:27 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D875AC0;
	Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-693400e09afso232603b3a.1;
        Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115265; x=1697720065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0Vjt05um3BpDubcIaNsNVDDn+m+9Vw9BFIrYTID0IU=;
        b=cqNmqQ0Hzb0JDVL+0CaB032AFChrIsmltTid60i5BJwSqK5W3NBRn5kwzUtfHk9vIw
         60XSGg9nyHZXg26HMwu7Le1JJgpJu6whnmlOa/uKjoKrIf9pA1G+eoPTt5saTERGHG6+
         IuSwqRQ9AbfWUZxD0V2VCE1Ywf6SB/EcCg8qt+RO7dEjKkCBDOyXCUuYGL6uyvq4MxaL
         5Zpr+3aNdZ3R/YQduh2+bv01wvEjOb/SwC9HlLSipNS8hfi0CqJuVSYkcWtfzbzx+fY/
         Uk6BmZWXRdhub+g4xNroz7a7cWXZe/Sbkfa3CaZdJ2oAmGl+zC7SmhdiT3tqDdMNSxAE
         nAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115265; x=1697720065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0Vjt05um3BpDubcIaNsNVDDn+m+9Vw9BFIrYTID0IU=;
        b=SPYYy9x/GppbL+tqerYYgKMye1YaRXGp2L4l6l9gzPaUta8kFjGqL7rfQHrc09lXhB
         E/+c0xzn6+PDFJqDuL/kuJ1xbyoeP8BRFHRh+pNQ7jKWAH1ceMgOAXZjPG5cANm1MH0U
         HzMTpJ5PLUWk6sxbpD6dgf3zzcI5Qvh/6KlqNwdGNldrufXbAm3T3Dqgib+zv9aZJNMb
         gQdVVbkkGP7eNYafYOW7fuG2chKBVbzPv0idLALhfRClpawI3aEHUMk5G9lwNxib+QGN
         ZJd4UoRf8Jd7Z65JtD3A0Br73zYwTW3PxIQ+/m9FVbPNrlNvxjFkN62Jt1gO6tdTjj9L
         kJQQ==
X-Gm-Message-State: AOJu0YyAN9YP8QR1TfwqqiSi9Kk8bAx4XF0FrZk4JH2Vy4kc/Wv7e3Y3
	ReTO7qDLMeYr6qGKfBa7aUsW8/LpZOzV9O+3
X-Google-Smtp-Source: AGHT+IG+m81EyDSBm7izQN8wcu/X9Qr8i8R8jMqpA3mILkuHdNolyAt9ljFFDnzm6j8hV2/zfwAHiA==
X-Received: by 2002:a17:903:2306:b0:1bb:ac37:384b with SMTP id d6-20020a170903230600b001bbac37384bmr26794992plh.6.1697115265067;
        Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001ba066c589dsm1886857pls.137.2023.10.12.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:54:24 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com
Subject: [PATCH net-next v4 2/4] rust: net::phy add module_phy_driver macro
Date: Thu, 12 Oct 2023 21:53:47 +0900
Message-Id: <20231012125349.2702474-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This macro creates a static array of kernel's `struct phy_driver` and
registers it. This also corresponds to the kernel's
`MODULE_DEVICE_TABLE` macro, which embeds the information for module
loading into the module binary file.

A PHY driver should use this macro.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 134 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 7b2a3a52ff25..df24c3860d40 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -677,3 +677,137 @@ const fn as_int(&self) -> u32 {
         }
     }
 }
+
+/// Declares a kernel module for PHYs drivers.
+///
+/// This creates a static array of kernel's `struct phy_driver` and registers it.
+/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
+/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
+///
+/// # Examples
+///
+/// ```ignore
+/// use kernel::c_str;
+/// use kernel::net::phy::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+/// kernel::module_phy_driver! {
+///     drivers: [PhyAX88772A],
+///     device_table: [
+///         DeviceId::new_with_driver::<PhyAX88772A>(),
+///     ],
+///     name: "rust_asix_phy",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust Asix PHYs driver",
+///     license: "GPL",
+/// }
+///
+/// struct PhyAX88772A;
+///
+/// impl phy::Driver for PhyAX88772A {
+///     const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
+/// }
+/// ```
+///
+/// This expands to the following code:
+///
+/// ```ignore
+/// use kernel::c_str;
+/// use kernel::net::phy::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+/// struct Module {
+///     _reg: ::kernel::net::phy::Registration,
+/// }
+///
+/// module! {
+///     type: Module,
+///     name: "rust_asix_phy",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust Asix PHYs driver",
+///     license: "GPL",
+/// }
+///
+/// const _: () = {
+///     static mut DRIVERS: [::kernel::net::phy::DriverType; 1] = [
+///         ::kernel::net::phy::create_phy_driver::<PhyAX88772A>::(),
+///     ];
+///
+///     impl ::kernel::Module for Module {
+///        fn init(module: &'static ThisModule) -> Result<Self> {
+///            let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, &DRIVERS) }?;
+///            Ok(Module {
+///                _reg: reg,
+///            })
+///        }
+///     }
+/// }
+///
+/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
+///     ::kernel::bindings::mdio_device_id {
+///         phy_id: 0x003b1861,
+///         phy_id_mask: 0xffffffff,
+///     },
+///     ::kernel::bindings::mdio_device_id {
+///         phy_id: 0,
+///         phy_id_mask: 0,
+///     }
+/// ];
+/// ```
+#[macro_export]
+macro_rules! module_phy_driver {
+    (@replace_expr $_t:tt $sub:expr) => {$sub};
+
+    (@count_devices $($x:expr),*) => {
+        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize))*
+    };
+
+    (@device_table [$($dev:expr),+]) => {
+        #[no_mangle]
+        static __mod_mdio__phydev_device_table: [
+            ::kernel::bindings::mdio_device_id;
+            $crate::module_phy_driver!(@count_devices $($dev),+) + 1
+        ] = [
+            $($dev.as_mdio_device_id()),+,
+            ::kernel::bindings::mdio_device_id {
+                phy_id: 0,
+                phy_id_mask: 0
+            }
+        ];
+    };
+
+    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
+        struct Module {
+            _reg: ::kernel::net::phy::Registration,
+        }
+
+        $crate::prelude::module! {
+            type: Module,
+            $($f)*
+        }
+
+        const _: () = {
+            static mut DRIVERS: [
+                ::kernel::net::phy::DriverType;
+                $crate::module_phy_driver!(@count_devices $($driver),+)
+            ] = [
+                $(::kernel::net::phy::create_phy_driver::<$driver>()),+
+            ];
+
+            impl ::kernel::Module for Module {
+                fn init(module: &'static ThisModule) -> Result<Self> {
+                    // SAFETY: The anonymous constant guarantees that nobody else can access the `DRIVERS` static.
+                    // The array is used only in the C side.
+                    let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, &DRIVERS) }?;
+
+                    Ok(Module {
+                        _reg: reg,
+                    })
+                }
+            }
+        };
+
+        $crate::module_phy_driver!(@device_table [$($dev),+]);
+    }
+}
-- 
2.34.1


