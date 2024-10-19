Return-Path: <netdev+bounces-137209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC29A4CCF
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677FA1F223AE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085C1DE4EE;
	Sat, 19 Oct 2024 10:15:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFC18755C
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729332901; cv=none; b=JOykp6iHZI2eHGdgbbp2FF/pdIXIkXj5zALQjtIl8VvG4tA8owqP5YpHjopYcBruucPVJ3JHVS6QFPlcXKvv1Id2hGJcN4qWzqK1shZWGTgzHSPqRw0vDsou419XYZ1wi64d/O9IQPhXgIqM/Vvy8i7SExFXye4+pUM9aRFteCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729332901; c=relaxed/simple;
	bh=5OuKA2ZjXi09wISBw0y4NRU7LnxMJJvZARQHevnRC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Le/T8lhTnBKK/nwecLgEjqqLNN2gHCQRSQwNuUZcfYNVaKYBWKkQsuZAXy3ZYL8usT+dVcBGx5yHY92WlNvarg5i9zNZdQgi2/OPnxm7QXYysa2PcEfVAOBnfiK3j/8uLFMawH0+U9TtFLjV5oyq5NC4z381xaoVLzfPgVVLDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=178.33.251.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.176.51])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4XVtxR2rzXz1Gf1
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 07:48:59 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-8j5vk (unknown [10.108.42.126])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 05D5C1FD1B;
	Sat, 19 Oct 2024 07:48:58 +0000 (UTC)
Received: from courmont.net ([37.59.142.95])
	by ghost-submission-5b5ff79f4f-8j5vk with ESMTPSA
	id 04rhKWpkE2fprQUAIm2eYQ
	(envelope-from <remi@remlab.net>); Sat, 19 Oct 2024 07:48:58 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G0012e879ea7-9036-4c1d-96da-78de22fd985f,
                    CD518CDB9F4554B3546701C84A6F0ED5AEB4A0A8) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.92.194.88
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
Subject:
 Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for getaddr_dumpit().
Date: Sat, 19 Oct 2024 10:48:57 +0300
Message-ID: <12565887.O9o76ZdvQC@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20241018171629.92709-1-kuniyu@amazon.com>
References:
 <2341285.ElGaqSPkdT@basile.remlab.net>
 <20241018171629.92709-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 7235877227960998263
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvghmihesrhgvmhhlrggsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedupdhmohguvgepshhmthhpohhuth

Le perjantaina 18. lokakuuta 2024, 20.16.29 EEST Kuniyuki Iwashima a =C3=A9=
crit :
> From: "R=C3=A9mi Denis-Courmont" <remi@remlab.net>
> Date: Thu, 17 Oct 2024 21:49:18 +0300
>=20
> > > diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> > > index 5996141e258f..14928fa04675 100644
> > > --- a/net/phonet/pn_netlink.c
> > > +++ b/net/phonet/pn_netlink.c
> > > @@ -127,14 +127,17 @@ static int fill_addr(struct sk_buff *skb, u32
> > > ifindex, u8 addr,
> > >=20
> > >  static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callba=
ck
> > >  *cb)
> > >=20
> > > {
> > > +	int addr_idx =3D 0, addr_start_idx =3D cb->args[1];
> > > +	int dev_idx =3D 0, dev_start_idx =3D cb->args[0];
> > >=20
> > >  	struct phonet_device_list *pndevs;
> > >  	struct phonet_device *pnd;
> > >=20
> > > -	int dev_idx =3D 0, dev_start_idx =3D cb->args[0];
> > > -	int addr_idx =3D 0, addr_start_idx =3D cb->args[1];
> > > +	int err =3D 0;
> > >=20
> > >  	pndevs =3D phonet_device_list(sock_net(skb->sk));
> > >=20
> > > +
> > >=20
> > >  	rcu_read_lock();
> > >  	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
> > >=20
> > > +		DECLARE_BITMAP(addrs, 64);
> > >=20
> > >  		u8 addr;
> > >  	=09
> > >  		if (dev_idx > dev_start_idx)
> > >=20
> > > @@ -143,23 +146,26 @@ static int getaddr_dumpit(struct sk_buff *skb,
> > > struct
> > > netlink_callback *cb) continue;
> > >=20
> > >  		addr_idx =3D 0;
> > >=20
> > > -		for_each_set_bit(addr, pnd->addrs, 64) {
> > > +		memcpy(addrs, pnd->addrs, sizeof(pnd->addrs));
> >=20
> > Is that really safe? Are we sure that the bit-field writers are atomic
> > w.r.t. memcpy() on all platforms? If READ_ONCE is needed for an integer,
> > using memcpy() seems sketchy, TBH.
>=20
> I think bit-field read/write need not be atomic here because even
> if a data-race happens, for_each_set_bit() iterates each bit, which
> is the real data, regardless of whether data-race happened or not.

Err, it looks to me that a corrupt bit would lead to the index getting corr=
upt=20
and addresses getting skipped or repeated. AFAICT, the RTNL lock is still=20
needed here.

=2D-=20
=E9=9B=B7=E7=B1=B3=E2=80=A7=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99
http://www.remlab.net/




