Return-Path: <netdev+bounces-143856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640369C48FD
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 23:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281E6284158
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94758176AB9;
	Mon, 11 Nov 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeEAaFdV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B713176231;
	Mon, 11 Nov 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363626; cv=none; b=pj/UhHHKC3UyOatf1g1y7apVaO0ClDXRi+p4qW/LDfoZvxCCS/HCLEsE6QBA4QL17tvAIZcg29v+7LzRobYg8/sa6S+ofRpGwDhnloUj26GjkPg4DrFysp7S3tNjXb7TGcLk8L5bWlVSdUMPFtIrDM33yjkEIGbYzTIazlFVb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363626; c=relaxed/simple;
	bh=MypPg+M/YDDViNpGViN4XBmvjlfXPTdU0SDbpmeqoyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPuVSjdNzwYz80rE03gUwcbx4NyHNJMfO6rMq77jmwHiLK22GxEBO1a+OUWhlDb0uJGspYwhB3U15lXMTO7zJoZ524btMeUNYpemMEB77WpVQhro4Jx+HL6EQ8c9iSBGXXA9I05YxYsHzClFz7V+hV2gJ+pf/YFdLs0iMSjdwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeEAaFdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6445C4CED4;
	Mon, 11 Nov 2024 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731363626;
	bh=MypPg+M/YDDViNpGViN4XBmvjlfXPTdU0SDbpmeqoyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EeEAaFdV4Dp/+zI1vvBxo2xzYbINFTljoPwlj7L2sA3pxCVPzyomXqQkfJo0tMRmz
	 MWL1S7X5yKLCqv0rA0EXBIU1xEpIC4jf6eznC7YXm63G5xGfSRnH4XpJoKxplItiNa
	 hCX8xktKL4uCRvDn9EE9MJBjjrg+SD7PZyvFelqXZgTgee4RPiW2FxyujItwDoCvpO
	 kONrxsIo8ynvtzWg9yvx/2E2mQIda/rLkMJhXZGkf5tn3KzVMUu5TkktzFafHngymx
	 yc3bbt/VMdWQGJcNor8RNzKCZ7sPBgL6aiY8N4bapnaEYZrvbmkSpDUG94A22/zu87
	 Q48M+i1eFZ0eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3439D3809A80;
	Mon, 11 Nov 2024 22:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v23 0/7] Replace page_frag with page_frag_cache
 (Part-1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173136363598.4189866.15703585337106552635.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 22:20:35 +0000
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
In-Reply-To: <20241028115343.3405838-1-linyunsheng@huawei.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexander.duyck@gmail.com, skhan@linuxfoundation.org,
 akpm@linux-foundation.org, linux-mm@kvack.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 19:53:35 +0800 you wrote:
> This is part 1 of "Replace page_frag with page_frag_cache",
> which mainly contain refactoring and optimization for the
> implementation of page_frag API before the replacing.
> 
> As the discussion in [1], it would be better to target net-next
> tree to get more testing as all the callers page_frag API are
> in networking, and the chance of conflicting with MM tree seems
> low as implementation of page_frag API seems quite self-contained.
> 
> [...]

Here is the summary with links:
  - [net-next,v23,1/7] mm: page_frag: add a test module for page_frag
    https://git.kernel.org/netdev/net-next/c/7fef0dec415c
  - [net-next,v23,2/7] mm: move the page fragment allocator from page_alloc into its own file
    https://git.kernel.org/netdev/net-next/c/65941f10caf2
  - [net-next,v23,3/7] mm: page_frag: use initial zero offset for page_frag_alloc_align()
    https://git.kernel.org/netdev/net-next/c/8218f62c9c9b
  - [net-next,v23,4/7] mm: page_frag: avoid caller accessing 'page_frag_cache' directly
    https://git.kernel.org/netdev/net-next/c/3d18dfe69ce4
  - [net-next,v23,5/7] xtensa: remove the get_order() implementation
    https://git.kernel.org/netdev/net-next/c/49e302be73f1
  - [net-next,v23,6/7] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
    https://git.kernel.org/netdev/net-next/c/0c3ce2f50261
  - [net-next,v23,7/7] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
    https://git.kernel.org/netdev/net-next/c/ec397ea00cb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



