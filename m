Return-Path: <netdev+bounces-177062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D057A6D9CD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10983A1925
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0D25E454;
	Mon, 24 Mar 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PqGb2ED8"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACDF1E633C;
	Mon, 24 Mar 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818011; cv=none; b=JC4kqkAZy9oEb2g2yOtpapDA9Q5CAwzls9KhbscOVTesZAqAWlU6DOvDAQ9lqMgDhBC2XxGyDkFOfQgQi0eqJ2jnlle4VhLv4QLedY7W3Ssb0ckJSZac2P62MgStgs/MmeoUCvnzuxmVcB+8wqDfht51hFqlWkKlLDlg4rhCS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818011; c=relaxed/simple;
	bh=wYgu0yj4rAcgBybWVgJbgK5SX6ir9b4d3V82SGy23m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qj7eu9GmqPpY/9R/pGNHnGpg8uMSuhUrtSA3QKkX/rkW14leVeAmrHRfj2s/TlW5XucUasYemjF43jjShzdDr9tJtDwSNMxOM/Lh8NywmP9o5LbHITbrLw+QAJWCKyWe9VvzpV6ozDeeBunBDgfuaf+lsy7DCaEGgfLCOZcWQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PqGb2ED8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52OC6A8Z01884390, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742817970; bh=wYgu0yj4rAcgBybWVgJbgK5SX6ir9b4d3V82SGy23m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PqGb2ED8JSe5J6HaWpH11lbkh46DXsYWOIKwMo1TQiSoIuZEnXf7B4LO0Gl4w3cvP
	 fBVXEGiaHL/Xx5Zkql+4TNaEiTsmUazaS18ioIQsAe8KwoevtT1eYGTQN4GeaX+vIG
	 xP0MeN4sK+uKxEICV/PLqOEv0PV1Pqdd/7yAMh/V13pOC05/kuQs0mf94aLWJCIlWI
	 8dbzjh+xfommns88bS6km3stkmgeY5Hyb88sPoI35k7/JJl7lUQ47xwZ+d2o4TE7kG
	 V5CkZVZsIj6rk8V69UOt47v/SZ3a87owWti0DE9vJobmOs7tcu+3iL8bw+gRva8267
	 TWf9DFTKRsMVQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52OC6A8Z01884390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 20:06:10 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Mar 2025 20:06:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 24 Mar 2025 20:06:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 24 Mar 2025 20:06:09 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>, Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next] rtase: Add ndo_setup_tc support for CBS offload in traffic control setup
Thread-Topic: [PATCH net-next] rtase: Add ndo_setup_tc support for CBS offload
 in traffic control setup
Thread-Index: AQHblMVgEp2xobAex0KxC/GYOCg1TLN55sKAgAF+ZWCABtq8AA==
Date: Mon, 24 Mar 2025 12:06:09 +0000
Message-ID: <ab27fd1a1e9d40759e090346eafb5881@realtek.com>
References: <20250314094021.10120-1-justinlai0215@realtek.com>
 <20250319123407.GC280585@kernel.org>
 <6824bd62f05644ec8d301457449eae19@realtek.com>
In-Reply-To: <6824bd62f05644ec8d301457449eae19@realtek.com>
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
> > On Fri, Mar 14, 2025 at 05:40:21PM +0800, Justin Lai wrote:
> > > Add support for ndo_setup_tc to enable CBS offload functionality as
> > > part of traffic control configuration for network devices.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> >
> > ...
> >
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index 2aacc1996796..2a61cd192026 100644
> > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > @@ -1661,6 +1661,54 @@ static void rtase_get_stats64(struct
> > > net_device
> > *dev,
> > >       stats->rx_length_errors =3D tp->stats.rx_length_errors;  }
> > >
> > > +static void rtase_set_hw_cbs(const struct rtase_private *tp, u32
> > > +queue) {
> > > +     u32 idle =3D tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
> > > +     u32 val, i;
> > > +
> > > +     val =3D u32_encode_bits(idle / RTASE_1T_POWER,
> > RTASE_IDLESLOPE_INT_MASK);
> > > +     idle %=3D RTASE_1T_POWER;
> > > +
> > > +     for (i =3D 1; i <=3D RTASE_IDLESLOPE_INT_SHIFT; i++) {
> > > +             idle *=3D 2;
> > > +             if ((idle / RTASE_1T_POWER) =3D=3D 1)
> > > +                     val |=3D BIT(RTASE_IDLESLOPE_INT_SHIFT - i);
> > > +
> > > +             idle %=3D RTASE_1T_POWER;
> > > +     }
> > > +
> > > +     rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, val); }
> > > +
> > > +static void rtase_setup_tc_cbs(struct rtase_private *tp,
> > > +                            const struct tc_cbs_qopt_offload *qopt)
> {
> > > +     u32 queue =3D qopt->queue;
> >
> > Hi Justin,
> >
> > Does queue need to be checked somewhere to make sure it is in range?
>=20
> Hi Simon,
>=20
> Thank you for your response. I will add a check to ensure that the queue =
is
> within the specified range.

Hi Simon,

Given that our hardware supports CBS offload on each queue, could it
be possible that checking the range of qopt->queue might not be
necessary?

> >
> > > +
> > > +     tp->tx_qos[queue].hicredit =3D qopt->hicredit;
> > > +     tp->tx_qos[queue].locredit =3D qopt->locredit;
> > > +     tp->tx_qos[queue].idleslope =3D qopt->idleslope;
> > > +     tp->tx_qos[queue].sendslope =3D qopt->sendslope;
> >
> > Does qopt->enable need to be honoured in order to allow the offload to
> > be both enabled and disabled?
> >
> Thank you for your suggestion. I will add a check for qopt->enable and ha=
ndle
> it appropriately.
>=20
> > > +
> > > +     rtase_set_hw_cbs(tp, queue);
> > > +}
> > > +
> > > +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type
> type,
> > > +                       void *type_data) {
> > > +     struct rtase_private *tp =3D netdev_priv(dev);
> > > +
> > > +     switch (type) {
> > > +     case TC_SETUP_QDISC_CBS:
> > > +             rtase_setup_tc_cbs(tp, type_data);
> > > +             break;
> > > +     default:
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static netdev_features_t rtase_fix_features(struct net_device *dev,
> > >                                           netdev_features_t
> > features)
> > > {
> >
> > ...


