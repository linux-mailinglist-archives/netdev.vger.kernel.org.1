Return-Path: <netdev+bounces-181866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D6A86A95
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 05:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE471B62BBA
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C61519A7;
	Sat, 12 Apr 2025 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAB6+7iP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626417C77;
	Sat, 12 Apr 2025 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744428597; cv=none; b=mAdpzG3NfgUX9/tdk6uU/8I9RrJIN4wph+b1CGWDZot4xrxmobLEf/qQE9tEaOaSM4cgU0Xo/zHhpcgMg71UVAZSAbXB/zBgTekevdgT6M2U1TPuQpUz6cwUexV5OGW/Vp6m85VErX41wU7xx8vkO1n3B3aofacFkwBcHBYaEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744428597; c=relaxed/simple;
	bh=pweT6ltWRsseEDmmoRfiCu2vyWuNcsgCnC3AaQynjGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SzAgXM8P8qA1WUR/ltETNW0QU1d3UxobA0XGjvfte9HLRyMMcSwqAy520BKUViylS2bi7U1BB4e5Q0MsfMxdq1RigVwdGS3DQarZCZKEBl1h2G89Yh2p8w0yzGPpijyF8Ejr2QKtfbGsJYZHUvt85d97ojmIBaG8PhJ4pfOVqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAB6+7iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC4C4CEE2;
	Sat, 12 Apr 2025 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744428597;
	bh=pweT6ltWRsseEDmmoRfiCu2vyWuNcsgCnC3AaQynjGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aAB6+7iPBIF1WkmNQaruhOOMgtsamNQy+zbykzwg4+lsXfZEj5/0nP0CRrBcZQ9NH
	 dd2GB3Xv0rmd7v8wOZOwlQkVwLgxW/JeGOio/5JwtfQCIg5UG87+BSBe3yC863E0DO
	 4xIaMvoY/QrC/1NBCKWTck4DKH4CcKA0cEouNwGE+mO3XbRIWRdWtU0Nq1g8PC8fKU
	 XP8ND8bXne/cQo4dI3ny2hsNFZ08yVk20GJMTJA4Lgp7SjkjAYMUYwrGW7022+dXHr
	 G1oXOBGK4RLT5skJzp0zCUvX0vJD65b+tJfxLiX+lBSCndtRpnelUfItf9jUCBzErQ
	 pGbf+RFX0XfQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6538111DD;
	Sat, 12 Apr 2025 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/7] There are some bugfix for hibmcge driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442863476.564205.11279218267618602672.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 03:30:34 +0000
References: <20250410021327.590362-1-shaojijie@huawei.com>
In-Reply-To: <20250410021327.590362-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 10:13:20 +0800 you wrote:
> There are some bugfix for hibmcge driver
> 
> ---
> ChangeLog:
> v2 -> v3:
>   - Add more details in commit log for patch6, suggested by Jakub.
>   v2: https://lore.kernel.org/all/20250403135311.545633-7-shaojijie@huawei.com/
> v1 -> v2:
>   - Add more details in commit log for patch1, suggested by Simon Horman.
>   v1: https://lore.kernel.org/all/20250402133905.895421-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [net,v3,1/7] net: hibmcge: fix incorrect pause frame statistics issue
    https://git.kernel.org/netdev/net/c/5b04080cd602
  - [net,v3,2/7] net: hibmcge: fix incorrect multicast filtering issue
    https://git.kernel.org/netdev/net/c/9afaaa54e3eb
  - [net,v3,3/7] net: hibmcge: fix the share of irq statistics among different network ports issue
    https://git.kernel.org/netdev/net/c/4ad3df755a96
  - [net,v3,4/7] net: hibmcge: fix wrong mtu log issue
    https://git.kernel.org/netdev/net/c/4e4ac53335de
  - [net,v3,5/7] net: hibmcge: fix the incorrect np_link fail state issue.
    https://git.kernel.org/netdev/net/c/1d6c3e06232e
  - [net,v3,6/7] net: hibmcge: fix not restore rx pause mac addr after reset issue
    https://git.kernel.org/netdev/net/c/ae6c1dce3244
  - [net,v3,7/7] net: hibmcge: fix multiple phy_stop() issue
    https://git.kernel.org/netdev/net/c/e1d0b52d87ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



