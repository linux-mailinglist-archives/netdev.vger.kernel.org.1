Return-Path: <netdev+bounces-302782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vCZIAFS4QmqjAAoAu9opvQ
	(envelope-from <netdev+bounces-302782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:24:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FA6DE026
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=fHYtUjpG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302782-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32000306BBA8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847F3921D6;
	Mon, 29 Jun 2026 18:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C838CFFA
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:22:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757335; cv=pass; b=b8vPIZVYcretXK9xNjcgFqEZdkvxhhbcIea/b3G928aBjRfEu2eQeTXC1VMVQquBk1KrCf3plRnbHMpdm0dPiwtlxinPcIfh4yj1QEYlhvIm9cRyhiLsqfCH9IKfFE22fCCIlGsL+yOUpB0YUgHmklxCVDam4dEvtZsW/mEMWg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757335; c=relaxed/simple;
	bh=XZWMWzzbxTCp0A/hORW1iOXn19N2bgzGEEw6BeagaM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+xgMpH6HwEotgmbxXSHDOo7MKM8fxUUl6U11gX6HlBSjBOZySRGUNAzsUBc9+ADL+BoKLqgaKu+swY4AkidmPaMdW0rwNhgBWyvbXVC/amI6Qn2S1rJ0VFYnEDlrUVOupPd+nTQweFeAOiTYaSG8oiZp0JvWecMGTk+Nu6JgjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHYtUjpG; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1390f75d8bbso7638542c88.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782757331; cv=none;
        d=google.com; s=arc-20260327;
        b=V5YXBpNcwRkISsGI4Krss6K36i1/1U29NVejvTQyRjVzVXtiudeuQwQXC35V5zseKL
         yZgH7+yrI3jdmoGVELvT5plkscqE9R9z3KvyQp0v9+ZyRm4NHYs9W9SJrlle4H+/rGdF
         Y9JDpglWzoJyFIzCXEbY9qJab5Ha5cXocfEoK8AbmkyMGYKdlYxdBkkP/E1XnWl9aKwN
         Kl1ZOa7YzPL+JKA6fX/ScsP2OGUP1fCDTXF2rdUD3RghtfX8Ri74OwQ8+uLr0SbzEhAc
         VDcYPySTty+YxwMhhisb3cB12NAXnhfO5VCC67jNn248NWIk3IbEzmDBkcZMgkIdCZrY
         SLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ykRpmoyNL9IVnFyPiGeEc5sahAk42O8etvuHtouk29M=;
        fh=QMiHEcf/i7qVTw9XqZfozit/lUJXqbrNM2kEnRpqUS4=;
        b=Ky+UkJDRy0Icbc1dER+RRAZnr86+2PFtZLm24dWUNUX6ePv3AYciK2Zgnman5Icdy2
         6FNKNmDVrtyyCbDHxcPBnVKWduXDoFxq65KMFMiasrVmdkaxxzwoHcBVR4di6xzSXXXv
         DEBcwfE+rbLXiedLTkN/b0g5iBKY1b06WRB05JDNh0IN1l5luzJ5J5dwBdCT/tWatY8J
         QMi+e3JLzal8V7XvQ/nwxT4yo5ePA7MhmAUQLJKB98ijK4Tjkt8t18IOWEpbUYkRiNWW
         9ArqEFcdBW8XIculsBqkn5JNzNClq69bqysy7E0+jx4lPiwD0mGwjX75z7pAsnUrkHl0
         vxMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782757331; x=1783362131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykRpmoyNL9IVnFyPiGeEc5sahAk42O8etvuHtouk29M=;
        b=fHYtUjpGg7r82XKWNqoqSuRIYi+TX22wUWApwPJlWAR0HFl4plEZFZA6lXkdT0bd/x
         OraCmke8mHK274LGa41xlZl+NQRuAqWH73GWFuJP2P0PIBv9Bvf7pElMafs8sOcLZO6X
         a/gjaeSDTIfJAkwvJH09oCUivxUjtXcFybO2+hRhGYyWWSbob398mVbWjVdYJKMVbGBE
         4odZeYmaI7dIDPRXxtUFBM7jNwfTqsLbeX3+hvs41UV5Hk7B1nZ/a7QBnvgSHDaRQ6kY
         /VujH13MS8fSp+l9vGTHSZ8Q6/Tb76sQfNhzYAghkTgkEJKNMdKg1ZfGzqe8AbIU0s03
         JudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757331; x=1783362131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ykRpmoyNL9IVnFyPiGeEc5sahAk42O8etvuHtouk29M=;
        b=A3/gkfqphMiq5zgyrtwHjnNGZID8GlyKVTmmX2UlwaaT6nK90dcIaif8FgqQq5/lOY
         Q5xKYkFcOMQ5ohREP+lIM04d8VfG45fv9v1eDUVhpb+76lRbPd9TZCNhH+Oasp9eb3SU
         SkHfgHUarAeuE8itCqHb1bIzLwcNjcAjjzDEgN4ouppGeinQO7zD0UZpth9IcIRP8xJ4
         U6gkz2giJhDtTLIjkeG4oR7KCC9SBcg6mmYYz0q0xTGahn+QwNvia/kCdPm6R9V24cQ+
         pB6jDZ/bW93GFRWgiGpxTChIVA4gO2AR++EDVUKCrYsGtrcWAUbo2iimPCDx7lqwjJYP
         8XCw==
X-Forwarded-Encrypted: i=1; AFNElJ+1beROU2mSoixym0VWwIoZmrt5SX7GifX+4Q/BbY3ILwQwJ2/tYCF77G5BB+8vyA/amojpsME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSlW7DHF1tWRATDAO7Z2pLfTYPeFf+AeF+MoL6BWsTW5nbkGk
	y8O7uitgfDxjeb12SsNM5CtR+zmgN2qlX3mdIiMqUatHIfHOUSnmN6Djuq326/6oBUw9crhJte4
	0QzsOhaModRGkkHjGtG4cbnfG74YNzZxBZelAlFRC
X-Gm-Gg: AfdE7clY4OSX546EbOClFzQZ+j1Vu49nXK3TtWOD1YdGR/5tiCzNEStmpNq8EzHnebn
	2sh6TZi8o0qASf/+KDZUHJrQdt2+vyjv/SS2yqVABrVI2MqoF9U7ZxHphYtU2OXF9Hnw89+VevT
	YAr3Dj2c0WRTBXBa/FfILv949UKrCJXVwndwfAq8iR/hATum+nhwz97tEyXh8KYjH4x6tvxA+iK
	PqVjFgBlCa0cRvbFXPPUEu6OshRgYgNR3UvBlC+Xwy1E0R/2A6H2Z0kDXQTmYlwg8GZmIBtST/I
	4NJKta/33IJMWE/iBCizYj9gAIL+2dRtEub8PVRTNAGqB/lxi+yZmDACp6ruXoCI5QzYWAbbuix
	CKQxje6lJKi9R8dvx+HMmISYV61nKDauSUs0aIVLSPSZw0IKR5j9J
X-Received: by 2002:a05:7022:62a9:b0:137:c0a7:8d01 with SMTP id
 a92af1059eb24-13b2a1b01d5mr343985c88.23.1782757330638; Mon, 29 Jun 2026
 11:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
 <CAAVpQUCayy3o59i2vh9hHRPi-3pw1BJgEYMwZYRpZnYEUoqsGw@mail.gmail.com> <F6AFD54C-1618-4501-80C2-88F796BA95C0@linux.dev>
In-Reply-To: <F6AFD54C-1618-4501-80C2-88F796BA95C0@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 29 Jun 2026 11:21:58 -0700
X-Gm-Features: AVVi8CdUk4Ilz2SW13eXTTxTOuobjZhIS8wlkDyiP8ZqmVHckKnAHDxwEK3pqXM
Message-ID: <CAAVpQUA+yKA773dtgr2E=mu4SbMCjWZk83sFYrWS6f1sDphdRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp/dccp: avoid parity split for socket-local
 bind range
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, luoxuanqiang <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C7FA6DE026

On Fri, Jun 26, 2026 at 7:00=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
> > 2026=E5=B9=B46=E6=9C=8827=E6=97=A5 07:40=EF=BC=8CKuniyuki Iwashima <kun=
iyu@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Jun 26, 2026 at 2:40=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote=
:
> >>
> >> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
> >>
> >> IP_LOCAL_PORT_RANGE lets applications override the netns ephemeral por=
t
> >> range on a per-socket basis.  __inet_hash_connect() already treats suc=
h a
> >> range as an explicit application partition and scans it with step 1 [1=
].
> >>
> >> Do the same in inet_csk_find_open_port():
> >
> > What's the use case of IP_LOCAL_PORT_RANGE + bind(, 0)
> > without IP_BIND_ADDRESS_NO_PORT ?
> Hi Kuniyuki,
>
> Thanks for the question!
>
> The use case is when an application wants to restrict ephemeral port
> allocation to a socket-local IP_LOCAL_PORT_RANGE, but still needs
> bind(..., 0) to allocate and reserve a local port immediately.

IP_LOCAL_PORT_RANGE was introduced for connect().

Unlike connect(), bind() occupies the port without SO_REUSEADDR/PORT,
so I don't think the step 1 or 2 makes any difference.


>
> IP_BIND_ADDRESS_NO_PORT is useful when the application can defer port
> allocation until connect(), but it changes this behavior: bind(..., 0)
> does not reserve a port in that case. So it is not a replacement for
> applications that need the local port before connect(), for example to
> publish it to another component or set up local policy.
>
> This patch is also intended to keep the bind(..., 0) path consistent with
> Eric's earlier change in __inet_hash_connect().
>
> Thanks,
> Xuanqiang

