Return-Path: <netdev+bounces-161606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6CA22A40
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE6165F05
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C091B4228;
	Thu, 30 Jan 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mw8u/BN4"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34F139B;
	Thu, 30 Jan 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229247; cv=none; b=JleOswK9/vpYPArgD2gfTC48ApTBqzB1Fi0F38fU6kxnZVwoeMrN3sqczXJWBCk44hZ9L5V5N8nkTd+iJo5p/YRoQbMIxlkOh8D/R+dy5LjP72mk1T/4N4ImZQCCyy2AMFRgBj3R+YkgvOy32scmIT/4rJvvzcjfZWrbYtzTdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229247; c=relaxed/simple;
	bh=ceg2xbuImqEiBLzoIokxmg31a3QbfMzmVUm70up/mvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRoy8orhViZFrquuNIV5uB9a6hnB/RszMPPtGuueMVHFHsB+wqa4LrTTAakcuIVpsLjPm4VI0RqMoYM7JAsYXeUlj7woNBkx5dPPqIRtWhf+R+NBb7H78fF7ixumhpcfEJL9BEmoDh9+h8GhI56JQ5TNR8mcf4cCIEH4b8PRFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mw8u/BN4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1A1043288;
	Thu, 30 Jan 2025 09:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738229238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceg2xbuImqEiBLzoIokxmg31a3QbfMzmVUm70up/mvg=;
	b=Mw8u/BN4CUbD3nFoGzA6w6ye4hm2VJbzUArFo344xceJKki2zt0mVIF/PWGoi/LMrX9XHk
	uN3lzy/SeDWJyTmNhT0OI+U85SFhWbgq0ZLm9ACrixWGkQ4EJpVh+LRw25ZRWkx0R/iQgJ
	biM4QeAoNKzvIhScmwon1q2NlDSvgeOV7YEsSDndLk17gvKuaJTR8T92lBgIPIPOnk/Vf8
	D4wHgnJ94aiHEKgksIV3DCjIaKGj9uMzU1ChpjlWSokpEH9NtFpE+TKX+9mgbRSn4kEi9b
	VVTg2ZzUtznS142xMsDYdaldt2F7SYnLeXtIWf54CgdawU1pXIeFzizLfT01TA==
Date: Thu, 30 Jan 2025 10:27:16 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: ethtool: tsconfig: Fix netlink type of
 hwtstamp flags
Message-ID: <20250130102716.3e15adb6@kmaincent-XPS-13-7390>
In-Reply-To: <20250129164907.6dd0b750@kernel.org>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-3-87adcdc4e394@bootlin.com>
	<20250129164907.6dd0b750@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrt
 ghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 29 Jan 2025 16:49:07 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 28 Jan 2025 16:35:48 +0100 Kory Maincent wrote:
> > Fix the netlink type for hardware timestamp flags, which are represented
> > as a bitset of flags. Although only one flag is supported currently, the
> > correct netlink bitset type should be used instead of u32. Address this
> > by adding a new named string set description for the hwtstamp flag
> > structure. =20
>=20
> Makes sense, please mention explicitly in the commit message that the
> code has been introduced in the current release so the uAPI change is
> still okay.

Ack.

> In general IMHO YNL makes the bitset functionality less important.

Do you mean you prefer u32 for bitfield instead of the bitset type? Why?

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

