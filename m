Return-Path: <netdev+bounces-173638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190BAA5A4C9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DDA3A7A7A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4E1DE2B2;
	Mon, 10 Mar 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD3Afsbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B41D7E3E;
	Mon, 10 Mar 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638004; cv=none; b=H147gxjNmyyT30CcTf1FBBeEmMnR1O45YSbP1sigxqveToK0loSRwj2koaOdbOa+qXJj8RsvUNOfpOzCDofdLJTVftAsgJ2klnplBGgfcBFAspT1JvWPHuhND3x3Bdg7nDjjtl76QHzY+UkMnun27n8zStJ5QtD46cQZmXA7hQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638004; c=relaxed/simple;
	bh=7pdIPCEDL7BN32azht/Sc4BIMnIg+tKYUud4LmRAFpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEUb7HUdpYCMXnr44klKOcGaKHPvrb35RwDslpJnpG/YG/kAcggsyp/uqnFJ1OmpoHVBwdpACkIvlOiaiZm9qXZIBXGPN2I0I2jJ3XOw8UrLrfu4mqfyO2kHqSEhEyhbqfEdOvTxBCeX97pKZlGrIEXEeFCzUdPGJ0nKMEOEcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD3Afsbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6791EC4CEE5;
	Mon, 10 Mar 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638003;
	bh=7pdIPCEDL7BN32azht/Sc4BIMnIg+tKYUud4LmRAFpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dD3Afsbzr9HkwBdwSdxUtuPItd7FQl03EvBe/UfkXYHYfSuIlddJNMfGIKUQJeaPb
	 AxswXN7iZi8fSndhoOTaTbap4iN8lAKcJzqyMoaBKcGE/K0HdBQkmG7Fww6EwVUURX
	 miZABuqc5p8E3+mls/tO6TkjBCnqw/hZUWA0UVlGlJC+h+FVrcfdVt5vAeMwYQqP9Q
	 A18g7k/7rVE9Y6GH53gk0nzr+cOuH6ncYC9fztz4lWVcHCXSE1GjQy62IaB7lXII8M
	 KH3IhDKZSqtA3Mlp8t2YKnzTKUegSnpSyQI+CumbskLgr3qa9NRGhQJppWYY9kx3FT
	 mbV3bwTvEneaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF00380DBDB;
	Mon, 10 Mar 2025 20:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: tsinfo: Fix dump command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163803723.3681464.5219456681589472906.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:20:37 +0000
References: <20250307091255.463559-1-kory.maincent@bootlin.com>
In-Reply-To: <20250307091255.463559-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vadim.fedorenko@linux.dev, thomas.petazzoni@bootlin.com, andrew@lunn.ch,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 10:12:55 +0100 you wrote:
> Fix missing initialization of ts_info->phc_index in the dump command,
> which could cause a netdev interface to incorrectly display a PTP provider
> at index 0 instead of "none".
> Fix it by initializing the phc_index to -1.
> 
> In the same time, restore missing initialization of ts_info.cmd for the
> IOCTL case, as it was before the transition from ethnl_default_dumpit to
> custom ethnl_tsinfo_dumpit.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: tsinfo: Fix dump command
    https://git.kernel.org/netdev/net/c/d0a4a1b36d7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



