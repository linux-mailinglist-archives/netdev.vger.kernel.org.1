Return-Path: <netdev+bounces-168942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1AA41A31
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0475D1893DCC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A27245037;
	Mon, 24 Feb 2025 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VjNc9Dfb"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77F288DA;
	Mon, 24 Feb 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391401; cv=none; b=n2bcZHJ8q5k9v/mHGpBzO5Fs1mMrmz7JStZKob8t882lzzJ9+hUXvcVx/adG48ZMUNyaFlgPy5Wd1/WLtL9IeNwQmEtbPBOUXzU9YrWuC+Cv0AhZdKW55wUjs/d0WAM5x1BPovSFtgiEAECfAiJBZjWH5CedKzffivBCXKSnCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391401; c=relaxed/simple;
	bh=+S9FJ/5Zj4NlTviCUaHIk2ju6QITpbOQ5WRlOLOzU1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsjoX/Xh+rpEC+Gztcp7Dy/nXXsBbIUaJF6qRA91IbivwvuSnbK0GlQptii+JTEp2akpWWVdaroFGRzFJIodDBL2oN1L2GC5KVdLqPZBer829Vsdi7lm3vrZhvcqD9k8jpTxSNoXhfo1ztdBA9EjE6XqbyBAKopiZF8fxg5Ma88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VjNc9Dfb; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56C3D4328D;
	Mon, 24 Feb 2025 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740391397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhOkwnRfRJLwfP6dSvZKfc6g/BsuQm8/Rk8DKbOHg8M=;
	b=VjNc9Dfb9+6zQTeqEjlxmGrL9jtvs1GMekMDZcHlkmepiktDUl9DLttcDBG8W7k/wy+VoP
	iTXe2xSU4pmiHEzuK0WMUImToUzDbMS3l9ewHy/eewy7aBqVJTO9G18WfKx8MsQvQJVNe3
	nrU9qA+fJgx8jL3eTizDcp1qo/e5siQ63yJoahQLlznC9xXE5uyHVAaW6Ci5JcxX0yWDUw
	d7FzToisVmq5sSxEauTDZuVC3knMe/7KLwpZ8XEtvNE6J8XP9i2ewlrIanUr9ltkw+I3CJ
	szufUiMw0lF2boE7iWSvKbJSnfNepyI3gxw95DsfmA5gIs4rTZS0h3X7uTOTJQ==
Date: Mon, 24 Feb 2025 11:03:15 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: mdio-i2c: Add support for
 single-byte SMBus operations
Message-ID: <20250224110315.62fb8c80@fedora>
In-Reply-To: <4ff4113d-f97d-4d40-bd7e-cdba6f30b6ee@lunn.ch>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<20250223172848.1098621-3-maxime.chevallier@bootlin.com>
	<4ff4113d-f97d-4d40-bd7e-cdba6f30b6ee@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrm
 hhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 04:36:49 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > This was only tested on Copper SFP modules that embed a Marvell 88e1111
> > PHY.  
> 
> Does the Marvell PHY datasheet say what happens when you perform 8 bit
> accesses to 16 bit registers, such at the BMSR?

It doesn't specifically say what happens to BMSR, however the section
about "how to perform a random read" gives an example of a random
register read that is made of 2 single-byte reads, including the STOP
bit being set in-between reading the upper byte and the lower byte.

While this doesn't exactly specify the BMSR's latching behaviour, it
looks to me that this is a coherent way of reading a register state,
and BMSR's link status register *should* latch until the lower byte is
read.

I'll try it out with one of my modules to make sure though.

Maxime

