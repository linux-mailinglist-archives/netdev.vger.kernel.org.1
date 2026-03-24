Return-Path: <netdev+bounces-271148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDaiCge1wmkvlAQAu9opvQ
	(envelope-from <netdev+bounces-271148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:00:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B725D318807
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37B530C5F01
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178438AC79;
	Tue, 24 Mar 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnmTiim2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA238AC76
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367597; cv=none; b=A0vmd+TsKgOwtJDBmMlkuHsxPDwrE6GmPFPv0WwRwlG3ZBvY2630PgnOHnCS/BQ7Rtc1WUjAiXS2r8QMSJcTW51plYCMN3HUFTL6sQU1X4j6PidfCOsLV36C5P4c2W9rdk3z62jxYM8pVo18VQHMzs4GDutFrM+GCFwtiZKg9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367597; c=relaxed/simple;
	bh=pabaukliVPTTBtCCbu7GRWF4HPcbxolgmd7lMaXKXsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXVDF4jCLPwUl2F2YwDyDLF9b46ljJzf0trQ+NZyjwUOWGQpr+T48TbdnVaG7RkpE7jTHrf6yu0xAfqNJnc6mm97PG/jcD9pmoQSA9SBuM7MfhSY5qvh/3jFeNgNWqosMO0eoUofcjGKYX7P0S0z3Hscsq5ClRXwzOPd/GYPwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnmTiim2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a2e62b893so10976991fa.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367593; x=1774972393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl/xsq3xgipQKWzjnfnvy5NKeXM0GCll+kZa/2IQSxk=;
        b=CnmTiim2xVF/kbpTidTyewQDOYU++BuvTFvgDnAPyOcSVIwlNhvobt+9xzcpeXHGlr
         oe7ynRzxgC4NCmwk20Ns0+5pNq5FnxsgYApJ0KIcIrFD2QVsUDuPASCrIjK08pGxvABO
         60jDt2mkE99BXxk/J5wHYim8zB1e/1OpdlAogCNWYB139eD9SRrWn5hKy/L0S+hD67KT
         YyEgXhLdeak7pNzAOsPxqQeuoe0Du66jV0tYodocYfJGmvV8WLuNrWRslM31dhhSjU+h
         hA4D+g1YXFnnbdlh3WzU2dLsbZYlC5vcTPLHxEldVc5EKFkp1NkBy1liAC8zWaTWBSLT
         NCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367593; x=1774972393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xl/xsq3xgipQKWzjnfnvy5NKeXM0GCll+kZa/2IQSxk=;
        b=nF1P/NzDgM4o7YKL3MrRBKXU3qR7/P8ynbWNSLiWZY+U7yQUvbKkPiSSy0LytoFWyD
         jfGx7dlAwKZ08oDayT7EuhPysnaL7EFa9Lw2D5P9gxTG8OgzVEUu4kg/0MUfsbmzWHbD
         LaR7dHrzA667EeLRGqCmUgk7/sYi8U8h3XARRWL4hQizASOAY68nNcKVty6BAQdGQhLH
         YW7jwX0KOTAjtCOrREzN7gDw0Bvy3ZOvV6ubOsuwtvxP8SxS10QkG3D86ghioZLtVyvF
         KanpjP/glM+ZDi4BQ2UMDh8tO1gnPbSu+vWMhErQp5pyVpSY+zFq1bFCmY1p8PkGG5RD
         FvUw==
X-Gm-Message-State: AOJu0YwRvSiPeVUHU4Bce+5hPMiPI1/29EVrYa20cew4j+TYguRSK8fr
	3kmgULVzzRboCCU96N14E3CCVDXwCoC1JWOm3FpkWL2yVSGfiezfEmzo2c0KedCU
X-Gm-Gg: ATEYQzyYHLGE39OY2Lmvk15tU1w0bS+EyD/mJttN+e7SbUsZ6uXVNSdD/IDIMdV2D0X
	pqFxdCLlQMS6/q4tb8jA4UFuLFo5wjIlYQT4VdofVWSWOS7tm+Nf7ay6hw+UrFyH4KIHcZTnNo9
	LM2zpRdhy+k1NjPQWOvVIl0kxUnuXA9akSC1WfHRTvTkLjyz3HiCCK8sOxzmCMocwaRMx7ELrO6
	t5P4NOOBKP3YZCN1evSE49Izt42l35qVeU29w846vB1CSx+nSe7rGJOYg7LX8kTAhfA76ToPHtp
	I/7QGjAXcJEwJZODX7vMPNAR3w6ZtwBcNrEgrp+EflCGB2yKrfWcQYUiEYEdq+jiRSo8+mdCOS2
	AUvxXBVgYQ3zzdnc/uNa9jSgP2Yg4maK5TR2lMVco4TEl6gshqrJhmUdQjkRZw8iAb7f/+GoiUY
	I6zuS4N9cT2W67JsiH53AQpAq8vivrLsZ0d+aGzJ/ja8ccRpABo2sI/MzSQxwKcasClJAqXpUDo
	M1Wy2k6dM0KxCPU3A==
X-Received: by 2002:a05:651c:4102:b0:38a:6acb:eb1d with SMTP id 38308e7fff4ca-38bf9640991mr42255771fa.12.1774367592961;
        Tue, 24 Mar 2026 08:53:12 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa7cd0sm32567841fa.32.2026.03.24.08.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:53:12 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH net-next v2 3/5] rust: phy: add config_init, read_page, and write_page callbacks
Date: Tue, 24 Mar 2026 18:52:47 +0300
Message-ID: <20260324155249.15098-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324155249.15098-1-iprintercanon@gmail.com>
References: <20260324155249.15098-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271148-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,umich.edu,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B725D318807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add three new driver callbacks to the PHY abstraction:

  - config_init: Called to initialize the PHY after a reset. This is
    needed by nearly all real-world PHY drivers to configure
    vendor-specific registers (RGMII delays, LED settings, etc.).
    config_init was previously proposed in an RFC for the Rockchip PHY
    driver but not merged at that time. This re-introduces it in a
    form consistent with the existing vtable infrastructure.

  - read_page / write_page: Required by page-based PHY chips (Realtek,
    Marvell) for the kernel's paged register access infrastructure.
    When these callbacks are registered, phy_read_paged(),
    phy_write_paged(), and phy_modify_paged() use them to switch
    register pages. Both must be implemented together.

Each callback follows the established Adapter<T> pattern with
unsafe extern "C" fn bridging to the Rust Driver trait method, and
conditional registration in create_phy_driver() via HAS_* flags
generated by the #[vtable] macro.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 142f7101723c8..9ffece7ee41c7 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -388,6 +388,51 @@ struct Adapter<T: Driver> {
 }
 
 impl<T: Driver> Adapter<T> {
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn config_init_callback(phydev: *mut bindings::phy_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The C core calls config_init with the PHY mutex held
+            // (from phy_init_hw), so the accessors on `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::config_init(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn read_page_callback(phydev: *mut bindings::phy_device) -> c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we hold `phy_device->lock`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            let page = T::read_page(dev)?;
+            Ok(page.into())
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn write_page_callback(
+        phydev: *mut bindings::phy_device,
+        page: c_int,
+    ) -> c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we hold `phy_device->lock`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            let page = u16::try_from(page).map_err(|_| code::EINVAL)?;
+            T::write_page(dev, page)?;
+            Ok(0)
+        })
+    }
+
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
@@ -580,6 +625,11 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id(),
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
+        config_init: if T::HAS_CONFIG_INIT {
+            Some(Adapter::<T>::config_init_callback)
+        } else {
+            None
+        },
         soft_reset: if T::HAS_SOFT_RESET {
             Some(Adapter::<T>::soft_reset_callback)
         } else {
@@ -630,6 +680,16 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
+        read_page: if T::HAS_READ_PAGE {
+            Some(Adapter::<T>::read_page_callback)
+        } else {
+            None
+        },
+        write_page: if T::HAS_WRITE_PAGE {
+            Some(Adapter::<T>::write_page_callback)
+        } else {
+            None
+        },
         link_change_notify: if T::HAS_LINK_CHANGE_NOTIFY {
             Some(Adapter::<T>::link_change_notify_callback)
         } else {
@@ -657,6 +717,11 @@ pub trait Driver {
     /// The default id and mask are zero.
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_custom_mask(0, 0);
 
+    /// Called to initialize the PHY, including after a reset.
+    fn config_init(_dev: &mut Device) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Issues a PHY software reset.
     fn soft_reset(_dev: &mut Device) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
@@ -709,6 +774,24 @@ fn write_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16, _val: u16) -> Result
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Returns the current PHY register page number.
+    ///
+    /// Must be implemented together with [`Driver::write_page`]. The kernel's
+    /// paged register access infrastructure requires both callbacks to be
+    /// present.
+    fn read_page(_dev: &mut Device) -> Result<u16> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Sets the current PHY register page number.
+    ///
+    /// Must be implemented together with [`Driver::read_page`]. The kernel's
+    /// paged register access infrastructure requires both callbacks to be
+    /// present.
+    fn write_page(_dev: &mut Device, _page: u16) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Callback for notification of link change.
     fn link_change_notify(_dev: &mut Device) {}
 }
-- 
2.43.0


