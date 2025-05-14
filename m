Return-Path: <netdev+bounces-190398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBEAB6B4A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FCF1B6040C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB243276024;
	Wed, 14 May 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M1p5Iwb0"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5F20299B;
	Wed, 14 May 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225226; cv=none; b=MPtGbFyxB2ye8A6KT0ldZNBEV16iSBv36tK0SgHdjYGg/ooK4G5TtbYUGIheij9vY2QRv0RUT9EWj9/iI29JmSPSu9m1xx8sHuZavcN7Whc/gSpFspTEdBGKjeOq/QgvI6AG9djL4D4neeYAJD40wWR0OtoqkLmNMg2Qy6iALtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225226; c=relaxed/simple;
	bh=NlajYTJSfazmLSRiirqfAL+mECUgQnC0dhtub+re41U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMDKw+0FSEIt2eWIeNuIvpkBn663Fh8rWKd+H3Vu9HJwviarz4WZbvVWEHAYdymODOym2vLzUqbTEiClt2NpZnb7JC+V3tXuVuTtp1fUfoXPW6yDqSKBNq9uSpxfUtqX6fL36tDCTd4C4yGy7cM6+VomKflMe3J1Z33iXlMmPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M1p5Iwb0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB291FCEC;
	Wed, 14 May 2025 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747225222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo1B64wUILKqKAiHJaL+05TTgFkZmbh/SeeSl0kMN+o=;
	b=M1p5Iwb0tlv7JLuTw2+gFp4ksPtaemsttIVn9dOhwoCJ5B+4SIx0E/X8BpAftxPYsHS1w0
	Moy16PdLUkaTy0RZRWCZib7Hr8uYoHO8IbMnOyKUU/ul+VK6OATMjySmtBCLBIqFPQc/QC
	wLHFVxnn6j3GWCX0upkx7dzNs4prqQWKY5+f59W1HNE4TjyVhmIAumV5RuayPpUU7HuJ/M
	qe6z6kCjjC+ZTrAPibNZNExYjIs6CWJ2194TjYKjFiKHOdP/qBYkUI6UpQj69NioHo4lDG
	JNsOvs8bsMRfbFPS79wFlxyWbIlADHDfKlmtKhw8DJ5X5ybtzUuZfvhSAlOe7g==
Date: Wed, 14 May 2025 14:20:19 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: dp83869: Support 1Gbps fiber SFP
 modules
Message-ID: <20250514142019.56372b4e@2a02-8440-d105-dfa7-916a-7e1b-fec1-3a90.rev.sfr.net>
In-Reply-To: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
References: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeileejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeekgeegtdemugdutdehmegufhgrjeemleduiegrmeejvgdusgemfhgvtgdumeefrgeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeeggedtmeguuddtheemughfrgejmeeludeirgemjegvudgsmehfvggtudemfegrledtpdhhvghlohepvdgrtddvqdekgeegtddqugdutdehqdgufhgrjedqleduiegrqdejvgdusgdqfhgvtgduqdefrgeltddrrhgvvhdrshhfrhdrnhgvthdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehrohhmrghinhdrghgrnhhtohhishess
 ghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Romain,

On Wed, 14 May 2025 09:49:56 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Hello everyone,
> 
> This is version one of my series which adds support for downstream
> 1000Base-X SFP modules in the DP83869 PHY driver. It depends on the
> following series from Maxime Chevallier, which introduces an ethernet port
> representation and simplifies SFP support in PHY drivers:
> 
> https://lore.kernel.org/all/20250507135331.76021-1-maxime.chevallier@bootlin.com/

Thanks a lot for giving this work a shot ! Maybe a small nit, but as
the dependency isn't merged yet, you should mark this series as RFC, as
it will fail on the autobuilders.

I'll take a deeper look into that this week.

Maxime

