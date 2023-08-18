Return-Path: <netdev+bounces-28795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B39780B79
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7678C1C215E1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6BC182D7;
	Fri, 18 Aug 2023 12:01:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5617FE9
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:01:42 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 640CD2701;
	Fri, 18 Aug 2023 05:01:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37IC0vH72025052, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37IC0vH72025052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Aug 2023 20:00:57 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 18 Aug 2023 20:01:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 18 Aug 2023 20:01:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 18 Aug 2023 20:01:18 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v4 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v4 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZ0RARFNOcbQzUQkim/sPQtTeyia/uBEyAgAHwjKA=
Date: Fri, 18 Aug 2023 12:01:17 +0000
Message-ID: <23d2bbcca442457fa3efa5533b0a4246@realtek.com>
References: <20230817133803.177698-1-justinlai0215@realtek.com>
 <20230817133803.177698-2-justinlai0215@realtek.com>
 <979eca15-adfe-4afc-995f-ac59f702bbd1@lunn.ch>
In-Reply-To: <979eca15-adfe-4afc-995f-ac59f702bbd1@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  +static inline void rtase_enable_hw_interrupt(const struct=20
> rtase_private *tp)
>=20
> If you read comments given to other developers, you would of seen that=20
> inline functions are not allowed in .C files. Let the compiler decide.
>=20
> > +static int rtase_get_settings(struct net_device *dev, struct=20
> > +ethtool_link_ksettings *cmd) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     u32 advertising =3D 0;
> > +     u32 supported =3D 0;
> > +     u32 speed =3D 0;
> > +     u16 value =3D 0;
> > +
> > +     supported |=3D SUPPORTED_MII | SUPPORTED_Pause;
> > +
> > +     advertising |=3D ADVERTISED_MII;
>=20
> You don't advertise anything, because you don't have a PHY.
>=20
> > +
> > +     /* speed */
> > +     switch (tp->pdev->bus->cur_bus_speed) {
>=20
> Speed is meant to be line side speed. That is fixed at 5G. So i would=20
> expect a hard coded value.
>=20
> > +static void rtase_get_pauseparam(struct net_device *dev, struct=20
> > +ethtool_pauseparam *pause) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     u16 value =3D RTL_R16(tp, CPLUS_CMD);
> > +
> > +     if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) =3D=3D
> (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) {
> > +             pause->rx_pause =3D 1;
> > +             pause->tx_pause =3D 1;
> > +     } else if ((value & FORCE_TXFLOW_EN) !=3D 0u) {
> > +             pause->tx_pause =3D 1;
> > +     } else if ((value & FORCE_RXFLOW_EN) !=3D 0u) {
> > +             pause->rx_pause =3D 1;
> > +     } else {
> > +             /* not enable pause */
> > +     }
>=20
> Probably not required, but it would be good to set pause.autoneg to=20
> false, just to make is clear you don't support negotiating it.
>=20
> > +}
> > +
> > +static int rtase_set_pauseparam(struct net_device *dev, struct=20
> > +ethtool_pauseparam *pause) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     u16 value =3D RTL_R16(tp, CPLUS_CMD);
>=20
> Similar to above, you should return EOPNOTSUPP if pause.autoneg is true.
>=20
> > +
> > +     value &=3D ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> > +
> > +     if (pause->tx_pause =3D=3D 1u)
> > +             value |=3D FORCE_TXFLOW_EN;
> > +
> > +     if (pause->rx_pause =3D=3D 1u)
>=20
> You can treat these as boolean.
>=20
> > +             value |=3D FORCE_RXFLOW_EN;
> > +
> > +     RTL_W16(tp, CPLUS_CMD, value);
> > +     return 0;
> > +}
>=20
>=20
>     Andrew

Hi, Andrew

Thanks for your quick review, I will check our code again and make changes.
>=20
> ---
> pw-bot: cr
>

