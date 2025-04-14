Return-Path: <netdev+bounces-182230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE064A88467
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2A818950F6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48127B4F8;
	Mon, 14 Apr 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EODCCOIm"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168127B4F0
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638250; cv=none; b=uEV7A+/m8KEheFIxyR61Zjuysab+hOooc6hDdFUrupS4etiqqe8Z9acOUPFe5thDpdaR1UDcQM91VCg5JJCEQq3wZBYp3NU+qE7Y/sQ+ewl3DAan8sk8xMaGawKMl5DEvFlfPHt4JfgG0uDHTM2sSPk62UEvW+r6TQeb7j3kM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638250; c=relaxed/simple;
	bh=fmi7flxlGHpvF4HSkQqrqNLSomJ0qJnIgw5w4V6dOUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWOUBTzfgc0PTl6E36qk9FMbEvCayr96EaYno/UQ/+eTczOQ58+ryfZ6Syv6typpVORav7FOE8b7LT088FgugvlBmDJHiVh6xzf32C1WHV0Y3NYe62D19RID4/YUPSzLRri4HK7aLTR2+pzgAQcbFKe1SZQS5BI3bM89S8dcOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EODCCOIm; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E7634385F;
	Mon, 14 Apr 2025 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744638245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmi7flxlGHpvF4HSkQqrqNLSomJ0qJnIgw5w4V6dOUI=;
	b=EODCCOImDJZJOCuCcz84zOFvtZMDxT4NZa9TkcGXku1evj31hS+THtNKRgd9yoakJGrz7U
	ydr24cRWnnXmHHgbpwKTV0CaGQ8yeT2LmSTNJ9VQpz9U70sYiEVWtnzZqb9GESO+g/Q8vp
	coexTfA6xmvzuj6cH1klbv5oQO+3eOc+tzPxWpKgGviZUHIQ0E8A8ZEAbcYZOSYhLhUhix
	LmlQ646pPSACpeTG+77yImfHqthGpVNj66tH90x9J+lXZk8L6MtK8fYjIVEbklGuFdmJ5b
	29dXRe3yD2OruLnXq67eGUYgBz+pmd82LLMZrt17cqxndSPOl/wXGbTzxm7Prw==
Date: Mon, 14 Apr 2025 15:44:04 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/2] ixgbe: add link_down_events statistic
Message-ID: <20250414154404.1c25ae91@kmaincent-XPS-13-7390>
In-Reply-To: <20250414130007.366132-7-martyna.szapar-mudlaw@linux.intel.com>
References: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
	<20250414130007.366132-7-martyna.szapar-mudlaw@linux.intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehmrghrthihnhgrrdhsiigrphgrrhdqmhhuughlrgifsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhishhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 14 Apr 2025 15:00:11 +0200
Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> wrote:

> Introduce a link_down_events counter to the ixgbe driver, incremented
> each time the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
>=20
> The value is exposed via ethtool's get_link_ext_stats() interface.
>=20
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.c=
om>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

