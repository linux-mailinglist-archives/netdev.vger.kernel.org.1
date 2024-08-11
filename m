Return-Path: <netdev+bounces-117448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED094DFE1
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 05:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAF7281198
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B22E541;
	Sun, 11 Aug 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re6t0UXl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B87F6;
	Sun, 11 Aug 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723348349; cv=none; b=spztGepy6A/e4aeKCYwIoGc0GmaAo/phA8LFRcQstaFroh/cXPiq2YmSZkvx/c71jiucOz0ZxR6DxVwSB8yOTOIztNEO0nT5aZXuFtaIei88f0CR+IvST2YJYpvzfFysu7ZlFq/QoR3yuaUv9wRq1UQUaxvczjpwt6Yu1bSJgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723348349; c=relaxed/simple;
	bh=fN++KgPGR5/sXVo/bRH9P3iTs/+SpQubUS+dKOMu1SQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJeeotOa6j0Noa4gSqhnWA613dZZwoAgAoh28PSiS9Ypn5gWMdgNfxN8xmyjYaMFZKoH1z6cvKaHfp0il/fvu1t8NvEzkURWAJOslHyZaKf5wrc8KDo7VMMKOK3ofeTtmSG17TOlG8V1Vk04uajAI3oh34TgZfCxb24lCHSDlpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re6t0UXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071FEC4AF0C;
	Sun, 11 Aug 2024 03:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723348349;
	bh=fN++KgPGR5/sXVo/bRH9P3iTs/+SpQubUS+dKOMu1SQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Re6t0UXlOF5vNvBLBUgr8MUyPMgo+FTY/RjSqYx7b6fUSHIzehOD2HszxfgGSFBNz
	 CnwrTNmcunnRa2iQHCWJG5ZvR91Kf/UdzSGR0D5nvJCqBKar30RheNBpyN4AbFedFc
	 3Em3pusNDW2A7ia0M4q0V8GSM5lFEfX2w5j8E64O9hNzCFyX6ojzxWWdFBm98w20km
	 FR6r0gw2cRN5Zv/hgM3MSs+z5a6cOYpZ9NYuQVD4ijd/92HPFDmg749Qlr1+E2vvf3
	 tgV+HP/nEp/jbuLwQwWZoHwMGz0SaQ6MyCzNwFPb0G+uDq245R2knsg1pe5w5I65Ej
	 HIwt/UgWIFlyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F953823358;
	Sun, 11 Aug 2024 03:52:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: ethernet: use ip_hdrlen() instead of bit shift
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172334834804.125619.10250611606174817787.git-patchwork-notify@kernel.org>
Date: Sun, 11 Aug 2024 03:52:28 +0000
References: <20240807100721.101498-1-yyyynoom@gmail.com>
In-Reply-To: <20240807100721.101498-1-yyyynoom@gmail.com>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  7 Aug 2024 19:07:21 +0900 you wrote:
> `ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
> Therefore, we should use a well-defined function not a bit shift
> to find the header length.
> 
> It also compresses two lines to a single line.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: ethernet: use ip_hdrlen() instead of bit shift
    https://git.kernel.org/netdev/net/c/9a039eeb71a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



