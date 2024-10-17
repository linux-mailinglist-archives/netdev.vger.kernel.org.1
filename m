Return-Path: <netdev+bounces-136799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD949A3254
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E748A1F23E1A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672395103F;
	Fri, 18 Oct 2024 01:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFD39FD9
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216655; cv=none; b=cNx8qbiIaSQrf/gd6j42E0LP64lhgR9zZqeHbZEFsNxckp0m3ZiDMUnmYZo2MufTyG7mIYOGHKcRIx6h1QAdlGX0ikT6ZImBJJLuAcWEZr9cmEOD4nPgEmQ04672K8o9lVnnyIfCtN8hdal2jSIg0irezQ6aIDw7YWfJJ/ypaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216655; c=relaxed/simple;
	bh=RGmjlpPYW3PehpB2Eo8mGnj6MiAhOAViHDIbdb3PKDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIhO6UgfFUU0Kp2aUoGCewcsI0jrCVeMztd3KfkBKtb6sC482lQwqxa84/X9NrtR2ROHUHLrgQrmiu5Iwiq+lk1zOcwh65yvvs4k1DT4K6a1Ej7xwolVTm/ZHXvGX6+wqjEN+m03Kt6QWJmcmgnaZBcDqDbGMj0V+K8AIy8+hLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=188.165.56.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.25.16])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4XTxhJ2r2Mz1R3K
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:49:20 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-697w8 (unknown [10.110.113.13])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E246F1FDDD;
	Thu, 17 Oct 2024 18:49:19 +0000 (UTC)
Received: from courmont.net ([37.59.142.103])
	by ghost-submission-5b5ff79f4f-697w8 with ESMTPSA
	id KWQrLS9cEWdT4gAAMCyPwA
	(envelope-from <remi@remlab.net>); Thu, 17 Oct 2024 18:49:19 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-103G005c882a681-abc3-40c2-bb92-d2742f8ba979,
                    F36AD18FB65E1C038B7E86C1D349DB2E61484AA3) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.92.194.88
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject:
 Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for getaddr_dumpit().
Date: Thu, 17 Oct 2024 21:49:18 +0300
Message-ID: <2341285.ElGaqSPkdT@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20241017183140.43028-6-kuniyu@amazon.com>
References:
 <20241017183140.43028-1-kuniyu@amazon.com>
 <20241017183140.43028-6-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 6642809453094115703
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkohgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnhepffegtdfhgeevfefhhfffhedvtddvtefgleevueeukeekteevgfdtgfffvdfhgeevnecuffhomhgrihhnpehrvghmlhgrsgdrnhgvthenucfkphepuddvjedrtddrtddruddpkeejrdelvddrudelgedrkeekpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvghmihesrhgvmhhlrggsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth

Le torstaina 17. lokakuuta 2024, 21.31.36 EEST Kuniyuki Iwashima a =C3=A9cr=
it :
> getaddr_dumpit() already relies on RCU and does not need RTNL.
>=20
> Let's use READ_ONCE() for ifindex and register getaddr_dumpit()
> with RTNL_FLAG_DUMP_UNLOCKED.
>=20
> While at it, the retval of getaddr_dumpit() is changed to combine
> NLMSG_DONE and save recvmsg() as done in 58a4ff5d77b1 ("phonet: no
> longer hold RTNL in route_dumpit()").
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/phonet/pn_netlink.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> index 5996141e258f..14928fa04675 100644
> --- a/net/phonet/pn_netlink.c
> +++ b/net/phonet/pn_netlink.c
> @@ -127,14 +127,17 @@ static int fill_addr(struct sk_buff *skb, u32 ifind=
ex,
> u8 addr,
>=20
>  static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *=
cb)
> {
> +	int addr_idx =3D 0, addr_start_idx =3D cb->args[1];
> +	int dev_idx =3D 0, dev_start_idx =3D cb->args[0];
>  	struct phonet_device_list *pndevs;
>  	struct phonet_device *pnd;
> -	int dev_idx =3D 0, dev_start_idx =3D cb->args[0];
> -	int addr_idx =3D 0, addr_start_idx =3D cb->args[1];
> +	int err =3D 0;
>=20
>  	pndevs =3D phonet_device_list(sock_net(skb->sk));
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
> +		DECLARE_BITMAP(addrs, 64);
>  		u8 addr;
>=20
>  		if (dev_idx > dev_start_idx)
> @@ -143,23 +146,26 @@ static int getaddr_dumpit(struct sk_buff *skb, stru=
ct
> netlink_callback *cb) continue;
>=20
>  		addr_idx =3D 0;
> -		for_each_set_bit(addr, pnd->addrs, 64) {
> +		memcpy(addrs, pnd->addrs, sizeof(pnd->addrs));

Is that really safe? Are we sure that the bit-field writers are atomic w.r.=
t.=20
memcpy() on all platforms? If READ_ONCE is needed for an integer, using=20
memcpy() seems sketchy, TBH.

> +
> +		for_each_set_bit(addr, addrs, 64) {
>  			if (addr_idx++ < addr_start_idx)
>  				continue;
>=20
> -			if (fill_addr(skb, pnd->netdev->ifindex, addr=20
<< 2,
> -					 NETLINK_CB(cb-
>skb).portid,
> -					cb->nlh->nlmsg_seq,=20
RTM_NEWADDR) < 0)
> +			err =3D fill_addr(skb, READ_ONCE(pnd->netdev-
>ifindex),
> +					addr << 2,=20
NETLINK_CB(cb->skb).portid,
> +					cb->nlh->nlmsg_seq,=20
RTM_NEWADDR);
> +			if (err < 0)
>  				goto out;
>  		}
>  	}
> -
>  out:
>  	rcu_read_unlock();
> +
>  	cb->args[0] =3D dev_idx;
>  	cb->args[1] =3D addr_idx;
>=20
> -	return skb->len;
> +	return err;
>  }
>=20
>  /* Routes handling */
> @@ -298,7 +304,7 @@ static const struct rtnl_msg_handler
> phonet_rtnl_msg_handlers[] __initdata_or_mo {.owner =3D THIS_MODULE,
> .protocol =3D PF_PHONET, .msgtype =3D RTM_DELADDR, .doit =3D addr_doit, .=
flags =3D
> RTNL_FLAG_DOIT_UNLOCKED},
>  	{.owner =3D THIS_MODULE, .protocol =3D PF_PHONET, .msgtype =3D=20
RTM_GETADDR,
> -	 .dumpit =3D getaddr_dumpit},
> +	 .dumpit =3D getaddr_dumpit, .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
>  	{.owner =3D THIS_MODULE, .protocol =3D PF_PHONET, .msgtype =3D=20
RTM_NEWROUTE,
>  	 .doit =3D route_doit},
>  	{.owner =3D THIS_MODULE, .protocol =3D PF_PHONET, .msgtype =3D=20
RTM_DELROUTE,


=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/




