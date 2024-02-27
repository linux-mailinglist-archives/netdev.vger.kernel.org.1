Return-Path: <netdev+bounces-75461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8786A009
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA482860F1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7D51C39;
	Tue, 27 Feb 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv+f9inP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525351C34
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061630; cv=none; b=u+A1YTDhSW6owTHbXLGIRlMaXayKGESurGeqt/1tS1SMqMb8z/8Ki+Pv3fUY5q3AHudReKnd4zYsA8z+nzWhboO33mLV1lPE/NooARoj9KbqGzeDz9JeLF1w0YSDX/cjiqqv6VQA1d5nRm+G7YFogIh3IjbTrLtN5D/RXBp2IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061630; c=relaxed/simple;
	bh=uTujFPo/NVgg0GZZHcN355DcItgsAQARffU3w8utHm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=su8+NdSmOPKL5bWWx5OVu3ukGbVqb+j36PTeNU7SiB2Q89eRsdDJgzUHFC/yy+09C08GPsl5tBjTUHggpBpY+p35SwLTLHx6zS34a0PXuqRnycxj6jdLdvDcgQJ7I4JJxqp0ktKJq5ap+UnWcEPRFpjHT4Rpldj6VUyJ3vbcWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv+f9inP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 964BCC43390;
	Tue, 27 Feb 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709061630;
	bh=uTujFPo/NVgg0GZZHcN355DcItgsAQARffU3w8utHm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kv+f9inPCdaO4lJFGr/L52UaqJdyvvYKal+A6siiPUrtJzoyiikLrCIqp7PULAL9H
	 zG+qFTIJXdPO7a3RqdkDk0CQvyXrN9QCVG4Wxja46PbcQ1M7uj2EQwy2EsgyCvv+nl
	 qmpzw+T8GfSa9ynLlT0qO/Dyjy5n1j0kVwEReRetnRHIm/dad+DIOj3QyvipBh8XFs
	 NaHCpP0sLLkU/0eWaOg2uUbH67B1xW5M5wBrtvjViYyGIcTS5bw4fBA6IipoPVfwKE
	 5yKc1Tz97fcTLpi/CJXV/bXLSOCvs7y+Nprsp+hkzHv/ZFwTtTLpOsFHlJhAm3oOq1
	 Af20ThR9htjcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 780CFD84BC5;
	Tue, 27 Feb 2024 19:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: use kvmalloc() in netlink_alloc_large_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170906163048.25913.1879809835090233715.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 19:20:30 +0000
References: <20240224090630.605917-1-edumazet@google.com>
In-Reply-To: <20240224090630.605917-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, shaozhengchao@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Feb 2024 09:06:30 +0000 you wrote:
> This is a followup of commit 234ec0b6034b ("netlink: fix potential
> sleeping issue in mqueue_flush_file"), because vfree_atomic()
> overhead is unfortunate for medium sized allocations.
> 
> 1) If the allocation is smaller than PAGE_SIZE, do not bother
>    with vmalloc() at all. Some arches have 64KB PAGE_SIZE,
>    while NLMSG_GOODSIZE is smaller than 8KB.
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: use kvmalloc() in netlink_alloc_large_skb()
    https://git.kernel.org/netdev/net-next/c/f8cbf6bde4c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



