Return-Path: <netdev+bounces-122036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BB95FA2B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0FFB209A3
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9123419922D;
	Mon, 26 Aug 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMuIhv1n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E28132121;
	Mon, 26 Aug 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702241; cv=none; b=C0VYHZ822A9kWSdlx7NsE39vjrXz7fErq+54kxWyDkoJW1vq3DumKhogQ/aV4xj3+rvsWn673Hu0O2qwHndcME9ip9x8SDBq3pS4eqqCO7zIgxziBiHWQIuglO5LTFGVTMiFjhc5WhzT//rwyrWBERcXlr6JHuwzeOBES7VFta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702241; c=relaxed/simple;
	bh=lqw1Pdc56XCjlWL8Y+N8SpMjt3GZMmy7HOOFiGFlodM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYcI3m+77aBG0kKCGr4CXj/WIBnTaIS+9JRj4IE/tQz+0GLJAmltUHkgu8+d5AAnK2vD4x4DTADwnc/5RvQrSqc1okBZDu/PUiZ0Ll9HushX0jjWjFIqN0iKDsjs15Lq/jZU1C9EENv5Bw3JkH/LLu58c/mFYPZL7dAlevyIwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMuIhv1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A26EC4FE81;
	Mon, 26 Aug 2024 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702240;
	bh=lqw1Pdc56XCjlWL8Y+N8SpMjt3GZMmy7HOOFiGFlodM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UMuIhv1nFK3X2YPFDbfqFPeHwLA91oFMzyN1ZQkKM040G1aGAUxeE1OnQjuTbtcOx
	 k5eX0cz6fmq62YCz5W0cZtF+ktuFPadvMi0pxaP2oSzRTCPpOfQ5d9O+9U5Q6yjnvU
	 tYR2BEDHQ6msGejRzSNrG73HgUO8bxHIU2Jn0CUrDxogxVaKY4bSxXpTEUUdbF9c6W
	 ngZx+zoZAVQ+Kso+Q480vx8yl6UaJNKhAEZjAERNw3YVT6wT4QAah+jGHFp8HdNPvM
	 0fjs7qkKUbfQkJqTkcndpse+7geb11hZkYuslmVqFA1169Q9olMzkKZYR0O1L9+Jcs
	 pW/gRS2EDJOAQ==
Date: Mon, 26 Aug 2024 12:57:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <20240826125719.35f0337c@kernel.org>
In-Reply-To: <4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
	<20240822115939.1387015-2-o.rempel@pengutronix.de>
	<20240826093217.3e076b5c@kernel.org>
	<4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 19:12:52 +0200 Andrew Lunn wrote:
> > If these are defined by a standard why not report them as structured
> > data? Like we report ethtool_eth_mac_stats, ethtool_eth_ctrl_stats,
> > ethtool_rmon_stats etc.?  
> 
> We could do, but we have no infrastructure for this at the
> moment. These are PHY statistics, not MAC statistics.
> We don't have all the ethool_op infrastructure, etc.

This appears to not be a concern when calling phy_ops->get_sset_count()
You know this code better than me, but I can't think of any big 'infra'
that we'd need. ethtool code can just call phy_ops, the rest is likely
a repeat of the "MAC"/ethtool_ops stats.

> We also need to think about which PHY do we want the statics from,
> the bootlin code for multiple PHYs etc.

True, that said I'd rather we added a new group for the well-defined
PHY stats without supporting multi-PHY, than let the additional
considerations prevent us from making progress. ioctl stats are
strictly worse.

I'm sorry to pick on this particular series, but the structured ethtool
stats have been around for 3 years. Feels like it's time to fill the
gaps on the PHY side.

