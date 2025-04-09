Return-Path: <netdev+bounces-180567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD71A81B29
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF874A7F95
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBD5D477;
	Wed,  9 Apr 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5pmx8vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39224C81
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166411; cv=none; b=stuAjYT0fUnCMZMR7hqAGX2EmvjwSsYPzkpKztYOLMKN2dWWl9z4ZRDL+0EnBp1F3zMhD2KIstgHbQwBcXZ6xYDVGRq1bmcMOKGQ48D7exF8YHSlqv4aG6OUddeOL9CAIeMcNaE2gaKCrRq4aSzfr1Axo8xLv0vspQW7GW8zYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166411; c=relaxed/simple;
	bh=hPHKw8GBy0hFTIUJjRpQOQFzpwL7UJjthBUqcbXdt+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQSNAyUo63dALUDiE+A2JXhTJ/oe8GiFWms90n9IXdp2kOEZ9A5XDJ4h64OCGunIbmouX1/e1l75rmfnulpcHbxjt7Lva3qNCewkBPyNNKWt7D+K7kw5tDtH4HTC7hpdQq9gGs+MV4bOHWriNMIrnMWIv3g5QdH/QjCAaum4//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5pmx8vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAAEC4CEE5;
	Wed,  9 Apr 2025 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744166409;
	bh=hPHKw8GBy0hFTIUJjRpQOQFzpwL7UJjthBUqcbXdt+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t5pmx8vsjRnHIbBmcVLjG/8kw2kkRMRsl/5V5dezgPfbb5r0D+zEAZedA/YuYe6Np
	 5JYC/fwa/kDl9TM66E9h/19MdElnoiHjfQpL23tOv08MALWai9JHTG3vgKKcBi48OY
	 B3JpI7h7tlPexLvnIvYZz92w44ln1bQVkAI2LfJ74w3I/tltE7LmtmU1QCro1XOwNh
	 3M4DiWSN42H/w4fsJXINsIT0iOMHfP/Tvyb2CiMpERC1yhusrTjVMfSaWtqHguoKuT
	 4zyeqFAkl6WWoAlrrtVRkcEYjJC93a3Foxw3rfNqTwVHZ1NQgt2PWK0PzadgIwN40e
	 jCKXOgEqeX1Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFBCA38111D4;
	Wed,  9 Apr 2025 02:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] udp_tunnel: GRO optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174416644627.2289933.4526280567617505719.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 02:40:46 +0000
References: <cover.1744040675.git.pabeni@redhat.com>
In-Reply-To: <cover.1744040675.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Apr 2025 17:45:40 +0200 you wrote:
> The UDP tunnel GRO stage is source of measurable overhead for workload
> based on UDP-encapsulated traffic: each incoming packets requires a full
> UDP socket lookup and an indirect call.
> 
> In the most common setups a single UDP tunnel device is used. In such
> case we can optimize both the lookup and the indirect call.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] udp_tunnel: create a fastpath GRO lookup.
    https://git.kernel.org/netdev/net-next/c/a36283e2b683
  - [net-next,v5,2/2] udp_tunnel: use static call for GRO hooks when possible
    https://git.kernel.org/netdev/net-next/c/5d7f5b2f6b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



