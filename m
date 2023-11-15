Return-Path: <netdev+bounces-47908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934907EBD05
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 07:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA061C2033E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C932E854;
	Wed, 15 Nov 2023 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E697E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:23:05 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E3B8;
	Tue, 14 Nov 2023 22:23:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AF6Mj3421501206, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AF6Mj3421501206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 14:22:45 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Nov 2023 14:22:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Nov 2023 14:22:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 15 Nov 2023 14:22:43 +0800
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
	<netdev@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Implement pci_driver suspend and resume function
Thread-Topic: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Implement
 pci_driver suspend and resume function
Thread-Index: AQHaDaOV4m3XpMTIGEaYaPZneRFztLBqD3yAgBDta/A=
Date: Wed, 15 Nov 2023 06:22:43 +0000
Message-ID: <cb31aabbf5104992b299682f5ba0e064@realtek.com>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-10-justinlai0215@realtek.com>
 <0af3a54f-09da-4a8b-b385-c6968334ace4@lunn.ch>
In-Reply-To: <0af3a54f-09da-4a8b-b385-c6968334ace4@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Sunday, November 5, 2023 3:52 AM
> To: Justin Lai <justinlai0215@realtek.com>
> Cc: kuba@kernel.org; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> Ping-Ke Shih <pkshih@realtek.com>; Larry Chiu <larry.chiu@realtek.com>
> Subject: Re: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Imple=
ment
> pci_driver suspend and resume function
>=20
>=20
> External mail.
>=20
>=20
>=20
> > +static int rtase_resume(struct pci_dev *pdev) {
> > +     struct net_device *dev =3D pci_get_drvdata(pdev);
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     int ret;
> > +
> > +     pci_set_power_state(pdev, PCI_D0);
> > +     pci_restore_state(pdev);
> > +     pci_enable_wake(pdev, PCI_D0, 0);
> > +
> > +     /* restore last modified mac address */
> > +     rtase_rar_set(tp, dev->dev_addr);
> > +
> > +     if (!netif_running(dev))
> > +             goto out;
> > +
> > +     rtase_wait_for_quiescence(dev);
> > +     netif_device_attach(dev);
> > +
> > +     rtase_tx_clear(tp);
> > +     rtase_rx_clear(tp);
> > +
> > +     ret =3D rtase_init_ring(dev);
> > +     if (ret)
> > +             netdev_alert(dev, "unable to init ring\n");
>=20
> If you fail to init the ring, is it safe to keep going?
>=20
>         Andrew


Thanks for your reply, I will add error handling of rtase_init_ring()

