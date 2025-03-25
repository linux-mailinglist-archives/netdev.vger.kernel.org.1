Return-Path: <netdev+bounces-177619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC70A70C00
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414213A61F8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D17E19ABD8;
	Tue, 25 Mar 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r78TeF09"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A818A6A8;
	Tue, 25 Mar 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937733; cv=none; b=trHwLYaE/tM8cPShFU8qDpAXDQBoeZ22aC5sAetiBPF0OgeQOmMLMezwepr+4qHAG7YPMmgtquZ0R9xW9YOXTbjXTxfwYdOa9DxdcurHOAMkOBVwxhioAouMEJKdkzXTRf+/hj2xvu5USR6kPeSzJlorOglyzV+c0XV1naH7m9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937733; c=relaxed/simple;
	bh=c7bhxmiwXTsK4cxlbwFhMkEbn6MrnoZl0Hxv+hso6bU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYx5v9a5i/djhEOVEiau+ylGU9GSUL9baZQ6vdo6Dr3917eyeKQS4UJ2kGXJ1qIcAFgqdqDEDao8p46F9BOqDtcv9wlVNw6givPf5oSiUO2YroUI22IqDPXysQGks6a6KAVVoXVOkVBZQF5fQSMPexGpym4BaCIqHqGDvUBmf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r78TeF09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D76FC4CEE4;
	Tue, 25 Mar 2025 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937732;
	bh=c7bhxmiwXTsK4cxlbwFhMkEbn6MrnoZl0Hxv+hso6bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r78TeF097LQaPGwKesLNMeYFakDCa727pWyXOQHaAiBwVDuIUNgYsTGclWrfABpvV
	 qtBXg/Cj6ueJu8AGn5AEBX/XXZksPMrUsbvVtMxMsmZjPhBjLo555unvDQSEs8gjLM
	 WDDt9BimEdQVkvJgVpf4/fu0GDIqw/53HK1CeiFn9sVcW6IpVjB5ADfQZn1wzFgr8x
	 nEVZkB5FW3boRYZvkyDR/wP4h9prrJaGFOITUCwrYcdGyt7n1Q1a14f6Ld9AyaJLCh
	 fijJNsaad6g9ICDvTBvWVoocj+GhIJ/nHItVrA1jter8dvPQTdgvSmZi3yLTDqq2kH
	 esJ824B8yJe1w==
Date: Tue, 25 Mar 2025 14:22:02 -0700
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
Message-ID: <20250325142202.61d2d4b3@kernel.org>
In-Reply-To: <20250325141507.4a223b03@kernel.org>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-3-maxime.chevallier@bootlin.com>
	<20250325122706.5287774d@kmaincent-XPS-13-7390>
	<20250325141507.4a223b03@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 14:15:07 -0700 Jakub Kicinski wrote:
> > This means the dump will have a different behavior in case of filtered dump
> > (allow_pernetdev_dump) or standard dump.
> > The standard dump will drop the interface device so it will dump all interfaces
> > even if one is specified.
> > The filtered dump will dump only the specified interface. 
> > Maybe it would be nice to have the same behavior for the dump for all the
> > ethtool command.
> > Even if this change modify the behavior of the dump for all the ethtool commands
> > it won't be an issue as the filtered dump did not exist before, so I suppose it
> > won't break anything. IMHO it is safer to do it now than later, if existing
> > ethtool command adds support for filtered dump.
> > We should find another way to know the parser is called from dump or doit.  
> 
> Let's try. We can probably make required_dev attr of
> ethnl_parse_header_dev_get() a three state one: require, allow, reject?

Ah, don't think this is going to work. You're not converting all 
the dumps, just the PHY ones. It's fine either way, then.

