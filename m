Return-Path: <netdev+bounces-170081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11191A47393
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F021891C63
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B41C07DA;
	Thu, 27 Feb 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKJFGeRT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520981BEF8C;
	Thu, 27 Feb 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627001; cv=none; b=OCL1eo/GnpLmtnwt5cwsXsie6Qa7ygDCdu4AGzu6c79tTsVIff8am76jIPHOvtvOPf9Hb8mGE6YM5aQpqlj1RCgCblwm5uBf2kwi0GXKGWRMwsOBRKthDVhJiI/R378kXUAg9uYevPWGyDKMh1rXEhsOnbmhCDS+dkEevZbNk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627001; c=relaxed/simple;
	bh=rNLQQs78vkxLecrCQFCDf/lI6r4LDtrYABhN0YIVP/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HKK1UAjPXGCSjBXkY2Gtg5n7keKvcAFrcbKSRdHN/SNhYXvVNtn/0oQksxSI7Fbw85KBZwwCHbbfkx8tK1tLtxR9lkRC1Fs6/R0/NMKHjyRefWJJmUvFeDV9I7wDdg9cyrgt1+gmzlppBYFOsJ/4p/hAXxghGkF8Hsikrs/k10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKJFGeRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A79C4CEEA;
	Thu, 27 Feb 2025 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740627000;
	bh=rNLQQs78vkxLecrCQFCDf/lI6r4LDtrYABhN0YIVP/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qKJFGeRTQ3/7AdTyNLJli/WTLreMANtJ3rkU7dlHLopOGVhArUvBaYEy+RRq135JU
	 ZNSMaj/FEs7r7LSj49Pfodcr/MoWYudbbveYDiU3orek5W4j3yDJSj0D1PM8Mzr6sZ
	 1kYWvZGmO0veeOaYPIQlNJ8fXC3yFjLtOiN/ixJ0hNetF7lPwKSEGFil1uhboHhz7K
	 YpqzpY8re4vosEd949p/IAnnlEipkw8LauZHlIrmDyzPXDc3hxHSenAgsI7PI2OuNc
	 dvUe2vP8CtJFHyD2jJVElNxmA4yjQSNkU1HlbWZUAVq2DxSnXrDE67w7OMUbyksnEW
	 EAkD5fs60NmKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE41380CFE6;
	Thu, 27 Feb 2025 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mvpp2: cls: Fixed Non IP flow,
 with vlan tag flow defination.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062703248.955127.11312136420699699756.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:30:32 +0000
References: <20250225042058.2643838-1-hchaudhari@marvell.com>
In-Reply-To: <20250225042058.2643838-1-hchaudhari@marvell.com>
To: Harshal Chaudhari <hchaudhari@marvell.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 20:20:58 -0800 you wrote:
> Non IP flow, with vlan tag not working as expected while
> running below command for vlan-priority. fixed that.
> 
> ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0
> 
> Fixes: 1274daede3ef ("net: mvpp2: cls: Add steering based on vlan Id and priority.")
> Signed-off-by: Harshal Chaudhari <hchaudhari@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.
    https://git.kernel.org/netdev/net/c/2d253726ff71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



