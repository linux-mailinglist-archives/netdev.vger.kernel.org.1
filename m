Return-Path: <netdev+bounces-103930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4190A62B
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECEBB28DCD
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63FF186E25;
	Mon, 17 Jun 2024 06:55:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E11862A1;
	Mon, 17 Jun 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607326; cv=none; b=Ocxr4a9rqsxH+98Xyhait8OR4oQcpJXL2acHl/pI9IoEBzW1E3NBhTqztrcWnNly08j2lot8GIXjhBldo8WFXJu59YyHzq7js+c+vG9gwoyMDKFQhufyZNVNCv5YsIlRN2m4j6/LcYe5Ti4NuY0FeWsCUGVgK6IZWpOeYIXifw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607326; c=relaxed/simple;
	bh=EbPM1ua44OR0qDCHbt7If6j3enB1A/91OBJIk+WTcZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RiGEsZn6/gq0DheIX+T/RsVGkvk8oDMcE3GiLjluThYBURnoyPy0BIB/XkspV/pS3VvLKr4GNlL1zSB16tD2rZaTMpmrSl57EHYYKKyWdGz57a6F+LjbWkG2toRpOIJSwHoLTYOkl37rcdES92N9BIWZ6BBKD7Vi3zdZK6Fyeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H6t0rlD2868264, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H6t0rlD2868264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:55:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 14:55:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 14:55:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 14:55:00 +0800
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
        "Ping-Ke
 Shih" <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Thread-Topic: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Thread-Index: AQHauLe4t8TnjFOscEGW3MirT25lzrHEW4aAgAC1QoA=
Date: Mon, 17 Jun 2024 06:54:59 +0000
Message-ID: <82ea81963af9482aa45d0463a21956b5@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-11-justinlai0215@realtek.com>
 <20240612173505.095c4117@kernel.org>
In-Reply-To: <20240612173505.095c4117@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

> On Fri, 7 Jun 2024 16:43:18 +0800 Justin Lai wrote:
> > Implement the ethtool function to support users to obtain network card
> > information, including obtaining various device settings, Report
> > whether physical link is up, Report pause parameters, Set pause
> > parameters, Return a set of strings that describe the requested
> > objects, Get number of strings that @get_strings will write, Return
> > extended statistics about the device.
>=20
> You don't implement get_strings any more.

Sorry, I will modify it.

>=20
> > +static void rtase_get_drvinfo(struct net_device *dev,
> > +                           struct ethtool_drvinfo *drvinfo) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +
> > +     strscpy(drvinfo->driver, KBUILD_MODNAME, 32);
>=20
> sizeof(drvinfo->driver) instead of the literal 32?

It seems like a better approach, I'll switch to using
sizeof(drvinfo->driver), thank you.

>=20
> > +     strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
>=20
> Can you double check that overwriting these fields is actually needed?
> I think core will fill this in for you in ethtool_get_drvinfo()

I have removed this line of code for testing. Before removing the code,
I could obtain bus info by entering "ethtool -i". However, after removing
the code, entering "ethtool -i" no longer retrieves the bus info.
Therefore, I believe that this line of code is still necessary.

>=20
> > +     if ((value & (RTASE_FORCE_TXFLOW_EN |
> RTASE_FORCE_RXFLOW_EN)) =3D=3D
> > +         (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) {
> > +             pause->rx_pause =3D 1;
> > +             pause->tx_pause =3D 1;
> > +     } else if ((value & RTASE_FORCE_TXFLOW_EN)) {
>=20
> unnecessary parenthesis
>=20
> > +             pause->tx_pause =3D 1;
> > +     } else if ((value & RTASE_FORCE_RXFLOW_EN)) {
>=20
> same here
>=20

Sorry, I will remove the unnecessary parentheses, thank you.

> > +             pause->rx_pause =3D 1;
> > +     }
> > +}
> > +
> > +static int rtase_set_pauseparam(struct net_device *dev,
> > +                             struct ethtool_pauseparam *pause) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     u16 value =3D rtase_r16(tp, RTASE_CPLUS_CMD);
> > +
> > +     if (pause->autoneg)
> > +             return -EOPNOTSUPP;
> > +
> > +     value &=3D ~(RTASE_FORCE_TXFLOW_EN |
> RTASE_FORCE_RXFLOW_EN);
> > +
> > +     if (pause->tx_pause)
> > +             value |=3D RTASE_FORCE_TXFLOW_EN;
> > +
> > +     if (pause->rx_pause)
> > +             value |=3D RTASE_FORCE_RXFLOW_EN;
> > +
> > +     rtase_w16(tp, RTASE_CPLUS_CMD, value);
> > +     return 0;
> > +}
> > +
> > +static void rtase_get_eth_mac_stats(struct net_device *dev,
> > +                                 struct ethtool_eth_mac_stats
> *stats)
> > +{
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct rtase_counters *counters;
> > +
> > +     counters =3D tp->tally_vaddr;
> > +     if (!counters)
>=20
> you fail probe if this is NULL, why check if here?
>=20

Sorry, this check seems unnecessary, I will remove it.

> > +             return;
> > +
> > +     rtase_dump_tally_counter(tp);
> > +
> > +     stats->FramesTransmittedOK =3D le64_to_cpu(counters->tx_packets);
> > +     stats->SingleCollisionFrames =3D
> le32_to_cpu(counters->tx_one_collision);
> > +     stats->MultipleCollisionFrames =3D
> > +             le32_to_cpu(counters->tx_multi_collision);
> > +     stats->FramesReceivedOK =3D le64_to_cpu(counters->rx_packets);
> > +     stats->FrameCheckSequenceErrors =3D
> > + le32_to_cpu(counters->rx_errors);
>=20
> You dont report this in rtase_get_stats64() as crc errors, are these real=
ly CRC /
> FCS errors or other errors?

Our rx_error indeed refers to crc_error. I will assign the value of
rx_error to the crc_error in rtase_get_stats64().

>=20
> > +     stats->AlignmentErrors =3D le16_to_cpu(counters->align_errors);
> > +     stats->FramesAbortedDueToXSColls =3D
> le16_to_cpu(counters->tx_aborted);
> > +     stats->FramesLostDueToIntMACXmitError =3D
> > +             le64_to_cpu(counters->tx_errors);
> > +     stats->FramesLostDueToIntMACRcvError =3D
> > +             le16_to_cpu(counters->rx_missed);
>=20
> Are you sure this is the correct statistic to report as?
> What's the definition of rx_missed in the datasheet?

What we refer to as rx miss is the packets that can't be received because
the fifo in the MAC is full. We consider this a type of MAC error, identica=
l
to the definition of FramesLostDueToIntMACRcvError.

>=20
> Also is 16 bits enough for a packet counter at 5Gbps?
> Don't you have to periodically accumulate this counter so that it doesn't=
 wrap
> around?

Indeed, this counter may wrap, but we don't need to accumulate it, because
an increase in the number of rx_miss largely indicates that the system
processing speed is not fast enough. Therefore, the size of this counter
doesn't need to be too large.

>=20
> > +     stats->MulticastFramesReceivedOK =3D
> le32_to_cpu(counters->rx_multicast);
> > +     stats->BroadcastFramesReceivedOK =3D
> > +le64_to_cpu(counters->rx_broadcast);
> > +}
> > +
> > +static const struct ethtool_ops rtase_ethtool_ops =3D {
> > +     .get_drvinfo =3D rtase_get_drvinfo,
> > +     .get_link =3D ethtool_op_get_link,
> > +     .get_link_ksettings =3D rtase_get_settings,
> > +     .get_pauseparam =3D rtase_get_pauseparam,
> > +     .set_pauseparam =3D rtase_set_pauseparam,
> > +     .get_eth_mac_stats =3D rtase_get_eth_mac_stats,
> > +     .get_ts_info =3D ethtool_op_get_ts_info, };
> > +
> >  static void rtase_init_netdev_ops(struct net_device *dev)  {
> >       dev->netdev_ops =3D &rtase_netdev_ops;
> > +     dev->ethtool_ops =3D &rtase_ethtool_ops;
> >  }
> >
> >  static void rtase_reset_interrupt(struct pci_dev *pdev,


