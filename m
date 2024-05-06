Return-Path: <netdev+bounces-93696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595FF8BCCDC
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7DF1C2115F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8F142E9D;
	Mon,  6 May 2024 11:33:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E874EB2B;
	Mon,  6 May 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995194; cv=none; b=nFrwexXyR/1QFac3Qde4p5hjHWmzO/+QI5sGDd8pn7CuL2ITMnLyoThyV/s87X4w6mP5r8+NTH8Zc3RxOvLxEIXivWS1UUKewT2Ag0ft+aODXENSpkih7MN2q6zstHm42yH1oLpq3YY6dYLwD5AX+cqq2ZbqB/m7ZpIVOyqIpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995194; c=relaxed/simple;
	bh=PIxogdcQO/DJOu/Ectik/7m3pQPCs86wpxCJ1na6reo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjjTGp7c6He6DU2VN3Pd1UsKhMQpJ108e0MFdDQPhZ9Aoy2OIITGlCxwu9K05u04nqNmmwo3PVItseURUJqnTKhwRWt9DB3BSqWga4Zd2KBKZ1G5w7y+orc4uZ/ZtmUWQDsYGNKIRbS4sSfTA6qkW10uklYy8nT7zG91VLQb6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 446BWdXS22260556, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 446BWdXS22260556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 19:32:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:32:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:32:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 6 May 2024 19:32:39 +0800
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
Subject: RE: [PATCH net-next v17 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v17 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHanHHPpu/0OXZUyEWgBGsNOMbxkLGEuuuAgAVa5UA=
Date: Mon, 6 May 2024 11:32:38 +0000
Message-ID: <14c200b4573b4a60af14b37861ca1727@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-2-justinlai0215@realtek.com>
 <20240503093331.GN2821784@kernel.org>
In-Reply-To: <20240503093331.GN2821784@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

>=20
>=20
> On Thu, May 02, 2024 at 05:18:35PM +0800, Justin Lai wrote:
> > Add pci table supported in this module, and implement pci_driver
> > function to initialize this driver, remove this driver, or shutdown thi=
s driver.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > new file mode 100644
> > index 000000000000..5ddb5f7abfe9
> > --- /dev/null
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -0,0 +1,618 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > +/*
> > + *  rtase is the Linux device driver released for Realtek Automotive
> > +Switch
> > + *  controllers with PCI-Express interface.
> > + *
> > + *  Copyright(c) 2023 Realtek Semiconductor Corp.
> > + *
> > + *  Below is a simplified block diagram of the chip and its relevant
> interfaces.
> > + *
> > + *               *************************
> > + *               *                       *
> > + *               *  CPU network device   *
> > + *               *                       *
> > + *               *   +-------------+     *
> > + *               *   |  PCIE Host  |     *
> > + *               ***********++************
> > + *                          ||
> > + *                         PCIE
> > + *                          ||
> > + *      ********************++**********************
> > + *      *            | PCIE Endpoint |             *
> > + *      *            +---------------+             *
> > + *      *                | GMAC |                  *
> > + *      *                +--++--+  Realtek         *
> > + *      *                   ||     RTL90xx Series  *
> > + *      *                   ||                     *
> > + *      *     +-------------++----------------+    *
> > + *      *     |           | MAC |             |    *
> > + *      *     |           +-----+             |    *
> > + *      *     |                               |    *
> > + *      *     |     Ethernet Switch Core      |    *
> > + *      *     |                               |    *
> > + *      *     |   +-----+           +-----+   |    *
> > + *      *     |   | MAC |...........| MAC |   |    *
> > + *      *     +---+-----+-----------+-----+---+    *
> > + *      *         | PHY |...........| PHY |        *
> > + *      *         +--++-+           +--++-+        *
> > + *      *************||****************||***********
>=20
> Thanks for the diagram, I like it a lot :)
>=20

Thank you for your like :)
> > + *
> > + *  The block of the Realtek RTL90xx series is our entire chip
> > + architecture,
> > + *  the GMAC is connected to the switch core, and there is no PHY in
> between.
> > + *  In addition, this driver is mainly used to control GMAC, but does
> > + not
> > + *  control the switch core, so it is not the same as DSA.
> > + */
>=20
> ...
>=20
> > +static int rtase_alloc_msix(struct pci_dev *pdev, struct
> > +rtase_private *tp) {
> > +     int ret;
> > +     u16 i;
> > +
> > +     memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct
> > + msix_entry));
> > +
> > +     for (i =3D 0; i < RTASE_NUM_MSIX; i++)
> > +             tp->msix_entry[i].entry =3D i;
> > +
> > +     ret =3D pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums)=
;
> > +     if (!ret) {
>=20
> In Linux Networking code it is an idiomatic practice to keep handle error=
s in
> branches and use the main path of execution for the non error path.
>=20
> In this case I think that would look a bit like this:
>=20
>         ret =3D pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums)=
;
>         if (ret)
>                 return ret;
>=20
>         ...
>=20
>         return 0;
>=20
> > +
> > +             for (i =3D 0; i < tp->int_nums; i++)
> > +                     tp->int_vector[i].irq =3D pci_irq_vector(pdev, i)=
;
>=20
> pci_irq_vector() can fail, should that be handled here?

Thank you for your feedback, I will confirm this part again.
>=20
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int rtase_alloc_interrupt(struct pci_dev *pdev,
> > +                              struct rtase_private *tp) {
> > +     int ret;
> > +
> > +     ret =3D rtase_alloc_msix(pdev, tp);
> > +     if (ret) {
> > +             ret =3D pci_enable_msi(pdev);
> > +             if (ret)
> > +                     dev_err(&pdev->dev,
> > +                             "unable to alloc interrupt.(MSI)\n");
>=20
> If an error occurs then it is a good practice to unwind resource allocati=
ons
> made within the context of this function call, as this leads to more symm=
etric
> unwind paths in callers.
>=20
> In this case I think any resources consumed by rtase_alloc_msix() should =
be
> released if pci_enable_msi fails. Probably using a goto label is appropri=
ate
> here.
>=20
> Likewise, I suggest that similar logic applies to errors within
> rtase_alloc_msix().
>=20

Since msi will be enabled only when msix enable fails, when pci_enable_msi =
fails,
there will be no problem of msix-related resources needing to be released,
because the msix interrupt has not been successfully allocated.
> > +             else
> > +                     tp->sw_flag |=3D RTASE_SWF_MSI_ENABLED;
> > +     } else {
> > +             tp->sw_flag |=3D RTASE_SWF_MSIX_ENABLED;
> > +     }
> > +
> > +     return ret;
> > +}
>=20
> ...

