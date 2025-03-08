Return-Path: <netdev+bounces-173196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC5A57D53
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 19:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657D63AD7FD
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCA1DB122;
	Sat,  8 Mar 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DhrstXCP"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C11B041A;
	Sat,  8 Mar 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459379; cv=none; b=lj48f51yE7S2OqL2XsqfPn8OBcw5L80gOzrJKsYFSOoekdGMkU6sr78znNjuvepGgTjL+q3kgB6Q7f1J+SUB3aISmw/s7oJ37Nfp8s36cKtagEWsH6rzDhuu+wofGlU8FP8FuwVDjEkF/5H9u8gXVzfz4KUv3cjsYfrmOVLjqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459379; c=relaxed/simple;
	bh=bj3AkQyGvXTri8BE6H5tQYcO68Pw6ckMVTozMMTxzeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER9+AOXs1hZnEJJdNru6H/tflC3casHZnDTKmRSpZbjN5JiMZtd9kt4NoUx8QJL875Mq11ZIg+mAQN4H4wBkaDwcWxy6YSz92dLqCM8yudt44fn6BmzHxPyO4+8f5Xgkb3cD/DY5NuC4fmpZTFq0XghgfTVXh59YLuET0pW8BN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DhrstXCP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 582E2442E0;
	Sat,  8 Mar 2025 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741459374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVizt2ypnXhadSn6f+iBrMMSpu+9hfUNiwubAs2JXgk=;
	b=DhrstXCPLPMkRn/DTi3/8xqShChF4pDqYIwL80fkmnrTih3SXKGwuFHHL3p2tGHq4kQ0C+
	HvdB9kOtmgwWkkRHNV/bmJly8QzZOrvunhb9NYdeSU3wG7/EPDiHVx17dh/SCFstEvuS5S
	ML7YKxCfhLQHs2iIcfNtgw5tVJfXqy0srUstji4m7T0R+50IPZn37wPyGF0QXsIt3aWhqv
	aLeHOcOSqkiCDzFCJKRC26ipWHNwQhVLCMZuuzFCgOVBhKcJzLDxmvuNWSacOgk1YTazab
	//y8Dd2vbRfyty/MhOZaut952vu/oPvvcxgWHHbQk1s1PxN7TH6ANpvXFL7NFg==
Date: Sat, 8 Mar 2025 19:42:51 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <20250308194251.30622971@fedora.home>
In-Reply-To: <20250225112043.419189-2-maxime.chevallier@bootlin.com>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
	<20250225112043.419189-2-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudegfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeeftdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheetveefiedvkeejfeekkefffefgtdduteejheekgeeileehkefgfefgveevfffhnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Tue, 25 Feb 2025 12:20:39 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> The SFP module's eeprom and internals are accessible through an i2c bus.
> However, all the i2c transfers that are performed are SMBus-style
> transfers for read and write operations.
> 
> It is possible that the SFP might be connected to an SMBus-only
> controller, such as the one found in some PHY devices in the VSC85xx
> family.
> 
> Introduce a set of sfp read/write ops that are going to be used if the
> i2c bus is only capable of doing smbus byte accesses.
> 
> As Single-byte SMBus transaction go against SFF-8472 and breaks the
> atomicity for diagnostics data access, hwmon is disabled in the case
> of SMBus access.
> 
> Moreover, as this may cause other instabilities, print a warning at
> probe time to indicate that the setup may be unreliable because of the
> hardware design.
> 
> Tested-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> 
> V2: - Added Sean's tested-by
>     - Added a warning indicating that operations won't be reliable, from
>       Russell and Andrew's reviews
>     - Also added a flag saying we're under a single-byte-access bus, to
>       both print the warning and disable hwmon.
> 
>  drivers/net/phy/sfp.c | 79 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 9369f5297769..6e9d3d95eb95 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -282,6 +282,7 @@ struct sfp {
>  	unsigned int rs_state_mask;
>  
>  	bool have_a2;
> +	bool single_byte_access;

Looking back at that code and our discussions, struct sfp already has an
"i2c_block_size", that is set to 1 for modules with broken emulated
eeprom, and there's already some logging and all the logic to disable
hwmon in such case.

So I think V3 will ditch that "single_byte_access" bool, and rather add
a "i2c_max_block_size" member, set depending on the bus capabilities,
that we'll use to clamp the i2c_block_size.

Of course the big warning to say that the design is inherently broken
because we're on a bus that's limited will stay, but that should make
our life easier for proper non-single-byte smbus support, and also
keep the code flow cleaner.

Let me know what you think,

Maxime

