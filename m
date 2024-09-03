Return-Path: <netdev+bounces-124353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3126E969193
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6424A1C229B7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7D19F131;
	Tue,  3 Sep 2024 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JXUq93zj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67C19E998;
	Tue,  3 Sep 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725331949; cv=none; b=RxBGTYAKmypLb0has5jOirwXLGP7acLrNfdFXZ9CGG1mPHL9CS7qWMqcaYPtga6il5OmVdnvT9e+4A1RKJjmLoYN8Sd1UgejdLj4BcdyUznDopDSm2xn7zqUVD0OTQqUW38Tnx2sZ3LI5ydEKyvTynJeTCvh40X4tfOqhfClQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725331949; c=relaxed/simple;
	bh=GztQwE1gB/QB/4pqe48TGIb07EvhsztMdvOaTHBSn+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmP/j/G64wHAx6nlmYFWuD0ap3C/ajmD8/WU8qkz7tkqJbvuDdLGJHDDC3mUdiG1mXDo281KE5R4Bv9H8yAQyKyDP9dDNWE5hAGECWDMAVwY23EfFemfVf9nR2BSx9kg8AbFD48E2cy2kjGttDgVaoiNITwwYonl4YGVdMKVnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JXUq93zj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4832piSgB651417, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725331904; bh=GztQwE1gB/QB/4pqe48TGIb07EvhsztMdvOaTHBSn+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JXUq93zjWN4jhvpEvjfiiXClnB3u/M4MYBb/mYU16aP42AQcqA9OA8fp+WW1OdryR
	 ItOXKcJ6JJAy/RtiPxHni0J375A5eZf+ooNSKUgkYD0QK81j6X9/btkbVTIXxXQnAZ
	 svYyE6/12CaBawfOFMyTVVdfIqtWp7buNcXtwxRcWjcKNiW1gS7VI5hHxqpFhItScI
	 sPBWpKHQ1ftDKwGgDZFiXp4ilbwdm1sAm4rehwTi0z+PrIBvUUv5VTYYwP1nSmr6Qy
	 doKhDQ1ieuTBj1sEXfGJ9SEgIR/S3sj9TOWC6QDwFtzut+geMrJh6VIAMt7wZCs5rO
	 iBhJd1BDZD2AA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4832piSgB651417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 10:51:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 10:51:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 3 Sep 2024 10:51:43 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Tue, 3 Sep 2024 10:51:43 +0800
From: Larry Chiu <larry.chiu@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>, Justin Lai <justinlai0215@realtek.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "jdamato@fastly.com" <jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: RE: [PATCH net-next v29 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v29 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHa+cbRwwh2xyzhbkuIuTt8rA5l2bJE0YmAgACQCqA=
Date: Tue, 3 Sep 2024 02:51:43 +0000
Message-ID: <03177710937042bb93dfbf3237394a91@realtek.com>
References: <20240829034832.139345-1-justinlai0215@realtek.com>
	<20240829034832.139345-8-justinlai0215@realtek.com>
 <20240902190425.6eef2ee6@kernel.org>
In-Reply-To: <20240902190425.6eef2ee6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, September 3, 2024 10:04 AM
> To: Justin Lai <justinlai0215@realtek.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> linux-kernel@vger.kernel.org; netdev@vger.kernel.org; andrew@lunn.ch;
> jiri@resnulli.us; horms@kernel.org; rkannoth@marvell.com;
> jdamato@fastly.com; Ping-Ke Shih <pkshih@realtek.com>; Larry Chiu
> <larry.chiu@realtek.com>
> Subject: Re: [PATCH net-next v29 07/13] rtase: Implement a function to
> receive packets
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Thu, 29 Aug 2024 11:48:26 +0800 Justin Lai wrote:
> > +             skb->dev =3D dev;
>=20
> no need to assign skb->dev =3D dev; eth_type_trans() will do it for you

Thanks, we will remove it.

>=20
> > +             skb_put(skb, pkt_size);
> > +             skb_mark_for_recycle(skb);
> > +             skb->protocol =3D eth_type_trans(skb, dev);
> > +
> > +             if (skb->pkt_type =3D=3D PACKET_MULTICAST)
> > +                     tp->stats.multicast++;
> > +
> > +             rtase_rx_vlan_skb(desc, skb);
> > +             rtase_rx_skb(ring, skb);
> > +
> > +             dev_sw_netstats_rx_add(dev, pkt_size);
> > +
> > +skip_process_pkt:
> > +             workdone++;
> > +             cur_rx++;
> > +             entry =3D cur_rx % RTASE_NUM_DESC;
> > +             desc =3D ring->desc + sizeof(union rtase_rx_desc) * entry=
;
> > +     } while (workdone !=3D budget);
>=20
> The check needs to be at the start of the function.
> NAPI can be called with budget of 0 to limit the processing
> to just Tx cleanup. In that case no packet should be received.

OK, we will use a for loop instead.


