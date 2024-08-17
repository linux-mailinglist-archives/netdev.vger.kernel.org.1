Return-Path: <netdev+bounces-119356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEC9554E6
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3CC1F22BC5
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15585FC08;
	Sat, 17 Aug 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tumVJB2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD48881E;
	Sat, 17 Aug 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861831; cv=none; b=PEPi9Nmmm+2pfY2PmX6KUOf8K2BpfePYuSl9ouJeUKr0IFhjnf0+oYDX+RCLnpbOPvUfY4SCcIUBMr7UraIv1Q3o+XsJvbUm/niWztptnQ6uSCdhGlO2gy5wDKuJ7LxDnyiR7F6CCNko+P89lvB31Q+W+qAwFFOiuBNDhjskbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861831; c=relaxed/simple;
	bh=Ftr/WkK+7t0BB13BzYcLEZwoZrRykENt4HY58CE1yHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4KLS+QPG/XdYiBsyUXMnM/MxU7/Cw94Ukz8KB9l317ADGvjTKyhAZw/l6w+236/DV3T08Z0IcYWV96eT9+4wUAEnBo9HhQ/hc/cZUCqZWtmHgbCxeTdqRGfHtXvM9JZpujiOZ77JKyWv5FSXEww23WbTqzvYmpDRFniqqYp8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tumVJB2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68202C4AF0E;
	Sat, 17 Aug 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723861830;
	bh=Ftr/WkK+7t0BB13BzYcLEZwoZrRykENt4HY58CE1yHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tumVJB2HV5eU76+uXFQ7AfUWeLorrS5ALFLAUn59qC/he3sJGIhNJL0iFN5dHgxa5
	 NQ3YiBwS2NUj9pjA60ycW8eKuSsmB+7ZMJgIBVw3WT4NCJs1ElC3qRJZm6CDEw0dOy
	 A1V6A5DDiebCUH0BrQVbuEaiiS+ue/NfzL0/aXn1MMboUEw2kCb75JEyW+cGYvfYHI
	 hSAd1GV/S0vBZz4ns/TmRQpwUFsNwAynLH0/8zKzOvpkp551Cx6BdmBs1Zm67f2Bt0
	 SNC2KPkoRDUW5yzNrVDjL5omHGF4mUSuhlqTSsyL78Z0o3wMqXv/W2tcmuH7eHkPJI
	 WjrWqWuW+hUxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECD38231F8;
	Sat, 17 Aug 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-09-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172386182976.3680864.4507469326812326397.git-patchwork-notify@kernel.org>
Date: Sat, 17 Aug 2024 02:30:29 +0000
References: <20240815171950.1082068-1-luiz.dentz@gmail.com>
In-Reply-To: <20240815171950.1082068-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 13:19:50 -0400 you wrote:
> The following changes since commit 9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b:
> 
>   Merge tag 'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-08-15 13:25:06 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-15
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-09-15
    https://git.kernel.org/netdev/net/c/2d7423040b7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



