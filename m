Return-Path: <netdev+bounces-47907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2097EBD03
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 07:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187E7B20ABA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C3B7E;
	Wed, 15 Nov 2023 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9713C22
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:20:52 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672F91;
	Tue, 14 Nov 2023 22:20:48 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AF6KET901500282, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AF6KET901500282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 14:20:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Nov 2023 14:20:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Nov 2023 14:20:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 15 Nov 2023 14:20:13 +0800
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
        "andrew@lunn.ch" <andrew@lunn.ch>, Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
Thread-Topic: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Thread-Index: AQHaDaOXaCiSv08AfUSaFrlhkAXsGLBp+vsAgBEBJNA=
Date: Wed, 15 Nov 2023 06:20:13 +0000
Message-ID: <462b9b3197e0459db71aaf9dcebfc642@realtek.com>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-13-justinlai0215@realtek.com>
 <20231104183904.GO891380@kernel.org>
In-Reply-To: <20231104183904.GO891380@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, November 5, 2023 2:39 AM
> To: Justin Lai <justinlai0215@realtek.com>
> Cc: kuba@kernel.org; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> andrew@lunn.ch; Ping-Ke Shih <pkshih@realtek.com>; Larry Chiu
> <larry.chiu@realtek.com>
> Subject: Re: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the
> Makefile and Kconfig in the realtek folder
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Thu, Nov 02, 2023 at 11:45:04PM +0800, Justin Lai wrote:
> > 1. Add the RTASE entry in the Kconfig.
> > 2. Add the CONFIG_RTASE entry in the Makefile.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/Kconfig  | 17 +++++++++++++++++
> > drivers/net/ethernet/realtek/Makefile |  1 +
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/realtek/Kconfig
> > b/drivers/net/ethernet/realtek/Kconfig
> > index 93d9df55b361..57ef924deebd 100644
> > --- a/drivers/net/ethernet/realtek/Kconfig
> > +++ b/drivers/net/ethernet/realtek/Kconfig
> > @@ -113,4 +113,21 @@ config R8169
> >         To compile this driver as a module, choose M here: the module
> >         will be called r8169.  This is recommended.
> >
> > +config RTASE
> > +     tristate "Realtek Automotive Switch
> 9054/9068/9072/9075/9068/9071 PCIe Interface support"
> > +     depends on PCI
> > +     select CRC32
> > +     help
> > +       Say Y here if you have a Realtek Ethernet adapter belonging to
> > +       the following families:
> > +       RTL9054 5GBit Ethernet
> > +       RTL9068 5GBit Ethernet
> > +       RTL9072 5GBit Ethernet
> > +       RTL9075 5GBit Ethernet
> > +       RTL9068 5GBit Ethernet
> > +       RTL9071 5GBit Ethernet
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called rtase. This is recommended.
> > +
> >  endif # NET_VENDOR_REALTEK
> > diff --git a/drivers/net/ethernet/realtek/Makefile
> > b/drivers/net/ethernet/realtek/Makefile
> > index 2e1d78b106b0..0c1c16f63e9a 100644
> > --- a/drivers/net/ethernet/realtek/Makefile
> > +++ b/drivers/net/ethernet/realtek/Makefile
> > @@ -8,3 +8,4 @@ obj-$(CONFIG_8139TOO) +=3D 8139too.o
> >  obj-$(CONFIG_ATP) +=3D atp.o
> >  r8169-objs +=3D r8169_main.o r8169_firmware.o r8169_phy_config.o
> >  obj-$(CONFIG_R8169) +=3D r8169.o
> > +obj-$(CONFIG_RTASE) +=3D rtase/
>=20
> An allmodconfig on x86_64 fails to build with the series applied up to th=
is
> point.
>=20
> ../drivers/net/ethernet/realtek/rtase/rtase_main.c:68:10: fatal error:
> net/page_pool.h: No such file or directory    68 | #include
> <net/page_pool.h>
>=20
> Please also note that, net-next closed, as per the following:
>=20
> ## Form letter - net-next-closed
>=20
> The merge window for v6.7 has begun and therefore net-next is closed for =
new
> drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
>=20
> Please repost when net-next reopens after November 12th.
>=20
> RFC patches sent for review only are obviously welcome at any time.
>=20
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel
> opment-cycle
> --
> pw-bot: cr

Thank you for your reply. I will correct the relevant compiler error and re=
post it after opening net-next.

