Return-Path: <netdev+bounces-200510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C4AE5C3C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9744D170A62
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C5239099;
	Tue, 24 Jun 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kyDCHbGP"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D42367B7
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744678; cv=none; b=ihMBGmT3K3rBiOpURRrClEDLziFGBIPJeax2c7gk8g3JSHQG3zIeLuOazyXAYttUE+aBqiRO3Mls/u0ibbQqvq7nwQSdk9Xbn6S02W4gTJJteGX7IkNFwnYgU1RQggaVx29JKltmm3vgRNKg5d6Bj3LOJENGPB4uS3SSw/+udwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744678; c=relaxed/simple;
	bh=kQkYDklmrOxAAMhFw4Gvw4Ot2AGcvtvcJ42a7YI9QYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jG+tV9VjUDRh5LBiI2P+UR3udKlKGkSF0z/qTkbRP4zLzKGdYDj1pvFUTa4edcvfKoKvN9NbdCpNKgzDs119WN2jr0g3kOXZJjnSZvoPGZa8e/6nWgdRc+lTn5mSKJwUyKIZhipZ7T4BHE4ovTIMOGv4wgWC8Iuppd1OS28Yplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kyDCHbGP; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21E5044A30;
	Tue, 24 Jun 2025 05:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750744674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZBf5zsyxWqDvGYWS+gF3boSpj2KcugLEq4eAbFz1sg=;
	b=kyDCHbGP2qAyC7CMwfNsKIgGa1yie75xIyZGH9U7RijbGXYX6NQOkOvjGtvc/5cdiMb0hC
	8dl88VHGjuLrYLQs/cgWAIe2O4yHGdxEnDKC0ipPuD6iEsnC8P9M7vWdMWNrhPqujWkn01
	sHMro9wO2uCthd9LqsaLG7Qk+9VHY1iFnr7ss8qsa8WGZcbhuymXegYKHya4uAJy+izJho
	t2eR93/ZOxSsbsiNl7//6TOYk8+lBCZrn/GVahAn5KAQ5KDMO/8Pzwd8hBiLMsNAU5WbOZ
	xtF00Wdthj2uJ8hDbwpESywndLVVK84ywrmeb7W70OLHOPV4C2Ti2r7my3+ykA==
Date: Tue, 24 Jun 2025 07:57:52 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: dynamically allocate full
 req size req
Message-ID: <20250624075752.36a19a9a@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
In-Reply-To: <20250623231720.3124717-3-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-3-kuba@kernel.org>
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

On Mon, 23 Jun 2025 16:17:14 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> In preparation for using req_info to carry parameters between
> SET and NTF allocate a full request info struct. Since the size
> depends on the subcommand we need to allocate it on the heap.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

