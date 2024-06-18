Return-Path: <netdev+bounces-104398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21090C673
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F5C28356A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCB185E67;
	Tue, 18 Jun 2024 07:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592513A245;
	Tue, 18 Jun 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697108; cv=none; b=PyPo80jnIrvPudYrkCRghfLnR3X2+SmhMH3z5L40ayQ5HlFNaDHVhbAtEV+ce43pmyCcxoSRoSv0OgjviaOJ8l2jWOgnxoq6GmG7U6QSebnxboaJOweotf7wVxIw/m+CIpQGi2T3pJHRqRWLRZi3ww4in75aTEIsBcHFkJB3Q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697108; c=relaxed/simple;
	bh=bk2jLyABiJ8wha3uvX9kVBJQC7PjnYSXD2YVCtySO3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G2/JLuij/KXJmVxZjzHrItLbtFPXEr4Bady7ThkH+Y7AObJOz+XHMGaQbQk31ij8HvZE2ctmOifSWEnL4FRWsMxGulLDEmJsts5gUzCXr/w64LGtHrwMXBlWIoM36aU2tXykUAwNxv9ty+jVFgiMGOP4lwC2zYDOn8sYPddd49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45I7pKb15197341, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45I7pKb15197341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 15:51:20 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 15:51:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Jun 2024 15:51:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 18 Jun 2024 15:51:19 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Hariprasad Kelam <hkelam@marvell.com>, Jiri Pirko
	<jiri@resnulli.us>,
        Larry Chiu <larry.chiu@realtek.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: RE: [v20 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [v20 02/13] rtase: Implement the .ndo_open function
Thread-Index: AQHawJ5eL1A+vv787Ey/gTxPzZ037bHL8dBA///X7QCAAVF5MA==
Date: Tue, 18 Jun 2024 07:51:19 +0000
Message-ID: <416da6e14d134caeaa4bfe29291f0eb2@realtek.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
 <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
 <0c57021d0bfc444ebe640aa4c5845496@realtek.com>
 <20240617185956.GY8447@kernel.org>
In-Reply-To: <20240617185956.GY8447@kernel.org>
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

> On Mon, Jun 17, 2024 at 01:28:51PM +0000, Justin Lai wrote:
> >
> > > >> How do you think about to increase the application of scope-based
> > > >> resource
> > > management?
> > > >> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/c
> > > >> lean
> > > >> up.h#L8
> > > >
> > > > Due to our tx and rx each having multiple queues that need to
> > > > allocate descriptors, if any one of the queues fails to allocate,
> > > > rtase_alloc_desc() will return an error. Therefore, using 'goto'
> > > > here rather than directly returning seems to be reasonable.
> > >
> > > Some goto chains can be replaced by further usage of advanced
> > > cleanup techniques, can't they?
> > >
> > > Regards,
> > > Markus
> >
> > rtase_alloc_desc() is used to allocate DMA memory.
> > I'd like to ask if it's better to keep our current method?
>=20
> Hi Justin,
>=20
> It may be the case that the techniques recently added by cleanup.h could =
be
> used here. But, OTOH, it is the case that using goto for unwinding errors=
 is in
> keeping with current Networking driver best practices.
>=20
> Regardless of the above, I would suggest that if an error occurs in
> rtase_alloc_desc() then it release any resources it has allocated. Assumi=
ng the
> elements of tp->tx_ring and tp->rx_ring are initialised to NULL when
> rtase_alloc_desc is called, it looks like that can be achieved by
> rtase_alloc_desc() calling rtase_free_desc().
>=20
> Something like the following (completely untested!).
> Please also note that there is probably no need to call netdev_err on err=
or, as
> the memory core should already log on error.
>=20
> static int rtase_alloc_desc(struct rtase_private *tp) {
>         struct pci_dev *pdev =3D tp->pdev;
>         u32 i;
>=20
>         /* rx and tx descriptors needs 256 bytes alignment.
>          * dma_alloc_coherent provides more.
>          */
>         for (i =3D 0; i < tp->func_tx_queue_num; i++) {
>                 tp->tx_ring[i].desc =3D
>                                 dma_alloc_coherent(&pdev->dev,
>=20
> RTASE_TX_RING_DESC_SIZE,
>=20
> &tp->tx_ring[i].phy_addr,
>                                                    GFP_KERNEL);
>                 if (!tp->tx_ring[i].desc)
>                         goto err;
>         }
>=20
>         for (i =3D 0; i < tp->func_rx_queue_num; i++) {
>                 tp->rx_ring[i].desc =3D
>                                 dma_alloc_coherent(&pdev->dev,
>=20
> RTASE_RX_RING_DESC_SIZE,
>=20
> &tp->rx_ring[i].phy_addr,
>                                                    GFP_KERNEL);
>                 if (!tp->rx_ring[i].desc)
>                         goto err;
>                 }
>         }
>=20
>         return 0;
>=20
> err:
>         rtase_free_desc(tp)
>         return -ENOMEM;
> }
>=20
> And then rtase_alloc_desc can be called like this in rtase_open():
>=20
> static int rtase_open(struct net_device *dev) {
>         struct rtase_private *tp =3D netdev_priv(dev);
>         const struct pci_dev *pdev =3D tp->pdev;
>         struct rtase_int_vector *ivec;
>         u16 i =3D 0, j;
>         int ret;
>=20
>         ivec =3D &tp->int_vector[0];
>         tp->rx_buf_sz =3D RTASE_RX_BUF_SIZE;
>=20
>         ret =3D rtase_alloc_desc(tp);
>         if (ret)
>                 return ret;
>=20
>         ret =3D rtase_init_ring(dev);
>         if (ret)
>                 goto err_free_all_allocated_mem;
>=20
> ...
>=20
> err_free_all_allocated_mem:
>         rtase_free_desc(tp);
>=20
>         return ret;
> }
>=20
> This is would be in keeping with my understanding of best practices for
> Networking drivers: that callers don't have to worry about cleaning up
> resources allocated by functions that return an error.
>=20
>=20
> I would also suggest reading Markus's advice with due care, as it is not =
always
> aligned with best practice for Networking code.

Hi Simon,
Thank you for your response. Based on your suggestion, if the descriptor
allocation of DMA memory fails, I will directly do error handling in
rtase_alloc_desc() using the 'goto' method. Moreover, in the error
handling section, I will call rtase_free_desc(tp) to free the already
allocated descriptor.


