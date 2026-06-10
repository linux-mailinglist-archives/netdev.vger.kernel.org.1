Return-Path: <netdev+bounces-297752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWuXLaKMKWr4ZAMAu9opvQ
	(envelope-from <netdev+bounces-297752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0666B377
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:11:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ePLTNA7l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297752-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297752-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F9830B9244
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3841360C;
	Wed, 10 Jun 2026 16:03:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACC3ED5AE
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:03:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107395; cv=pass; b=hHH0Ts9BEd5XzZ2XG6zJ858aBj/hX8t+e23pu0LlOrO59IrMz7z1/YoLb6lXf9bv1aKrDqwacWaJANVGW3pRSWa2cDkOmhijv+WDfSodAWEemo5Se4G8r6gAMiyuqN0J+pzBoaHzPLi7sG26k2fn3nJE9dKZ2i3yh5RJG87orwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107395; c=relaxed/simple;
	bh=vYPZutgLD6oyXvbqPcPgDptfvBqZYovvAkvXvpZm7ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFbJbzJDJEtfGsuj187+1bWjxYi/uXDTW/oEqkHKDDm0E45JNCsVPQicdB+z4Un/Iyt7rOnMVeRwugBCFXy30P089PyD5IerHFN/Dh2vICaQ77Pg/VpZOGwdsrMZwJyQUddeGstm4E98YFyd3GZKu28PZnkk5p6hE9KE7BDxB3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePLTNA7l; arc=pass smtp.client-ip=209.85.167.175
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-485ecc0f2dfso5481407b6e.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107393; cv=none;
        d=google.com; s=arc-20240605;
        b=f6NrAEiZNCwg58gRqCGP6dFXI8e6Y+ZXuI5EoSlyGVQ5D9XvtacPejJfpgHhdTmAzB
         ynlCUh5BArswTn1l4k4v+Z7dxizKjRgZSsu8eD0V12kIEj/K8RObn/bN3uVP1tKvWBvL
         yJuGApepd3QQQ5MgO2oZlyv++W4D+3lJb7s/TH9WD96PKCa+/aUTp80WYY66qU4HD7j5
         RMVZp+c/nU4d4OCErZgFAh6qAuLvTSU7S1gDD9oM9K/I/Rbrgh26CMtA7j6m+NrKEvml
         D7BlMgKYR6e0FnnfoOxKTk31s6DW2SiDMSL9UXWs3wmfaylzUPPL4zTqpxJCKHCmkeHJ
         XyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R47RGexCcK9VP9Q+oJq1oQWs/+cXsLl3Ej3mUpfyLYY=;
        fh=gW0htO2SfXWlwMMuCqLpA3qXZJoKbnoPuiD81vGrSw4=;
        b=fodaV/MDeMPhR/sZsE5bYXUbpn//b7FVVs1eVTsEKIP2uQovfc52MBwot0itqV2pNx
         nI44Mhi8q3Ly5X9vXrdah3x3CFKC4xgKzNP6bQpL6d8ZsTzGuU4fX5RNKzhQi7cykRu7
         5j+mXatMMvGpXGtp21MaYw9NlPbuMxR8/fJ29sVKnX/InxgyjOoKD/Jn1316/zDoqfIn
         +T+XBwE3uNmdiNQKMekaz0pO7mKWgg4EjNHzA2J4C/KBNvHzMb9V6omy4tujXZkLU81A
         FYKf4saoFbIkOpcoeynNtuK0mWmHYGXHHqxz8dtPWFBTIX/92BFlliV2CuvEwNuulXYv
         KNog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781107393; x=1781712193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R47RGexCcK9VP9Q+oJq1oQWs/+cXsLl3Ej3mUpfyLYY=;
        b=ePLTNA7lHI8hXlYkbmgWKhiG+tYOAP2fTjMVfWnasn65+/hJb2DM2iJHsfB6sMl7U9
         GTDNot9g6DpFw8kAxsgHDvkNjkpyjXWe54twqlelDpgkL3v1lOjoXzO7nZuaS6JWzYDH
         8EsNMSdPPWxyT2h3D/bS+utgygPbipZv1OxFPEB0ih9ZtO+E6H8oBcDP0GgzKppjnTO9
         rX8Kgc8v0BtD4VWBMa2SChEyl61XzW9qyPTfM/GpXhzQBq7RVJvf2n0waf+qO1DORj2J
         vIxJoGZzliyDs2XHZXmDJAibu9PE+BLoUP2a+pF5TnGymEr2K1drwgxOJrZiEtOLkQ6E
         25/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107393; x=1781712193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R47RGexCcK9VP9Q+oJq1oQWs/+cXsLl3Ej3mUpfyLYY=;
        b=avaP2/U5YLFY2PeX8MHs+lw9eDeK6BoDcwH0y4oow7V8Q7vADZ/H+Q8R3Ty7SIJsRH
         9PaIJLB7W8NVai9wBjZUpQMHcjcOQDHOOHnvYa91Xvy1FissRmWTKCRktp1KXWj6FPly
         ZcxqV3jErozaHcqYjNDrlc66wzOnssVyT5U9yxRVqJ7V2FliDAGXjL07ceweUbsSpqf6
         u/WKluP2Myc9WNz19UFSdfb20XNGifjGYpwJYCG1p2jFgHd4miYM5RZmvp6WgtKwoh3p
         RYew1bRp4P9m00yH2woYsQAKAg7+Ld/xYNdS/ZbbSviVCRIDOOeS9xDD8ahbuteI05xz
         kEtw==
X-Forwarded-Encrypted: i=1; AFNElJ/j6uCs8fp4bVaR0Xoyu7cI/qO4VMZxB2m912V/PbFYrHjv/iaRGdPBE3XVA2Grw3U/c8+8nfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1kBf1UY1twV80OdtoE96c2NbNJqqrv4hWQPYzMr3pFCmaHUv
	9wc4vfstVQLZIzyCmoGsSo0JSxDPWYVLlCZdHFzwlCe458K6/h26tJiklc26rCSJ8aGyqivmCf4
	TERjf8Z75O5gdE1c9wqx8BiSZi5qF+ase4gxF+xzO
X-Gm-Gg: Acq92OG/vz8UFXNkFjC8uD06l79GM6p8YPZXjQMUa4/ZtqtOZGb7mb23/syeLJIKgyb
	ghDAPqsefYjaOOkUc5NyEbC1C8F6fYB2IlNPwRSMVG0VepRB8WfGupdg5EiOTSCQNAv5VQN8T4M
	JedcNEcNXnWfLD9RDIUtRJG4dzFfh+TS+/qhNWm6tPzkq1NKhpPgvJC/pAbvcR+b/w8m8LGbDIW
	07p1Hst6xCbyaeD8gToSwixjIR3Rmnwjc81btjFoTeelSRZyI5queo/vNt0u2w6tzlOZUN0c+ua
	XRkkQ2kQioJ8i6//STJ/wRzOEXgHOY5NsZ3Ry4WqDJVZj3l7pDR7IgPLPzJ1HvQ99eBC5e/PfdE
	UdIVgJ+O49T3xlgCpnE7ctcpdmeJL4w==
X-Received: by 2002:a05:6808:344b:b0:485:3a3f:c2d6 with SMTP id
 5614622812f47-4868de659dfmr16994856b6e.31.1781107392034; Wed, 10 Jun 2026
 09:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com> <20260609080839.2506801-4-edumazet@google.com>
 <b1680463-5563-413e-a6aa-e07f60c1489a@blackwall.org>
In-Reply-To: <b1680463-5563-413e-a6aa-e07f60c1489a@blackwall.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 09:03:00 -0700
X-Gm-Features: AVVi8CcGuUx-gjdyq0Hm5a9fBPcu1gdB4C36xsiyTUyjTLvtyUYiZk9PGip11M0
Message-ID: <CANn89i+i3wZYSAJFfo4CkHQ86BJQOCz02_ptG92KniUC1Ts7sg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: bridge: use atomic ops to read/change
 p->flags (I)
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32F0666B377

On Tue, Jun 9, 2026 at 11:29=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 09/06/2026 11:08, Eric Dumazet wrote:
> > Use test_bit() in net/bridge/br_arp_nd_proxy.c,
> > net/bridge/br_fdb.c and net/bridge/br_forward.c.
...
> > @@ -214,24 +214,24 @@ void br_flood(struct net_bridge *br, struct sk_bu=
ff *skb,
> >                */
> >               switch (pkt_type) {
> >               case BR_PKT_UNICAST:
> > -                     if (!(p->flags & BR_FLOOD))
> > +                     if (!test_bit(BR_FLOOD_BIT, &p->flags))
> >                               continue;
> >                       break;
> >               case BR_PKT_MULTICAST:
> > -                     if (!(p->flags & BR_MCAST_FLOOD) && skb->dev !=3D=
 br->dev)
> > +                     if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && s=
kb->dev !=3D br->dev)
> >                               continue;
> >                       break;
> >               case BR_PKT_BROADCAST:
> > -                     if (!(p->flags & BR_BCAST_FLOOD) && skb->dev !=3D=
 br->dev)
> > +                     if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && s=
kb->dev !=3D br->dev)
>
> here it should be BR_BCAST_FLOOD_BIT, not MCAST
>

Oops, thanks for catching this.

