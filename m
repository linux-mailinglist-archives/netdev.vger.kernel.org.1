Return-Path: <netdev+bounces-278194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKuiCz9U3WkFcQkAu9opvQ
	(envelope-from <netdev+bounces-278194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:38:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A73F3264
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 831B23076DDA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C9394797;
	Mon, 13 Apr 2026 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izRGz1XJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF158214A9B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112482; cv=pass; b=Pti5y899ua6otvFHUf9ZTCPwXMMyZ7griTVCQiXrD0VgR9zqcqaBYFBDBxhUd1SzeQX2kUIBu7NA9trPiZ3kWWj9loF2hRTgnFJOKqd7YhVNvUu6btW+FjKHs7uN2/Acg2RemqhalTrVUircYSDUEyMezR+4WfEvfqBM4Nsv/u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112482; c=relaxed/simple;
	bh=fWAzA0wTyrkxcVaaXJ1wlKZRpwD8rCOI5q0vhr5h8mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ende367zwvJuh0lhg7WYW0O6he6ijmDnES/+z235aiWQF6rTe0IzYEEJpMxVNsdWVD1BEl9FdSX3IvbfkuXO9pXOz9PR6R7dTuTikRydRejq1RPk3cME/f4rVX17UifJXsM6mDzy4axuaSYhPwEotvmX67n8KE5HCeJoBnrsngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izRGz1XJ; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662f30d3f1fso2748177eaf.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776112479; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2v/uUTDvYaqEQ784FE5qZhiRl/sVEh/vOWPQ0O4DCev0Hi9EVhc8bksqWY8EuvQNY
         YXS+iIcwqy5FN0YqMOgUC/ScY9T29WIK0OdLCZJfR4NEG5KnMRgNPAxdA9dYqeQgWNlU
         3LchO4XAZW7DZ5moX/DfHdOd5AZuMd6ZV1RiFsAt4Tpl5102MVkE3NcaiyEU1byxvs12
         jqqRNNIILbyCQWBu403Z3kxX1V9OtpUkw+pLVjpvZz+NOJe9a2pTFai9WiPclsXYIjVq
         Xzad8Epr+liB5hT75V8AspIZTFpbJo8t1saDcfQhvU6usjQSLY4Y9vHWvhbsJ6q6NM/D
         ivIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2JZqSNZSabeA9feR9Ftdqo7HF6IrjzhR1bTuaRUEMX4=;
        fh=C0bo4FwFRsEfy0Rc4veFb+ua8KWAbPSWgAtP16czAA0=;
        b=jjPC/yE5DmD4/CKBFSUMxPNWWNaAZJjhRcaq8q2hZvApDVFHU+gAHjxGwGzOGsgboP
         LD1HXpQCAgjcOKV3bVhhPB8YQ/W1n4A3THuLGtyUkfxSIBQq0g29sWeipUQxYmFsvN7o
         iQLpYf9wTwSdJxW8Inco+CjyTi62csZxmVLl9+hOsA4CwJmYy4AVBdgmywZi/idOudtK
         0KyZphBnJVY6oWsJWTJVZnzgmcO2lnEPZxNw6MUW2k/m6q5g8pLzaIYEsysCxN28aHkU
         4VrEPE9OKwZajbOkcAvMvpk7bYCskAmLNmDVC5Cfg/NWkVQg2l//fJVXWa/f2eK1COWe
         YxgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776112479; x=1776717279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JZqSNZSabeA9feR9Ftdqo7HF6IrjzhR1bTuaRUEMX4=;
        b=izRGz1XJXJCnQwZjUThMkohPipFaXDGKNduURu7TPuhMucf5pKZu8PGPZMUFoqdCgY
         SMJVNPgJ7IaTax45I28LWqNceFA/AUbsTsbtbXOlVIw4aVS/+um2q9RedUYXGbFoCU0y
         8GWoiV9AgkohA00i8/CRFq8xlEu5nhf7uHqj0pRIhQ/k1s79Zt1AwSXKssBTTCEa3qWT
         yNs3bityG9Lyt+hElQTAwT/fBLBxH5kzzDmbX2mBepC9+ilaweVwLZylBDitE7Ydd+3M
         8+GGu3HqXKXlihVnCwizX7yzPSdYKGT2QlsGTjXqvOQcvFvWMT4vFIhNqzbjWptBqMCO
         ntEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112479; x=1776717279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JZqSNZSabeA9feR9Ftdqo7HF6IrjzhR1bTuaRUEMX4=;
        b=XV9855JaFdQho5IXkkeuj9ysahzxN5pXUw0l1nzipmrHB/ugQmGN2pcRfKMVajnar6
         BllFLKw9RD0UO3NgaTyrmmse6fnPP5afspqWtfg/OCc4HoNGVhSmvmF6yCAywjI9UnVo
         Obe/D3jteOZtrxwwZXVD0QERlzxdlyoHHA4fjs45WIyTU7lAF6dGt+1ADsdYvh9aMRE9
         solt5CTJr4WmpNnpubhQud62LcXuDyhj6Ddlnic2DFrWfIV/1u794bEHT3F/ad8h/3Th
         7w10adJ8c34gZJll8coKWvqmgdTKp+HiSoftozr5RQX5ag2THaaPcf3jLFBwYT15s6it
         jYmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hGcCTx49sHEHyxpD5XcdMEPZTtap46BSWGP0/cFu4Qc04PeRRhS6qpawXJi+P5xTG4mqa+6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDU5la256stn8QQ94kxTe7ZjIXM5mYWPZbUi8QBpIsioi7F2f
	NYOy+Id7Qf3u7BH8CkT1W8pujLjsLaAg9Tu0YG+mRyw6/1Dqm1S7QuB3TIB5iJFZOOKKyJnvQbS
	J0qtDDwn7I4rNOZpxjwnHtW+tFh7NoKQ=
X-Gm-Gg: AeBDieuCYDShO1Z6FEWPetAExCAj1t7EuaCeR+uFuEEVIJUWV6jhxBstioTiGrieEcl
	83STHPE7r5JZ18T2NuIDza8mIKdf/U4cz4BWHfmt1xwzFf5bm/YOmNXL7P76GkVFt/freoQWVoK
	2g7ZaKQi1RVPIjgd4ywwTwBxWJdOeZeFaNRNZrbud9JjnGKwpu2cm9g4516KYR3acxkNkNDSyGS
	VNhGaDG8dh+cjKkhylNnnHug7ed8UCL77gmc4LyrS2RMNGh0vNWXhTqzUa/rJoHGuh29bR+snff
	URKcztg5mqPoEKAWiD4GSDgMEs2rD54it07A0w==
X-Received: by 2002:a05:6820:2012:b0:67e:1b6c:5414 with SMTP id
 006d021491bc7-68bf7fc923emr6601900eaf.19.1776112478646; Mon, 13 Apr 2026
 13:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413182225.10683-1-devnexen@gmail.com> <CANn89iLE4k=N62i9hs+GumpP5v7CU7L+Qj644=4Zk74_P0zDxw@mail.gmail.com>
In-Reply-To: <CANn89iLE4k=N62i9hs+GumpP5v7CU7L+Qj644=4Zk74_P0zDxw@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 13 Apr 2026 21:34:27 +0100
X-Gm-Features: AQROBzC9iQHRZqaFtJR60vFAXh5TUfvZq43t2UGNv9ETqfs8Q976ni1S8kIUTR4
Message-ID: <CA+XhMqzKjZUaAPn4C04EyZvUpF6wQ+BKAbdOqO4nWDaNEGhJcw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: check qdisc_pkt_len_segs_init() return
 value on ingress
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,fomichev.me,google.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B7A73F3264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

  You're right on both counts. An LLM was used for the initial
bug-finding /
  pre-analysis on this one, and clearly it wasn't deep enough.
Daniel's
  question made me go back and trace the redirect paths properly =E2=80=94 =
the
  premise was wrong, __dev_queue_xmit() already catches them. I should
have
  re-read your 7fb4c1967011 commit message before sending.

  Dropping it. Sorry for the noise.

  Cheers,

On Mon, 13 Apr 2026 at 21:09, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Apr 13, 2026 at 11:22=E2=80=AFAM David Carlier <devnexen@gmail.co=
m> wrote:
> >
> > Commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> > changed qdisc_pkt_len_segs_init() to return an skb drop reason when
> > it detects malicious GSO packets. The egress path in __dev_queue_xmit()
> > checks this return value and drops bad packets, but the ingress path in
> > sch_handle_ingress() ignores it.
> >
> > This means malformed GSO packets entering via TC ingress are not droppe=
d
> > and could be redirected to another interface or cause incorrect qdisc
> > accounting.
> >
> > Check the return value and drop the packet when a bad GSO is detected.
> >
> > Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >
> > v1 -> v2: reorder variable declarations for reverse xmas tree
> > v1: https://lore.kernel.org/netdev/20260408172307.46498-1-devnexen@gmai=
l.com/
> >  net/core/dev.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
>
> NACK. This is is not needed.
>
> I will not even bother, this is an obvious LLM based patch.

