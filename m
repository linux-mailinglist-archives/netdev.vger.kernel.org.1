Return-Path: <netdev+bounces-104444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2590C8AF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB972282315
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260B20BA9F;
	Tue, 18 Jun 2024 09:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6E20BA8D;
	Tue, 18 Jun 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704641; cv=none; b=d32yNYBW5VmTcEiUDftYshZIyilTCuyYc44CXtNUVP0rAS7eesJb3udp3KOz3wM3lqCDibOh+ma+N7IqdCQoIkyhGzodH+iRAnbLb/S0e9lyg98HWOsvTWTympL352e+comZp8pL2gpAWujBMryde0fy4qMaZZP/YPT3L1gt4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704641; c=relaxed/simple;
	bh=kQT2vNmbzC611SxXjaKEACv+4h8nw9vPYq7MFYi4xfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRuP/Spx0ElqWH//BhtRFz/nquIN1HBa6pgolXZwNpkttIKi9Rn96Uy7QZrJdgzJQ4kGzGjQ4T7YTNS75wWCdF7Vwr6ukTIqw0j+jMndus9fAKJjha5mS4y76m8jjTj0AH7hW+XFd/weJ6OboFymahl5IBadvl/StCA94IYYZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45I9ufP23332592, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45I9ufP23332592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 17:56:41 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 17:56:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Jun 2024 17:56:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 18 Jun 2024 17:56:41 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        "rkannoth@marvell.com"
	<rkannoth@marvell.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Thread-Topic: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Thread-Index: AQHauLe4t8TnjFOscEGW3MirT25lzrHEW4aAgAC1QoCABncfgIAByXtA
Date: Tue, 18 Jun 2024 09:56:40 +0000
Message-ID: <1f0376e1dbc846a799d62a56bc6c9ff2@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-11-justinlai0215@realtek.com>
 <20240612173505.095c4117@kernel.org>
 <82ea81963af9482aa45d0463a21956b5@realtek.com>
 <94c758fc-cfcf-4a11-95b6-ca57cc85ed3e@lunn.ch>
In-Reply-To: <94c758fc-cfcf-4a11-95b6-ca57cc85ed3e@lunn.ch>
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

>=20
> > > > +     strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
> > >
> > > Can you double check that overwriting these fields is actually needed=
?
> > > I think core will fill this in for you in ethtool_get_drvinfo()
> >
> > I have removed this line of code for testing. Before removing the
> > code, I could obtain bus info by entering "ethtool -i". However, after
> > removing the code, entering "ethtool -i" no longer retrieves the bus in=
fo.
>=20
> https://elixir.bootlin.com/linux/latest/source/net/ethtool/ioctl.c#L710
>=20
>         if (ops->get_drvinfo) {
>                 ops->get_drvinfo(dev, &rsp->info);
>                 if (!rsp->info.bus_info[0] && parent)
>                         strscpy(rsp->info.bus_info, dev_name(parent),
>                                 sizeof(rsp->info.bus_info));
>=20
> This suggests you have not set the parent device.
>=20
>         Andrew
Hi Andrew,
I understand your explanation. However, when we input ethtool -i,
shouldn't we aim to get the bus info of the actual device rather than
the parent device? That's why I think we need to add this line.

