Return-Path: <netdev+bounces-43697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B87D4466
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0383CB20BF6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47974C87;
	Tue, 24 Oct 2023 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ92YfIs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D326EA1;
	Tue, 24 Oct 2023 01:01:49 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC737EE;
	Mon, 23 Oct 2023 18:01:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so802642b3a.1;
        Mon, 23 Oct 2023 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109307; x=1698714107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItB9ha1BmOHrGCim5sjcrsZp6wWNCIp1MheHkK4zrJE=;
        b=LZ92YfIs11+eUcs6hLPQp82DmZhSF/lnoIGyiUfpOZgChoybOxrbNVruEE+/8znp/P
         kHYQ2ZSoMwDbu7RXWySW2M+7NKkYxwYQApVf2/BUJ9Bh8iIK725vqnFx3IGSiMooYaqB
         +eZPaGMt9DXEmzrHHDV1FLtoiHAPXANmNxoT6eyaDoO2YqpkZF95rePTaoy18BWk4RXk
         naUz/Tus3LIRiODqG+H0icvIKW9aXAyo0kexfWER0ouVuScMV5I/oKvQxUF+5Jsgj6jz
         Jk4RIO+GHTfmQsCbHrhkkglVs1y/xDCJXgvWEA0khYHniyG1SzNCjv1nT5NvLQm5r8Fu
         UF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109307; x=1698714107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItB9ha1BmOHrGCim5sjcrsZp6wWNCIp1MheHkK4zrJE=;
        b=DOEZ0fk/vEPAQMKwCFZZ5vdmECoLE+BaYiSkT++FZq6lTH8tPoUHeTCv10cIIgONLM
         2idsW21SPt+IkWx7IYIqmsFpwhoOoixyodzstzCWWlMCqQPvcMYTlc1vZjhG91dHdaP6
         yk+8h2FZLM0hPkqQ+Zji9yrFYWaPBWE0eabz6Je1/sKowsueMZEQpj4OvkO3kITbFP3S
         c7jNKTByaN8fAbNsC4CR7/CkIrbSdf6tSvaFVES8MfaaUYXv4Ke5AIij2hjTwkgk3tXM
         /YoCjp+bwy6OH5AJDru/RjhHohqW8TAtqJq3AV1Gh3/1U6k6fZnoQ1yuI7OLpwXzsiou
         CK+A==
X-Gm-Message-State: AOJu0Yx8rnvCBHwGXzI4el78Y1I95H+Lkr5SLRHqGusUTWrzOBacDJFg
	mJj/JxNVb+1//Dmu/DOZuBhLUFCpbubyFQ==
X-Google-Smtp-Source: AGHT+IEzgNe9aA7aZe/+Dd4SgsL7UO5r7cpi+pqicWmZLsfAm6yMjuQ1NmWwd0kK0dJMb9+k/ZwxmQ==
X-Received: by 2002:a05:6a00:4598:b0:6be:4b10:b27d with SMTP id it24-20020a056a00459800b006be4b10b27dmr10411032pfb.0.1698109306749;
        Mon, 23 Oct 2023 18:01:46 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b006be077531aesm6707888pfi.220.2023.10.23.18.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:01:46 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	greg@kroah.com
Subject: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver macro
Date: Tue, 24 Oct 2023 09:58:39 +0900
Message-Id: <20231024005842.1059620-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro creates an array of kernel's `struct phy_driver` and
registers it. This also corresponds to the kernel's
`MODULE_DEVICE_TABLE` macro, which embeds the information for module
loading into the module binary file.

A PHY driver should use this macro.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 129 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 2d821c2475e1..f346b2b4d3cb 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -706,3 +706,132 @@ const fn as_int(&self) -> u32 {
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
+///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] = [
+///         ::kernel::net::phy::create_phy_driver::<PhyAX88772A>::(),
+///     ];
+///
+///     impl ::kernel::Module for Module {
+///        fn init(module: &'static ThisModule) -> Result<Self> {
+///            let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, Pin::static_mut(&mut DRIVERS)) }?;
+///            Ok(Module { _reg: reg })
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
+            $($dev.mdio_device_id()),+,
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
+                ::kernel::net::phy::DriverVTable;
+                $crate::module_phy_driver!(@count_devices $($driver),+)
+            ] = [
+                $(::kernel::net::phy::create_phy_driver::<$driver>()),+
+            ];
+
+            impl ::kernel::Module for Module {
+                fn init(module: &'static ThisModule) -> Result<Self> {
+                    // SAFETY: The anonymous constant guarantees that nobody else can access the `DRIVERS` static.
+                    // The array is used only in the C side.
+                    let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, core::pin::Pin::static_mut(&mut DRIVERS)) }?;
+                    Ok(Module { _reg: reg })
+                }
+            }
+        };
+
+        $crate::module_phy_driver!(@device_table [$($dev),+]);
+    }
+}
-- 
2.34.1


