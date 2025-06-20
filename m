Return-Path: <netdev+bounces-199742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A665AE1AD3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803FA1BC7ECB
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D528B4F8;
	Fri, 20 Jun 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JYFU+TYQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318982836B4;
	Fri, 20 Jun 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421874; cv=none; b=SCABHAyVN+4N5u2Jb5QIGDcAqitTyZrih5CITeXNIUBIxzhN16Kw3FgHkq0vfL4sWpYtowv1hxfzO+7RvaqsGTaifl6TesZciVOd8JqsNupLLF40BlCdHOQNyqq0XUXFTPKilNvrtXw+5H+cgSjG5t0NODpnQeZUcsHl84OhCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421874; c=relaxed/simple;
	bh=I1SSuyFnlPzNJ3Iz4UM7jzuOhjZg40BZvC3l0Eu1Ry8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewXtY0/lQW9ipPO34fzCG6vn5xKfmQur6fTCDGvC92OcTm2gDwTScWV7NLiAZQjzxfp7Q9eKizcOMEiCnxUHHM0KES46gru/SVHx5t4D4euPvN2FALyvyZlaYonJ2mvMNdZapJVMPd+8adIDd/adDj7lLoOqrm3twzhQAO6XvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JYFU+TYQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBB9B43289;
	Fri, 20 Jun 2025 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750421870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1SSuyFnlPzNJ3Iz4UM7jzuOhjZg40BZvC3l0Eu1Ry8=;
	b=JYFU+TYQN5WlP1fjExoaIPpe/LY+osCh2qlhxDLSdfvSe1tSy7ZIOv4MAE5cQo0AJ+QVxX
	yclK82aCufpuCAG4/l7zSb9tE3PwQHUeyJsvGFdoc68J+qwmYaEVT8whFgREt4Y3WEdKBd
	K3uNHCUlmQ0neHB7aNZ+tIFwOnXuvC1ClTRKmIk1PG/O0pr6SViDcWEDZ4N5MdaQ+Lv0Dp
	1o61cVFM4b13QGmOyaAVg4mMdj9UZITW3xaD5xu5WFT992fTvAex0kd3Z+a5ZC2WzcAzeP
	yzkzEXFdty5x7STvMhR9RMRyjvQWXoPGSSOmaFUIdvlxjrsrDrzQWtkEcZGGdA==
Date: Fri, 20 Jun 2025 14:17:47 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>, thomas.petazzoni@bootlin.com, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ethtool: pse-pd: Add missing linux/export.h
 include
Message-ID: <20250620141747.471b8d6b@kmaincent-XPS-13-7390>
In-Reply-To: <20250620101452.GE194429@horms.kernel.org>
References: <20250619162547.1989468-1-kory.maincent@bootlin.com>
	<20250620101452.GE194429@horms.kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlr
 dgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Fri, 20 Jun 2025 11:14:52 +0100,
Simon Horman <horms@kernel.org> a =C3=A9crit :

> On Thu, Jun 19, 2025 at 06:25:47PM +0200, Kory Maincent wrote:
> > Fix missing linux/export.h header include in net/ethtool/pse-pd.c to re=
solve
> > build warning reported by the kernel test robot.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202506200024.T3O0FWeR-lkp@intel.c=
om/
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Hi Kory, all,
>=20
> The change that introduced this warning introduced a log of such warnings.
> Including a lot in the Networking subsystem. (I did not count them.)
>=20
> So I agree with the point from Sean Christopherson [*] is that if the pat=
ch
> that introduced the warnings isn't reverted then a more comprehensive
> approach is needed to address these warnings.
>=20
> [*] Re: [PATCH 3/6] KVM: x86: hyper-v: Fix warnings for missing export.h
> header inclusion https://lore.kernel.org/netdev/aEl9kO81-kp0hhw0@google.c=
om/

Ok, thanks for the info.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

