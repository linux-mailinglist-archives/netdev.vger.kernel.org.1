Return-Path: <netdev+bounces-270330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLdVNV+GwGkKIgQAu9opvQ
	(envelope-from <netdev+bounces-270330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:16:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD52EB3C1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3795A3013276
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5918A92F;
	Mon, 23 Mar 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K49IgaKB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA183CC3
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774224967; cv=none; b=saj25STq93wEI1jLmhv4+LlyMHu9XHTniJD0HSNbiXrGR/CUbFjtsToGNyjKwhXELqmoZ4pkKJh1xn++o96n60NXzRIF3BUyGPuMWqKf7kuGhYu16CAnaKI3GAk3Q7W3dtaTq2+NKGYU2d9fZku1u1VQ5W6IFNkDbYjuRsQs/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774224967; c=relaxed/simple;
	bh=Vz6hlss71wCpMQTFpOI1UCwil8q0Rwfj9v3C/adr88w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZp16CkeehC79TOwd3az6NehCRs66XmvmTIQ4wxZtgGeGhVRXYsvcuVJnRb/X3fqwYSHvcnaJGU4X1wGwaVy78bryiKAG5t4XG0KAUKbC5Y5aNO2AXeYi923hnkG8NOr7HdVCqvueq0+LC0+4XnsO1FAFPPiF95CJq2lydoUGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K49IgaKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D05C2BCB3
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774224967;
	bh=Vz6hlss71wCpMQTFpOI1UCwil8q0Rwfj9v3C/adr88w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K49IgaKBHvfjrjUTPdu5EtJnJwHDSCtVg5836pGr17Tolll4phlkn3kK6tscuRGv8
	 lj5wVJvGU+l0/J3q8zhrEzFzUOcZ577TSsiAgd+xEM4SQUags8QNKmcaMuEsX2IIk6
	 Eupr/0fE/NSaHgtnc8Hv6coQqu/Ie/rMmpxuqD+FL1PqFdABPdkDTe0xVxxhv0IBoj
	 SxDPEqllePTuhppFENB0kGnniMAP9rmUokobao7jnz8BsjXfhNAMi4/3yzzIiD8l7k
	 ZBBGM2pjbfHTbcV4vglorRmhvHpscvYWXeZOZ0N8aMxjr/cT2T6v5elPXiIGjKWhaZ
	 w/LiUbTXc5X4Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a723b2b29so28932081fa.2
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 17:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRjhJB6479cDoP0rh3E+TRQY+ESoY1dm/pWLmBqxy49NdTHccooIGM0srj26EBmrJFN+4KXn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FoQSmBsEbn7UsEz1oAU6KId0+sKXVAEVwAPCBM2MpWDRYuWi
	/x7qu8brOtbwhbXzN4xoHQWWib+YR1Ml5lgl8ego1Nl0GU87j7XR5SNZ/xRZwmnWMSaH47++aj9
	CfBczzSHzS2DavKRjlJAohVEm2a5q4h0=
X-Received: by 2002:a05:651c:1313:b0:38b:df0c:979f with SMTP id
 38308e7fff4ca-38bf9741c1bmr26363211fa.37.1774224965758; Sun, 22 Mar 2026
 17:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org> <20260319121653.2975748-5-gary@kernel.org>
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
Date: Sun, 22 Mar 2026 20:15:29 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9k+aTosVrC+e5SAm7Hso60sGw=YiBRjwwx5ruRNgSRepA@mail.gmail.com>
X-Gm-Features: AQROBzDn4PtiEdBNjn48YaossWLeRtmfaQJy0WX92eUX_bEnBMYsO2ItiMTXlbM
Message-ID: <CAJ-ks9k+aTosVrC+e5SAm7Hso60sGw=YiBRjwwx5ruRNgSRepA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Yury Norov <ynorov@nvidia.com>, rust-for-linux@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270330-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51DD52EB3C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 8:17=E2=80=AFAM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Given the macro scoping rules, all macros are rendered 3 times, in the
> module, in the top-level of kernel crate, and in the prelude.
>
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/bitfield.rs    |  4 ++--
>  drivers/gpu/nova-core/num.rs         |  2 +-
>  rust/kernel/build_assert.rs          | 19 ++++++++++++-------
>  rust/kernel/dma.rs                   |  5 +++--
>  rust/kernel/io/register.rs           | 19 ++++++++++++-------
>  rust/kernel/io/resource.rs           |  2 +-
>  rust/kernel/ioctl.rs                 |  2 +-
>  rust/kernel/net/phy/reg.rs           |  8 +++++---
>  rust/kernel/num/bounded.rs           |  2 +-
>  rust/kernel/prelude.rs               |  3 ++-
>  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
>  rust/kernel/sync/atomic/predefine.rs |  2 +-
>  rust/kernel/sync/locked_by.rs        |  2 +-
>  rust/kernel/sync/refcount.rs         |  8 +++++---
>  rust/kernel/xarray.rs                | 10 ++++++++--

Acked-by: Tamir Duberstein <tamird@kernel.org>

