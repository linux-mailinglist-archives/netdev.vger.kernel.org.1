Return-Path: <netdev+bounces-176489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13CA6A882
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171357AA1CF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9451F221F00;
	Thu, 20 Mar 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqJiC4Ew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B81DF25C;
	Thu, 20 Mar 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480997; cv=none; b=bdo06X7sAJ6D15th98E9bQWApaIN9RHP20P9/kU7vJUUCniYhaW154B7WSxDBNz0kbFA5UHSHIICt48Udru+3LpDPrIotMmE4g91BoVVcJYjTL01w/nZbUDDEMoylNOoyImMM7D8GJRq41YfvNNQU2vFHzQg5FT7lL1K/0pjXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480997; c=relaxed/simple;
	bh=Ti/nPNcHhUjjxe5r91mKPGB6E8jYIDBSN+HrP1EABkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oSKOU1n2JfFxnDLmFComjkK9J5TKZF357SGpmImlQ2WqQJ8+xVk9dbfkO+j49eExvYyhytN4PCn5zmo3nQOj74ev5ex5MqQLtrtcBgcqmN6hdPQaIfKkX4z55atBTvETi9QvMJKAm3+S6kx1TmMN0GLitUSh14Et+52oglRZ2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqJiC4Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FE2C4CEE3;
	Thu, 20 Mar 2025 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480996;
	bh=Ti/nPNcHhUjjxe5r91mKPGB6E8jYIDBSN+HrP1EABkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AqJiC4EwKencGEq6GzmQtxiqnjXghHaBmq5FA/iPfVtSg7mYPlV9BjfAYsC4a95wv
	 Lje5oHDwx/NmTLIasLiGqHfPb+7KSRwPNzmqCdk++nF//8QMCXQk2Qacu3tqKI0Tqk
	 mc8WNnHzxhAOV2TZPbkr8yzH1ltAaji9IT9MWJlVwGsWQTRNV6HTx3SDrSRF3JexOW
	 80fz+wkar++Cr/GLnevV4PhfOdHboRP2b+XRbqntX8ZkZmfYgZWCXg5CnKh13jYLC1
	 r/dTEBiW3IGjVjiJa0gBdc9OshICecFOj4im9SBJWUR1hZaw/nCv749ruhSH9uVibD
	 yB3Sr1QawMDzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4123806654;
	Thu, 20 Mar 2025 14:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/neighbor: add missing policy for
 NDTPA_QUEUE_LENBYTES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248103280.1787925.10049074860167505727.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:30:32 +0000
References: <20250315165113.37600-1-linma@zju.edu.cn>
In-Reply-To: <20250315165113.37600-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 gnaaman@drivenets.com, joel.granados@kernel.org, lizetao1@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Mar 2025 00:51:13 +0800 you wrote:
> Previous commit 8b5c171bb3dc ("neigh: new unresolved queue limits")
> introduces new netlink attribute NDTPA_QUEUE_LENBYTES to represent
> approximative value for deprecated QUEUE_LEN. However, it forgot to add
> the associated nla_policy in nl_ntbl_parm_policy array. Fix it with one
> simple NLA_U32 type policy.
> 
> Fixes: 8b5c171bb3dc ("neigh: new unresolved queue limits")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES
    https://git.kernel.org/netdev/net/c/90a7138619a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



