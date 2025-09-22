Return-Path: <netdev+bounces-225355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B110FB92A5F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CC51901BE5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656D318138;
	Mon, 22 Sep 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU6u3Nxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B831771B
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567012; cv=none; b=LfDjp5M4ur+kc9ZxQ2ttUPO5PqEomHcbGR3qIqwxYCjbpKhQclklIe20T2DUYiarYXZKI7H3s1d4LVmilaQZ/5tsXCac45cf/SjJ5MWMV6cpgtfjzHw+Od4NVrBoo4SQJQnDx6z9J9tT/l/dBQI5hrbHT9BR3gsrenNdI1fHyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567012; c=relaxed/simple;
	bh=O/gw1t9pM9h5RIdRGaF49XozCbi1EyH5mJUl07nHa1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b/bTTWOSqdJK/JU7IsXwCkJPVl2ZUDfRFHQOVEOD7/ojRCT4DOxhnCoSSo70EFK7bEdg1bDmv7ya09LioSEMvuyrzqy7c3J5w6qTgANQAx7S2spB0h24awRIlgAJkCnpGQRtdL3F3emn6Y42k0M4zSFB0+5fN8BPYNOX6XQhF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU6u3Nxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECDEC4CEF0;
	Mon, 22 Sep 2025 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567011;
	bh=O/gw1t9pM9h5RIdRGaF49XozCbi1EyH5mJUl07nHa1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MU6u3NxffhGMILBIG8XymGk4LMpSxubLDCN5m8wM2nOFQ/ANsZbzVUhupgwFATIEZ
	 0f1k59xfHNFFznGwxqfhbYfCGmSp0Wbf0CnhSBlPC3eT1CIiDRu2PjVZBO+o9gbpdN
	 Auhqu+3ox1tnxNyzUzJPBsYIzPnjdCSKb/gd1qT5evVOM//pdi4qsj+PnmZkUlkh1c
	 pmVkx/VPeaJTPnz19Lux6+ZExc+9qs1HxuybFAtwgb/0LCC4HGrr+lexIVXhGnLwQS
	 EhHwBxV5R0u4ng9sK8K5l7X6jrnFYpKy5zw8mVF0vPyze8CUq12MB2VNEObkJZdSvy
	 3wySTkWemtmXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9CC9D39D0C20;
	Mon, 22 Sep 2025 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/3] tcp: Clean up inet_hash() and
 inet_unhash().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175856700950.1118970.11081370522271920576.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 18:50:09 +0000
References: <20250919083706.1863217-1-kuniyu@google.com>
In-Reply-To: <20250919083706.1863217-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 xuanqiang.luo@linux.dev, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 08:35:27 +0000 you wrote:
> While reviewing the ehash fix series from Xuanqiang Luo [0],
> I noticed that inet_twsk_hashdance_schedule() checks the
> retval of __sk_nulls_del_node_init_rcu(), which looks confusing.
> 
> The test exists from the pre-git era:
> 
>   $ git blame -L:tcp_tw_hashdance net/ipv4/tcp_minisocks.c e48c414ee61f4~
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/3] tcp: Remove osk from __inet_hash() arg.
    https://git.kernel.org/netdev/net-next/c/6445bb832dc0
  - [v1,net-next,2/3] tcp: Remove inet6_hash().
    https://git.kernel.org/netdev/net-next/c/0ac44301e3bf
  - [v1,net-next,3/3] tcp: Remove redundant sk_unhashed() in inet_unhash().
    https://git.kernel.org/netdev/net-next/c/bb6f9445666e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



