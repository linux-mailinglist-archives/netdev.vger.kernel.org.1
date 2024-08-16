Return-Path: <netdev+bounces-119120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5AB9541F5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170411F22346
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB581ADA;
	Fri, 16 Aug 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="g0ofoxm5"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C326F2E7;
	Fri, 16 Aug 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790709; cv=none; b=WiJiovlZtBFBrzedVKd0nt3qkBBMmUii1BbjQUItWcqNYRD90n1EEurRUiIkGulhMcFoijcOwX0RShQ/x5jYGlS6BVJzxNSS+b4+tZlGVQYCCNwY/VZeIz/xoj4ZjBinIQy+SabcfYTpBtmS+Iqa6YmmCzw3BI/9Rlz9KxY3Cp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790709; c=relaxed/simple;
	bh=eChf9Dbv5tEia+uyccONUrYBhMWFrthByY8RFvh9+ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ql5d76SYLXjEdVvxL0w7+aO7nB5Erb07np5OMNX3iEYErQprc3qnLrmDPxgWfG2TEIHzbqwpUj4rFo43JPm4c5VlNrYNyKxiny3HoDdtTKQnS99i/ZK4lK3TAF2VtdzG64YBwqQvz8qtJBtFQh0B7X15QmnkBnzjMdatZkJsdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=g0ofoxm5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47G6iHGY1762028, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723790657; bh=eChf9Dbv5tEia+uyccONUrYBhMWFrthByY8RFvh9+ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=g0ofoxm5y+iP7PGadGiErhNakNi8ZesBYNblKYSkyfi71QIeFvySpDKwAK58jVJlk
	 Big0pTo40mXmj55eIpcBptc0wHaJlt+JYyNtH+Om5dAP/0A0v8OEplNqgebKlogdsR
	 Zte0oykYs+YJ/bpmi6KPGOz7UbtT9dXt/entILrjuaAVBCF6KgVpdqVDagVJnfcDvs
	 a+ObMsZhQku4LD/tXEVtYlnpGfWiIJ3KA1DDpueXTAnD7CZOsD6t6wkyHksqOmpT3W
	 NXMqjvhQxYRK91Wzjh6/5Wr9ciU39ac8dZvp17SJgOfEhHZTa/FjdNQATpljE+FfZK
	 LPTMBzEYjEFhQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47G6iHGY1762028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 14:44:17 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:44:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Aug 2024 14:44:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 16 Aug 2024 14:44:17 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
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
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v27 10/13] rtase: Implement ethtool function
Thread-Topic: [PATCH net-next v27 10/13] rtase: Implement ethtool function
Thread-Index: AQHa7IKZgu9hD1qOPUSyRfG55mQZDLIonR+AgADXX9A=
Date: Fri, 16 Aug 2024 06:44:17 +0000
Message-ID: <ff91f4dd147f4493bd25a16c641f1806@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-11-justinlai0215@realtek.com>
 <20240815184635.4c074130@kernel.org>
In-Reply-To: <20240815184635.4c074130@kernel.org>
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

> On Mon, 12 Aug 2024 14:35:36 +0800 Justin Lai wrote:
> > +static void rtase_get_drvinfo(struct net_device *dev,
> > +                           struct ethtool_drvinfo *info) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +
> > +     strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
> > +     strscpy(info->bus_info, pci_name(tp->pdev),
> > +sizeof(info->bus_info)); }
>=20
> This shouldn't be necessary, can you delete this function from the driver=
 and
> check if the output of ethtool -i changes?
> ethtool_get_drvinfo() should fill this in for you.

Thank you for your response. As you mentioned, ethtool_get_drvinfo()
will indeed populate the relevant information. I will remove
rtase_get_drvinfo().

>=20
> > +static void rtase_get_pauseparam(struct net_device *dev,
> > +                              struct ethtool_pauseparam *pause) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     u16 value =3D rtase_r16(tp, RTASE_CPLUS_CMD);
> > +
> > +     pause->autoneg =3D AUTONEG_DISABLE;
> > +
> > +     if ((value & (RTASE_FORCE_TXFLOW_EN |
> RTASE_FORCE_RXFLOW_EN)) =3D=3D
> > +         (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) {
> > +             pause->rx_pause =3D 1;
> > +             pause->tx_pause =3D 1;
> > +     } else if (value & RTASE_FORCE_TXFLOW_EN) {
> > +             pause->tx_pause =3D 1;
> > +     } else if (value & RTASE_FORCE_RXFLOW_EN) {
> > +             pause->rx_pause =3D 1;
> > +     }
>=20
> This 3 if statements can be replaced with just two lines:
>=20
>         pause->rx_pause =3D !!(value & RTASE_FORCE_RXFLOW_EN);
>         pause->tx_pause =3D !!(value & RTASE_FORCE_TXFLOW_EN);

Ok, I will modify it.

Thanks
Justin

