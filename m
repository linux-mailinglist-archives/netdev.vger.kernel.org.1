Return-Path: <netdev+bounces-184760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9C5A97192
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2884F17F676
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA528FFCF;
	Tue, 22 Apr 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gr4x62qV"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E0283C8D;
	Tue, 22 Apr 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336991; cv=none; b=O1mZfputBR1IV+meNMBo8+auzz3kcRNZGNbJq48+6CvXKR0M9A7MDHOAKGbmW1E80uzy6pS+xOpg6hUZcrXQTOj1hUY9Ro3mbUdIs9cZenRsLLVdm6jnzV9k9argwZYKHneHn3dg2wwoMtspl1IFqvwUQhpSkT/VX2Kr7HuITrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336991; c=relaxed/simple;
	bh=RVXgkiRxKfMs3u9+YyC/xVKrAOVb5kTrbP3f1okq8e8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0BcDVRcQ/kXFK/KgWhIcc1XodHz0f8lR/uiAFHWGhj6/oXgYGahtQ1/uNBnhgBtOHkkKen4wfTMEORhguDQZldlMCPMW9jL9PvdlbWJVDwj/Xmvac4Av3doGvAGyD8a4mPhUtwd/O4TuXvKAtK3Vt5PJ6gqn0g9RqQsZHsCUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gr4x62qV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 645A943B46;
	Tue, 22 Apr 2025 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745336979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh3TOfjfjJtUvON3fbrchsnqfDrRlyCdWG8ags+8rQM=;
	b=Gr4x62qVWVJAZOqxoX06AnZysciGvSzFdSjOhSqxWDVbTqMV3wEPeM8pJOQb/10fNgs+si
	0W7YhwBA4ilB5Sf0PRqfH9opH8lhnhU6wWYmn2qhGX/6tF0cGySV0BVYC4CVSULmXeiU6X
	gIDGrw3ckqcCGZdlz08ChE5MRZkKGI3mpziwQvDZaQuXOl1fzQ3i/Yb1OVSlRxMxuvb9sp
	vyQAyeSpZHSeJ7SndnFO7nQ06vCF3H+Xe3NSRPvmSE35nq1G3gtbQnEcWMdBAjmFOf8zUl
	31ad9KcVgBAAppNYiHbTaJxPx48CMed1UcF9jPVYLKVvPQiE4rcXJublK+/SUA==
Date: Tue, 22 Apr 2025 17:49:34 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexis Lothore <alexis.lothore@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Daniel Machon <daniel.machon@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH net 1/2] net: stmmac: fix dwmac1000 ptp timestamp status
 offset
Message-ID: <20250422174934.309a1309@fedora.home>
In-Reply-To: <20250422-stmmac_ts-v1-1-b59c9f406041@bootlin.com>
References: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
	<20250422-stmmac_ts-v1-1-b59c9f406041@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghml
 hhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Alexis,

On Tue, 22 Apr 2025 17:07:22 +0200
Alexis Lothore <alexis.lothore@bootlin.com> wrote:

> When a PTP interrupt occurs, the driver accesses the wrong offset to
> learn about the number of available snapshots in the FIFO for dwmac1000:
> it should be accessing bits 29..25, while it is currently reading bits
> 19..16 (those are bits about the auxiliary triggers which have generated
> the timestamps). As a consequence, it does not compute correctly the
> number of available snapshots, and so possibly do not generate the
> corresponding clock events if the bogus value ends up being 0.
> 
> Fix clock events generation by reading the correct bits in the timestamp
> register for dwmac1000.
> 
> Fixes: 19b93bbb20eb ("net: stmmac: Introduce dwmac1000 timestamping operations")

Looks like the commit hash is wrong, should be :

477c3e1f6363 ("net: stmmac: Introduce dwmac1000 timestamping operations")

Other than that I agree with the change, these offset are the right
ones, thanks...

With the Fixes tag fixed,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


