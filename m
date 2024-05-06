Return-Path: <netdev+bounces-93588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2288BC5CF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D61F2213C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522322075;
	Mon,  6 May 2024 02:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFA181;
	Mon,  6 May 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714963230; cv=none; b=c8vRACyAJ6eXOWVy+ueTQuItpDqTC7x8pJv1WvYkp3uY2Y/kJYf+aykIIdnj4G2eoGAFgUM1w8itXviwtDaNSVnaLN7kDufnbmd++7H41yCiA88GKxA99K9+d6kbaczEqNK40mLSNGcAM2QXS4RG3GacUj05Gr/vZRj3aRf+2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714963230; c=relaxed/simple;
	bh=UzuvbpT59bSEfIj+CxmqYxw+cOAWIj3xILqoUieEs8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFhDg2nw1TLHJ6UP1dcLY/wO2WxReynQJwYr4Ow/nZ5eb5Rm+I+DsKD2l5mryXbAiVtBJWx5U0OnqTMCgqYgVmA5ml5bkvgSnDj35/0uSKqk7MbjDxUo7wAY5byWRlvu6CoCYHkjN8J7w23cMAnjObYHCzB9jrCCSKlukVNkkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4462dq1tB1815379, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4462dq1tB1815379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 10:39:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:39:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:39:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 6 May 2024 10:39:50 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
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
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHanHHZpNHx0voP+0CDD26jysJVP7GEr5aAgACdBfD//4djgIAEr/zg
Date: Mon, 6 May 2024 02:39:50 +0000
Message-ID: <7d81d0f7a24a4349a53cd77f9e42ee4a@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-3-justinlai0215@realtek.com>
 <20240503085257.GM2821784@kernel.org>
 <3199bfed19ad4e0bb8ca868b6c46588a@realtek.com>
 <20240503110315.GO2821784@kernel.org>
In-Reply-To: <20240503110315.GO2821784@kernel.org>
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

> On Fri, May 03, 2024 at 10:19:05AM +0000, Justin Lai wrote:
> > > On Thu, May 02, 2024 at 05:18:36PM +0800, Justin Lai wrote:
> > > > Implement the .ndo_open function to set default hardware settings
> > > > and initialize the descriptor ring and interrupts. Among them,
> > > > when requesting irq, because the first group of interrupts needs
> > > > to process more events, the overall structure will be different
> > > > from other groups of interrupts, so it needs to be processed separa=
tely.
> > > >
> > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > >
> > > Hi Justin,
> > >
> > > some minor feedback from my side.
> > >
> > > > +static int rtase_open(struct net_device *dev) {
> > > > +     struct rtase_private *tp =3D netdev_priv(dev);
> > > > +     struct rtase_int_vector *ivec =3D &tp->int_vector[0];
> > > > +     const struct pci_dev *pdev =3D tp->pdev;
> > > > +     u16 i, j;
> > > > +     int ret;
> > >
> > > nit: please use reverse xmas tree order - longest line to shortest -
> > >      for local variable declarations in new Networking code.
> > >
> > Hi Simon,
> > This is partly because ivec needs to use tp for initialization, so tp
> > is placed in front of ivec, causing this situation.
>=20
> Thanks Justin,
>=20
> Understood.
>=20
> Had I noticed that I probably wouldn't have commented as I did above.
> But, FWIIW, in such cases my suggestion would be to separate the declarat=
ion
> from the assignment.
>=20
> Something like this:
>=20
>         struct rtase_private *tp =3D netdev_priv(dev);
>         const struct pci_dev *pdev =3D tp->pdev;
>         struct rtase_int_vector *ivec;
>         u16 i, j;
>         int ret;
>=20
>         ivec =3D &tp->int_vector[0];

OK, I understand, thank you for your suggestion.

