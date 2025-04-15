Return-Path: <netdev+bounces-182697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B5A89BC0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239997A7BF8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FB28DEF5;
	Tue, 15 Apr 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D7ztH0mK"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148127991E;
	Tue, 15 Apr 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715757; cv=none; b=hq/NSA08lwmYpzTk1rhYUmo5zIh4r9f3Uf+QcmOeXkqfsdjjzXWG+2/epylSgMo5SAofKjzbDDKQ2/vcQiUag7FSR0M7gemO3/AF5Dj8DuV2z+b2MgkycgBHpw+3uIMSaRpvooN4pXUjVGXSmabpeET3EWlBWEf5yCV9k5w3EPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715757; c=relaxed/simple;
	bh=ESdxRsI5H2fH1qLuof0hi0dgsc52nyAkcdU9rpUfqUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyOIbHtrgWHimkF+/U6ogKNNryLldl/+dopt7c+ZMkzCbVaR3EsUgiLteUEWiFNypxBfstNbxcjzkfK8oS4WAe2mpsJAvgXx4qEvQFLtd4lQoop3j1s3bzRnW2LDcFjYxveaYEbtsXqnbDs2XO0KdickqZUKTH8sXUalopi2GyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D7ztH0mK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF13243A01;
	Tue, 15 Apr 2025 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744715751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFB15gTIJBDpeGlS/cv2ReAhXeiDDHLVaR68JGGc0xo=;
	b=D7ztH0mKUYnIvtU2sA00xwI+e+PY+KeBEYH0fBLkwBzMuDOYcFTMJwc3egCuVEFwdZk3BK
	N+54vsjLUHrm/IZ9xgAqtLsVE/oakR1DkGzTb+9Z/CQD2TmPR/55gVtJSWJvU3pfHzqFbx
	zrbyzzPN45ilYCymFE85YGem/1O/v+9x8eMd0yGGUR2rQ+0XUSz223J6nJEf9kEccUi4R3
	A2fA7+9G6nFBCimb11vj6r61kDBrQ1T/GnRIFNcCzrR4cQusfGBe8FouCuP55R7osd0zzR
	VYM8wJskqoCcBxRQpG7hBIMB1+I5EvXLBDrJdJAcX26yZlRDYvU4Grj6d2snqA==
Date: Tue, 15 Apr 2025 13:15:48 +0200
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
Message-ID: <20250415131548.0ae3b66f@fedora.home>
In-Reply-To: <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	<16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeffeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedviedprhgtphhtthhopehmrghtthhhihgrshdrshgthhhifhhfvghrsegvfidrthhqqdhgrhhouhhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhesl
 hhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 15 Apr 2025 12:18:04 +0200
Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:

> Historially, the RGMII PHY modes specified in Device Trees have been
  ^^^^^^^^^^^
  Historically
> used inconsistently, often referring to the usage of delays on the PHY
> side rather than describing the board; many drivers still implement this
> incorrectly.
> 
> Require a comment in Devices Trees using these modes (usually mentioning
> that the delay is relalized on the PCB), so we can avoid adding more
> incorrect uses (or will at least notice which drivers still need to be
> fixed).
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/dev-tools/checkpatch.rst |  9 +++++++++
>  scripts/checkpatch.pl                  | 11 +++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index abb3ff6820766..8692d3bc155f1 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -513,6 +513,15 @@ Comments
>  
>      See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
>  
> +  **UNCOMMENTED_RGMII_MODE**
> +    Historially, the RGMII PHY modes specified in Device Trees have been
       ^^^^^^^^^^^
      	 Historically
> +    used inconsistently, often referring to the usage of delays on the PHY
> +    side rather than describing the board.
> +
> +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the clock
> +    signal to be delayed on the PCB; this unusual configuration should be
> +    described in a comment. If they are not (meaning that the delay is realized
> +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
>  
>  Commit message
>  --------------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 784912f570e9d..57fcbd4b63ede 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3735,6 +3735,17 @@ sub process {
>  			}
>  		}
>  
> +# Check for RGMII phy-mode with delay on PCB
> +		if ($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
> +		    !ctx_has_comment($first_line, $linenr)) {
> +			my $prop = $1;
> +			my $mode = get_quoted_string($line, $rawline);
> +			if ($mode =~ /^"rgmii(?:|-rxid|-txid)"$/) {
> +				CHK("UNCOMMENTED_RGMII_MODE",
> +				    "$prop $mode without comment -- delays on the PCB should be described, otherwise use \"rgmii-id\"\n" . $herecurr);
> +			}
> +		}
> +

My Perl-fu isn't good enough for me to review this properly... I think
though that Andrew mentioned something along the lines of 'Comment
should include PCB somewhere', but I don't know if this is easily
doable with checkpatch though.

Maxime

