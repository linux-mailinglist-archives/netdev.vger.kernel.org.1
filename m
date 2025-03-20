Return-Path: <netdev+bounces-176372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBFAA69ED9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 04:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B3980239
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DB01EB9F9;
	Thu, 20 Mar 2025 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VZxhZJKS"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C32F5E;
	Thu, 20 Mar 2025 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742442303; cv=none; b=uxBleLeaDKodme7CkltOsfvQE2Gyis7FaKsd2p8tzClfVJoAx2ftQJSFKB08x8oMdK5Xab+45SnPVMdz5OOLxQi3wKVknyxNz69KOB0SxrQpHaXvZtM3PuV0K80Jmy1698pMH3wH39VYeeuvJ3wY3u+27eKDn9dNKyFSiZMX/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742442303; c=relaxed/simple;
	bh=OdAbk2LOFtDHMerSPge0nhSNgZt523e54gQmN39dbFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwcPDjDNBfeoAZV0DdDybTqOcaN2jo+Vi+tZx6YDvo8uAKMObqc+KCEVGizzD5MGELg1Hut1I7Ycs4jWXfBbcdZwq8lZxqMUzbolB2HlXsGJ7uDwbFujRhMOBu6MtvXQC7orxbJ0tZ1kKJW6Eij82uDZh2TIUL5XEk2paFqEWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VZxhZJKS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3iXZQ11779596, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742442273; bh=OdAbk2LOFtDHMerSPge0nhSNgZt523e54gQmN39dbFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VZxhZJKSp0QsZptwFc5eeXoPN2JOq5Zksctao1Pugl1zae2zemo2G1AV5x+XETme0
	 EgLi7fmZlfINGkQTF41tYz/MCxbvCd5XWeft6bLLj2b7DfwGPku0Lp3FJecXbwWCKn
	 iwQJiCNWUz99UWPE7C8O9yrtHLcxTxVezrkewyVwusLLBILDoytgXa8eaugkBJbJgd
	 yEU4MZCyKb+prro+UvCCcA+3wUfKw8giUvjCl5NfBAheh7zT7n9xOSCbQf5eQ49u/v
	 Ra0PW+fHQ/71ipOGos1uLVJXj+BC68zWtYQveJmnLZfbOdp+EMVe/5Zgx9QFPEEB01
	 6HFrlo9UaUpYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3iXZQ11779596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 11:44:33 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:44:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Mar 2025 11:44:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 20 Mar 2025 11:44:33 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
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
Thread-Index: AQHblMVgEp2xobAex0KxC/GYOCg1TLN55sKAgAF+ZWA=
Date: Thu, 20 Mar 2025 03:44:33 +0000
Message-ID: <6824bd62f05644ec8d301457449eae19@realtek.com>
References: <20250314094021.10120-1-justinlai0215@realtek.com>
 <20250319123407.GC280585@kernel.org>
In-Reply-To: <20250319123407.GC280585@kernel.org>
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

> On Fri, Mar 14, 2025 at 05:40:21PM +0800, Justin Lai wrote:
> > Add support for ndo_setup_tc to enable CBS offload functionality as
> > part of traffic control configuration for network devices.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 2aacc1996796..2a61cd192026 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1661,6 +1661,54 @@ static void rtase_get_stats64(struct net_device
> *dev,
> >       stats->rx_length_errors =3D tp->stats.rx_length_errors;  }
> >
> > +static void rtase_set_hw_cbs(const struct rtase_private *tp, u32
> > +queue) {
> > +     u32 idle =3D tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
> > +     u32 val, i;
> > +
> > +     val =3D u32_encode_bits(idle / RTASE_1T_POWER,
> RTASE_IDLESLOPE_INT_MASK);
> > +     idle %=3D RTASE_1T_POWER;
> > +
> > +     for (i =3D 1; i <=3D RTASE_IDLESLOPE_INT_SHIFT; i++) {
> > +             idle *=3D 2;
> > +             if ((idle / RTASE_1T_POWER) =3D=3D 1)
> > +                     val |=3D BIT(RTASE_IDLESLOPE_INT_SHIFT - i);
> > +
> > +             idle %=3D RTASE_1T_POWER;
> > +     }
> > +
> > +     rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, val); }
> > +
> > +static void rtase_setup_tc_cbs(struct rtase_private *tp,
> > +                            const struct tc_cbs_qopt_offload *qopt) {
> > +     u32 queue =3D qopt->queue;
>=20
> Hi Justin,
>=20
> Does queue need to be checked somewhere to make sure it is in range?

Hi Simon,

Thank you for your response. I will add a check to ensure that the
queue is within the specified range.
>=20
> > +
> > +     tp->tx_qos[queue].hicredit =3D qopt->hicredit;
> > +     tp->tx_qos[queue].locredit =3D qopt->locredit;
> > +     tp->tx_qos[queue].idleslope =3D qopt->idleslope;
> > +     tp->tx_qos[queue].sendslope =3D qopt->sendslope;
>=20
> Does qopt->enable need to be honoured in order to allow the offload to be
> both enabled and disabled?
>=20
Thank you for your suggestion. I will add a check for qopt->enable and
handle it appropriately.

> > +
> > +     rtase_set_hw_cbs(tp, queue);
> > +}
> > +
> > +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type t=
ype,
> > +                       void *type_data) {
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +
> > +     switch (type) {
> > +     case TC_SETUP_QDISC_CBS:
> > +             rtase_setup_tc_cbs(tp, type_data);
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static netdev_features_t rtase_fix_features(struct net_device *dev,
> >                                           netdev_features_t
> features)
> > {
>=20
> ...

