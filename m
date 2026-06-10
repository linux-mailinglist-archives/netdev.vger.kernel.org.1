Return-Path: <netdev+bounces-297755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nCgDNviOKWoHZgMAu9opvQ
	(envelope-from <netdev+bounces-297755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:21:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15C66B5B5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:21:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="vMQ8bGK/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297755-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F056F301E128
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366D33A9D6;
	Wed, 10 Jun 2026 16:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F2407CFF
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:11:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107884; cv=pass; b=lc3zhKa2Y1OppUy2p7AXW0hbmYRzI4/biywDJHkw9IaLB6YlpMN6cUxUli6UNxa9pZZ0IoD0Fb4JeG7ECkWsnZmhNJ57N7AAW2zlSrsmP95XKUC0V9F5/zZ0AiN3aODgneLHbxC/5/4t/C8g91eBS/0F9Kg0X/sneZgl4cTUuUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107884; c=relaxed/simple;
	bh=UaKsvlPBoLK6Qf8cSPsxvJ7kOou5Bz2856Lr1B0BvNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc3FY4ZQbMx02jDCMxUd50V1go70qLA6te1p4kohfSJ7B5vlBwLcHVKDrOYsUleoNPqm/4IiJgP1n6zzQAQPic0t74q7T4nUbKUJMvYj5d5mArd5Ibwdx5bpE0DFdhfJZczovRAfABHYue0ujkJvSZ9qvMT0ZENazcEJk4PhTJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMQ8bGK/; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51764768c36so89718471cf.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107882; cv=none;
        d=google.com; s=arc-20240605;
        b=bUsSoCSamSuOWx6hjnz2v8X0y3KPk2KBkVjQyEZcP1hFB8KdD8144Y+2mvjFbDAJg/
         TzhrWI7lz4qYHSr0twATGDej7tVUMvz8nhtIQHskdnGnRCJBaGZpjGnbcSzIOvJzCCJw
         bJK5uOWTiAwqGlRhKOd3skO/QIgYQDkVoOIBoVsd0VMH2ZdJSE4s4oss2rSQMcAyT+5U
         ktheACNSdwY8hj1m45buAoPRnsPNx/z1BykEDzd5Royc5NwSYU0gZGcPg5VSd0hA8F1z
         r1iqqI6tgs4jSVE7amutUbezMloFBwVgIiHQpOUH5qduzZed5gyY1GGwnt9mcdF45ivg
         95SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aIJqbwhUq0DXsQgBGbz5NchUkysQwKa3ZvfK6WJ5p8A=;
        fh=8dtxkCBlEi+6/9Vdk9vj8HSs8nev27n7pNloMnzoLd4=;
        b=fVPHdsFwHxL2+nwqolcUx8XMFnvvyLdqRap5Mk5NEzingc/Pf5W46q57WBfGcd5uXW
         P0SzuHFMAnuEotnM7uqnygY+G2reUEL3Wva0V5gBitR2NsQQ8xCzSI/YF/jN1IEThZIt
         Ru1udQHtbcWDtBX0ekf2H+hDTshtm9Q73P7FnZ+hwGYgDJz5+Xd6CMRXrfNu2dsVqmK2
         SDcuKPhMrV4woSH3c211cGR9CiqSz/vyBatHEP7n32mBE/E0aUwZ7Pzy3c6rjSVzZQ0y
         mJgtZNACbEk5qhdUb6XD9DkAM0z+TXbv+qFhKikQtcnmjD87xPbYxS+30KiB+qHOR00r
         Fwcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781107882; x=1781712682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIJqbwhUq0DXsQgBGbz5NchUkysQwKa3ZvfK6WJ5p8A=;
        b=vMQ8bGK/R2eHra8LBoZeBn+vWCmFijRxK7ipVA1qA+Ru2BJZoKu5auqGOv7FM4cMxF
         tvlcfEpjmtDY1LIZL7/I4qZmoexznOy49iguVlMiLGQ6tiNZKIbgEoQquiOOSGaVTdiE
         g+YyNhxEEigyvPFfTIuQO42/4CP9HqyE6aNUxRbZ9ZHjTw4NR+KNZnNhOVG5J3aGW9si
         g8lGstksEoP6CK+mOnHT8ljCzLspHZMgEEqqeSa+I6S8u551Yp/x+aXtSo0b60TEzMd7
         rZMewlo+L8e/GStBe0jpuJEjg7PCjvS7tLyObrzYxKLoZWCPYTrRHaYd+Scw8XnwS6xV
         J3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107882; x=1781712682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIJqbwhUq0DXsQgBGbz5NchUkysQwKa3ZvfK6WJ5p8A=;
        b=JuTjhEoZoF2/k1+6BIUatHVIoW2pCEQld0XAqg425mIIGjDCGz9jB70LXI12zA0CZK
         aJPoxPxhOq7J64ewi1euijK024e/3mceMUCSSyj/mX3iKpm/tlE7coe+EFv1Dj9MOqHT
         GVBG2dlPJPoU7fAu7XJ/HqQD2FlTjfTE3SqU/cr6c4iOwUMMMEnIoQZ8QmyvJ1963FL2
         VeeLK2w+TIY8mOqG4O8Qcxum6cJWpsVsjNr8fpcTZa48wRXPZrqBwxLDK6HlmzSyGbTL
         FQie2kqHqegBaXo+wsnzSp1FMsQaQxEWUiRvWwJHKkRaOj0ERfntqqszK5SHPeSlwXZk
         IqXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9akc1OeuJprrc9daU4JABpdEAS6OhbvfhxeLo7/uNxX4MaFynW2DCwqN6E4DMqgRchPdCN/zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7OfDy9F7bHJrclMiF7A2Oy+2fW6RGc6dSQfka3lK7Z3mJMPV
	9ULrc7IOQXRM/rWw6yWO5OAeCx9Vta13b3MeSaBtVTizQwtlaUKBydnYIlO/3gd2hG2XhuqxT+b
	N9e6QJjffjWMJj0ScTNbRiP8rWydsYSZ1P6ALBcHN
X-Gm-Gg: Acq92OH7eVOr/ilIjHu4vKHwA0uFkS8/j+wlr9gDnQLr+2ILCIMMbDkjxvgPY8WGL6l
	OdqLKthxvClDJd8PXxPAvKfxgywWd4BAm8FCvW5CRi4vEXFPo/wBBfHGTKTc30Z0Zyzz9d0GnEU
	aRHnxreFcOPmv8ihqTwbGY57QLUVmS74aQTHLEbU00/laHxIKzrGlROJoa/K6psqNy4f14ReBoO
	MRkhS/msbxBhwIKP4Xg+CLpY8dMZtFNFzYfcdt7+CpDWssWuUEhdKSEmiEYRKIBlmd6vdFsJBt5
	ZoHnAjCgn/JQ5H42X3fEg193lF26tmPNqQvXgbcEhRi3BF7c4O3Y2IXw4RNREYZHlR/8GTVINxR
	yOHGljI+eQUJ0bZLoanf6GWtyz0o53Q==
X-Received: by 2002:ac8:711a:0:b0:517:97f9:78f5 with SMTP id
 d75a77b69052e-51797f97a8dmr255372111cf.10.1781107881302; Wed, 10 Jun 2026
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com> <20260609080839.2506801-5-edumazet@google.com>
 <9c330505-483c-47fc-9a7a-29b8abd6aad7@blackwall.org>
In-Reply-To: <9c330505-483c-47fc-9a7a-29b8abd6aad7@blackwall.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 09:11:08 -0700
X-Gm-Features: AVVi8CdlkOHuikd3A35cYM2iYewAI8y5qsPhdTVSkOU0a2WgPM9Lad14Db8_G54
Message-ID: <CANn89iLbCG4Q2cfJ8-MzUOqGw9r2zVYvovaM-KrPDtFJy86JQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] net: bridge: use atomic ops to read/change
 p->flags (II)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297755-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E15C66B5B5

On Tue, Jun 9, 2026 at 11:27=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 09/06/2026 11:08, Eric Dumazet wrote:
> > Use READ_ONCE(p->flags) in br_port_flag_is_set() to keep its ABI.
> >
> > Use test_bit(), clear_bit(), set_bit() in:
> >
> >     net/bridge/br_input.c
> >     net/bridge/br_mrp.c
> >     net/bridge/br_mrp_netlink.c
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   net/bridge/br_if.c          |  2 +-
> >   net/bridge/br_input.c       | 12 ++++++------
> >   net/bridge/br_mrp.c         | 20 ++++++++++----------
> >   net/bridge/br_mrp_netlink.c |  8 ++++----
> >   4 files changed, 21 insertions(+), 21 deletions(-)
> >
> [snip]
> > @@ -1246,7 +1246,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
> >   static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *=
skb)
> >   {
> >       /* If there is no MRP instance do normal forwarding */
> > -     if (likely(!(p->flags & BR_MRP_AWARE)))
> > +     if (likely(!test_bit(BR_MRP_AWARE_BI, &p->flags)))
>
> s/BR_MRP_AWARE_BI/BR_MRP_AWARE_BIT/
>
> >               goto out;
> >
> >       return br_mrp_rcv(p, skb, p->dev);
> > diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> > index 86f0e75d6e345f8f388ae163860a685279174222..cebd4037744ffa2796c170c=
1e1ac2f213b315760 100644
> > --- a/net/bridge/br_mrp_netlink.c
> > +++ b/net/bridge/br_mrp_netlink.c
> > @@ -538,9 +538,9 @@ int br_mrp_ring_port_open(struct net_device *dev, u=
8 loc)
> >       }
> >
> >       if (loc)
> > -             p->flags |=3D BR_MRP_LOST_CONT;
> > +             set_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
> >       else
> > -             p->flags &=3D ~BR_MRP_LOST_CONT;
> > +             clear_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
> >
> >       br_ifinfo_notify(RTM_NEWLINK, NULL, p);
> >
> > @@ -560,9 +560,9 @@ int br_mrp_in_port_open(struct net_device *dev, u8 =
loc)
> >       }
> >
> >       if (loc)
> > -             p->flags |=3D BR_MRP_LOST_IN_CONT;
> > +             set_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
> >       else
> > -             p->flags &=3D ~BR_MRP_LOST_IN_CONT;
> > +             clear_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
>
> this one changes LOST_IN_CONT to LOST_CONT_BIT

Oops again, thanks again!

