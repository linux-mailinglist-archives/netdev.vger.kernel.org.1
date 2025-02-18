Return-Path: <netdev+bounces-167312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912CFA39B9F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF67A48AE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5023ED64;
	Tue, 18 Feb 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="iqftALd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC022CBFA;
	Tue, 18 Feb 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.31.204.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880104; cv=none; b=RlpwaaM0nW8N8yrYU067/7hGfxfEXn4cARcXxisxhkn4NK3+2c7emMDziiha4aCnlujlfIpV5sIb1E4taGTZWz8hcVv4sg/B2muq2tZCv+8qobQAWOOOXobKeQIxPIksUH/1s2/Jw5twtMfJaxhMR/GpCUd8ZjVPd1X9QoVR4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880104; c=relaxed/simple;
	bh=hKlrLxA+CguCamDBIz14d2zPrVm7fMm2y9yXrp8LrAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejx5tGwwpt3POgP9fGxQHLrpPGKTEEbBIAZpDFAr4HlWp2FC0L/5EiyxmWVikrE7CvxHilUo4SaGP22c56s4283AlTUen2rDlVkpC+0KqEuge2Yr1joT2VgbCiJ/VShFzr6EhELwJv+Ii5ixx1HY+XHVg9SbQNIcXK4l0m19mSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz; spf=pass smtp.mailfrom=nic.cz; dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b=iqftALd6; arc=none smtp.client-ip=217.31.204.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from solitude (unknown [172.20.6.77])
	by mail.nic.cz (Postfix) with ESMTPS id 404551C05D1;
	Tue, 18 Feb 2025 12:54:29 +0100 (CET)
Authentication-Results: mail.nic.cz;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
	t=1739879669; bh=hKlrLxA+CguCamDBIz14d2zPrVm7fMm2y9yXrp8LrAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Reply-To:
	 Subject:To:Cc;
	b=iqftALd6mdGOePNYj/Riu+fiSTIQd2zVfVBSg1KFHkr9ttJrhv6494kIX4QTBSIjs
	 bsKCgPqM7EMMRkpkI3Bw0h6gR1153NCjcp9HSVKIgZFAPlnskIGwpPhj+v6SkKHW2L
	 biJ9Fme7iR5P2giQrWghMIdCxJ1ss+SGL5SXoEIU=
Date: Tue, 18 Feb 2025 12:54:29 +0100
From: Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Message-ID: <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 404551C05D1
X-Spamd-Result: default: False [-0.10 / 16.00];
	MIME_GOOD(-0.10)[text/plain];
	WHITELISTED_IP(0.00)[172.20.6.77];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	FREEMAIL_TO(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Rspamd-Server: mail

> +#define MDIO_MMD_AN_MV_STAT				32769

Why the hell are register addresses in this driver in decimal?

