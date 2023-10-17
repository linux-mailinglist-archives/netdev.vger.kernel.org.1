Return-Path: <netdev+bounces-41893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 256FE7CC1C4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0274B210A9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360141ABC;
	Tue, 17 Oct 2023 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtYtatVv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081441A93;
	Tue, 17 Oct 2023 11:30:26 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F0D9F;
	Tue, 17 Oct 2023 04:30:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d5fd02e3dso677555a91.1;
        Tue, 17 Oct 2023 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542224; x=1698147024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5JpkfFDcQ2qhOKpbIw2Q9hWSWvGzyli2/kbRhFyDok=;
        b=VtYtatVv2vkrrW6Y0rIxiidomBxdNRtLVjlLenIqoPTfi7FwBDW1lOTcG+gdn87EPd
         YHMOPgAuGBPkwFGOi9IUuoYyPOZe3O9k+1+S9AMDRaHwliL6MSWHPZUYVBtVbw/3a/7f
         VobK35UckblvWQPNhVUDcBIigQfUY9bCabr25og0NR/W3MLZufr3hLRboG8ZHyYlN96G
         2ZNzLseYpMFiVJRpt3bjOCnZHLAjSQM/u0d5YNsJgOTAWxEDbAqyrm8MIsMUqChD/1RG
         HxC0aqBcDVZlFJTd73BWAdOm4jLtu+po5MZvAw03d8q1aM+pPQuqOKrF8IRbxl2/5JOC
         CR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542224; x=1698147024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5JpkfFDcQ2qhOKpbIw2Q9hWSWvGzyli2/kbRhFyDok=;
        b=WZBD1RnfSKXZljVO1zWsjENtAISv4PkjPh+F/FvdOIBaSzxfyast5xzkvZIlPfZcDr
         9toS9XGRbsZOVoMmC7+4N3+XYQuKjF2mlZ7iPe1jfrsZJhxolD+4JHm/NFwf7I2gp7lR
         FgfROw1ljHDyEFzUIyRwppgHVhyRCfuFj2CsI3aq4PyUmdcHwSSXm9DN45vsQMXgI8pf
         dCD3e/WQGzyYctcfbm63OgyESB2wf2wtQN/Ql00So79SqyrWjZIfIxCgD0IOMf1Kayff
         H963Ijso5Va46BtGvJVcI83IJ6fAo1OjvmVjc/4gYyGUZX2zllkilMMmPWdGHwrH6k4F
         ZLiQ==
X-Gm-Message-State: AOJu0YxdHmE5kxu9OOL9DC7kyglqwzXGgs5i5k+S0cLtWiuuHmV/boko
	f/pDKDzrAJw5DoKcJyhvUrV5wKMYH7alYD6d
X-Google-Smtp-Source: AGHT+IHOgXMc1FLWfbh8YGjPOTEJYNVnZ99dnjpkbKjV3sOrUQcpecmk31wFJ0BXAEJl4co+ZbnofA==
X-Received: by 2002:a17:90b:1d81:b0:27d:6009:36c7 with SMTP id pf1-20020a17090b1d8100b0027d600936c7mr1978784pjb.4.1697542224110;
        Tue, 17 Oct 2023 04:30:24 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b002635db431a0sm1116277pju.45.2023.10.17.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:30:23 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/5] rust: net::phy add module_phy_driver macro
Date: Tue, 17 Oct 2023 20:30:11 +0900
Message-Id: <20231017113014.3492773-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
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
index 7d4927ece32f..5b74a7450b36 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -699,3 +699,137 @@ const fn as_int(&self) -> u32 {
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


