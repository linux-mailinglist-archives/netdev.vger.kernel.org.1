Return-Path: <netdev+bounces-44337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55637D7925
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043E9B2121F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1CF1FD5;
	Thu, 26 Oct 2023 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYSES8/W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE8368;
	Thu, 26 Oct 2023 00:16:56 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A974128;
	Wed, 25 Oct 2023 17:16:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd20c30831so65486b3a.1;
        Wed, 25 Oct 2023 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698279414; x=1698884214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dai6/5Sj+Xk31ULBT23BFb2mBpVbKPO2kyGQiRVRhos=;
        b=kYSES8/WAmaGBUZ4kCQDNfE3zQeGr7uOCM/NWwcK7LUHJ0uqeEWafhh8NCD2bXZtou
         mo+35nainVaDEygqz7ZornDXGEH5ETQnvhlNvFSa92ZyiTvl9LPwqC6IVVNJLwNm6DTw
         /1LTDase/BUhSIkPHuUl1RVj83KHXqbM/nKXI5f4PVBKc61qakrb3G2gDb9EIv3Louca
         gDS1MNJGAt8HDYmDiRHS7y5Di5Dj9oslLM8pDLRSEgxgr5WyyvAuF02TpDpX6ATPIkFU
         FiYd8BOwAZ8dESToZotb4CrqOHFEGbY6AOHlUhE/WfGmi6YrWVxp7IIhEC/rHDmYgr5q
         Vouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698279414; x=1698884214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dai6/5Sj+Xk31ULBT23BFb2mBpVbKPO2kyGQiRVRhos=;
        b=P+zJvAHHL2NZ4GqENkjUgq4Wbbmeqad8c3aHj/Lv3hVuS+l1lXNYKy38EPigG5s2hW
         eIYck2OiCRbiEWruuTijHoeCCKoYPU1QCzv0clcotjQ4sBmPumush3NlUVOWazbY5lmJ
         GJT3KbP1LGdlr+fyKgKEbS3bwUiXaI+S8RpILtBG9jnTkcX3GeXMEpYH1Kxga8sQB5GO
         TIWwtEd6w96BgT6yOKdEVc/Vm1pYQDbUl/1rPXuLUOpVw0IKPFL7t6Ur8QoyCr5LDZfZ
         9F7tX0kkG76GKsGPOnnULqq7w4wkhpV23kZni+Z0EQi/mHDQXG/ZsYOVzqPo6tDggULk
         mYJw==
X-Gm-Message-State: AOJu0Yz4dRY3gzuU4loojnbHNh9GXS8gzHmVCVNXLjeCaNccLHnQLjx+
	6+vgvN8pqogM72u9uf7RdRSjEIkfncsmJcG3
X-Google-Smtp-Source: AGHT+IEczx8IZE8NDWCnhQlUkbDZVSjKyp/KBhNUIsqanLvNBFUPARdvttRGig9NleUE9pIk1OogmA==
X-Received: by 2002:a05:6a00:1c86:b0:6bc:ff89:a2fc with SMTP id y6-20020a056a001c8600b006bcff89a2fcmr17982131pfw.2.1698279414168;
        Wed, 25 Oct 2023 17:16:54 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006b341144ad0sm10407945pfb.102.2023.10.25.17.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:16:53 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH net-next v7 3/5] rust: add second `bindgen` pass for enum exhaustiveness checking
Date: Thu, 26 Oct 2023 09:10:48 +0900
Message-Id: <20231026001050.1720612-4-fujita.tomonori@gmail.com>
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

From: Miguel Ojeda <ojeda@kernel.org>

This patch makes sure that the C's enum is sync with Rust sides. If
the enum is out of sync, compiling fails with an error like the
following.

Note that this is a temporary solution. It will be replaced with
bindgen when it supports generating the enum conversion code.

    error[E0005]: refutable pattern in function argument
         --> rust/bindings/bindings_enum_check.rs:29:6
          |
    29    |       (phy_state::PHY_DOWN
          |  ______^
    30    | |     | phy_state::PHY_READY
    31    | |     | phy_state::PHY_HALTED
    32    | |     | phy_state::PHY_ERROR
    ...     |
    35    | |     | phy_state::PHY_NOLINK
    36    | |     | phy_state::PHY_CABLETEST): phy_state,
          | |______________________________^ pattern `phy_state::PHY_NEW` not covered
          |
    note: `phy_state` defined here
         --> rust/bindings/bindings_generated_enum_check.rs:60739:10
          |
    60739 | pub enum phy_state {
          |          ^^^^^^^^^
    ...
    60745 |     PHY_NEW = 5,
          |     ------- not covered
          = note: the matched value is of type `phy_state`

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/.gitignore                      |  1 +
 rust/Makefile                        | 14 +++++++++++
 rust/bindings/bindings_enum_check.rs | 36 ++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 rust/bindings/bindings_enum_check.rs

diff --git a/rust/.gitignore b/rust/.gitignore
index d3829ffab80b..1a76ad0d6603 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 bindings_generated.rs
+bindings_generated_enum_check.rs
 bindings_helpers_generated.rs
 doctests_kernel_generated.rs
 doctests_kernel_generated_kunit.c
diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..a622111c8c50 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,6 +15,7 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
+always-$(CONFIG_RUST) += bindings/bindings_generated_enum_check.rs
 obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
     exports_kernel_generated.h
@@ -341,6 +342,19 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+$(obj)/bindings/bindings_generated_enum_check.rs: private bindgen_target_flags = \
+    $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters) \
+    --default-enum-style rust
+$(obj)/bindings/bindings_generated_enum_check.rs: private bindgen_target_extra = ; \
+    OBJTREE=$(abspath $(objtree)) $(RUSTC_OR_CLIPPY) $(rust_flags) $(rustc_target_flags) \
+        --crate-type rlib -L$(objtree)/$(obj) \
+        --emit=dep-info=$(obj)/bindings/.bindings_enum_check.rs.d \
+        --emit=metadata=$(obj)/bindings/libbindings_enum_check.rmeta \
+        --crate-name enum_check $(srctree)/$(src)/bindings/bindings_enum_check.rs
+$(obj)/bindings/bindings_generated_enum_check.rs: $(src)/bindings/bindings_helper.h \
+    $(src)/bindings/bindings_enum_check.rs $(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen)
+
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
     $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
diff --git a/rust/bindings/bindings_enum_check.rs b/rust/bindings/bindings_enum_check.rs
new file mode 100644
index 000000000000..eef7e9ca3c54
--- /dev/null
+++ b/rust/bindings/bindings_enum_check.rs
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings' enum exhaustiveness check.
+//!
+//! Eventually, this should be replaced by a safe version of `--rustified-enum`, see
+//! https://github.com/rust-lang/rust-bindgen/issues/2646.
+
+#![no_std]
+#![allow(
+    clippy::all,
+    dead_code,
+    missing_docs,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+
+include!(concat!(
+    env!("OBJTREE"),
+    "/rust/bindings/bindings_generated_enum_check.rs"
+));
+
+fn check_phy_state(
+    (phy_state::PHY_DOWN
+    | phy_state::PHY_READY
+    | phy_state::PHY_HALTED
+    | phy_state::PHY_ERROR
+    | phy_state::PHY_UP
+    | phy_state::PHY_RUNNING
+    | phy_state::PHY_NOLINK
+    | phy_state::PHY_CABLETEST): phy_state,
+) {
+}
-- 
2.34.1


