Return-Path: <netdev+bounces-182788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984BA89E82
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2823A33CA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C423292911;
	Tue, 15 Apr 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pb6tvvc7"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BE28B4F1;
	Tue, 15 Apr 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721224; cv=none; b=LYUozLV6/mrODf5gP+l/F9Ji09VCzTorFUP67bvflWQpbqyFaQTRGP55bPx3TvuDRgNL2OK/XotGGBb7TK/cfJMXYPCdnzsVcOXDTmZhC/T8UB875MBhVd8NYLAkvUysuCD0XAYU2pWH+VlFZ9cMXwuuNyIlf6ce2GdT1ZWR4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721224; c=relaxed/simple;
	bh=5vRosKX5Osw72EvS+mxpqaBtV03BB8wYWXzLNWqTvNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VscrMf5Z9vcPJLfsdRX8xR3T/IfPYH68qe8JrHNLl0AC1DRdz7qs3ckQXEdliLVBfEm2CygvrlF8ROdjWzEtJQXaYNKzQHTo/TsmXv2FFMUic3UPqY/nYYvfnNA+ntejAJZmU26Tanc3ZMRkmzhc7sD1UlMIJCoS645ztW5ewQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pb6tvvc7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 299544397E;
	Tue, 15 Apr 2025 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744721219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOROKFQ2lacCi0F/sGRNvCq/N5utu9L8rxls16miSXo=;
	b=Pb6tvvc76apWhHbdIEqp/Stcts3c7Sm/V+f6ZLnsfk6BojnBRT3ZEPHzce74zAiG4TniuH
	cf13yoXltXjAjAuMf/nMIooDISY8kg3lLrKYXVpABFT8hWrAiNUXeGmlQPo2GSjvp7E7s8
	nP0BG3XeaMRpAMTv3JjUC11g9nPwDyW+DWQc64GMv/oDLsNq9lvhQdPPKKwNDCLg9295KJ
	f1opItPe2LX2cVUnrs1U6ILDCrw+XxVkwlNZM2aH6/vzMyahQXRf/rtH4SAlxny+yiheen
	/F5b1OniD+8tDZbayxWleJlcC4r8MzWx8MlhSXxh6XKSMiey9Wo2XVxnEROBEw==
Date: Tue, 15 Apr 2025 14:46:55 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
Message-ID: <20250415144655.416c31ab@fedora.home>
In-Reply-To: <a40072f780a531e5274ce7f2ed28d1319b12d872.camel@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	<16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
	<20250415131548.0ae3b66f@fedora.home>
	<a40072f780a531e5274ce7f2ed28d1319b12d872.camel@ew.tq-group.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedviedprhgtphhtthhopehmrghtthhhihgrshdrshgthhhifhhfvghrsegvfidrthhqqdhgrhhouhhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhesl
 hhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 15 Apr 2025 13:21:25 +0200
Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:

> On Tue, 2025-04-15 at 13:15 +0200, Maxime Chevallier wrote:
> > On Tue, 15 Apr 2025 12:18:04 +0200
> > Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:
> >   
> > > Historially, the RGMII PHY modes specified in Device Trees have been  
> >   ^^^^^^^^^^^
> >   Historically  
> > > used inconsistently, often referring to the usage of delays on the PHY
> > > side rather than describing the board; many drivers still implement this
> > > incorrectly.
> > > 
> > > Require a comment in Devices Trees using these modes (usually mentioning
> > > that the delay is relalized on the PCB), so we can avoid adding more
> > > incorrect uses (or will at least notice which drivers still need to be
> > > fixed).
> > > 
> > > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  Documentation/dev-tools/checkpatch.rst |  9 +++++++++
> > >  scripts/checkpatch.pl                  | 11 +++++++++++
> > >  2 files changed, 20 insertions(+)
> > > 
> > > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > > index abb3ff6820766..8692d3bc155f1 100644
> > > --- a/Documentation/dev-tools/checkpatch.rst
> > > +++ b/Documentation/dev-tools/checkpatch.rst
> > > @@ -513,6 +513,15 @@ Comments
> > >  
> > >      See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
> > >  
> > > +  **UNCOMMENTED_RGMII_MODE**
> > > +    Historially, the RGMII PHY modes specified in Device Trees have been  
> >        ^^^^^^^^^^^
> >       	 Historically  
> > > +    used inconsistently, often referring to the usage of delays on the PHY
> > > +    side rather than describing the board.
> > > +
> > > +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the clock
> > > +    signal to be delayed on the PCB; this unusual configuration should be
> > > +    described in a comment. If they are not (meaning that the delay is realized
> > > +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
> > >  
> > >  Commit message
> > >  --------------
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 784912f570e9d..57fcbd4b63ede 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3735,6 +3735,17 @@ sub process {
> > >  			}
> > >  		}
> > >  
> > > +# Check for RGMII phy-mode with delay on PCB
> > > +		if ($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
> > > +		    !ctx_has_comment($first_line, $linenr)) {
> > > +			my $prop = $1;
> > > +			my $mode = get_quoted_string($line, $rawline);
> > > +			if ($mode =~ /^"rgmii(?:|-rxid|-txid)"$/) {
> > > +				CHK("UNCOMMENTED_RGMII_MODE",
> > > +				    "$prop $mode without comment -- delays on the PCB should be described, otherwise use \"rgmii-id\"\n" . $herecurr);
> > > +			}
> > > +		}
> > > +  
> > 
> > My Perl-fu isn't good enough for me to review this properly... I think
> > though that Andrew mentioned something along the lines of 'Comment
> > should include PCB somewhere', but I don't know if this is easily
> > doable with checkpatch though.
> > 
> > Maxime  
> 
> I think it can be done using ctx_locate_comment instead of ctx_has_comment, but
> I decided against it - requiring to have a comment at all should be sufficient
> to make people think about the used mode, and a comment with a bad explanation
> would hopefully be caught during review.

True, and having looked at other stuff in checkpatch, it looks like
there's no other example of rules expecting a specific word in a
comment.

So besides the typo above, I'm OK with this patch :)

Maxime


