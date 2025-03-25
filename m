Return-Path: <netdev+bounces-177617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1689A70BEF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4F189C84F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945692690C4;
	Tue, 25 Mar 2025 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb25Rr9J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA4268FFB;
	Tue, 25 Mar 2025 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937319; cv=none; b=ghDHt59sbpT1ZUtFIW00iBaSm4ju3alzYPjHFii0V6+A+aBWFpelwu+wdgHD/ZIDCHFadb/NhiYWtQxTrXypawX2z9DASdXHDyqdkl97MbDvhpmXiwxSsaUKeoT/DI2R67SBrAqvNu93Wb44S5UnjS21TxFuc3fv6IML+1qh6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937319; c=relaxed/simple;
	bh=mxt6JNXfJPXNlWUTHnpRW/oHvE3ekeq0oRQ0lYqYPBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU4Nqy39Q6nMDylhHAUldpLXC7V0fkWwORqXfdSmeavQJTMa+sg22qCNqMVYoG371wZzQN7PXDXFGJ2wpXKR0WteIXE1YqFB0+f3e5v19gAePS3TurqBBSIfRyNf9GdTj1DjdxnQzEVFHw2y2TTkzHWg1XcXjOaBSbqboqDWsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb25Rr9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B42AC4CEE4;
	Tue, 25 Mar 2025 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937317;
	bh=mxt6JNXfJPXNlWUTHnpRW/oHvE3ekeq0oRQ0lYqYPBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sb25Rr9JGnrPnbmxJYCYAEXS15QlDG83gDuR/Dw7yx0CFM5sgk3IHmrrLKeWsdr0E
	 9cxjJX1J512P+r4j8aAWCmNUA7OZNLdxj4tAMQIBzUV3U0zcQC+O27wcihRxngY9O3
	 17i921yxwU0CpmRHFrYaI8qSJ0zMmUQKWybWKq3Q56NCGlTfBx2e7TuD2liEVmu8Pq
	 2Sn/NFmXj0pY2vl7rvv9rGZRC3nu+bFPq0esdjL3/WhucdHEYzmUDygRgdCM6amQZY
	 ld97nWIilA9C/YhbpBq9Hl+hj1JQ8QI1EP1ObvoLov26eyND4KtSX1AsFISJ4hMFc/
	 LDVUz5UiyYvGg==
Date: Tue, 25 Mar 2025 14:15:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 2/8] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
Message-ID: <20250325141507.4a223b03@kernel.org>
In-Reply-To: <20250325122706.5287774d@kmaincent-XPS-13-7390>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-3-maxime.chevallier@bootlin.com>
	<20250325122706.5287774d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 12:27:06 +0100 Kory Maincent wrote:
> > @@ -636,10 +659,10 @@ static int ethnl_default_start(struct netlink_callback
> > *cb) }
> >  
> >  	ret = ethnl_default_parse(req_info, &info->info, ops, false);
> > -	if (req_info->dev) {
> > -		/* We ignore device specification in dump requests but as the
> > -		 * same parser as for non-dump (doit) requests is used, it
> > -		 * would take reference to the device if it finds one
> > +	if (req_info->dev && !ops->allow_pernetdev_dump) {
> > +		/* We ignore device specification in unfiltered dump requests
> > +		 * but as the same parser as for non-dump (doit) requests is
> > +		 * used, it would take reference to the device if it finds  
> 
> This means the dump will have a different behavior in case of filtered dump
> (allow_pernetdev_dump) or standard dump.
> The standard dump will drop the interface device so it will dump all interfaces
> even if one is specified.
> The filtered dump will dump only the specified interface. 
> Maybe it would be nice to have the same behavior for the dump for all the
> ethtool command.
> Even if this change modify the behavior of the dump for all the ethtool commands
> it won't be an issue as the filtered dump did not exist before, so I suppose it
> won't break anything. IMHO it is safer to do it now than later, if existing
> ethtool command adds support for filtered dump.
> We should find another way to know the parser is called from dump or doit.

Let's try. We can probably make required_dev attr of
ethnl_parse_header_dev_get() a three state one: require, allow, reject?

Part of the problem is that ethtool is not converted to split ops, so
do and dump share the same parsing policy. But that's too painful to
fix now, I think.
-- 
pw-bot: cr

