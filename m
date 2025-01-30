Return-Path: <netdev+bounces-161670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F05A23253
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B591B1885994
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680E61EE031;
	Thu, 30 Jan 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G2eAOhkB"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05513FEE;
	Thu, 30 Jan 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256174; cv=none; b=rVRNUXoejiDjbDPtpFlzoH1kWdVoV65nFo6y4HE5tmf/lvbEKjMq4SuB39kC1CsOoRLArOoRXTC6zDP8LZh/e5836o8gslEaYFrmICAZGLvZCzyJ0OJRZeWRd6r2tEF8tT5EhJNt7n5SbaEYKog72E4LXJzFHrY+jAMHWfAr+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256174; c=relaxed/simple;
	bh=UhfdpQm5JGzhS99lZ+Wp2n+UfSdJp6jak6E0tscqSZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+74x5+Ey+62slKTQ+bBdLD7tfcxhIA/2oHfyGsj/ib5Qw2jZNJWRU1mH4GU8bUFc10VWoW7B+82nm9KULMp2a0jDkI3tywOr09KYiPxOcuPsu0qA/cxh2/YibfArG1nNUbfSc6ug1WxxE0Uv8/lQY5Hq3hbx2HJfBYg5i8uMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G2eAOhkB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F78D44325;
	Thu, 30 Jan 2025 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738256169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u57qeUqfDY/mpFryGyfjHV6XRJwlw/bi3UET/NkyKLc=;
	b=G2eAOhkBR9tR0h5uspHH48myfoTgsNreJ8XkXQDc1tUNSuVnomlK0YI4qrd5Gg6RTr8Yny
	CaL91YkfEtpFLNDLop6pM/8rVycs5gG1vYLDJQCzaL/tsGysmpzYFo1Dw4p2yOOdM7r6EO
	Nm3NLjeaMQhqzJt8sqEtrkOdCTgby65B9ysTKRjpurnob4ydkdqvdb012yUjDHCMbob94h
	ep0aANmqJZMVJDQ8t7dqAKJQOmJ5BL031cLjv92oCpum6Ui56d1IPO+Oz+GCXLlyqp3YCR
	xzfVZqWoHRfr1ny4Nb/npsCjEiAMPH1Rz+je4lzjXZHgyB6TZoBBADR+nqv8Ag==
Date: Thu, 30 Jan 2025 17:56:07 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/3] MAINTAINERS: Add myself as maintainer for
 socket timestamping and expand file list
Message-ID: <20250130175607.79af57a3@kmaincent-XPS-13-7390>
In-Reply-To: <20250130083104.7f66ff2e@kernel.org>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-1-87adcdc4e394@bootlin.com>
	<20250129163916.46b2ea5c@kernel.org>
	<20250130101811.5459c3f8@kmaincent-XPS-13-7390>
	<20250130083104.7f66ff2e@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrt
 ghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 30 Jan 2025 08:31:04 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 30 Jan 2025 10:18:11 +0100 Kory Maincent wrote:
>  [...] =20
> > >=20
> > > Does that sound fair?   =20
> >=20
> > Yes it does. Whether setting me as reviewer for the SOCKET TIMESTAMPING
> > subpart or adding me as maintainer of these two files it is ok for me. =
What
> > do you prefer? =20
>=20
> The latter, TBH. I'll send the patch. We recommend setting up lore+lei
> to subscribe to threads which touch particular files. It's much more
> scalable than adding interested folks to MAINTAINERS. Tho, last time
> I looked lei didn't support the weird mdir format used by claws :(

You are right don't bother to add me to MAINTAINERS file, I am indeed not an
experienced reviewer for now.

Oh, didn't know the lei tools. Thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

