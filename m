Return-Path: <netdev+bounces-299056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/SXCirPLWqAkQQAu9opvQ
	(envelope-from <netdev+bounces-299056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E567FCE5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:44:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Yn5cGcaX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299056-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F7D2301CA4F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608CA39A047;
	Sat, 13 Jun 2026 21:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633C3921D0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:44:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387045; cv=pass; b=S9ptlmx/n0kfM+oufhPjCqeO8wdXab9eL/9lICBkbTCqUg81iyVZLTFK+od+MxnBK2jyVidhPx2Fl+bFMeIe/Ih75wuFw5m1rm9z2IISdd0sLMao+lyVIla0sqgPoNelMoKA5pcEVx7HSypmF/tMtX/PqQ+6yNise3MT3r6ZkL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387045; c=relaxed/simple;
	bh=shGqwXIT/9k1CTZiY7lQbAjqDdaUMQMO41xsdAlkuHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hd6Ex4vxbCoyCOqHFAStDQ2B9yiWsmoy19x3dcTV5UoKXpErapPfMS5JVOlpcIVbloGeNz9mYszzywwR9p2u1Y3yk2+Eo7Jb/eBgjh/CjC1JVQKGd5LgcAB3/Ng1rcBv3VY8Q4+IGSi5Lo9hdtGptyiS3sEmsrOMs2F70hd84Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yn5cGcaX; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6914a658115so2632167a12.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 14:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781387040; cv=none;
        d=google.com; s=arc-20240605;
        b=lkOH6fFuCfug4mHdVjQaEetA9PVDqoAxU4LaROYf2D/cmnPu3HawvXj4deVwCeNIAb
         nk3f3qR1cJBbWm8rrebb/m2MD6dn6pfE51Qr3WkyiAJmFM8HTxFIjzJmokIJh8pVIQLt
         0mVFOnnjftYQEYwLAk93AYT9m84h4q0Q/CMDfQ+RRxNdOQ2GvglApIrrD4AEKPf7ChXe
         mN+b6F5ZfnoBfqpn9n4odk1J+jO1cJeG33rSprE+LFung4Un+sxBiFG4xOUcakGz8hoy
         SXdTA7h5hEpfn9rtqtww/vEN/tARe5nGuMw51uXr+RRbrzvFhcD28N/Mdcqk2XZYWwd1
         886w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QzdEIs8IbYBJwlFunPACllXp2t7V7kjH0qnCjgXYRcg=;
        fh=NvKKMRq9ulPIUsSAq5HZhP3aGtfRY2tf85HqFRoXmDM=;
        b=UJJY4Icnl3nGRbLbogo38OsRlSiuRPH8PcsDy8nD3+gNcbdiqJTee2U4mC2ljpGVxb
         BEhSGihfoedma4poosRamzH3pXvKFEZU7OtRNCGjW97/iAxZ0WmI0sWz4MiegIMtvFdS
         uAIY8GS4ouFaCp3GIzt1O4Ng2TTDCm7gZIPbbgpcTpTCmBfTmeRXtmUUKxuLLr3vpiys
         rNYLlavXhyppX8dAZc1Nk+rm1OyzRilAmUU8Yvuy2nGUxYpZESOXuD6ik795nYmusWaI
         0+K0fGK1TuxZyN5qEq11Qpu/GFxHFuhJfZYaw75pBihZ0lEhZP8UKMstEQfxkJDC+iml
         nDpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781387040; x=1781991840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzdEIs8IbYBJwlFunPACllXp2t7V7kjH0qnCjgXYRcg=;
        b=Yn5cGcaXeR3/B/k5z0AVfO6kbuIVcEeLXkkjZ7Q1lrooW6yLC4Z1opSA8qcKhQex0f
         2+uN22TcHYOZ3lV9bCb+y7VVrVnxbODatgwAZfGduna5IbXKU3fFWIIudwJHuJtt4pJo
         MDIgxo6ocNeKn8lerymXf1Sbqv9ur0VR4Q92lLw8w3HkX56IPBEhjoskNB2SZdveWWq3
         grGuIlT+mBS5yHM6UNIBTrLPpX167zIGi1J9zfPv077li51jgnK7loL2vDCGQXY+LukY
         RaLaKDNMKO5alLFnn+uK/trCXOX9tLqnsv2bOuY8kMbc7LtTEAaXA0RbBV5VhnaYxOKf
         e0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781387040; x=1781991840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzdEIs8IbYBJwlFunPACllXp2t7V7kjH0qnCjgXYRcg=;
        b=hibbYHzQ17YEGt7lSC6FcDWy4Yvol5jLYNDqhh3TVJsLqvfuB72MKSRjtPrcYus6zv
         6PigbPSOUnpyl0uSMUE+/2IT8TJzdcuTTCcY+DRhlTumek1tL4oXyWc1zzQL+IaEYDIK
         Nj68b15/HxtXSSfWxftn2TBcOoRbSkNi52+mpFakqppcaQW0Ih5uSdbtV/WnGYw0DzlB
         om+zkzAF42PzZdAve+077RHTleJ1i1Vj1oZA7b+uryYQ6J8qSbIeFvYBfwqcxkMgf1F0
         7RICMLZa5FVA5nwJxHZ1lfgGXsa6vU92J3kNajvK+yNqAB5/IXi1dIh2WRT/qNUd5vp9
         fSzw==
X-Forwarded-Encrypted: i=1; AFNElJ8mcxL4pid8Jfw0e11E1VrurJNzfKq+8eEDMfun/sb93llwl09G7absjoTZZQzF8IRFH/MZP8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypqhoaq8yvM64K6Id4OsUFglpbuKv59BYqZL31Qclt/VLjNJyT
	MzibxHzgul3ODOZ22dmBxrXiEL3K3z+DYsBe6r/3KINDIhi6Ps+a0+WyDH7XB8E3eyRcQRio5M6
	f0WH5+au8Bc3tjhuIZnwnxR8Wjp8oKTMR6sTokUL9
X-Gm-Gg: Acq92OEaPj3wNXSMLyCZ8kQR3kbRyVpZgfl1M3RfPt4pfwxncCe6anqYFOIr5U0ToOg
	wiGiaQHuI2ZFf9p1oBogVVYp3XXKxKMWP5KNvaQyTUSwUC5QayKms/6EPRgqfnUrNqxq2rehp/+
	qg57/h0YsieZZQtG10I2bevEnoJLW4WcrjAyoYmyAZjNx1IlCH4QOuWZYaD5Map06kZ47Wxod6V
	XCmKiK29n+q+88508lf9QWZGYeFlLxyE8dTzRy6qC+qYleYHmSB9wx0c6h7Ocs3e02yGxtQ6UFZ
	LQJL2LGYbnSk02o5ZGZgzYRzuZC9e4KI7xq/B3gCCD7DJLDJiilpPGZceCTWC1hskpvmrIp84uh
	cMLkNAtmteBYMBQ8+Sy3vrHLa6DvNGWXj6HVdT87k1k3ev2clLLUmzyUKUiNvMfQ=
X-Received: by 2002:a05:6402:390a:b0:68e:4c0:f599 with SMTP id
 4fb4d7f45d1cf-693784de192mr3613711a12.5.1781387039742; Sat, 13 Jun 2026
 14:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613102041.55e3b50e@kernel.org>
In-Reply-To: <20260613102041.55e3b50e@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 14:43:46 -0700
X-Gm-Features: AVVi8Ccn4RYCTXqzMYwrPCruXfWWhOo7OhdWRurpDqUSjxzTS9ZYmbEdgW-fxsU
Message-ID: <CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D2E567FCE5

On Sat, Jun 13, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote:
> > When standard socket applications are run on these hosts,
> > a userspace proxy is required to mediate traffic between the
> > hardware and the applications.
> >
> >             +---------+                 +----------------------+
> >             |  proxy  |                 |  socket application  |
> >             +---------+                 +----------------------+
> >               ^     ^                               ^
> >   userspace   |     |                               |
> >   -----------| |-----------------------------------------------
> >              | |    |    +---------------------+    | skb
> >              | |    `--->|  virtual interface  |<---'
> >   kernel     | |   skb   +---------------------+
> >   -----------| |-----------------------------------------------
> >               |
> >               v
> >        +------------+
> >        |  hardware  |
> >        +------------+
>
> The first patch looks kinda nonsensical but then I saw this diagram.
> Looks like you're vibe coding an integration that makes it easier to
> treat netdev as a slow path for a user networking stack.
> Please tell me if I'm missing anything otherwise add my nack if you
> repost.

Hmm, what would be a better way to tell users that HW TS is
available on tunnel devices ?

Other options were 1) add attribute to tie the tunnel to a physical
device and use its ndo_hwtstamp_set/get, or 2) add bpf retval
hook in the path like update_socket_protocol().

Or do you think applications should handle ENOTSUP by ioctl
as soft error and always set SOF_TIMESTAMPING_XXX_HARDWARE
since the underlying physical device may support it ?

Anyway, I'm happy to drop patch 1 for now and explore options.

(Believe it or not, I haven't let AI write code because I don't
 want AI to take over the most fun part.)

