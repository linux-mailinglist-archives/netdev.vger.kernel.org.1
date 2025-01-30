Return-Path: <netdev+bounces-161604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10089A22A23
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDDA1883B7A
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274D1B0434;
	Thu, 30 Jan 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lLOOs7TQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D760139B;
	Thu, 30 Jan 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228703; cv=none; b=t41S0jzSV3C1wYGz7ZTE5KCnfcRKVJzJOgsbiUIm4FplB7G8eXAHrvXrV4IWWKJiT5jznYd1oMeHoGeOmKu52j9Fbpy0tXhTw3EbGKC6fHjn15zGJ6N9sEBspXLmKjZcuJ+pmMxBtSu0as743AfGpnsqKq8EddtJJ43ErcWTgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228703; c=relaxed/simple;
	bh=NUOK2qVCCo5WQquLSVd5u1bqkOLCbNJ42xZvBg0Pmqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cx96HKl2wyfY7I6F0Igw9TVv5NbgPxnFqPg/RRDhw4tcGl0JdNBC99RFExLMGRPhKmsU6xjWGE1qGOcOqvDmCPSV/QHCnINiE5YgipFt6abNI66hoTXYR5xWEHdBrHkBPV6fRfPNvVphfqQbsiXU+t35uYstzHXO3jMwhU+Alyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lLOOs7TQ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA00E432EB;
	Thu, 30 Jan 2025 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738228693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2vHnTx0uU8R/JSBydXEgqbPIcNPEeT1TGZLUdk5tTw=;
	b=lLOOs7TQkmUJgRH8qDAelpPYRw7pVdm2/rpWBGMslFEnb+QSflqYxnJYI/2ADALu1MBjTY
	RQP0q52I6GmlCLi4RkLTnEx3w9iFwj0T+sbfYZWlJ7Lg2GTFkj0LnFQ9yREjIz7XbStBOT
	+5BF0G4S85rfaXpwNctLapQbbzaTeHglqz9zweekgCkgU2oxhh95tcTTucT8bO+I8m3Dk3
	bMdJMVImw25LnqymQjGS2/RqE5ajDB2DFm2oBQy4YwrleC88t7Wv8X/Nhm/aUBGz8yQi9z
	oVcPi9cJCVOfm29MM/vyIT1fBg5ZxwCSvNBZQHDWPTyzt2U2NowZou6vYpT9gA==
Date: Thu, 30 Jan 2025 10:18:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/3] MAINTAINERS: Add myself as maintainer for
 socket timestamping and expand file list
Message-ID: <20250130101811.5459c3f8@kmaincent-XPS-13-7390>
In-Reply-To: <20250129163916.46b2ea5c@kernel.org>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-1-87adcdc4e394@bootlin.com>
	<20250129163916.46b2ea5c@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehgeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgo
 hhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 29 Jan 2025 16:39:16 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 28 Jan 2025 16:35:46 +0100 Kory Maincent wrote:
> > Add myself as maintainer for socket timestamping. I have contributed
> > modifications to the timestamping core to support selection between
> > multiple PTP instances within a network topology.
> >=20
> > Expand the file list to include timestamping ethtool support. =20
>=20
> Hi Kory, is there more context you could provide for this change?
>=20
> For core pieces of the stack, with a long history, we tend to
> designate as maintainer folks who review the changes, not just
> write code. According to our development stats that doesn't
> describe you, just yet:
>=20
> Top reviewer score:
>=20
> 6.12: Negative # 5 ( +6) [ 50] Kory Maincent (Dent Project)
> 6.13: Negative #11 (***) [ 29] Kory Maincent (Dent Project)

Yes indeed, I am not really confident reviewing code part that I don't know
well. My thought that I did not have lots on review in the PTP patch series=
 I
just managed to get merged. So I would try to change that.
Moreover I have changed a bit the management of time stamping configuration=
 so
if there is changes or fixes I could be helpful.
Indeed adding myself as maintainer is a bit overestimated, maybe I could be=
 set
as a reviewer to be in the CC of the patches.

> https://lore.kernel.org/20250121200710.19126f7d@kernel.org
> https://lore.kernel.org/20241119191608.514ea226@kernel.org
> https://lore.kernel.org/20240922190125.24697d06@kernel.org
>=20
> That said, I do feel like we're lacking maintainers for sections=20
> of the ethtool code. Maybe we could start with adding and entry=20
> for you for just:
>=20
> > +F:	net/ethtool/tsconfig.c
> > +F:	net/ethtool/tsinfo.c =20
>=20
> Does that sound fair?

Yes it does. Whether setting me as reviewer for the SOCKET TIMESTAMPING sub=
part
or adding me as maintainer of these two files it is ok for me. What do you
prefer?

I will try to review more ethtool code now that I began to understand how it
works thanks to my PoE and PTP work.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

