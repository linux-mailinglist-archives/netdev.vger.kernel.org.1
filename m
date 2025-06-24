Return-Path: <netdev+bounces-200508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1AAE5C32
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2684A0E3F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8930239E75;
	Tue, 24 Jun 2025 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GTo6sc2/"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FCD235044
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744630; cv=none; b=I5OzKyhlFVzVHiZL9fnvu0UgbgzCYdCGSUhJVz6/XT4E7/DZSVeIwyQi+l3hcH1rKxT0L+uxGobRYZkPkZZPUu1TqDcazwNA2ieT9EqaINrZXrWd1jXzpgkNpyA/AJErB57KFpRCvP7K6+33NYx3VMuTsDB6+VxPiJIZMVOIfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744630; c=relaxed/simple;
	bh=GUwj84oIPHQuz/AaU5nBp9adOUI9GmoMbXbzrv0/P6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMIBXcCkyJh2mWhrvmuc2QLvNRiNkX8XMxQ0QqyiTVfhUOXRzCvF+a2EBIMLT4XWraPd7OAkNuGQsg7ngstAXsSzBdkRt/8lo3QpXh5v7C3cIMoDTytJshasUJlks80ss/OmhgSWZ4u9UPaj39crju/82d1G4Is7AKZI15ELE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GTo6sc2/; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A47CE442B1;
	Tue, 24 Jun 2025 05:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750744626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xE0qqfzJQc4e+jTdK7V7Rzop/kCzZE0i2n6M6LqSy84=;
	b=GTo6sc2/WAY4v/hyckauXj7dmtkQMxpNLts4xDdIl14qVVUQ03wRIFFXAo7z7AZEUIZZDv
	3fj83gRtomLyqNmeLcRxoQV7YVFwaUbvaVsa46oiLZOM1veE4BamZ+nqPuKYbIww6r0NCf
	6RCGZvkCGbCTyOTaQBMGWwqmsbPl7ojeMbWcNVHRCPyw2Zy7oJIQd1dQp9Gt6C61XbHATy
	95Q19hq9E/CFLtbkMbwpvGXc89jzzBV0X8qHDMVVLY4UENBXj8XhhBDMSviNt3YAWlHC4P
	k6yYdhY1XNFzGI/UCR2JIfZGYE5iOlpz+Ciq8PHGGw0JFeUISQ7dNGqDgi2iLw==
Date: Tue, 24 Jun 2025 07:57:05 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 3/8] net: ethtool: call .parse_request for
 SET handlers
Message-ID: <20250624075705.3f10676d@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
In-Reply-To: <20250623231720.3124717-4-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-4-kuba@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopedvrgdtvddqkeeggedtqdguudduhedqsggvtdguqdgtvggttddqrgdvrgduqdgstgeftgdqiedvvdgvrdhrvghvrdhsfhhrrdhnvghtpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguv
 ghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 23 Jun 2025 16:17:15 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> In preparation for using req_info to carry parameters between SET
> and NTF - call .parse_request during ethnl_default_set_doit().
> 
> The main question here is whether .parse_request is intended to be
> GET-specific. Originally the SET handling was delegated to each subcommand
> directly - ethnl_default_set_doit() and .set callbacks in ethnl_request_ops
> did not exist. Looking at existing users does not shed much light, all
> of the following subcommands use .parse_request but have no SET handler
> (and no NTF):
> 
>   net/ethtool/eeprom.c
>   net/ethtool/rss.c
>   net/ethtool/stats.c
>   net/ethtool/strset.c
>   net/ethtool/tsinfo.c
> 
> There's only one which does have a SET:
> 
>   net/ethtool/pause.c
> 
> where .parse_request handling is used to select which statistics to query.
> Not relevant for SET but also harmless.
> 
> Going back to RSS (which doesn't have SET today) .parse_request parses
> the rss_context ID. Using the req_info struct to pass the context ID
> from SET to NTF will be very useful.
> 
> Switch to ethnl_default_parse(), effectively adding the .parse_request
> for SET handlers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

