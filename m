Return-Path: <netdev+bounces-184510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18672A960BB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640563A944C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02172459D6;
	Tue, 22 Apr 2025 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QWymn49K"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645222A810;
	Tue, 22 Apr 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309708; cv=none; b=BHm99lCvMrSXCco2y9DiDStqpbKV2JY8PtFvccl+jYVCELntz/pMtj3V04nP23bm+mJfMaJlT+09uhJeaphpO9bcI7r2UHiRUaccnBODtZLK6SFKipCE6YLiSLy+AGpLizPUC1MKdstc1QRzf9kmFiQ6Kfc/mFMmIz3e/QWPimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309708; c=relaxed/simple;
	bh=6qKhc97FmMMiYVDr+AJ/b3IdpejTYJoI7n+6lv9WR9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcyQqGeo2agd5/4bRD/hVuWgjAx5SgptBkV2vdUz/X+bjsxeDDdBfkD5cP62Sdfj48Lv2vEgv5btzxvdq5aOr/5oRD3Tl5G4X4LDUAlJ7jJ9T7xtfv63O6sqsy7wX4d65j3L6JzH9xsli8GnS068fwAn7IHHL93/458B4M1ivg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QWymn49K; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55C12433E9;
	Tue, 22 Apr 2025 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745309698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Yc3gxdqIsXJ4Gx8X3W1BH3QJGXuUB7NOO+sXP8fB8=;
	b=QWymn49KdvYDh6+sPzLRT4QYTHv80yADrH5wD0rMIGKrwe651VHrstMQrYkrw8YIe/79n0
	zfq7wiNiU/UGIVAa1DHc0efElMoQJkhQXkAnclz4PCUDSMNDidpRAdEodV3NmZ+8vamlSF
	ohJ3m+d4J8t2rYkOgazEGVJEX8/MDVV/IQpfCpot2n6juZs1yreU6tF13fNWDmsAIcVOYb
	Dxk4yylze28tw8G/i0O2I93f0/k+2kCyet+xK0TvvJUFirN0cBb9d/rrzq2qCJg0LVf7wZ
	oPeFmhHfjHFcBPc/qy9QuUA5jQxUJFjZwrWO+kfki8x/C6uGuOKZsYaoNHE+1w==
Date: Tue, 22 Apr 2025 10:14:55 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: dmurphy@ti.com, andrew@lunn.ch, davem@davemloft.net,
 f.fainelli@gmail.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, michael@walle.cc,
 netdev@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net] net: dp83822: Fix OF_MDIO config check
Message-ID: <20250422101455.08c8883c@device-24.home>
In-Reply-To: <20250422063638.3091321-1-johannes.schneider@leica-geosystems.com>
References: <20250422063638.3091321-1-johannes.schneider@leica-geosystems.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtiedphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhnvghiuggvrheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhmpdhrtghpthhtohepughmuhhrphhhhiesthhirdgtohhmpdhrtghpthhtoheprghnu
 ghrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Johannes,

On Tue, 22 Apr 2025 08:36:38 +0200
Johannes Schneider <johannes.schneider@leica-geosystems.com> wrote:

> When CONFIG_OF_MDIO is set to be a module the code block is not
> compiled. Use the IS_ENABLED macro that checks for both built in as
> well as module.
> 
> Fixes: 5dc39fd ("net: phy: DP83822: Add ability to advertise Fiber connection")
> Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
> ---

The patch looks correct, but doesn't apply. Have you correctly rebased
it on the latest net tree ?

Thanks,

Maxime

