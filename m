Return-Path: <netdev+bounces-200507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004ABAE5C30
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAD54A0D17
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE722CBEC;
	Tue, 24 Jun 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="esC9nZC2"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CF20EB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744607; cv=none; b=ODRmIesBGZoUDBK1KOu2LQn43tBSmU1XpopZ0Qvh5rXDL8nieqZKdw84Evx3gISl28cPSGZp52mHZ7tc+olyXXt1Txq6/0h8MK25XGHxwVVfdetTjjg+xe7idfq6M+4HMjKw94K8vdf+ZM3OH5QEVqNAOUBmNFhrl7ZTTlUWSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744607; c=relaxed/simple;
	bh=fstHr44hO4JwAqDDVko2ZM1gulnm+fCqjrJSkAtzt+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/y6mGabBKyKMmtAObIrqnfuOHzxpAXqjx2bZAJVIFT0zJ4Pav5KYPPLKFqBRqGe7WDOZeUgzW0ySvpSfnTqVIePoZUcgw9BUJFK0CI7E3Y6m7aOurqGLQoU1Ch+KnGlb8ag2eNCHxGIO1vQMFvLt8250UP1tlt7J51/AskopFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=esC9nZC2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AABD243253;
	Tue, 24 Jun 2025 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750744602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQkHjLCLcRkKgCqeagBS74422ioivPMFCKd9PMZocVo=;
	b=esC9nZC2aHFiPw/LhYj9PRFRdN4kJypFf3O+pkfPIRM3SA9Wn3msKbGFZX/dgxvKKYzTqp
	xiCpEpcA7ecuOuzATnPjWIcQAim/xlsf/zuK7rQ2rGAgX18HHUfbnw9+jVR0xt2kP9xXZR
	NSt6rHurEx1aFhLLgfYIXzJVzETmh2EM/t8a4PnvQPuNJMVBKYqfyngd2ATasYHv682w2e
	ECMVEh0crpHhtul8zW5vFZJjVfgFG/pMAa0ss8tFlVIn4xMfHRfXhxuyX4eUaU0LEJC3Ow
	hX8jwEQpAbOxJf5Rq/PnQwBpZeLjWCsmYijDSLfCEK6vbCxXBMDU+DN5o1BX2w==
Date: Tue, 24 Jun 2025 07:56:40 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 4/8] net: ethtool: remove the data argument
 from ethtool_notify()
Message-ID: <20250624075640.343f02dd@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
In-Reply-To: <20250623231720.3124717-5-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-5-kuba@kernel.org>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopedvrgdtvddqkeeggedtqdguudduhedqsggvtdguqdgtvggttddqrgdvrgduqdgstgeftgdqiedvvdgvrdhrvghvrdhsfhhrrdhnvghtpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguv
 ghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 23 Jun 2025 16:17:16 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> ethtool_notify() takes a const void *data argument, which presumably
> was intended to pass information from the call site to the subcommand
> handler. This argument currently has no users.
> 
> Expecting the data to be subcommand-specific has two complications.
> 
> Complication #1 is that its not plumbed thru any of the standardized
> callbacks. It gets propagated to ethnl_default_notify() where it
> remains unused. Coming from the ethnl_default_set_doit() side we pass
> in NULL, because how could we have a command specific attribute in
> a generic handler.
> 
> Complication #2 is that we expect the ethtool_notify() callers to
> know what attribute type to pass in. Again, the data pointer is
> untyped.
> 
> RSS will need to pass the context ID to the notifications.
> I think it's a better design if the "subcommand" exports its own
> typed interface and constructs the appropriate argument struct
> (which will be req_info). Remove the unused data argument from
> ethtool_notify() but retain it in a new internal helper which
> subcommands can use to build a typed interface.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

