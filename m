Return-Path: <netdev+bounces-144195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056939C5F8A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98B92860ED
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC398215027;
	Tue, 12 Nov 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ob/wfwxl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC532141DC
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434028; cv=none; b=J3F1fyPmN5YeseBvyopY9Vttt4CXV5S4PxIoW+hev9OwDI3mz2bYWYlyySESaNYSaxC1dwaTqe/DtKRkIR5S6184TspLJbO180mmPSw/bgsW1pxkGBYBowqvOsew0zpiwcQQMZ7MtyoElcKvL1+k+J7scJl3auIVe4nPt3mwa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434028; c=relaxed/simple;
	bh=UYX2O1h2AvLoRdjFa5niV/SAHORHbQlFVhftdFs2wYs=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExvrvnQsmrW+OipLOhJ4Ym3HWaBf+KfG5UCsUUulHkWIE8ICCwyXmr+1por8L9ptZK8ymuuIbhDEzMupIWf170+ql77wA6OXSZ9AfWlo9OF3MPvizeLf7z6QlDGid060rdzOW8znZRQbEjyUpZruAeS0Fyc+EkJcuqdBcp7aO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ob/wfwxl; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731434028; x=1762970028;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=vgUV/OWM1rcXFGmTAMLYM2PDx47Hl1iykASf7BDAkg8=;
  b=ob/wfwxlEz35qWzSBph7f9heQ3c9xXwUuQbIf3aRVoh6Nny5Rey3yDP+
   ofTUuhgx0J4Ow+q7oeWbVnc0qRIISTjsN+0C05NoekHxZ1nSzMOe+Bj9j
   Mjpgnxl52kQFa0RG8+UhIVC0e0ZKjpVqxPp0/UxE0QuXAVZH+mNqjhaK8
   E=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208";a="351726582"
Subject: RE: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 17:53:45 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:29367]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.224:2525] with esmtp (Farcaster)
 id 50424793-4fea-4c12-ad0a-678039f5021f; Tue, 12 Nov 2024 17:53:42 +0000 (UTC)
X-Farcaster-Flow-ID: 50424793-4fea-4c12-ad0a-678039f5021f
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 17:53:42 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 17:53:41 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 12 Nov 2024 17:53:41 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbLeQGl7kxu2fA00SYfY6yxcXfg7Kn9ekAgABNu5CAATcUAIAKf5Ww
Date: Tue, 12 Nov 2024 17:53:41 +0000
Message-ID: <baf0fe9c0a1741a6883768e816346123@amazon.com>
References: <20241103113140.275-1-darinzon@amazon.com>
	<20241103113140.275-4-darinzon@amazon.com>
	<20241104181722.4ee86665@kernel.org>
	<4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
 <20241105172858.273df3fd@kernel.org>
In-Reply-To: <20241105172858.273df3fd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you Rahul for the detailed explanations

Hi Jakub,

> > Just wanted to clarify that this feature and the associated
> > documentation are specifically intended for reading a HW timestamp,
> > not for TX/RX packet timestamping.
>=20
> Oh, so you're saying you can only read the clock from the device?
> The word timestamp means time associated with an event.
>=20

Based on the documentation of gettimex64 API
The ts parameter holds the PHC timestamp.
We are using the same terminology
https://elixir.bootlin.com/linux/v6.11.6/source/include/linux/ptp_clock_ker=
nel.h#L97

 * @gettimex64:  Reads the current time from the hardware clock and optiona=
lly
 *               also the system clock.
 *               parameter ts: Holds the PHC timestamp.
 *               parameter sts: If not NULL, it holds a pair of timestamps =
from
 *               the system clock. The first reading is made right before
 *               reading the lowest bits of the PHC timestamp and the secon=
d
 *               reading immediately follows that.

> In the doc you talk about:
>=20
> > +PHC support and capabilities can be verified using ethtool:
> > +
> > +.. code-block:: shell
> > +
> > +  ethtool -T <interface>
>=20
> which is for packet timestamping
>=20

ethtool -T shows all timestamping capabilities, which indeed include
packet timestamping but also the PTP Hardware Clock (PHC) index
If the value is `none`, it means that there's no PHC support
This is done by implementing the `get_ts_info` hook, which is
part of this patchset.

https://elixir.bootlin.com/linux/v6.11.6/source/include/linux/ethtool.h#L72=
0

> also:
>=20
> > ENA Linux driver supports PTP hardware clock providing timestamp
> > reference to achieve nanosecond accuracy.
>=20
> You probably want to double check the definitions of accuracy and
> resolution.
>=20

Thank you, will be changed in the next patchset

> We recently merged an Amazon PTP clock driver from David Woodhouse,
> see commit 20503272422693. If you're not timestamping packets why not use
> that driver?

The AMZNC10C vmclock device driver is intended to be used in systems where =
there's an hypervisor.
The PHC driver in this patchset is intended for virtual and non-virtual (me=
tal) instances in AWS.
The AMZNC10C might not be available in the future on the same instances whe=
re PHC is available.

