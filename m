Return-Path: <netdev+bounces-200506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DBCAE5C2F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F96E3A3277
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137F22D78A;
	Tue, 24 Jun 2025 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Klb5/qbL"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67F20EB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744529; cv=none; b=JujdMvEUNFok37KqXrlPKRsyf+5EJ9N7nvzwi3YBf6W9CO1SqilXrXAVhPHZESJHPIPER/9gyrDT+VGhb5aV7+FXso/e52sen7Uyg57GM7DljwNeRweTQPY9l2/jF07mcvU0t0ebAbykxTgzm2YL2DNDaiP28o+M+zsk8EPPreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744529; c=relaxed/simple;
	bh=wCW1hIHSJFsT1xGqSuFfFcm/RaE8vBCD86ahn2llPXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA9nmkqotxU2rT9rhNDE5+tNWCHJewHRC6ql3q+mtHRNQv5XWC3mCs58X8lZy9EXshfPB1uiLVsIYae0u20XOum9xknppSas8OARESBf/hI8FsRhak5ZUQy6gValllw+i5wOHopc4TDtYSebBKx6e1jPziQahsscpEhYQcoQbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Klb5/qbL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7562442A7;
	Tue, 24 Jun 2025 05:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750744519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m6p9p/D+28CbseP6Ovr8xGl5DuveoQZgWX4N3sDQIk=;
	b=Klb5/qbLnP8d2OhcnqiyHH79PvvgOlRAuS3z3Zu6eqnIabaTByNWGXFOUBC8qnonBt4vsR
	JRFT0VOXuwJVoP6KlKxWZRfkDo4m3RksQiEICLII32pmbZXtjTUWphU1EJTXxUHJz/yDZ7
	Y/F8i6yGuqvzOcteXA8Bgvp+VJQfstk1wnWlls1uZ5Xi+lJ1+lNd/A6fzlk+mtOVl5lvEU
	bYJ+QoPt/+uiIdd8yWPJDWaZAQNoQAhm8ykms/oagBvkQJa6bO6BgkF5zGwtOXlM8TS3rR
	xzCaRh6L8ZEwBNypiNHC8Xl+6hf0CnthW6MHyGrHB1nUSARHmDiM5PoS07jjcw==
Date: Tue, 24 Jun 2025 07:55:17 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 5/8] net: ethtool: copy req_info from SET to
 NTF
Message-ID: <20250624075517.209319f3@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
In-Reply-To: <20250623231720.3124717-6-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-6-kuba@kernel.org>
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

Hi Jakub,

On Mon, 23 Jun 2025 16:17:17 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Copy information parsed for SET with .req_parse to NTF handling
> and therefore the GET-equivalent that it ends up executing.
> This way if the SET was on a sub-object (like RSS context)
> the notification will also be appropriately scoped.
> 
> Also copy the phy_index, Maxime suggests this will help PLCA
> commands generate accurate notifications as well.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

It works perfectly for PLCA, now the notif is generated, and for the
right PHY :) thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

