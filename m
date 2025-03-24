Return-Path: <netdev+bounces-177212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4428A6E4A8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0E51888DD1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DC91C7015;
	Mon, 24 Mar 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZO97QPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD917E0
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849398; cv=none; b=FblRN6V5tepyOQP9tqiAJcQK9Sty7MXHBMn3jF2cZD5j7x7KtVF34A3/2zVpcn2f1+za5PVta1M/0J/3YJ7c+iO+ZgWxN/23q+WijIzF1VWuw/Myn+fiNcgV/90M4vL/n21Mj21fS4UXoaXZL7HHZcMwJXGEtXnECn85YI51o3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849398; c=relaxed/simple;
	bh=PfIHtCFUgLSL2au88KrHRC71LoBugtEQqrPlFGwxQNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f0hSQxMuk5GGw0fMg7k8dJqEJE7JlQN18BSN7zJENEa64x1A8L8ug7BBQpjt96Rxyx/Qkjruhgkc1T4HKurTME4HmZXhOgXzsMKtntCAh4aU8Kzj4ZOVwsiYjMPsyPR9hNeDskfMQj6Rr8fWH3GcGdOmFTdX8Kr6pryE6p/ZVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZO97QPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4831EC4CEDD;
	Mon, 24 Mar 2025 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849398;
	bh=PfIHtCFUgLSL2au88KrHRC71LoBugtEQqrPlFGwxQNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZO97QPDSrQrbrMAUREU3SZg7Zx4UbcDnpaLElm4U28CWhs7I2ZIRCynKSHESZTrp
	 Hm2ysghSyw2mvgiAK3R11a3QDlcUFTbMzRFj51sCZxT0vaO2ZKUDHhR1ySB5L9JAvw
	 p78sxLjHCVTa3GRIL1BX+KbMTPaxEy/t0sgIKFNS0CxwGTChM8Mcynk72ygGx3sIQW
	 /+yAqfjyJnsgCUQMs3VK5vP/pDkp6udcYgHWGzC4euL3tk2DVtaesY2pvnJmpl63LE
	 DJNO4Cu2mDgpRLqHV53Bho2TwbwvwEButsUtrZeezxncWXCLjCgOC3G9yhOIZ4YpWw
	 nS6hyd1bGsJgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF6AF380664D;
	Mon, 24 Mar 2025 20:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284943451.4167801.16577812605509314831.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 20:50:34 +0000
References: <20250319124508.3979818-1-maxim@isovalent.com>
In-Reply-To: <20250319124508.3979818-1-maxim@isovalent.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 maxim@isovalent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 14:45:08 +0200 you wrote:
> There commands can be used to add an RSS context and steer some traffic
> into it:
> 
>     # ethtool -X eth0 context new
>     New RSS context is 1
>     # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
>     Added rule with ID 1023
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context
    https://git.kernel.org/netdev/net/c/3865bec60683

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



