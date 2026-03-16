Return-Path: <netdev+bounces-268229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKv7LI1CuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:49:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D71429E84E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EDE23074F32
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE7339878;
	Mon, 16 Mar 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTui4M+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799451A9FAF;
	Mon, 16 Mar 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683100; cv=none; b=FZo+5P7XDv6V29LkG5MYU6SHRBZPjGT8Nrcq+9B5vTHPQIOQjr5fti6uvarmYCrqiVyDVbFaHvr/5I5rR6PXJzXYB7YZOevLrtBcX6zwkAcPupl3VEt6+rIHfrwuqEpyRgWGmuJCID7zaNoyJ0Q10wAyYFNRRGD3Xw6fhBPvQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683100; c=relaxed/simple;
	bh=w/zVmIvVRlvAcWc/q7hSUbNiIiAMLEpfTODNGbRGoAc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a3oeOIlEowqmjiYslgQMX1uXhNk3izohujfMqHXhRXvBIqUXfEvAjoCrK7DqD2qszOOpSNzUWzf0slwv+4Q48LceYes6deuLtcz2rtxyfupo73/YjMAi15C4MrjF8uMVcWJ/rvySNEjajIlH+OgBZuV9f7fbPCFwcYF4DrRbjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTui4M+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE15C19425;
	Mon, 16 Mar 2026 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683100;
	bh=w/zVmIvVRlvAcWc/q7hSUbNiIiAMLEpfTODNGbRGoAc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UTui4M+W3iOIDWHV8IOGKrODOXifnDow2/g26R09U8g0c/Vx3WQdgiWgenmlPVAc9
	 QYqd6kV0Qj2Np+uS3y7FGQrJTrHS3kNGCAjbz0NbNMTX8nXsLtlpmy1ojPqr0svgcR
	 3TOKVcRsi3r9p+CLo3KKNVg/xeV3gbfHc0d/EfbS4aOEZ/yiB2iAPKwUmh/2b9K30E
	 tgtrtNNDDUhK12SCk5UxVKEL1++oODOOk3itsnTfSdfYCEuZ29cY4RRZHhGga4VEAR
	 Acn5k0H7kPQZmPIeL65B591jZqcxeltiPsR6bbOyw7k2cqsng3RDnuatbxnQUeGBe7
	 mk7BlSvU0+0rg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 18:44:53 +0100
Message-Id: <DH4E6KJDQJBP.1UR72LIQA0Q92@kernel.org>
Subject: Re: [PATCH v2 4/4] rust: make `build_assert` module the home of
 related macros
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Will Deacon"
 <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Waiman Long"
 <longman@redhat.com>, "Tamir Duberstein" <tamird@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
To: "Gary Guo" <gary@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260316150720.1646109-1-gary@kernel.org>
 <20260316150720.1646109-5-gary@kernel.org>
In-Reply-To: <20260316150720.1646109-5-gary@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,gmail.com,collabora.com,arm.com,nvidia.com,infradead.org,redhat.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D71429E84E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 16, 2026 at 4:07 PM CET, Gary Guo wrote:
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index a396f8435739..bef3f33cf2ea 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -5,12 +5,14 @@
>  //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-=
mapping.h)
> =20
>  use crate::{
> -    bindings, build_assert, device,
> +    bindings,
> +    build_assert::build_assert,

I think we can just drop it, as we already include prelude.

> +    device,
>      device::{Bound, Core},
>      error::{to_result, Result},
>      prelude::*,
>      sync::aref::ARef,
> -    transmute::{AsBytes, FromBytes},
> +    transmute::{AsBytes, FromBytes}, //
>  };
>  use core::ptr::NonNull;
> =20
> diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
> index b7ac9faf141d..9cb18ce1c479 100644
> --- a/rust/kernel/io/resource.rs
> +++ b/rust/kernel/io/resource.rs
> @@ -229,7 +229,7 @@ impl Flags {
>      // Always inline to optimize out error path of `build_assert`.
>      #[inline(always)]
>      const fn new(value: u32) -> Self {
> -        crate::build_assert!(value as u64 <=3D c_ulong::MAX as u64);
> +        crate::build_assert::build_assert!(value as u64 <=3D c_ulong::MA=
X as u64);

We include the prelude here as well, so this should also be just
build_assert!().

>          Flags(value as c_ulong)
>      }
>  }

