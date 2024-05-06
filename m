Return-Path: <netdev+bounces-93591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF508BC5F7
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29ABCB20548
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EE3EA64;
	Mon,  6 May 2024 02:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EC358A7;
	Mon,  6 May 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964383; cv=none; b=Ai55f3nIE1bHLn50ChFx3sBxdyelR4yxYgeT2ni+3ItbqBPzpW6zhxbhxD/GVBbNoAHIVsIdTMtkPljUsrANXT38ayfA3PWAHhX10oLjizOgthw1AvNa1nzJU2mR7YQ7LEPg1aBzCjr7YyIuPeiHuGUolKqvDzKIaePhDn2NaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964383; c=relaxed/simple;
	bh=IKOlGJFWtXHnjZ6QppAGH3LxjDXAOqPBOHtxGdKHjr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mq5o/nyz6RSOi/oDly883uv05P5V7DJduTnirwCxxdeYpFWTPD5TjBV5JSL3KBK+7rjH/m2HkORojwh3YR2seMWXuW8eoPkaScUqR3xwWOG1gyLa++LQt+TfhDOWZieMoAoWJUI08kyHOqXZyz4t5gw4kYEpIyXkde7AfUGb8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4462xNshD1853303, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4462xNshD1853303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 10:59:23 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:59:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:59:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 6 May 2024 10:59:23 +0800
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
Subject: RE: [PATCH net-next v17 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
Thread-Topic: [PATCH net-next v17 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Thread-Index: AQHanHJwtQlHSOPjc0iBIoHkieL8ZLGEqrkAgATePEA=
Date: Mon, 6 May 2024 02:59:23 +0000
Message-ID: <d1936d4110594bc1a7914f9aa5616366@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-13-justinlai0215@realtek.com>
 <20240503083534.GL2821784@kernel.org>
In-Reply-To: <20240503083534.GL2821784@kernel.org>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

> On Thu, May 02, 2024 at 05:18:46PM +0800, Justin Lai wrote:
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
>=20
> Hi Justin,
>=20
> I believe that you also need:
>=20
>         select PAGE_POOL
>=20
> As the driver uses page_pool_alloc_pages()
>=20
> FWIIW, I observed this when using a config based on make tinyconfig with =
PCI
> and NET enabled, all WiFi drivers disabled, and only and only this Ethern=
et
> driver enabled.

Thank you for your feedback, I will modify this part.
>=20
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
>=20
> The advice above to chose Y and M seem to conflict.
> Perhaps this can be edited somehow.
>=20

I will confirm and modify this part again, thank you for your suggestion.
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
> > --
> > 2.34.1
> >
> >

