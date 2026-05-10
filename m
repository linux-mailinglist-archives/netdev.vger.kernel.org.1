Return-Path: <netdev+bounces-286351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FKcGKa+AGoCMQEAu9opvQ
	(envelope-from <netdev+bounces-286351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:21:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD3505617
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988203008A50
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207523B27DB;
	Sun, 10 May 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeIS39yK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286D355F28
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433676; cv=none; b=M/LPXzoAdqD46Za/yxBgNKQ1uSG6plbDnlQdtRIBHX3pyTq99qqMcR08rhRBuCSQiE25AivGQBvcm5ozD7EnuIWFt+YmPck1FbwnT1WXHRU4U4VSoaX/byZQyjk1LxjvqHPQnQ3lCl2NTMlT/UwP29UwEKpCtpM3/1PstY4pZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433676; c=relaxed/simple;
	bh=4+uxGObMYDFS6OGCfTIg7ypXeYEjI5Jwb5VKnUE2AMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V+7CIY1XXgcS2bLI4glsmwtaW/WAyqg/GJBJO8nON3mO/7GfCbK9zytejZldhjlPKl1lP/1Rr6xK2LFKUhfdPNGhB3JoG92eUsqbX2xA7ct/w7k7AdnSCSEDzRM+wNecslskF7gIj/cQMvjeZTEFhpHdUGyHWFf2wpCe2+5OQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeIS39yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8871C2BCB8;
	Sun, 10 May 2026 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433675;
	bh=4+uxGObMYDFS6OGCfTIg7ypXeYEjI5Jwb5VKnUE2AMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GeIS39yK2eNNliSwr0EENogEiYGXA2o1kENgslokMXc4aRwalVE9vfhCMs0mi/M8Q
	 0ZrF/no5T1LB/AAdy4t8sFBi8hiK9Qw8eOeW1WRQ5lTbIF9MBvaI7K1stFUsV/Z6RK
	 +SUXY3MhaPUl+lKp7nyP0eN3EVfmmCCyKarO82Y+QmkQJaJjU+T+4FD/lMHyI3ZMpx
	 Lmi+V8Wh/tjZq7tJht2jRXsVw3VGYyjmzqfyEo7CZeJI6HtqLtr3zzUceGc/xtPhax
	 ym+10D0Fhq6sInkTpBKmr6vWjrYixzjewX5oZ+zc/3/ndReHKUElBZjk921qrz0ZE5
	 zzqIheGN9lNsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDE03930020;
	Sun, 10 May 2026 17:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] ipv4: Flush the FIB once on multiple
 nexthop
 removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843362304.1437390.4439633711313941705.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:20:23 +0000
References: <20260507075606.322405-1-cratiu@nvidia.com>
In-Reply-To: <20260507075606.322405-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 kuniyu@google.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, pabeni@redhat.com
X-Rspamd-Queue-Id: C9BD3505617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-286351-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 May 2026 10:56:03 +0300 you wrote:
> This series optimizes multiple nexthop removal performance from having
> to do a FIB flush for each nexthop being removed to only doing a single
> FIB flush after all nexthops are removed.
> 
> This dramatically improves performance in scenarios where there are
> many nexthops and many ipv4 routes. Please see individual patches for
> more details and for a test scenario.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/3] ipv4: Provide a FIB flushing signal from nexthop removal functions
    https://git.kernel.org/netdev/net-next/c/31c777be2a2e
  - [v3,net-next,2/3] ipv4: Flush the FIB once on multiple nexthop removal
    https://git.kernel.org/netdev/net-next/c/35ce55100c61
  - [v3,net-next,3/3] ipv4: Add __must_check to nexthop removal functions
    https://git.kernel.org/netdev/net-next/c/5dcbd64e66ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



