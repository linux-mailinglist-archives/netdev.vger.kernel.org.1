Return-Path: <netdev+bounces-270212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPGjNxmgvmnoUgMAu9opvQ
	(envelope-from <netdev+bounces-270212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:41:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A42E594A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7BCE300B5AD
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225331D726;
	Sat, 21 Mar 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZZZduyM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE92C0F95
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100502; cv=pass; b=TbkyrC8VJC8SfMuTIrh7uc4O2UsHH8ZOp98a2/Pzw/auQMTPqBfA5xz6qptvXbzpeKMEj+eKy1Zyrl3rQlzPV/Soe/NKjq/8hV1S/LX/2pjgSo53AHg1ooq29PtPwhhKLyF4ycLrjh5kRZ/acJoPmRgYLkwAQzPjfIrZyr/BHi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100502; c=relaxed/simple;
	bh=E37BO8hDdA+Rl7BL4jzarWentIvaF0FL23SOtM4G2kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlShvl8XeGQYJbeRl6j05GAVKtDqViNHrGVbEQ2/xIrrQz28ERlnN2OiG+qSeacp2A8vcj0DABmP/Jn5T4Aa3NEBdMT6BzZFv8IT2Ir9pHded4PS7jlIrap8Ij/kr53LduMMGJMue9I4f2ojcXkS6smjbl1EAQ77cXBJGehwK1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZZZduyM; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0c7267500so147782eec.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 06:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774100500; cv=none;
        d=google.com; s=arc-20240605;
        b=Z28fDv1iA52sLi6ucWpS5/vTjOqDNpSBAxXNveSP95WslxO710JgL0OvmtYbxrfJvX
         wMBvNgrPGVJMlICrYOUPTFXwyFqdrPksYpi6y7LFehAStkPaWfPVqaU9j0Fa11SV8c7K
         PJXR3W5LlCcb4NSNWmxg+/pwKum7wK6tNcPSndhrxC1SBAlpCRbnNsM+2T10sRQPowV7
         7GByEQDGfybU1WbkkC1Id2Nkfk0Mt2uQtd+FJ3GqxJGb4fXdzwrhomS5hMQaKQ383fIt
         WnFGYFOy6x9JVu8fa5Abz3r1H9SaHgP4SN6OguyZivCDM1FiPFJwNN/09QrvwyCCww7/
         EZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLhX9/g2+09qUmS7UZocL6buru35hRvt9bcjyD+wrFQ=;
        fh=zDEwW7riqitJU1a9cidRTQGfghcEcER8nAyO9je8Kzc=;
        b=GMIBBXqwIoFnUk85XyfYyCGUgu+wAlvlcvYSu5fTOgbpGWGoUYVTY1LfY/J0AIqhjK
         XYU6XJNEZPgQBBjR9jUuIt9/uhsbVNxRB43SEZ4fxxBK1dBghecvXeEFssm7N5Meo0jx
         17LVqmIeN6cBPJU+Vc0niMVi1kc/F1M2qCdUICWukfpU/kTbbytZ+hXDRnh6Upy7w+H3
         M2jM/WAk9nzSWv+nh4umIcHMuL9Vv/Q/j0PcpKT2ggzXkcrsbmkktC/DUP+z5LehvH4m
         DxTV+5sMeEga/VWvRbomTSCqDEYsxUztOby2NBX5U0CfBKfYs/rGb75F2QJAskA3rN0h
         jQaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774100500; x=1774705300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLhX9/g2+09qUmS7UZocL6buru35hRvt9bcjyD+wrFQ=;
        b=JZZZduyMPua2CEFOIXBWpm54rZVlbfXVB1DgxchOM5vj4q9iA3zQJ/60i43RMqVaXI
         +MYGHtosY9TqOzHS8W3FyZRwtS3y9WJ0gZIe0b5Kp5QKQ9sTQBGoiISafGCT+1OhQHvZ
         7+0dmkdTqJF11jgmK1uhvyOwflx2ngeidAGoZOXkAcHeV5KzswORWuUTi0jx6dU77OkP
         +YoDPMgBydUZ88V7ydNZQqT61gnuCg2K0ou/oDwg0Z4VLJlnA0T+yImGjs/7BAtqcM6v
         XQGbZ9DzU90elmvETgXKjMaVrfw3uYoc80tULdv7FLVjvsRYqPXbz2IwLqJFOR7hP5kb
         KJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774100500; x=1774705300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLhX9/g2+09qUmS7UZocL6buru35hRvt9bcjyD+wrFQ=;
        b=gYqdEugPVhDOt6vBn1cI4aflyBMvJ2Y7lnEPboHOg9PtupMsxJG6ixQxMdvRl5fqk/
         vOd8r3RmpyaJcQqhIbPOdfFqedfONADIolMz+kHEaDtAz0l+0rUgYzAHMQV+wO85wNwl
         qpfxCml/7vjZkXQFFrI37oKyBSY2ZR4/dYInV9UlMnlK1m99BeaoC+HAebabWCGv5vVk
         HpMyWHDt1V/Y7FRDCQI936K5gk0OdQPeJS3Y855OJuHY4CDXFHi/kBvS++kJCW5T4a2Q
         XYZ7B/9tBwQFcOSnNmtNwPQ55ll+fo/IRNrg0dlfuOD+gfWaLudIXgpbte1dzbl+l6gh
         Fiiw==
X-Forwarded-Encrypted: i=1; AJvYcCV/13odl3Hs3e5QYoCvvAe8chc8WLaSPX1ztZcsjHl1CXO0Rj8FZcSnnsyYUG9BLf/1x1MSrq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6RwgEU35OYw/lOfjY+fks3zds7/pgO61lfc2usCCFgo5uSBU
	LcSvezFrNYOHI0PCZYSm5jYkNWBbXDnG0Tkl6Ub5MYjbrD0nvMdtB+G15Yo2i4byQEsTr8QY689
	+P9U7DkkY++y3u7wAXA/LpMxarLB3/Uo=
X-Gm-Gg: ATEYQzzgAiOgt8KirLhAk/6/MWmIeClMnPB5t3emsZJTJP/KVonqnaVuWwHyx7TnpNB
	IDtBVh8TgfLOo3tUNq0FuXah+qa3nx7XQ9xf6QyxjhRAxcdeRliKm8pgaZe1giMATr6lLMcZPAD
	Hc831A5w5sMJKOAYX7FNr/wIQ0XizbDeXJxgW6ri/oE5q2GuPVe/MfJJ7DqmMMBF/q0WzoZx837
	GOM/vjp5W99OHWRnPs4m8X0IrvEzpRPYnEE711jPgZuLRZqR07uLxJWX1RU9KCKq2VucX5FHPjq
	z+tkrzvGHfJbq7LpWnHhHBDFomjKJO33IRmrbXuh1N5U2Ou2L8/ng2PASydYyWkoZSu2mguoUJJ
	SFb5A/uAVM7BcwdEryP0JTgE=
X-Received: by 2002:a05:693c:3105:b0:2be:687:5dbc with SMTP id
 5a478bee46e88-2c1097cc851mr1504671eec.6.1774100500037; Sat, 21 Mar 2026
 06:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org> <20260319121653.2975748-5-gary@kernel.org>
 <DH8HDA6Q6FU3.3JR57W97IO1VE@nvidia.com> <DH8HYCAIRCZD.2DXSNBFXXT6ED@garyguo.net>
In-Reply-To: <DH8HYCAIRCZD.2DXSNBFXXT6ED@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Mar 2026 14:41:27 +0100
X-Gm-Features: AaiRm51Hwdlg5eHPgbbbJ8KEe0n7xAmw4NZpb9mUA-Y19mwW6yxZqTznI1K4o44
Message-ID: <CANiq72kamU+XqG8AisK8uk9A2vkJeo0xcXZ7SJiisb9KMLK6ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Tamir Duberstein <tamird@kernel.org>, Yury Norov <ynorov@nvidia.com>, rust-for-linux@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270212-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,protonmail.com,google.com,umich.edu,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,garyguo.net:email]
X-Rspamd-Queue-Id: 895A42E594A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 2:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I personally view them all as variants of BUILD_BUG_ON, hence the name is
> `build_assert`. I thought about `assert`, but to me that feels like it's =
going
> to host runtime assertions.
>
> I won't be surprised if we're going to have `assert` module in the future=
 to
> host families of
>
>     assert!()
>     warn_on!()
>     unsafe { assume!() }
>     ensure!()
>
> etc..

We also have now `unsafe_precondition_assert` in the `safety` module
which is essentially a `debug_assert` at least for now, which could
potentially be moved too.

Most of these (both build time and runtime ones) should be in the
prelude anyway, so they should be easy to reorganize.

Cheers,
Miguel

