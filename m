Return-Path: <netdev+bounces-176706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C5A6B886
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5573B9032
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5191F3BB8;
	Fri, 21 Mar 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L6ojrQiZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95791F3B8F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551838; cv=none; b=n/6oEfOLCZEdF1C+z70hv81pL4wKL/oJ/4mPodvFMx+nZQmuP4kmdqNz+FgsG/PBKJ3yuofMCvaWNFv1A+FPWynx/rndrbJfD65SDTezZqtFcPaxFLX9PPIAbHu6l8Z887RZzwj/IcBiCJih019NXIWlb6EUfD7A0OV6H/+B/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551838; c=relaxed/simple;
	bh=fd3ZLSPo68QW4VuOeYoXclke2gsHkrWePZ1eDhkXj7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHNtiGVpG1SUE4qn2MszjRWtHWgsGTown3qwAf33NeypJCk0V64dGMHgzRWs4RoGrphVooS2qtiAIuKSVXPS0ShBskpM7gRxussfKk7JP7npolaCuFuXJCPkOYUaouIL0OTg+qjhxbsxWYYgAZVleY2ghesY3oa2Xb1hi7Cg+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L6ojrQiZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66F1C43137;
	Fri, 21 Mar 2025 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742551834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHs5bpcWReb9HwlNAxoRayUedLO+wMU44yWlFroZ/ts=;
	b=L6ojrQiZNDFiVdVPxrFVfeHomOt3djWUGu8d2CFztTzAP5N5cuevs/mdBb17lGx8x7bRn4
	06X5PR66z77ZBUr5t/ORPzCi+d44EnGjGbuXl6O0A/ktfCtgXEW1m73jL/TXI24HcEBLHj
	Ntg1WQqJ8n1+5sYb0ZlgJu17XwHi/RyhWbYSl2EZpjGpbt7g1C6J0FePVEztdXnwTj2AYd
	clV70lNxI4tkuZEb6HzlwfZk3VXMHs8dXNO3rorv6Zxde4lM3dljpr7iERL0OoMWBnwR/X
	lPZ+F3oYVvFneKcZ2l2ZfqsExpcAhwlW49oAr94SirNUuNY9hxSVVW3BukVa1Q==
Date: Fri, 21 Mar 2025 11:10:28 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory
 corruption
Message-ID: <20250321111028.709e6b0f@fedora.home>
In-Reply-To: <20250321090510.2914252-1-tobias@waldekranz.com>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehtohgsihgrshesfigrlhguvghkrhgrnhiirdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtohepmhgrrhgtihhnrdhsrdifohhjthgrshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tobias,

On Fri, 21 Mar 2025 10:03:23 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
> information, from concurrent modifications.
> 
> Both the TCAM and SRAM tables are indirectly accessed by configuring
> an index register that selects the row to read or write to. This means
> that operations must be atomic in order to, e.g., avoid spreading
> writes across multiple rows. Since the shadow SRAM array is used to
> find free rows in the hardware table, it must also be protected in
> order to avoid TOCTOU errors where multiple cores allocate the same
> row.
> 
> This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
> concurrently on two CPUs. In this particular case the
> MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
> classifier unit to drop all incoming unicast - indicated by the
> `rx_classifier_drops` counter.
> 
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

I gave it a quick test with simple tcam-based vlan filtering and uc/mc
filtering, it looks and behaves fine but I probably didn't stress it
enough to hit the races you encountered. Still, the features that used
to work still work :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks a lot,

Maxime

