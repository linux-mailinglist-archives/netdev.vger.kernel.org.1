Return-Path: <netdev+bounces-292876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sExBOmbMGGrrnQgAu9opvQ
	(envelope-from <netdev+bounces-292876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:14:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0815FB457
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71E6330283F2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F85369D7B;
	Thu, 28 May 2026 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="ABVsfi5C"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07E36B044;
	Thu, 28 May 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010058; cv=none; b=ePZeO9EqtBzlc4jMutDHq58WqoQqpp/5rYsM9X5IUPZsFZfqJtkM000W3B9KJWJuUFcI2ltOfaR38tXi4+BOYLsmIb3Unx0ocb0QCstuZC4JKWNGpjWOBBHbZRrWRC5VHXwUA6kqyuLkQR5emq/V88KaaE51nRhmllSNubALC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010058; c=relaxed/simple;
	bh=vEiKRY9wXaA+V7ZqUq9srooGuIVH4yS3XxBz5COIcIU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DpirFl8YSXW7noXtDtDu3L63cAQfFJKd9jrgYwzABbNoeGufW6iDoooYZLnJ0mCMHTBcuSUv40VtNpSiSt1nR7xHZQHopJ2bcgS+31hb3Bh/sh1NvDy2ZMoyx5Tg4Zli8+U4IsLyLzAtBuSwElau0zRcdBb13+uxnMCKL7moV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=ABVsfi5C; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64SNDZMg027703
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 May 2026 00:13:38 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64SNDZMg027703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780010029; bh=vEiKRY9wXaA+V7ZqUq9srooGuIVH4yS3XxBz5COIcIU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=ABVsfi5CjLWvd/L6v2qjDWfGG/O6AvsQs/C3ppB+9vG2DlfazQtkgUmhzOMJvqpUT
	 Lk/EoKyXUHa7j1c9ysLsddX0yr3ErXXZYfvwwi5oinODpGR4KL0ZD5LFAXeFLjTkSl
	 1t9UkCf4ARcR/9cU/LQmrpZcPB3O5N7j7GK1Qs39eRbrYLbpFV0r8b7F+p1339fo6k
	 LACem9evDkKuSwX1Lare4XP27LoJ5sX2ksl2j6l35JuKoeI43niyZciNTiZzngY6qK
	 /Dd78CazCWjrMLDaW1IztaCYVW22DFzAKHMGuLY355fghpjfCNuGKP8kJDwiaEG/nG
	 a4SZDmp0LZpSQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <723c23da-69e4-4cdb-8b72-9a3af5f8dba3@lunn.ch>
Date: Fri, 29 May 2026 09:13:03 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AF97002-3E4B-4492-B086-685E865E1B4E@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
 <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
 <885A5B11-A34A-4F69-9E9F-ABF10159B789@padl.com>
 <CABvLYuA85b1X9wHH073HPX=xv_1uZ2+anhcr+3MMkoVF-3DVcA@mail.gmail.com>
 <2E4F8243-8687-4591-A03D-4402D4FBEC02@padl.com>
 <723c23da-69e4-4cdb-8b72-9a3af5f8dba3@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,luminex.be,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:mid,padl.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: EF0815FB457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> On 28 May 2026, at 10:46=E2=80=AFpm, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
>> It would be good to support both, particularly for switches with >4
>> queues. Maybe this can be keyed the presence of the DT property (now
>> renamed, marvell,avb-mode).
>=20
> You need to be careful with DT. It represents hardware. Configuration
> of that hardware, or policy, should not be in DT.

Noted. The tradeoff is I don=E2=80=99t user space to be aware of =
specific hardware, i.e. a SRP daemon should not care whether it is using =
HW offload or a software bridge. But it would also be ideal to allow a =
1:1 mapping of TCs to queues non-AVB uses such as Cedric=E2=80=99s.

A similarly sized hammer to DT would be a command-line option. Another =
option that requires a small user space change would be to add (say) =
TC_MQPRIO_MODE_CHANNEL_SRP, or to overload TC_MQPRIO_MODE_DCB for AVB.

Thoughts?

Luke=

