Return-Path: <netdev+bounces-107630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDE91BC2A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC871C22328
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF415382F;
	Fri, 28 Jun 2024 10:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453C1103;
	Fri, 28 Jun 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569174; cv=none; b=qMPbJex4apzcvK4YAf5VTryzzeCGnWusP3/dZa2Uv8h+7m469jVRkejVnqo28JYFp63tHKYyPcoXVkP4B0q4K3U2kwcNFal4i0KWUZJDwlvMZpZjBbSz1E3qYdV3Fp8xVYSsOtnWRmF745hIV1QcaCOvdJV4Wc4tIWXkpQ07BSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569174; c=relaxed/simple;
	bh=PNSoFvOSJj+NqpkoD1kr4B6BNyIZCnBE5tZ8DQc88ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcEFfETJMvznYci2il5+nzGlqvLHw2uIQU79hLcL9Ti0PQRCBUPHnqRfWEkYBpy7wOOybIxAYa42T0cInX2LvsQ+OnlAzDu4YXSqGlRVuJhm+m1BZyz38q0aK4XT9PtaMCWqQhimLUhFZaMgEp+nDT0qssMgnxB4RD6S72ekL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45SA5U3m8241953, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45SA5U3m8241953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 18:05:30 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 18:05:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 28 Jun 2024 18:05:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 28 Jun 2024 18:05:30 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Joe Damato <jdamato@fastly.com>
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
        "horms@kernel.org" <horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v21 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v21 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHaxf/sEAgcLIB15E2ANY/J/AeALbHbT6EAgAGo9ZA=
Date: Fri, 28 Jun 2024 10:05:30 +0000
Message-ID: <874d99a1ed984ef09a332855bafaedb5@realtek.com>
References: <20240624062821.6840-1-justinlai0215@realtek.com>
 <20240624062821.6840-3-justinlai0215@realtek.com>
 <Zn2WPhHOgBZFEvPE@LQ3V64L9R2>
In-Reply-To: <Zn2WPhHOgBZFEvPE@LQ3V64L9R2>
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
> On Mon, Jun 24, 2024 at 02:28:10PM +0800, Justin Lai wrote:
>=20
> [...]
>=20
> > +static int rtase_open(struct net_device *dev) {
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct pci_dev *pdev =3D tp->pdev;
> > +     struct rtase_int_vector *ivec;
> > +     u16 i =3D 0, j;
> > +     int ret;
> > +
> > +     ivec =3D &tp->int_vector[0];
> > +     tp->rx_buf_sz =3D RTASE_RX_BUF_SIZE;
> > +
> > +     ret =3D rtase_alloc_desc(tp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D rtase_init_ring(dev);
> > +     if (ret)
> > +             goto err_free_all_allocated_mem;
> > +
> > +     rtase_hw_config(dev);
> > +
> > +     if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> > +             ret =3D request_irq(ivec->irq, rtase_interrupt, 0,
> > +                               dev->name, ivec);
> > +             if (ret)
> > +                     goto err_free_all_allocated_irq;
> > +
> > +             /* request other interrupts to handle multiqueue */
> > +             for (i =3D 1; i < tp->int_nums; i++) {
> > +                     ivec =3D &tp->int_vector[i];
> > +                     snprintf(ivec->name, sizeof(ivec->name),
> "%s_int%i",
> > +                              tp->dev->name, i);
> > +                     ret =3D request_irq(ivec->irq, rtase_q_interrupt,=
 0,
> > +                                       ivec->name, ivec);
> > +                     if (ret)
> > +                             goto err_free_all_allocated_irq;
> > +             }
> > +     } else {
> > +             ret =3D request_irq(pdev->irq, rtase_interrupt, 0, dev->n=
ame,
> > +                               ivec);
> > +             if (ret)
> > +                     goto err_free_all_allocated_mem;
> > +     }
> > +
> > +     rtase_hw_start(dev);
> > +
> > +     for (i =3D 0; i < tp->int_nums; i++) {
> > +             ivec =3D &tp->int_vector[i];
> > +             napi_enable(&ivec->napi);
>=20
> nit / suggestion for the future (not to hold this back): it'd be nice to =
add support
> for netif_napi_set_irq and netif_queue_set_napi so that userland can use
> netdev-genl to get queue/irq/napi mappings.

Thank you for your suggestion, I will consider adding this feature in futur=
e versions.

