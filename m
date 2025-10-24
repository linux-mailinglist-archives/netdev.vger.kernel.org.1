Return-Path: <netdev+bounces-232308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F9C0400E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10813B1A35
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0F18C933;
	Fri, 24 Oct 2025 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNtTK093"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D243757EA;
	Fri, 24 Oct 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268426; cv=none; b=YPt9pg64U6qxs7UTjEa7rXxkBbEP2K+4JFlRE23h7s77FfEiYv8nN3asuVxddEO1kph906v6xsIr6fwtSYoNLJu1/EKtdELeTNKP0UwKDP+gB3NjG1wYxwv63AqosOVJAe2JMQSUtmm/xI0CRF/ceSqHqlaNyi8WcN6tf/maHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268426; c=relaxed/simple;
	bh=E52/C2NI1v8LOeNlODaaZwoSzzKa4S3nQNDgy67egio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHrHOOzkJLmveeZANYODO2zTXICwZnTLMZz5AhTSp1Mdmu5nQnL+wmw63TQg3CwIsed1LBVXGxRvTlNWMJwp76nUGXyc8960LaJ1eOlKhfILX0ld96QlB4wyqAvZT1weYskFbdFF4xydePMl1mFz9N5Ao/i9ICkiII/tfxBif6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNtTK093; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47D5C4CEE7;
	Fri, 24 Oct 2025 01:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268425;
	bh=E52/C2NI1v8LOeNlODaaZwoSzzKa4S3nQNDgy67egio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NNtTK093imMpKanJSxAsIZmnS8ey1uab6wfwn+tI9uMTJlDmexMFDgg+gvV5Zd4nx
	 LnIoKrQTk/JWVlYy19tad6hDNIiipggQ4qMoENFfcPLLoDSPT1dTh6N78Nr/OhoDvB
	 tMfgm6k9kl85NsXHVaji+1rWne0+kSi7mskQXzf736FKGE9TwmGqoO540eqAM8hDKv
	 2ZFINyal8rmWZYmH4fNXrfEOzKsABIin9zEZi3CuBj1RyB4WBGNyNlWgNv5BS6KL2X
	 SgnU9uI1FQOKrI7rrdvOV/Gi097hwejFgosOVjTHKnBPVcdsMdeXBgJSCrWPM/B7He
	 tqJILxY+5TQNQ==
Date: Thu, 23 Oct 2025 18:13:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v7 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20251023181343.30e883a4@kernel.org>
In-Reply-To: <20251020103147.2626645-3-o.rempel@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
	<20251020103147.2626645-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 12:31:44 +0200 Oleksij Rempel wrote:
> +      -
> +        name: supported-caps
> +        type: nest
> +        nested-attributes: bitset
> +        enum: phy-mse-capability

This is read only, does it really have to be a bitset?
YNL will generate the string table automatically for user space to map
the bits to names. And we have to do a bunch of const_ilog2() and render
the MASK in the uAPI...

