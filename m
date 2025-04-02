Return-Path: <netdev+bounces-178729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C3A78874
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE216F05B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B931EF38B;
	Wed,  2 Apr 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wrbao3Nr"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030733C9
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577251; cv=none; b=dn0cWNXY70n67q05dKDkdMK3SO9wkRAVUgtRp5Od9lhOnHSie9eS/4WHFS5BZQeYwiCXP58UJmc1iJ4a6Zjjn2Rr75punnE7eTuNHlis7K0KdvJgWLZiQMYep1zQER/7DEy25M21CT1IhPG4VBxL06YDkyIQRyrBOez/kh3khAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577251; c=relaxed/simple;
	bh=dhTKnefKVCBDaXmDHWo9Bzk2glf7ZIlaW9nQ+WiPi7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8pDQRQ8cIuI5qqrUMnw9c25La/g1nq5N5AtN0idrenAbxlHrKB0c3P1gPtb8urY5Z3JQ3uIl0whLZ+s5CgQ+xZo3htyBZyTbtVVR1QVszU1bubNxvoDts+SsUpJWOlkiSumPjIXzzBy2CX7dJqifZpdUY/4OvEZ9Lj0YEPV2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wrbao3Nr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BADD44544;
	Wed,  2 Apr 2025 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743577241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eToIplwWYvAeo7gXRTILTINmI7/fvBx9C836aoGs27c=;
	b=Wrbao3Nr/oJzOquoJyfFSrXkdfCNCeCKnLja7AfdYXzB361sRRoLMBNcOslwhYc1IP1DzY
	fqIcyT+jPerR+/YqTjBw8XxjtzTjZF5a7KBCek3KeDRU1jpF5weFP89/py2UBSGm4PEcnN
	iJ+GMYmiaNiJ9GiclfyGPgxkErA69XA+fahRVwR6t4HFCifSSjhP/TvTbujX0HuZFAU6XO
	xIPC0AYvN8mw8p1oLvuv1ioBNBxOKMsZfp4DmXkjR38o+SjLrRJlaKxiqup6dnD4swLaER
	XYoDJSRyXj/QYxWU494ljAlW4HTgg7oyfVxsN/+YcQM02E3Hu3MOY5GWwGf/0A==
Date: Wed, 2 Apr 2025 09:00:40 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <20250402090040.3a8b0ad4@fedora.home>
In-Reply-To: <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
	<174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrlhgvgigrnhguvghrrdguuhihtghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnu
 higrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Alexander,

On Tue, 01 Apr 2025 14:30:06 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The blamed commit introduced an issue where it was limiting the link
> configuration so that we couldn't use fixed-link mode for any settings
> other than twisted pair modes 10G or less. As a result this was causing the
> driver to lose any advertised/lp_advertised/supported modes when setup as a
> fixed link.
> 
> To correct this we can add a check to identify if the user is in fact
> enabling a TP mode and then apply the mask to select only 1 of each speed
> for twisted pair instead of applying this before we know the number of bits
> set.

The commit title should be :

	net: phylink: ...

> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

With that,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

