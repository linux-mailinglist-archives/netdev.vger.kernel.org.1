Return-Path: <netdev+bounces-92689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3C8B8430
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 04:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AC81F23868
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D371643A;
	Wed,  1 May 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaFwezv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A414A8B
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529432; cv=none; b=qaM8snACyVaKyKjwekZm8TLApCvJlLLa8SaxflZjH0O9EBzbvSm4OJb543fGxEJGY9daLMm029XSpT2LmW6RmAvpxMExC5PTM01R/iHFtwhT2uL3TGsdYCZ4GpcSFLLoKlmpx929tPUX/flJ1Ce+dDTN4WSkFUXnhdOEpZ9MUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529432; c=relaxed/simple;
	bh=rApcXqXP/0P7ZYW98+63/oU2HaVvtH8ALMBCOeCkpps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g00mBq0sICmHpZ7ne59U0NPpUbK85bx5oIqXbkKOXYcRLtS5peZhVdBieMUQF9puaK+wABjGsrtLUk2pwEjpYfkFptksKKc7RKxKikk0fQMCcWZ/UiV6fQuDjHTBZOo/cvUQ8WNs4xBACQM3k9Ysc09B0YhNyFxmpXXrYPKiVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaFwezv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69400C32789;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529432;
	bh=rApcXqXP/0P7ZYW98+63/oU2HaVvtH8ALMBCOeCkpps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iaFwezv6XMcxaWAuK1Wz1rqdjv1dwXmP+hkQePwpbIHk5+wk3yFJlok6RQs/knIqw
	 YtJyKRQUG6XZSuI2wS8cl7IlwNPTcdreWfpHcV+QgQtYGxOwXp9GMNcVVO1O8xCc4o
	 lCaQ0rEXyfufpFTL6ZoqiyXjdym0SVX5XwIaJvAQJ80o3XXT6yUUphZI/kF+O0As7z
	 Pam+zS+FQrs69O1AfffZjXzZgrSMtBtMiPeHdXKTGZsCVGnTS+nA+3MQ57/WlRn/86
	 +xMi0Qil9ExfUTq9WQIA8dYOUPWCUCNFmgwui/9dppC8gQ5YNInUS1ep0yDKkMXmTm
	 Fmf2lJfUoIm0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D331C43443;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: three additions to net_hotdata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452943237.31721.107123600647104396.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 02:10:32 +0000
References: <20240429134025.1233626-1-edumazet@google.com>
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 13:40:20 +0000 you wrote:
> This series moves three fast path sysctls to net_hotdata.
> 
> To avoid <net/hotdata.h> inclusion from <net/sock.h>,
> create <net/proto_memory.h> to hold proto memory definitions.
> 
> Eric Dumazet (5):
>   net: move sysctl_max_skb_frags to net_hotdata
>   net: move sysctl_skb_defer_max to net_hotdata
>   tcp: move tcp_out_of_memory() to net/ipv4/tcp.c
>   net: add <net/proto_memory.h>
>   net: move sysctl_mem_pcpu_rsv to net_hotdata
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: move sysctl_max_skb_frags to net_hotdata
    https://git.kernel.org/netdev/net-next/c/a86a0661b86f
  - [net-next,2/5] net: move sysctl_skb_defer_max to net_hotdata
    https://git.kernel.org/netdev/net-next/c/d480dc76d9f8
  - [net-next,3/5] tcp: move tcp_out_of_memory() to net/ipv4/tcp.c
    https://git.kernel.org/netdev/net-next/c/dda4d96acb20
  - [net-next,4/5] net: add <net/proto_memory.h>
    https://git.kernel.org/netdev/net-next/c/f3d93817fba3
  - [net-next,5/5] net: move sysctl_mem_pcpu_rsv to net_hotdata
    https://git.kernel.org/netdev/net-next/c/c204fef97ee6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



