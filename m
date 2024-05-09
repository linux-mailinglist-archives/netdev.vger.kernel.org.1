Return-Path: <netdev+bounces-94854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E998C0DE5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF6E283ACE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92BA14AD26;
	Thu,  9 May 2024 09:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95F14AD1A;
	Thu,  9 May 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248774; cv=none; b=kLPMb/V+EMG+3KEavF+f8NgvHQ6hw4l9W6NuRm7s8xSCb4valSUDV/JGDyUU1wiKCWDBFCEWqNZaDjegG7X7ZuuI0Um4OGafPJQCxA2A4h/J6eb6ahtVqlgrZnwjdqbdYo+iQ1FcGo2ZdtuieCh7kSpHbc3mrnU5fSvffTKtexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248774; c=relaxed/simple;
	bh=dtQ5WtrGDhIWgT1qeZF8014MTF0JeO8/hPqjUWcHDGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHd44pzcD+A+i5/wl2GdIW/Z1RMA0wAhi38l8AvfKC65aOIuDNQaU/xV3ifyGD37rgEXV4eSnK6CLVPp79m+Qnmis0O/SqbC5abtbeBs32wsqZiGddoOWiIWyznwYJ831R+lrqpreKCzg0HiWvoNGutFoZWvzniXUU1zuRqvwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4499x4Jd91475338, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4499x4Jd91475338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 17:59:04 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:59:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:59:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 9 May 2024 17:59:04 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHaoUT5RWh4TO7cuUeh1vkT8i8o3LGN87+AgACfZICAAApUsIAADPfg
Date: Thu, 9 May 2024 09:59:04 +0000
Message-ID: <feeecf2edbe54d999b09068718e9c8b5@realtek.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
 <20240508123945.201524-3-justinlai0215@realtek.com>
 <20240509065747.GB1077013@maili.marvell.com>
 <9267c5002e444000bb21e8eef4d4dc07@realtek.com>
 <MWHPR1801MB19187C10FEBB29BDACE499B1D3E62@MWHPR1801MB1918.namprd18.prod.outlook.com>
In-Reply-To: <MWHPR1801MB19187C10FEBB29BDACE499B1D3E62@MWHPR1801MB1918.namprd18.prod.outlook.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
> > From: Justin Lai <justinlai0215@realtek.com>
> > Sent: Thursday, May 9, 2024 2:29 PM
> > > > +
> > > > +     /* rx and tx descriptors needs 256 bytes alignment.
> > > > +      * dma_alloc_coherent provides more.
> > > > +      */
> > > > +     for (i =3D 0; i < tp->func_tx_queue_num; i++) {
> > > > +             tp->tx_ring[i].desc =3D
> > > > +                             dma_alloc_coherent(&pdev->dev,
> > > > +
> > > RTASE_TX_RING_DESC_SIZE,
> > > > +
> > > &tp->tx_ring[i].phy_addr,
> > > > +
> GFP_KERNEL);
> > > > +             if (!tp->tx_ring[i].desc)
> > > You have handled errors gracefully very where else. why not here ?
> >
> > I would like to ask you, are you referring to other places where there
> > are error description messages, but not here?
> other functions, you are freeing allocated resources in case of failure, =
but here,
> you are returning error directly.
>=20
After returning the error, I will do the corresponding error handling in rt=
ase_open.
.
>=20
> > > Did you mark the skb for recycle ? Hmm ... did i miss to find the cod=
e ?
> > >
> > We have done this part when using the skb and before finally releasing
> > the skb resource. Do you think it would be better to do this part of
> > the process when allocating the skb?
> i think, you added skb_for_recycle() in the following patch. Sorry I miss=
ed it .
> ignore my comment.
>=20

OK, thank you for your feedback.

> >
> > > > +
> > > > +err_free_all_allocated_irq:
> > > You are allocating from i =3D 1, but freeing from j =3D 0;
> >
> > Hi Ratheesh,
> > I have done request_irq() once before the for loop, so there should be
> > no problem starting free from j=3D0 here.
> Thanks for pointing out.

Thank you also for your review.


