Return-Path: <netdev+bounces-44335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BC7D7923
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA23281EDF
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7B10E3;
	Thu, 26 Oct 2023 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw+o/aLi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2501196;
	Thu, 26 Oct 2023 00:16:55 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A910E;
	Wed, 25 Oct 2023 17:16:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so68809b3a.0;
        Wed, 25 Oct 2023 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698279413; x=1698884213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NcySeGbVn6nm4hfix7vvvBaAjSB8vVibdKxehQYJa0=;
        b=jw+o/aLioEbFEjRcPz6+lgTZeR0K5g1kRy+OpgLLGTWprlXTL4BWF1N0QCFNMXTk0l
         ANZBZeZCWOa6lySdZgQVZKjHrxvlrAJyxn8uIIoLu+I4K1e98iXOr994TaCuCd2oTK1N
         9HhZLAwEHIJygxOnfdTwRFz/8hnn32qLYpwK/+CZOOJjPydUfy2tb08zwJ7pduipR6QG
         ZF0pzpBlyQOylMUmtJTP96A+bFQuWb24eS86Rk3NJGrqm55PdXqeVmp3pW3LNF8cof16
         d/LM7G+0BOYGnHdIGSggKsVsh7zZSpJeGTiIZzmUPULuaPSaC+UUbzmpxByLaEGHm3ct
         KYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698279413; x=1698884213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NcySeGbVn6nm4hfix7vvvBaAjSB8vVibdKxehQYJa0=;
        b=LvK1+FN533ZSLffyPdcxFscLQlWxUvgFDl0qE50bcC+CPeOGETukeD2dmbb/pqM3rI
         wUIPepMa0M0quBzBrVDLOmIdTnjcuk59QLDrbsWWYIuuqKzX/oeSbs5Kl7g0NjhIY563
         aQm8GeAYuHO9Z3FLMFyhFz1QGsk8pHtL54OukUEZAvOVDXC+dNsdB1hFiXq9v8jcc0Sf
         wou718jl/k4I5P2HtIK7by5asa9FBAGK4xuFVAbuKD6AzfWaOwtM4b0KRApDZB1rzbIk
         XQJAQceA9sweYCayjReq9Xx5dV7KiRhuYHLos7Ybo9yK5fkwZAQrsvFv/bQ2OshuSAgz
         qojw==
X-Gm-Message-State: AOJu0YxGz4LXyfyvC6hX1xW4y0hY1pcMdlUGtKH1kiasNdLq1pka3CFq
	lPeYB5Pv1aKLLA7cOGTHGYuBQTn7pancG7Mu
X-Google-Smtp-Source: AGHT+IHHR8xGOgUO0F3HFA2x5EQiqliQxx+nBdvwIV9RZfGSI1AoMw7iduzXGoYoNsGrx0K0t9i8uQ==
X-Received: by 2002:a05:6a20:42a8:b0:163:d382:ba84 with SMTP id o40-20020a056a2042a800b00163d382ba84mr20482395pzj.5.1698279413387;
        Wed, 25 Oct 2023 17:16:53 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006b341144ad0sm10407945pfb.102.2023.10.25.17.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:16:53 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com
Subject: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver macro
Date: Thu, 26 Oct 2023 09:10:47 +0900
Message-Id: <20231026001050.1720612-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
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
 rust/kernel/net/phy.rs | 143 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 61223f638bc6..145d0407fe31 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -723,3 +723,146 @@ const fn as_int(&self) -> u32 {
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
+/// ```
+/// # mod module_phy_driver_sample {
+/// use kernel::c_str;
+/// use kernel::net::phy::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+/// kernel::module_phy_driver! {
+///     drivers: [PhyAX88772A],
+///     device_table: [
+///         DeviceId::new_with_driver::<PhyAX88772A>()
+///     ],
+///     name: "rust_asix_phy",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust Asix PHYs driver",
+///     license: "GPL",
+/// }
+///
+/// struct PhyAX88772A;
+///
+/// #[vtable]
+/// impl phy::Driver for PhyAX88772A {
+///     const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
+/// }
+/// # }
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
+/// struct PhyAX88772A;
+///
+/// #[vtable]
+/// impl phy::Driver for PhyAX88772A {
+///     const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
+/// }
+///
+/// const _: () = {
+///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] =
+///         [::kernel::net::phy::create_phy_driver::<PhyAX88772A>()];
+///
+///     impl ::kernel::Module for Module {
+///         fn init(module: &'static ThisModule) -> Result<Self> {
+///             let drivers = unsafe { &mut DRIVERS };
+///             let mut reg = ::kernel::net::phy::Registration::register(
+///                 module,
+///                 ::core::pin::Pin::static_mut(drivers),
+///             )?;
+///             Ok(Module { _reg: reg })
+///         }
+///     }
+/// };
+///
+/// #[no_mangle]
+/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
+///     ::kernel::bindings::mdio_device_id {
+///         phy_id: 0x003b1861,
+///         phy_id_mask: 0xffffffff,
+///     },
+///     ::kernel::bindings::mdio_device_id {
+///         phy_id: 0,
+///         phy_id_mask: 0,
+///     },
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
+        static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id;
+            $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = [
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
+            static mut DRIVERS: [::kernel::net::phy::DriverVTable;
+                $crate::module_phy_driver!(@count_devices $($driver),+)] =
+                [$(::kernel::net::phy::create_phy_driver::<$driver>()),+];
+
+            impl ::kernel::Module for Module {
+                fn init(module: &'static ThisModule) -> Result<Self> {
+                    // SAFETY: The anonymous constant guarantees that nobody else can access
+                    // the `DRIVERS` static. The array is used only in the C side.
+                    let drivers = unsafe { &mut DRIVERS };
+                    let mut reg = ::kernel::net::phy::Registration::register(
+                        module,
+                        ::core::pin::Pin::static_mut(drivers),
+                    )?;
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


