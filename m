Return-Path: <netdev+bounces-176546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EBDA6ABF6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1654A0211
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75441224AFA;
	Thu, 20 Mar 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gEVaPQ+R"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132D2248BE
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491665; cv=none; b=r/dnnq0jGpK5VqrJ1YnWIHq7z2R1t3B7F2AzjRzg3SrpEkDyKhiCBd8IBYtBxDQw2TQYDFp2SCZX+jmtQ+t7C7hu7bMX6WLTkoa8wMIIAJE35xbuGCs4gXQUhSKyPtbGNBGl1EwwRKavtcvl3mYN7yreFIoMitKMIli7MtF+BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491665; c=relaxed/simple;
	bh=hIYEfUuBjej8Cj1xUGLDI79DqxMvzVP0A4NuAu0wOso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5SU67+YhiSgVeUz8iwvjl6eTrZAc63uWjqbIAMMqsOSQnatembNkRPxG2FgMARvzIkeU1UV6IbgRXx37mX57xjSgwmh85S3zHQESaAG3BUFpwQVD+VA1U0lzwh1NeqHlMxxnGdnEZ9iC8KRYE1ZE07VsTjB2E7qZ/y0S0Du3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gEVaPQ+R; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED7D6441AF;
	Thu, 20 Mar 2025 17:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742491661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YrH4FE9NjAjK59QeCAfqP/0b7MTccf+VEFr3B/Cy7c=;
	b=gEVaPQ+RNVeW+NZm3j58neLRLBlGhpZC17t1U4C1DBOIbEXPOxNxA6dSfkWgt5CBmtyOGb
	biD2GOZYm7WSjTw9OIOebJ2Djw7e9CcNr+1aPIOOAyKXFHzYKp2b6pSztiw18oM2FHKyVK
	1KTgIEKF2JFj62p24tcRubyKfCTG3cElhY5yNPdI3KTsY9UetyTl3FfIpAFelIkekcbKh8
	vBhO+MJKKkI5ho+aEbMjS+IBJQfjRbrGBHDMyMMBYvcScgplzJZk0SWas0u0ZYqVkwcKb5
	8voPz4AaIDAhABTxB7TD4O+Cxowg1NcLM8/WFYz7Zr8M28cDQLoD8HFvl4W1CQ==
Date: Thu, 20 Mar 2025 18:27:38 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
 edumazet@google.com, pabeni@redhat.com, ezequiel.garcia@free-electrons.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Prevent parser TCAM memory corruption
Message-ID: <20250320182738.67108ea4@fedora.home>
In-Reply-To: <16143c70-de5a-4f30-ad29-eae33d2e5b0b@lunn.ch>
References: <20250320092315.1936114-1-tobias@waldekranz.com>
	<20250320105747.6f271fff@fedora.home>
	<87zfhg9dww.fsf@waldekranz.com>
	<16143c70-de5a-4f30-ad29-eae33d2e5b0b@lunn.ch>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepthhosghirghsseifrghluggvkhhrrghniidrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpt
 hhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtghinhdrshdrfihojhhtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 20 Mar 2025 14:14:16 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > We still need to disable bottom halves though, right?  Because otherwise
> > we could reach mvpp2_set_rx_mode() from net-rx by processing an IGMP/MLD
> > frame, for example.  
> 
> Ah, that answers the question i was asking myself. Why does RTNL not
> cover this...
> 
> Maybe the design was that RTNL is supposed to protect this, but things
> are happening outside of it? It would of helped if the code had put in
> some ASSERT_RTNL() calls to both indicate this was the idea, and to
> find cases where it was not actually true.

I think this was definitely missed. I added some of it back then, and I
certainly didn't consider non-rtnl protected paths. an ASSERT_RTNL
would've been a good idea indeed :(

With netdev_lock closing in, I think Tobias's approach is better. We
can't rely on a netdev_lock to protect the parser as it's shared
accross multiple netdevs.

Maxime

