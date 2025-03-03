Return-Path: <netdev+bounces-171358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502DA4CA5E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45DA17FB96
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B382153C4;
	Mon,  3 Mar 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B8pE0DrF"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C321505F;
	Mon,  3 Mar 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023338; cv=none; b=eEJoO54un1dwryokCRCKF8oId615ekr/lQXxOFs/iRBsvx3beSHXJ6+Vi9pPf29u9OFrW8OZgYcX4X1GoQ8hlzJU3dDIJ57uSOceznyP3odcQUaq4Kz0lrFY9GP4wAeiM76qK86KYPBzr1hkOjrmthNKDbHmn66rAjiwPZiv6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023338; c=relaxed/simple;
	bh=feivEZBZvpiPU8pRpTX6k3MSLxb7XTZQUVE5mRxjW1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8PSn8SxFXEPYgalUROgxlydGKVQ+6BrvIKep9DEIEn2o1HrizriyoYbAv1ZblF675RGfOiKrdMk+E1+r4EWC41Brgxh3iHpwxjR+Qg3mX/awV3et/Ho6iAqAmixyMDpjmTAt2WUoDNUC4CfvWssFHo7HrzfGXYtYKzV/4+nqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B8pE0DrF; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4CDA20470;
	Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741023334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+B3rMYSVR03ft2KwtD71VoyHSPoRijyZQbUqoCMt0o=;
	b=B8pE0DrFNC5cSUAeeQMp0HlRdACeO0lzkrjtJs6ARb0TutXQnTlM8PNXApUTcyjjj5tXOu
	y2l8Py5hbgmcZsKxvI9uPkPI+wDFDqQK4ZU7hJ2GW1tB0QcC4pjeTSicuJpQJKaOElCz0R
	wRpwl9MJoPeeaHWTqo6VCBqNMi5/VqdprD7PnF4OjaSIDJUBwEJK35Oz1h337Q+luyQqMa
	wNBbhEwg5x/VSh6r1c/3KfHJsgcNI6YL9rjSPnGc1hzoLdfXQfoCk73ePXtsaO6sag0wqD
	zRCeCtPHMs603ADv5fI/GRVBUINw4TnVVCdINJqnPAM0gZBRhlZoRVh4cAUoWg==
Date: Mon, 3 Mar 2025 18:35:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, Ariel
 Elior <aelior@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Manish
 Chopra <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Ram Amrani
 <Ram.Amrani@caviumnetworks.com>, Yuval Mintz
 <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] qed: Move a variable assignment behind a null pointer
 check in two functions
Message-ID: <20250303183532.580eb301@kmaincent-XPS-13-7390>
In-Reply-To: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	<1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	<f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
	<6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
	<Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
	<325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
	<64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
	<a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelheehveeuvdfhgfeukeethedvheduuedvudduteehledtheelleekffelvdefheenucffohhmrghinheptghmuhdrvgguuhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopeforghrkhhushdrgfhlfhhrihhnghesfigvsgdruggvpdhrtghpthhtohepmhhitghhrghlrdhsfihirghtkhhofihskhhisehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhto
 hepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhjrghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheprggvlhhiohhrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 3 Mar 2025 11:28:29 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Mon, Mar 03, 2025 at 09:22:58AM +0100, Markus Elfring wrote:
> > > The assignment:
> > >
> > > 	p_rx =3D &p_ll2_conn->rx_queue;
> > >
> > > does not dereference "p_ll2_conn".  It just does pointer math.  So the
> > > original code works fine. =20
> >=20
> > Is there a need to clarify affected implementation details any more?
> > https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereferen=
ce+null+pointers
> > =20
>=20
> This is not a NULL dereference.  It's just pointer math.
>=20
> regards,
> dan carpenter

Feel free to ignore Markus, he has a long history of sending unhelpful revi=
ews,
comments or patches and continues to ignore repeated requests to stop. He is
already on the ignore lists of several maintainers.
There is a lot of chance that he is a bot.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

