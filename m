Return-Path: <netdev+bounces-40679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE147C8522
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58074282C4D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151611400A;
	Fri, 13 Oct 2023 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA0KJW3g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A9F9DF;
	Fri, 13 Oct 2023 11:59:30 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FC2195;
	Fri, 13 Oct 2023 04:59:24 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a398f411fso2192852276.3;
        Fri, 13 Oct 2023 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697198363; x=1697803163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPVq+rfDhOvL1koc8IwzPpPTp2OVMuSqNIxi3t27Yzg=;
        b=QA0KJW3ggb/B36CID7aXRPfNnPKJ2dkLWoZ7IrZmMifM68Csh1rclWq+pBI+caAT3b
         rngiROY/33f89Ws61zG6bHHZYUTNyEXLWUL60xEIt/yHh2xyb5V10Qp/PJ4NDlCznBIo
         bCTyipKgv19ZD04CZCWa3jRbTSyqBKyTlPUWG++sWslmpBB1V5vrQdqX2gp/tPD3W7nm
         Yhn+bM1dm23H1/e97pLiH2fH5pyg65DTCdplpezDzul+Uks7co5pU4zvhWhPqCOBp7iG
         V97HjURUnsgF+RBf1sKIAvXJx2tC1Dv46oiCrL5ZAbkzz6E3r1bYIRp3xUKQMYQe9EPc
         nEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697198363; x=1697803163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPVq+rfDhOvL1koc8IwzPpPTp2OVMuSqNIxi3t27Yzg=;
        b=vuNQbUpj63XzehRo5xrtEGdxwm4NDxwJR0ifW16/VnL9IP2fO+mZFSwRF8j/nC5Ohs
         yo+n81WifBpJB069BJXSNrrVgNmWda9AprKTUG9LKcxLPDWPcmTSh69BakqCDBM/lLk0
         Z5ceNovv3l/XAq+lcOcxEwJrcV8aXCUO1iXHrlDPLg4FTCrAiCG1rUdxC72TNaikUChm
         oyqrK+oz5nrzjTDsTILQDBbe2WueN9d8tipwaG9wyxhYdai3pra5Ld0dcFX/L0zJAT/1
         oN74j5zLDSszZsp+ZizTYVF+gj3Gl30qoMSEC3mXH4uzWrzlWMD+0OaopSo0FUKjhZcu
         k0dQ==
X-Gm-Message-State: AOJu0YxqtwmRz4W4JH0Yj0RS77qMfQU5FkE3/PbJNlExIP6r+Nh2GXto
	hMidnCrsYtpC/iWsZHyzOYWPmNJ2ROvFBQooPRE=
X-Google-Smtp-Source: AGHT+IHS5UyJlEk+jXwllINRUQi99hkWfQlqlauQFnmZSnXwkitfAZslmN5XyWDThKgnsfrLBG4O/7IsK874TLNylWc=
X-Received: by 2002:a25:688c:0:b0:d9a:c79c:9367 with SMTP id
 d134-20020a25688c000000b00d9ac79c9367mr3927114ybc.46.1697198363585; Fri, 13
 Oct 2023 04:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com>
 <20231010.005008.2269883065591704918.fujita.tomonori@gmail.com>
 <CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com> <20231012.081826.1846197263913130802.fujita.tomonori@gmail.com>
In-Reply-To: <20231012.081826.1846197263913130802.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Oct 2023 13:59:12 +0200
Message-ID: <CANiq72mgeVrcGcHXo1xjaRL1ix3vUsGbtk179kpyJ6GAe9MMVg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 1:18=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> IIRC, Andrew prefers to avoid creating a temporary rust variant (Greg
> does too, I understand). I guess that only solusion that both Rust and
> C devs would be happy with is generating safe Rust code from C. The

As far as I understand, the workaround I just suggested in the
previous reply was not discussed so far. I am not sure which of the
alternatives you mean by the "temporary rust variant", so I may be
misunderstanding your message.

> solution is still a prototype and I don't know when it will be
> available (someone knows?).

If no alternative is good enough, and you do not have time to
implement one of the better solutions, then we need to wait until one
of us (or somebody else) implements it. I understand that can be
frustrating, but we cannot really agree to start using
`--rustified-enum` or, in general, ways to introduce UB where we
already have known solutions.

Instead, we prefer to spend some time iterating on this sort of
problem. It is also not the first time at all we have done this, e.g.
see `pin-init`. It is all about trying to avoid compromising, unless
the solution is really far away.

Having said that, to try to unblock things, I spent some time
prototyping the workaround I suggested, see below [1]. That catches
the "new C variant added" desync between Rust and C.

For instance, if I add a `PHY_NEW` variant, then I get:

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
          | |______________________________^ pattern
`phy_state::PHY_NEW` not covered
          |
    note: `phy_state` defined here
         --> rust/bindings/bindings_generated_enum_check.rs:60739:10
          |
    60739 | pub enum phy_state {
          |          ^^^^^^^^^
    ...
    60745 |     PHY_NEW =3D 5,
          |     ------- not covered
          =3D note: the matched value is of type `phy_state`

It seems to work fine and would allow us to use the wildcard `_`
without risk of desync, and without needing changes on the C enum.

> Sorry, there's no excuse. I should have done better. I'll make sure
> that the code is warning-free.

No problem at all -- it is all fine. I hope the workaround is suitable
and unblocks you. Please let me know and I can send it as a patch.

However, I would still prefer that it is done in `bindgen` -- when we
talked about that possibility in the weekly meeting a couple days ago,
we thought it could be doable to have it ready for the next kernel
version if somebody steps up to do it now. I could do it, but not
before LPC.

Cheers,
Miguel

[1]

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
index 87958e864be0..4a1c7a48dfad 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,6 +15,7 @@ always-$(CONFIG_RUST) +=3D libmacros.so
 no-clean-files +=3D libmacros.so

 always-$(CONFIG_RUST) +=3D bindings/bindings_generated.rs
bindings/bindings_helpers_generated.rs
+always-$(CONFIG_RUST) +=3D bindings/bindings_generated_enum_check.rs
 obj-$(CONFIG_RUST) +=3D alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) +=3D exports_alloc_generated.h
exports_bindings_generated.h \
     exports_kernel_generated.h
@@ -341,6 +342,19 @@ $(obj)/bindings/bindings_generated.rs:
$(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
        $(call if_changed_dep,bindgen)

+$(obj)/bindings/bindings_generated_enum_check.rs: private
bindgen_target_flags =3D \
+    $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters) \
+    --default-enum-style rust
+$(obj)/bindings/bindings_generated_enum_check.rs: private
bindgen_target_extra =3D ; \
+    OBJTREE=3D$(abspath $(objtree)) $(RUSTC_OR_CLIPPY) $(rust_flags)
$(rustc_target_flags) \
+        --crate-type rlib -L$(objtree)/$(obj) \
+        --emit=3Ddep-info=3D$(obj)/bindings/.bindings_enum_check.rs.d \
+        --emit=3Dmetadata=3D$(obj)/bindings/libbindings_enum_check.rmeta \
+        --crate-name enum_check $(obj)/bindings/bindings_enum_check.rs
+$(obj)/bindings/bindings_generated_enum_check.rs:
$(src)/bindings/bindings_helper.h \
+    $(src)/bindings/bindings_enum_check.rs $(src)/bindgen_parameters FORCE
+       $(call if_changed_dep,bindgen)
+
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags =3D \
     $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
diff --git a/rust/bindings/bindings_enum_check.rs
b/rust/bindings/bindings_enum_check.rs
new file mode 100644
index 000000000000..7c62bab12ea1
--- /dev/null
+++ b/rust/bindings/bindings_enum_check.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings exhaustiveness enum check.
+//!
+//! Eventually, this should be replaced by a safe version of
`--rustified-enum`, see
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

