Return-Path: <netdev+bounces-131885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F998FDDD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E831C21419
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB174070;
	Fri,  4 Oct 2024 07:32:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1621862
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027165; cv=none; b=mTRx3G29BuoYbK6NXU+A31V49nziSSIemJk6oXYHNQ3JR4eHkcrfz45y/0AQbktwPYJn+ywSTAbrKRWI5rEdjWyFqyoy0xX31pALzOoe+stCgK8W/gC3q2jdWzOvf9HAT1LSB07Ylswg6iv4X0H3qdOqWa8Cd0LHeDyQ6+F/hBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027165; c=relaxed/simple;
	bh=qq6bQalh11RPLC47ojlZoIdm+bDJNIvVhK5PPkpdcuA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qe4ibeMPBzkbPpZXJxmoitR+k/xisoEvWSnURckTA0n7DqGdsssXeZvuQ7E4Rr15Um/jKRBuYFTiqHRIkVOh+8vy2ni7BTgys3bTTxvixWcli5x7s/ESU9Lin8198cORhvZdHW9CFE9UK3tX3W4Vxl7pD/S7ikmQKzIlwM0a8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=178.33.251.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.9.135])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4XKfsF4yvQz1sZZ
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 07:13:21 +0000 (UTC)
Received: from ghost-submission-55b549bf7b-zd9hm (unknown [10.110.188.21])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1A2121FE9E;
	Fri,  4 Oct 2024 07:13:10 +0000 (UTC)
Received: from courmont.net ([37.59.142.96])
	by ghost-submission-55b549bf7b-zd9hm with ESMTPSA
	id ixY9CoaV/2YclBEACvZv3Q
	(envelope-from <remi@remlab.net>); Fri, 04 Oct 2024 07:13:10 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-96R0010c63f422-fae0-415f-84d9-8d5e57b855dd,
                    121B9CD251BF2F3270647EF5B0AA7C8EFB4D397F) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:103.5.142.236
Date: Fri, 04 Oct 2024 16:12:52 +0900
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Remi Denis-Courmont <courmisch@gmail.com>, Florian Westphal <fw@strlen.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_net_6/6=5D_phonet=3A_Hand?=
 =?US-ASCII?Q?le_error_of_rtnl=5Fregister=5Fmodule=28=29=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241003205725.5612-7-kuniyu@amazon.com>
References: <20241003205725.5612-1-kuniyu@amazon.com> <20241003205725.5612-7-kuniyu@amazon.com>
Message-ID: <7DDD1B29-F8DA-4F59-9B0A-EC108D61E54E@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 10777395384518908377
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpedtheettdehgeefjeefteehteegvdevkeekjefhgfeggfeiveevfffflefgheeujeenucfkphepuddvjedrtddrtddruddpuddtfedrhedrudegvddrvdefiedpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvghmihesrhgvmhhlrggsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth



Le 4 octobre 2024 05:57:25 GMT+09:00, Kuniyuki Iwashima <kuniyu@amazon=2Ec=
om> a =C3=A9crit=C2=A0:
>Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl
>message handlers"), once the first rtnl_register_module() allocated
>rtnl_msg_handlers[PF_PHONET], the following calls never failed=2E
>
>However, after the commit, rtnl_register_module() could fail to allocate
>rtnl_msg_handlers[PF_PHONET][msgtype] and requires error handling for
>each call=2E
>
>Let's use rtnl_register_module_many() to handle the errors easily=2E
>
>Fixes: addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message handle=
rs")
>Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon=2Ecom>

Acked-by: R=C3=A9mi Denis-Courmont <courmisch@gmail=2Ecom>

>---
>Cc: Remi Denis-Courmont <courmisch@gmail=2Ecom>
>Cc: Florian Westphal <fw@strlen=2Ede>
>---
> net/phonet/pn_netlink=2Ec | 27 ++++++++++-----------------
> 1 file changed, 10 insertions(+), 17 deletions(-)
>
>diff --git a/net/phonet/pn_netlink=2Ec b/net/phonet/pn_netlink=2Ec
>index 7008d402499d=2E=2Ed39e6983926b 100644
>--- a/net/phonet/pn_netlink=2Ec
>+++ b/net/phonet/pn_netlink=2Ec
>@@ -285,23 +285,16 @@ static int route_dumpit(struct sk_buff *skb, struct=
 netlink_callback *cb)
> 	return err;
> }
>=20
>+static struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_=
module =3D {
>+	{PF_PHONET, RTM_NEWADDR, addr_doit, NULL, 0},
>+	{PF_PHONET, RTM_DELADDR, addr_doit, NULL, 0},
>+	{PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
>+	{PF_PHONET, RTM_NEWROUTE, route_doit, NULL, 0},
>+	{PF_PHONET, RTM_DELROUTE, route_doit, NULL, 0},
>+	{PF_PHONET, RTM_GETROUTE, NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED},
>+};
>+
> int __init phonet_netlink_register(void)
> {
>-	int err =3D rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWADDR,
>-				       addr_doit, NULL, 0);
>-	if (err)
>-		return err;
>-
>-	/* Further rtnl_register_module() cannot fail */
>-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELADDR,
>-			     addr_doit, NULL, 0);
>-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETADDR,
>-			     NULL, getaddr_dumpit, 0);
>-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWROUTE,
>-			     route_doit, NULL, 0);
>-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
>-			     route_doit, NULL, 0);
>-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETROUTE,
>-			     NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED);
>-	return 0;
>+	return rtnl_register_module_many(phonet_rtnl_msg_handlers);
> }

