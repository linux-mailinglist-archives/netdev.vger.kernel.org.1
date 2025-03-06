Return-Path: <netdev+bounces-172458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D4A54C07
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3FE18938FF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC020E016;
	Thu,  6 Mar 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cHP/EFR5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5920E00B;
	Thu,  6 Mar 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267430; cv=none; b=sza99qR1+TUIQzECJw6hMnT2IQ8mlD3pXQtdOoaTHh4b91/s3n6VB8SaMPUDHkzbWfVmNOWWr0OijTAKF8/2Yip4EIxjFHyfr8w0n1Ayp403/h7vJfqv/decN2DDTmSP+mdBbzzxnnBjpVIGW6UvaRXYEePhdin7oV0AIK30+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267430; c=relaxed/simple;
	bh=VFadsBIqL5IISzt+4mcfWBVPza2wFEMT8qatYssX7LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5kEKFu2Lk2JOiCS3Efz4rychGR/o+r1kxZNK3t5R5FiKh7lUbfSikdYvps9OfkhJn1wWMXv08LbzomfgFhcvqWH2c5qQM0H28x3QbhF7Ze7pJpKFE01ZOC7kNyfGBS1R2pFboEDKwll2M4rPV7/Q/rnOzcVC2NtehXJOlYn094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cHP/EFR5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69D3D44244;
	Thu,  6 Mar 2025 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741267425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4Q3RXYXb0D4cJknsOGegKUPW287ecQPCElx5kFqb08=;
	b=cHP/EFR5c1GSwHt4mSouKKSK+C5PFyWyOCKcAwE1DTLVfi0ZWWs9Q4UXkAiwDlLCls2jht
	OquMHnF+vzsq1EXFmmYRhkoOKLWJjZxoScrWM1PGSFpPe/sd+1+ArUIVN5V/DiNzz0zCxm
	iKmnHGAKpox2wM9aBJUkBn9oLNmBbebcwIckecUvzPqpApfHkNg0EWdO06mPXeWRzU/vmT
	5JCZmV2Z/LQuYuO6SJGyeT6PSclu4L/nmX/P9CqUeTq2hrkph3Mg/+mGXpAqWuSRetrTtV
	4aDFDd1n8QZib1xNqsrGmUKiWjW3umwA/3DbOtPv4xLbN6tOpnZRBvn8fT8MOQ==
Date: Thu, 6 Mar 2025 14:23:43 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] net: ethtool: tsinfo: Fix dump command
Message-ID: <20250306142343.37ff9a48@kmaincent-XPS-13-7390>
In-Reply-To: <eb1ee266-4b2f-4c6f-a728-2d39469a7855@linux.dev>
References: <20250305140352.1624543-1-kory.maincent@bootlin.com>
	<eb1ee266-4b2f-4c6f-a728-2d39469a7855@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepvhgrughimhdrfhgvughorhgvnhhkoheslhhinhhugidruggvvhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 6 Mar 2025 10:38:58 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> On 05/03/2025 14:03, Kory Maincent wrote:
> > Fix missing initialization of ts_info->phc_index in the dump command,
> > which could cause a netdev interface to incorrectly display a PTP provi=
der
> > at index 0 instead of "none".
> > Fix it by initializing the phc_index to -1.
> >=20
> > In the same time, restore missing initialization of ts_info.cmd for the
> > IOCTL case, as it was before the transition from ethnl_default_dumpit to
> > custom ethnl_tsinfo_dumpit.
> >=20
> > Fixes: b9e3f7dc9ed95 ("net: ethtool: tsinfo: Enhance tsinfo to support
> > several hwtstamp by net topology") Signed-off-by: Kory Maincent
> > <kory.maincent@bootlin.com> ---
> >   net/ethtool/tsinfo.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> > index 691be6c445b38..9edc5dc30de88 100644
> > --- a/net/ethtool/tsinfo.c
> > +++ b/net/ethtool/tsinfo.c
> > @@ -291,6 +291,8 @@ static void *ethnl_tsinfo_prepare_dump(struct sk_bu=
ff
> > *skb, memset(reply_data, 0, sizeof(*reply_data));
> >   	reply_data->base.dev =3D dev;
> >   	memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info));
> > +	reply_data->ts_info.cmd =3D ETHTOOL_GET_TS_INFO;
> > +	reply_data->ts_info.phc_index =3D -1; =20
>=20
> This change makes sense, but I'm curious why do we need
> memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info))
> at all? ts_info is embedded into reply_data which fully zeroed 2 lines
> before.

Indeed you are right, this is totally useless.
I will remove it.

Regards,

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

