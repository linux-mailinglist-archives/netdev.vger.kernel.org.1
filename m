Return-Path: <netdev+bounces-297186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eOt8Ii9LKGrhBgMAu9opvQ
	(envelope-from <netdev+bounces-297186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:19:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3E662DAE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ILC3pvwH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297186-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EE28301A0B0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C04C041A;
	Tue,  9 Jun 2026 17:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D83AA1A9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:19:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025579; cv=pass; b=oW9IN/iaH6hxKCcw7K0OOoL3cYqAO8liTCR4LG7zVqIhtySEbwOmQEznfEEzHxRWy07K6zI9C2MLNzyvcSv517csE82nscXf8b9cM30J3iMsirX0hNn5Grpj4wlQuAphdpH6Sx5FR0ie/XwW69SXfiQj/lIsr84L2m37umO7DcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025579; c=relaxed/simple;
	bh=i9E6g7FrTHJuH/KM/L2YDGTx0q9lRs2Xj+Q3YKzpptI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAS+cydgH1XVFpz05MR/mCM8OsNcFZnXxKHdZYLKpu/lAuB0FqwHsnWjitROiPh4RFOuii1xh8dwxqSkTtEXS6nDZKMw4/KUjP9hummJpWkhV4VHc2nqP6U03w88hPVOYn3lvv7kLz4uP6erzRr8F20WAhqfZ02HXwlZZx1/690=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILC3pvwH; arc=pass smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304f9bc869aso714648eec.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025578; cv=none;
        d=google.com; s=arc-20240605;
        b=Sa++xqdHGNGwh25KycrPEfIzGXgkcwrs0L+cti5Q0j62Bqr5CsUc56kQ/otzEAPBdF
         hrNoTijMM0XsU6Olsrox24lJYiqDuzDsN+iiWzRXExZXy0ctiD3v8bZDASIxtqdrQPe/
         F8ZizJ7MypHPJ/b5Liq5ivMo5Uwwx4eSsRy5HWIY7SSp9AfFKueM+Bo0TLsVBwvG9sC0
         2Tag1qTmf/HchM/80IflmFebMsgFa01YTik3gZCdPRVGG6ZY4ZNn1mtADOgBYJqt8Dgr
         NWV8ZI2IThGdNOXuJ4dtFhFIZw8vFK5aSbOl55K9hhBpndqTftNsjXrMZsfTEPa8oQQT
         h4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qdj1ZDhkK9hVS2s2BU4ZL0QegPmYjb1pgGPh1FYEFmw=;
        fh=3y/2bwCvAl6LFDn/NEzoCq0IDXNMaUTbdBD/zfI0WO8=;
        b=kwQGMWgbFRnQyGyezkni4JYhpUf5HXiwsuKu+BJ0FvyiZEWqO7p6SzWF1TPUSAr95U
         Pk0PJqbYkbMafUorZ09AG7gbo4lWDQ2vfKb2jZXj+fzdAeUkGxLli6b0sfiS039HRhEc
         M0AZnVuJ1ME54IDVg8yZA42YdNg0F1dOZjr6lLgSUyyooY4MCt5m5oH7TpPGqMW6kOYx
         1EPLPwpBsaKtTNMPyLq1AkQWPlZnCIf7u7YrDD93PXvwQxZRiMqkruc3ByzmWfMYD6Mw
         iRKhAP7GUNDW+DjQPCzgwJRe4RS/BfamDKKxZHDNU5p4XGGCN2+0TvFLsGPG/Rg+6xkh
         jBlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025578; x=1781630378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdj1ZDhkK9hVS2s2BU4ZL0QegPmYjb1pgGPh1FYEFmw=;
        b=ILC3pvwHmwrGs+WIEIEIAs3/R1AaG67QWbLwRlH0vi7RDeKE6UhFGy4Q81WDDh7XSw
         E7yvTiZPPgh7gIZ20+nT93ooOHAnRyRlj01xaFgjm2yc6QHegKQObljIcffnVwKI/4CF
         vvjG1AhhCwUBG4bzoESOvbyvmxq8lN1z+Dh+jRLvXDnvEjhpZmdqecGE8h/4oCwMDslo
         SOGPQg4d1vnq3kX0HwY2UPmVVY0VguyvnpPs9nPCRHmEeVUL1U+VetHtsQeUcSryhqR6
         K1u46KP66wHOkalkuuVFdWtCOYIy/H8Nmvh/uqNCTwc03nQnk6Y1kXXrm3OE1ugNkHgk
         jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025578; x=1781630378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qdj1ZDhkK9hVS2s2BU4ZL0QegPmYjb1pgGPh1FYEFmw=;
        b=llV0byHJjWZeEXUg3GUZXsJ6+Gp22fFhNeJ1b9lUM++LJognxhWuxo9YwJJMeldXPU
         2GzHYcg4a6VlGX37nZw14tfqeDfqpvgjrYn1xA+bixzZqCxp0WHSnfhpPfc5pvG/67L0
         R1whjRedZyxyjsDb/1Z5EXLKG33tMWjhZOjLS7JCWZ0bJd/pKJEilnwZm8kkAHZ4cjys
         QJ92BKzYYWB9XeArO/MRqCqqSV+92iAH4J1reqeWQ2s4AuN4zdo/rD0FPJzJFCKglXrZ
         bdj4HdNSo8LO1g0U5fxT7bYSadGQWMf/6slqaEYwGYpCYvW0m5KiMsUPjDjpoJWR5Rgc
         sEtg==
X-Forwarded-Encrypted: i=1; AFNElJ+zR/OZRs8jd0pEZbyYiBaMeRtMcmzJv2NdKZnh7KwnKt+rFHkgG6H0whRpdeL/bcYXSCaYvZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpXWl11t1+wU8Lih1pAkzDQY69ygK81kiOXd2u+rk8fQH1ZtX
	iGdaHR5kfB9a8BnjXFEMwEhBRo2cAdptUNYnWeWvjqSn4DBSIstNVPbmURk8ThcVadscDqMI08k
	kKCCT1eC4xBt0mUNODWQpuxweqUZXkhw=
X-Gm-Gg: Acq92OGXGfl7PiF6bIDPnumAzf5IrbNwp57satl9EWr6yFvHJk0zIfQIDzDBtjmEzFI
	t+XDJgo5zIVgPCcwG/ZvHFMV3mIywNOl8Qwv9KNE/2g0p9UrIOQlC80crSAwb5tMpuK/A1nkAEY
	3A/fJcFIkrOPz8laLYoT3JN8OuiRk87JnY6pUbipVYRku660B36t2eoMKNHCwu4LlojGq4GqTrG
	dZQt/avp9tXd7zaPDxXsflvMOi+cMmtNTbbZKIzjek5ahJFSu4s7+A3Lxnbd6bfgqCblMCyxG+H
	VycSNpC9qwvFPFnCu6+CY598jlwxKbpcZqGd9vqV0asntcXJeG+g5MKu6zMFBjeFoP3gLN3KeLW
	D/P9bxsN45jNeYt/ocrJ5wo3px62ZE30FAA==
X-Received: by 2002:a05:7301:169a:b0:2ff:b29b:87b with SMTP id
 5a478bee46e88-3077b5fe235mr6554986eec.5.1781025577871; Tue, 09 Jun 2026
 10:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609142637.373347-1-gary@kernel.org>
In-Reply-To: <20260609142637.373347-1-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 19:19:25 +0200
X-Gm-Features: AVVi8CeFkVbj9E3PXx3Az4UAa3Y8O7iOpi-vamCvayZRaQa0QwlC9T9yRU6Twpc
Message-ID: <CANiq72miJLmc2EadxUa+yVZ5T72QuTES4Gz=YVUsNivYvR=wDQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:dakr@kernel.org,m:acourbot@nvidia.com,m:aliceryhl@google.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:fujita.tomonori@gmail.com,m:yury.norov@gmail.com,m:will@kernel.org,m:peterz@infradead.org,m:mark.rutland@arm.com,m:mingo@redhat.com,m:longman@redhat.com,m:tamird@kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:driver-core@lists.linux.dev,m:netdev@vger.kernel.org,m:fujitatomonori@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297186-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29A3E662DAE

On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> This is the remaining unapplied patch from
> https://lore.kernel.org/rust-for-linux/20260319121653.2975748-1-gary@kern=
el.org/.

Thanks for rebasing! I had it as "Waiting for apply" in the
spreadsheet, but this saved me a bit of work.

Quick question below about the prelude...

> +#[doc(no_inline)]
> +pub use crate::build_assert::{
> +    build_assert,
> +    build_error,
> +    const_assert,
> +    static_assert, //
> +};

Did you split this for some reason? I moved the file to a single group
per crate when I moved the file to the new formatting style, so I was
wondering if we could keep it non-split. I mean, it may be nicer for
macros since it allows us to group them, but I hope we don't end up
with many `use`s again if we go down that road again...

Or perhaps you did it for the attribute, i.e. it may behave
differently, but I doubt that is the case? i.e. if `no_inline` somehow
behaves differently this way.

> rust/kernel/sync/atomic/predefine.rs

In this one you used the prelude, but in the others not -- which is
fine, we should be using the prelude more (though perhaps it is a
separate change), but I wonder if there was a reason.

Thanks!

Cheers,
Miguel

