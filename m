Return-Path: <netdev+bounces-297502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W6rsOaATKWoOQAMAu9opvQ
	(envelope-from <netdev+bounces-297502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B37666AE0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pYPut+Mq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297502-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297502-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0AC131AC747
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B6391E77;
	Wed, 10 Jun 2026 07:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052E391838
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:30:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076628; cv=pass; b=bvagigDWp2GHLeuPzwdTJtB6sSejXqxBADgsh1hToP57KHiUYPOYPFW0r4fd3fMUU3AbykuVelmECS41m3tyxdosXak+WxWyXuaD4tPWRzltRo7TrJHgq8drZRzmcX3rbl1dQyEQ/UxCaA7QBzRT5rVY/5/UlD+dSDCgmtRXc8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076628; c=relaxed/simple;
	bh=1u2BFa1iUX+XKaaA6ooa9MVnK/6+bpSB45oSuaa4+9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwgAI3r7JE1qz2kArMLHCIAYI1CUxJsyPq5gudO0ebvL5Ji9S5DmdFvtDDPi5sluqGJoSVdCxuPZNTPj/6YZLPUiLwmUcE3OVsFBiFs4DCnDJpsK/HMzw0ILGnTaGkpMM08MbHmEHdqjJ1wFSUI3deWpbtOHxKitgACn4fQWOG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYPut+Mq; arc=pass smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304dd3bb7a6so566163eec.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 00:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781076625; cv=none;
        d=google.com; s=arc-20240605;
        b=X3oDlNM3Si7C7eDtQ4LT25w5KWjcSlJQdf6hAQ4WggYcnE3qVEDpb2XVE7rHXqzIrU
         pwZCGGKxUoMgH3/gdaQAdcLpOtAyPSuTtj6od6EnnRRwtNr+dCviTrftw9fsnjYlJHZr
         oqvUB3be0x7aTwKqx/qeL1hNd0Fea7mrhylnQ8XhJo47vGXg4ucBjsutxe59T9b+65pQ
         t6ypGkKY7Or0FjeGwrSioTBgw9A1M7GtAVsLPFN0GX+vJjeFDYxnO+mLUT6Rf7tvzZVq
         aiiCH7paSyu8shJ8Rqf0rSTHsZp/6x1Ogc3fC6Yub0lv4hDwtmINraIzm43azbHI/Uib
         a7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pi1bSKu1iANxXNi53S3zpezuz21+ZWdmB0PoX/T+q2c=;
        fh=oAwmwObgMB3S4XH3gBTXhbP9Wn5ykILkhs3MpDP1kAA=;
        b=SN6XNDcJ5/4xZwAAkNPmV4V3YgZ5M7wkcrK86ETiTkFjvq4AejpDoEt9vu6Tkcn3kr
         eRaYoD7Je3opD8via9cqo2atKE9D7Fqoscfqn5SeVd1PUvUK6gYQq+aCMVPs3aEn8wj2
         QzbaybJA8SCRgBVxf7PXK2ZmPIKJBNeeCGLCa2zghQsOKh6gALL65CWbU/ySaBnwRbpV
         uW4oMWyczgUpeNfkLkmBnBPA3H8xrDt8EOhqgJDmmrw2urIyd8v5ByaN11c/XHsdu1je
         WGNYdbsCzKDKdyCEZrLLZJ4CHG+K/fBC9hT656bYvajFh6rdM74HaNdIxHcV1c0S0tH4
         2aHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781076625; x=1781681425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi1bSKu1iANxXNi53S3zpezuz21+ZWdmB0PoX/T+q2c=;
        b=pYPut+Mqxq4/OOvf2q1dARN6KdpIUt5at9sqi1VUtwOCSMTLRz0qLIzYcf74RivN1v
         JXXCMc8ZJnnMnai+vtGaa9EH29zddtISIuWLk26GRxsvYR+Uik8AwlGUViRR4fePmVJn
         EGx3zGrkbkD/YArVm0bCnwtIyF4/sRNo0N+cGEThfkl6QuuZ3t8YyFjXf2demfoZ8F7D
         MV7GcR/WkkxWtZWDRjdif5Iqc4g+LJwifcQdaRZMcmdGQ3pOhhKDVVlnAE+pJscxjp0f
         nlZetxkfrHcSw8b+TvhiozWfw4/P0fnFMDKQvECo7J/X0m571HHoMfdtsCunitsB6UDq
         TfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781076625; x=1781681425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pi1bSKu1iANxXNi53S3zpezuz21+ZWdmB0PoX/T+q2c=;
        b=Tpp76Jah2QLqzEVqJvIBi1vGkqqOGhDh/DapJwkc3FhWeyM6Dw+XCqMBOkfkXcckJ1
         5vMdflhlhQyzfVeEoI0CmgYws763J+5Gt61mFkVlSDrOierhKQ8h1mACd539DQHkI6O5
         p1avUiRPIqkx3OFzpdsYRLrdtChJ85k8J4aHQqi3NUalm7RtDBM7asq3w6Ip+hKmYcI8
         XdPh8Lk/Yu+DPVYj1OQxlO9PYf6Cx+WyJ6jAzIXikutppNmxzvdlCx6MhvXV3LOJbMoQ
         foMdJqfjiZ+DlLILLe2Qylf3p6cuwSPpm5b9eTVyhMkx9Stuvr8D/418i9D5goeozBGF
         M6bg==
X-Forwarded-Encrypted: i=1; AFNElJ8dxBgKcT9stpSYeQZaD4Vh+LoHNzrAekHnc05oP5brX+naR3hxPraLVZM5DrQaMEeQnUlTr5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwgNfvE+p2lSQ3mjCvVDlpvAunJtqaYPM06Pgf72gylIgKnpi
	Qa1MqWmSrYchvpGaX6oIbe09/UPOr+rbEBoIgSwI8Yam2AJ1xZccZ0FuNTIj6718rUhtLlq9In/
	EFn2tJ1BKic7DJVHVzYZkl43aBOaIYl4=
X-Gm-Gg: Acq92OHnFxpwzcDpaosuTRv28ueOhHOJpt9/fpEdOcIwvIv1mdW4B9/C/oReWsxnapd
	A2HJUbG3lk77wuiOwblYChO3om7UYJ5OrbNLSKVgJ0tWeqiReYEt0QJkemhUvJmbjQbenN1yoCR
	CAJQteM/nq8nEeLp69a8IdmZU1pTrvfhnIeQQGIDBA29v7dkRA5D9RFJZpRsDw61fIsicK+BOCW
	J64B3ZH16EYR9JlfUNu2FOD/EraU8cr17rRYezMRqH0bronAJxbsGFmijZSiujA3bqUV8fJ08OP
	wmmsTCAsAoyEx+N4dwKI1fFxmP6Xt2EGpV/Y968Xal5ErGxwls8hvD1HhEvrY4wI7yev3rVnFXn
	cFKKVxBEzRpqA8pJY7rBKlCuld8uuMSvlFg==
X-Received: by 2002:a05:7300:bc0c:b0:304:8860:74dd with SMTP id
 5a478bee46e88-3077b57ff09mr6067698eec.8.1781076620726; Wed, 10 Jun 2026
 00:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609142637.373347-1-gary@kernel.org>
In-Reply-To: <20260609142637.373347-1-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jun 2026 09:30:07 +0200
X-Gm-Features: AVVi8CfhtUOUWqMJb81Bw-Ep_qKBuU8iXg5G_qpR2vrQ4E2KJJ25x_mDHtH0Smg
Message-ID: <CANiq72=H_box4dE2aFWcENE-UY9_1cAKMWzhxLUS_a=zHsFKrQ@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related macros
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Tamir Duberstein <tamird@kernel.org>, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:dakr@kernel.org,m:acourbot@nvidia.com,m:aliceryhl@google.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:fujita.tomonori@gmail.com,m:yury.norov@gmail.com,m:will@kernel.org,m:peterz@infradead.org,m:mark.rutland@arm.com,m:mingo@redhat.com,m:longman@redhat.com,m:tamird@kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:driver-core@lists.linux.dev,m:netdev@vger.kernel.org,m:fujitatomonori@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,gmail.com,ffwll.ch,protonmail.com,umich.edu,collabora.com,infradead.org,arm.com,redhat.com,lists.linux.dev,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85B37666AE0

On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Given the macro scoping rules, all macros are rendered twice, in the
> module and in the top-level of kernel crate.
>
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Acked-by: Boqun Feng <boqun@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` -- thanks everyone!

    [ Sadly, because the definition is hidden, `rustdoc` decides to not lis=
t
      them as re-exports in the `prelude` page anymore, even if we refer to
      the not-actually-hidden item.

        - Miguel ]

    [ Kept a single declaration in the prelude, and reworded since they
      already had `no_inline`. Removed other imports from `predefine` since
      we now use the prelude. - Miguel ]

Cheers,
Miguel

