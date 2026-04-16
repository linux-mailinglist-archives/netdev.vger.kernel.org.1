Return-Path: <netdev+bounces-279158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MAIIm5B4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE641476F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D32D9301A088
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164A3ED5D4;
	Thu, 16 Apr 2026 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJpW7pKr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2A38D6AA
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370023; cv=pass; b=d+ZMM+PAxH1MC+5WxZDI/d5PZ6bbLFD31Xxzb+cgDo4oEfFfQsbhbPYdRa1YW+Eq3y4fDazEGYFDQaeds2gyHW5IJPMyk0ioADwn1CVvsMSnpbzo6pBLwky80c0LKZV9nDOMV7QYJbouFdGNBP6NBBQP6B/yFwuHaQBt845pEFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370023; c=relaxed/simple;
	bh=0rplOeAZ4MoG0MY9jtzGV+t4eJkOYZbes63oYcNbVAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVm3t5vPS3V1C+DXW//CChgxYkLCEiIuZoCf6xuA/TvDMjCl58LY/M1OFEgE/nxD1pO0mfHNO9pi3uto8CGk5XvB8dYuV+/22EbKBqscvGmROkCTqYJqoTM13OMSD3uIs4VS4IoTi+IIn8azBC735+fTUdlM15YfxQH8hIC9Res=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJpW7pKr; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso775a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776370014; cv=none;
        d=google.com; s=arc-20240605;
        b=D9gkEB9R1S2yDAcAvJaJM82F1wccA3/wYM9J7K4GJPI2oTJez1HuRGUwLroQ+TV9Wy
         lX0joeC/YO6+UeFmRWl37Oj+z1YjvrHcRmWF/XM32hMZC7LJSG+nLtOq6lKKURGh1OWp
         FlPWldo1TxpQe+IVIJWo0zrBBrBIGfTObJh/zrmGnylvqVO8jCpscRbEGySe/iCWq5Vx
         JviZFHgQNKsyADaZe4PT9hEcGpvukhiPVajSVO+p6cpSrHAn+/6hga+9wwr6moQFm2T4
         fIEqTjn+/AdL/rHd5CjTpLg/eMqasZyoMd1X/++UDaaC9sMD3r6R0YULy+MOl65fsi0x
         sXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SYTanURfRrhunWlbKgFNmkYHEA4Clj+oTkGhnh1Xx7Y=;
        fh=4vR2TczkMfTmpsisLvVMHnjgzUBpzoQPF02JEC4rDXg=;
        b=UBPTs2OOschYgu7AWiKGi8w4SkKFuSoB/UrN8TTNSrLZKrJ7SFCAy/5d1Fxx4VRv5f
         EQpV8loAFt8pgoebhLu0iAmyAHhtrT1fsJ8yJpHvjR4+41p1OWHLRiNBd1pKUu2cZL+d
         B0ITpqb3m0Q5qBGoXH6kIPZYIw/Q8zEbDcBj0WTsW2dAiZUrCSVP1df9bj6YX25zkEJN
         OQkbKlVpk2sIhPPO4JMGODJESKcQsebjSfq6JSuPBgBbw6IBGZip9oic4X3FgWI22+au
         XqIWNx89mXFb7msxN4OQ0w8JjdOG8MeHgQoJsKxXnV+1evm5M8dcQ0+MOKvobc5OoScE
         WG8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776370014; x=1776974814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYTanURfRrhunWlbKgFNmkYHEA4Clj+oTkGhnh1Xx7Y=;
        b=pJpW7pKrOmjbpfWvYkiEn125QXxGI5wVQSZN9x/9gaNj6/94NhQqfOYZVMbO/N50uv
         FJLUy/FomjP2geuFxC8bQU3BAc6H/kqJeT3iEztisNuulFBY86Ftqyie+/1mwvQ2z1Z5
         /Lj62yjUoye4aUFSiAhwbiL5Yy29A0JN3LqGWHKRnyRk8NtS/TJr91IH3y1ZLoRPMPSQ
         Wk4VMOiSp/56AA3j9CggVP7M7iuvlWr8zaJR3N2TE8LOSSfdjI/PbQXf6RbEYk+psVJK
         W7ny05+2cu9vWEaxs1AgcFZKlwROH7KJFVV4YuISLsow/xvoHJEPjk2fHBW7UXyCwUlE
         w/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370014; x=1776974814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYTanURfRrhunWlbKgFNmkYHEA4Clj+oTkGhnh1Xx7Y=;
        b=GXzFXrZ9UFnPvqdBLeusTCSaAI30u75iU1Y/SGEsPu/n9cqVi1iYOKolr+T1+qB53n
         5OrS4Vb6sJrPGvrSMnJY/6TYgMBl7DpuGscCCbjJV81kxv0duK6po6TZ26ANLQOrCK3R
         HLQqjkKjBFL/X4bIzqEe9QftsZS4ocwDLcfZhoy0f3XgYueDl7V4UJavA12wJweROKuM
         U7n72vXen9BmZyFVoIEAFRfWJLb3YDDpu3Vy0M1tX4I2gpAXa/WLBTloiHSgNrsbrANU
         ot5e5AYXciaixDN/th4zvh+3v5fqits9aiYnd512ZUusfEnHjZ2+Mbry4H/Thh9v2Vs1
         VgbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/r5vjKDd+9b6oZnNTwjvZHrp3di3rdqqxNHG//WvB7Er3tPakcLiG2X9yDa3MtPpv2OWvtTPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyW3Q/4Jn2efFpreS+rx880GxXDvLbPsB8Uv8hKzRu6dwkzWDf
	toDi0de4dJMPawtcAkoQCNdgqBukFPygWCk0MqUB3QdbzWLuvBLbMkW/Fs3OCl0FPVuncV4J3GL
	ENiilwdU7AkOmtfHvM1bTjxqc3vwwGiljcbqbD8HC
X-Gm-Gg: AeBDietsguLSIsva4dwfT15fqymXvNEuoOMA6MeWPg1Lri73nq1tC5v/b0PcoTQ4Rvh
	rZpsPVRD/ebpt4d3LTpggnXh54+0tlrhDtJnSJ3WOOtaOrrGuHrfDG/74vRgrHe7lQbOaExcoZm
	62dCyQV4asDp2MbxPXnGoOOBqJvvgV30cLB5lHJWWuRK4WS3LnWD6LqDIRl/62OA+HnXsiQSD7S
	sAd6OXCq1F6Dx5FRK3Sr52tHh2boV8MSw9CRyXJkiZm0JRpSQ29EnO+0WunVKkX9ApkDyhTmuBp
	/YFuY+VhyBfeysMQc9SJpMhTm6n3egeKpIi8vAUcFbqDUlAaIKKOBMIgnrQ=
X-Received: by 2002:aa7:d9c9:0:b0:670:d5f0:2595 with SMTP id
 4fb4d7f45d1cf-672bd26e718mr10155a12.11.1776370013685; Thu, 16 Apr 2026
 13:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com> <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
In-Reply-To: <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 16 Apr 2026 13:06:42 -0700
X-Gm-Features: AQROBzB2R8ebp2n8G6tJ7zWb-zQBTCsTD7t5yX43SHL7LMXtTnExmFCv7UgMyQo
Message-ID: <CAGSQo03b4tTQW=bXiRrmjvF8NympD_dcJX=2jwPdMmguXLfifQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: netlink: add raw netlink abstraction
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279158-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7FDE641476F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 2:44=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This implements a safe and relatively simple API over the netlink API,
> that allows you to add different attributes to a netlink message and
> broadcast it. As the first user of this API only makes use of broadcast,
> only broadcast messages are supported here.
>
> This API is intended to be safe and to be easy to use in *generated*
> code. This is because netlink is generally used with yaml files that
> describe the underlying API, and the python generator outputs C code
> (or, soon, Rust code) that lets you use the API more easily. So for
> example, if there is a string field, the code generator will output a
> method that internall calls `put_string()` with the right attr type.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   3 +
>  rust/helpers/genetlink.c        |  46 ++++++
>  rust/helpers/helpers.c          |   1 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/netlink.rs          | 329 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 380 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 083cc44aa952..8abb626fce6c 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -88,6 +88,8 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <linux/xarray.h>
> +#include <net/genetlink.h>
> +#include <net/netlink.h>
>  #include <trace/events/rust_sample.h>
>
>  /*
> @@ -105,6 +107,7 @@
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN=
;
>  const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLOC_MI=
NALIGN;
>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
> +const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE =3D GENLMSG_DEFAULT_=
SIZE;
>  const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D GFP_KERNEL_ACCOUNT;
> diff --git a/rust/helpers/genetlink.c b/rust/helpers/genetlink.c
> new file mode 100644
> index 000000000000..3530b69f6cf7
> --- /dev/null
> +++ b/rust/helpers/genetlink.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2026 Google LLC.
> + */
> +
> +#include <net/genetlink.h>
> +
> +#ifdef CONFIG_NET
> +
> +__rust_helper struct sk_buff *rust_helper_genlmsg_new(size_t payload, gf=
p_t flags)
> +{
> +       return genlmsg_new(payload, flags);
> +}
> +
> +__rust_helper
> +int rust_helper_genlmsg_multicast(const struct genl_family *family,
> +                                 struct sk_buff *skb, u32 portid,
> +                                 unsigned int group, gfp_t flags)
> +{
> +       return genlmsg_multicast(family, skb, portid, group, flags);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_cancel(struct sk_buff *skb, void =
*hdr)
> +{
> +       genlmsg_cancel(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *hd=
r)
> +{
> +       genlmsg_end(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
> +{
> +       nlmsg_free(skb);
> +}
> +
> +__rust_helper
> +int rust_helper_genl_has_listeners(const struct genl_family *family,
> +                                  struct net *net, unsigned int group)
> +{
> +       return genl_has_listeners(family, net, group);
> +}
> +
> +#endif
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index a3c42e51f00a..0813185d8760 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -32,6 +32,7 @@
>  #include "err.c"
>  #include "irq.c"
>  #include "fs.c"
> +#include "genetlink.c"
>  #include "io.c"
>  #include "jump_label.c"
>  #include "kunit.c"
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index d93292d47420..f5ea0ae0b6b7 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -122,6 +122,7 @@
>  pub mod module_param;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
> +pub mod netlink;
>  pub mod num;
>  pub mod of;
>  #[cfg(CONFIG_PM_OPP)]
> diff --git a/rust/kernel/netlink.rs b/rust/kernel/netlink.rs
> new file mode 100644
> index 000000000000..21f959c95fdc
> --- /dev/null
> +++ b/rust/kernel/netlink.rs
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Google LLC.
> +
> +//! Rust support for generic netlink.
> +//!
> +//! Currently only supports exposing multicast groups.
> +//!
> +//! C header: [`include/net/genetlink.h`](srctree/include/net/genetlink.=
h)
> +#![cfg(CONFIG_NET)]
> +
> +use kernel::{
> +    alloc::{self, AllocError},
> +    error::to_result,
> +    prelude::*,
> +    transmute::AsBytes,
> +    types::Opaque,
> +    ThisModule,
> +};
> +
> +use core::{
> +    mem::ManuallyDrop,
> +    ptr::NonNull, //
> +};
> +
> +/// The default netlink message size.
> +pub const GENLMSG_DEFAULT_SIZE: usize =3D bindings::GENLMSG_DEFAULT_SIZE=
;
> +
> +/// A wrapper around `struct sk_buff` for generic netlink messages.
> +///
> +/// This type is intended to be specific for buffers used with netlink o=
nly, and other usecases for
> +/// `struct sk_buff` are out-of-scope for this abstraction.
> +///
> +/// # Invariants
> +///
> +/// The pointer has ownership over a valid `sk_buff`.
> +pub struct NetlinkSkBuff {
> +    skb: NonNull<kernel::bindings::sk_buff>,
> +}
> +
> +impl NetlinkSkBuff {
> +    /// Creates a new `NetlinkSkBuff` with the given size.
> +    pub fn new(size: usize, flags: alloc::Flags) -> Result<NetlinkSkBuff=
, AllocError> {
> +        // SAFETY: `genlmsg_new` only requires its arguments to be valid=
 integers.
> +        let skb =3D unsafe { bindings::genlmsg_new(size, flags.as_raw())=
 };
> +        let skb =3D NonNull::new(skb).ok_or(AllocError)?;
> +        Ok(NetlinkSkBuff { skb })
> +    }
> +
> +    /// Puts a generic netlink header into the `NetlinkSkBuff`.
> +    pub fn genlmsg_put(
> +        self,
> +        portid: u32,
> +        seq: u32,
> +        family: &'static Family,
> +        cmd: u8,
> +    ) -> Result<GenlMsg, AllocError> {
> +        let skb =3D self.skb.as_ptr();
> +        // SAFETY: The skb and family pointers are valid.
> +        let hdr =3D unsafe { bindings::genlmsg_put(skb, portid, seq, fam=
ily.as_raw(), 0, cmd) };
> +        let hdr =3D NonNull::new(hdr).ok_or(AllocError)?;
> +        Ok(GenlMsg { skb: self, hdr })
> +    }
> +}
> +
> +impl Drop for NetlinkSkBuff {
> +    fn drop(&mut self) {
> +        // SAFETY: We have ownership over the `sk_buff`, so we may free =
it.
> +        unsafe { bindings::nlmsg_free(self.skb.as_ptr()) }
> +    }
> +}
> +
> +/// A generic netlink message being constructed.
> +///
> +/// # Invariants
> +///
> +/// `hdr` references the header in this netlink message.
> +pub struct GenlMsg {
> +    skb: NetlinkSkBuff,
> +    hdr: NonNull<c_void>,
> +}
> +
> +impl GenlMsg {
> +    /// Puts an attribute into the message.
> +    #[inline]
> +    fn put<T>(&mut self, attrtype: c_int, value: &T) -> Result
> +    where
> +        T: ?Sized + AsBytes,
> +    {
> +        let skb =3D self.skb.skb.as_ptr();
> +        let len =3D size_of_val(value);
> +        let ptr =3D core::ptr::from_ref(value).cast::<c_void>();
> +        // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, an=
d the provided value is
> +        // readable and initialized for its `size_of` bytes.
> +        to_result(unsafe { bindings::nla_put(skb, attrtype, len as c_int=
, ptr) })
> +    }
> +
> +    /// Puts a `u32` attribute into the message.
> +    #[inline]
> +    pub fn put_u32(&mut self, attrtype: c_int, value: u32) -> Result {
> +        self.put(attrtype, &value)
> +    }
> +
> +    /// Puts a string attribute into the message.
> +    #[inline]
> +    pub fn put_string(&mut self, attrtype: c_int, value: &CStr) -> Resul=
t {
> +        self.put(attrtype, value.to_bytes_with_nul())
> +    }
> +
> +    /// Puts a flag attribute into the message.
> +    #[inline]
> +    pub fn put_flag(&mut self, attrtype: c_int) -> Result {
> +        let skb =3D self.skb.skb.as_ptr();
> +        // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, an=
d a null pointer is valid
> +        // when the length is zero.
> +        to_result(unsafe { bindings::nla_put(skb, attrtype, 0, core::ptr=
::null()) })
> +    }
> +
> +    /// Sends the generic netlink message as a multicast message.
> +    #[inline]
> +    pub fn multicast(
> +        self,
> +        family: &'static Family,
> +        portid: u32,
> +        group: u32,
> +        flags: alloc::Flags,
> +    ) -> Result {
> +        let me =3D ManuallyDrop::new(self);
> +        // SAFETY: The `skb` and `family` pointers are valid. We pass ow=
nership of the `skb` to
> +        // `genlmsg_multicast` by not dropping `self`.

I think if genlmsg_multicast returns an error code we may need to drop
to avoid leaking. Specifically, there is at least this path:
1. Set group to a large number (that's an unconstrained public parameter)
2. We suppress drop
3. We call genlmsg_multicast
4. We call genlmsg_multicast_netns
4. We call genlmsg_multicast_netns_filtered, which does an inbounds
check for the `group`. If it is too large, it returns EINVAL without
consuming the SKB - include/net/genetlink.h:493
5. We leak the skb

However, at the same time, if we pass that check and descend into
`netlink_broadcast_filtered`, it will unconditionally consume the SKB,
and possibly return an error code in other situations.

I think this either means that we need to make the inbounds check for
groups in `genlmsg_multicast_netns_filtered` use `consume_skb(skb)`
before returning EINVAL, or we need to check the error code for EINVAL
and manually drop if we get it. The second one seems kind of janky
because `genlmsg_multicast` doesn't document that its free-behavior
differs for different error codes.

> +        unsafe {
> +            bindings::genlmsg_end(me.skb.skb.as_ptr(), me.hdr.as_ptr());
> +            to_result(bindings::genlmsg_multicast(
> +                family.as_raw(),
> +                me.skb.skb.as_ptr(),
> +                portid,
> +                group,
> +                flags.as_raw(),
> +            ))
> +        }
> +    }
> +}
> +impl Drop for GenlMsg {
> +    fn drop(&mut self) {
> +        // SAFETY: The `hdr` pointer references the header of this gener=
ic netlink message.
> +        unsafe { bindings::genlmsg_cancel(self.skb.skb.as_ptr(), self.hd=
r.as_ptr()) };
> +    }
> +}
> +
> +/// Flags for a generic netlink family.
> +struct FamilyFlags {
> +    /// Whether the family supports network namespaces.
> +    netnsok: bool,
> +    /// Whether the family supports parallel operations.
> +    parallel_ops: bool,
> +}
> +
> +impl FamilyFlags {
> +    /// Converts the flags to the bitfield representation used by `genl_=
family`.
> +    const fn into_bitfield(self) -> bindings::__BindgenBitfieldUnit<[u8;=
 1]> {
> +        // The below shifts are verified correct by test_family_flags_bi=
tfield() below.

1. My understanding is that bit layout is implementation defined from C11:

"An implementation may allocate any addressable storage unit large
enough to hold a bitfield." (This one gets tested statically via
interaction with bindgen)
"The order of allocation of bit-fields within a unit (high-order to
low-order or low-order to high-order) is implementation-defined."
(this one gets checked by your KUnit test)

so we can't actually know that any manual bitpack/unpack will do what
we want reliably - another C compiler might do something different.

2. While this looks correct to me from an endianness perspective (in
terms of what compilers actually do rather than what the spec says),
have we run it on a big endian arch just to make sure?

> +        //
> +        // Although bindgen generates helpers to change bitfields based =
on the C headers, these
> +        // helpers unfortunately can't be used in const context. Since `=
Family` needs to be filled
> +        // out at build-time, we use this helper instead.
> +        let mut bits =3D 0;
> +        if self.netnsok {
> +            bits |=3D 1 << 0;
> +        }
> +        if self.parallel_ops {
> +            bits |=3D 1 << 1;
> +        }
> +        // SAFETY: This bitfield is represented as an u8.
> +        unsafe { core::mem::transmute::<u8, bindings::__BindgenBitfieldU=
nit<[u8; 1]>>(bits) }
> +    }
> +}
> +
> +/// A generic netlink family.
> +#[repr(transparent)]
> +pub struct Family {
> +    inner: Opaque<bindings::genl_family>,
> +}
> +
> +// SAFETY: The `Family` type is thread safe.
> +unsafe impl Sync for Family {}
> +
> +impl Family {
> +    /// Creates a new `Family` instance.
Might be worth calling out that this panics on bad input rather than
returning an error in docs? It might be fine because this isn't going
to be called dynamically, but it doesn't match the usual behavior for
other kernel functions.
> +    pub const fn const_new(
> +        module: &ThisModule,
If const_new for MulticastGroup can take a &CStr, why can't we take one her=
e?
> +        name: &[u8],
> +        version: u32,
> +        mcgrps: &'static [MulticastGroup],
> +    ) -> Family {
> +        let n_mcgrps =3D mcgrps.len() as u8;
> +        if n_mcgrps as usize !=3D mcgrps.len() {
> +            panic!("too many mcgrps");
> +        }
> +        let mut genl_family =3D bindings::genl_family {
> +            version,
> +            _bitfield_1: FamilyFlags {
> +                netnsok: true,
> +                parallel_ops: true,
> +            }
> +            .into_bitfield(),
> +            module: module.as_ptr(),
> +            mcgrps: mcgrps.as_ptr().cast(),
> +            n_mcgrps,
> +            ..pin_init::zeroed()
> +        };
> +        if CStr::from_bytes_with_nul(name).is_err() {
> +            panic!("genl_family name not nul-terminated");
> +        }
> +        if genl_family.name.len() < name.len() {
> +            panic!("genl_family name too long");
> +        }
> +        let mut i =3D 0;
> +        while i < name.len() {
> +            genl_family.name[i] =3D name[i];
> +            i +=3D 1;
> +        }
> +        Family {
> +            inner: Opaque::new(genl_family),
> +        }
> +    }
> +
> +    /// Checks if there are any listeners for the given multicast group.
> +    pub fn has_listeners(&self, group: u32) -> bool {
> +        // SAFETY: The family and init_net pointers are valid.
> +        unsafe {
> +            bindings::genl_has_listeners(self.as_raw(), &raw mut binding=
s::init_net, group) !=3D 0
> +        }
> +    }
> +
> +    /// Returns a raw pointer to the underlying `genl_family` structure.
> +    pub fn as_raw(&self) -> *mut bindings::genl_family {
> +        self.inner.get()
> +    }
> +}
> +
> +/// A generic netlink multicast group.
> +#[repr(transparent)]
> +pub struct MulticastGroup {
> +    // No Opaque because fully immutable
> +    group: bindings::genl_multicast_group,
> +}
> +
> +// SAFETY: Pure data so thread safe.
> +unsafe impl Sync for MulticastGroup {}
> +
> +impl MulticastGroup {
> +    /// Creates a new `MulticastGroup` instance.
Same as before - should the panic be documented?
> +    pub const fn const_new(name: &CStr) -> MulticastGroup {
> +        let mut group: bindings::genl_multicast_group =3D pin_init::zero=
ed();
> +
> +        let name =3D name.to_bytes_with_nul();
> +        if group.name.len() < name.len() {
> +            panic!("genl_multicast_group name too long");
> +        }
> +        let mut i =3D 0;
> +        while i < name.len() {
> +            group.name[i] =3D name[i];
> +            i +=3D 1;
> +        }
> +
> +        MulticastGroup { group }
> +    }
> +}
> +
> +/// A registration of a generic netlink family.
> +///
> +/// This type represents the registration of a [`Family`]. When an insta=
nce of this type is
> +/// dropped, its respective generic netlink family will be unregistered =
from the system.
> +///
> +/// # Invariants
> +///
> +/// `self.family` always holds a valid reference to an initialized and r=
egistered [`Family`].
> +pub struct Registration {
> +    family: &'static Family,
> +}
> +
> +impl Family {
> +    /// Registers the generic netlink family with the kernel.
> +    pub fn register(&'static self) -> Result<Registration> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `genl_family`=
 struct.
> +        // The `genl_family` struct is static, so it will outlive the re=
gistration.
> +        to_result(unsafe { bindings::genl_register_family(self.as_raw())=
 })?;
> +        Ok(Registration { family: self })
> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.family.as_raw()` is a valid pointer to a regist=
ered `genl_family` struct.
> +        // The `Registration` struct ensures that `genl_unregister_famil=
y` is called exactly once
> +        // for this family when it goes out of scope.
> +        unsafe { bindings::genl_unregister_family(self.family.as_raw()) =
};
> +    }
> +}
> +
> +#[macros::kunit_tests(rust_netlink)]
> +mod tests {
> +    use super::*;
> +
> +    #[test]
> +    fn test_family_flags_bitfield() {
> +        for netnsok in [false, true] {
> +            for parallel_ops in [false, true] {
> +                let mut b_fam =3D bindings::genl_family {
> +                    ..Default::default()
> +                };
> +                b_fam.set_netnsok(if netnsok { 1 } else { 0 });
> +                b_fam.set_parallel_ops(if parallel_ops { 1 } else { 0 })=
;
> +
> +                let c_bitfield =3D FamilyFlags {
> +                    netnsok,
> +                    parallel_ops,
> +                }
> +                .into_bitfield();
> +
> +                // SAFETY: The bit field is stored as u8.
> +                let b_val: u8 =3D unsafe { core::mem::transmute(b_fam._b=
itfield_1) };
> +                // SAFETY: The bit field is stored as u8.
> +                let c_val: u8 =3D unsafe { core::mem::transmute(c_bitfie=
ld) };
> +                assert_eq!(b_val, c_val);
> +            }
> +        }
> +    }
> +}
>
> --
> 2.54.0.rc0.605.g598a273b03-goog
>
>

