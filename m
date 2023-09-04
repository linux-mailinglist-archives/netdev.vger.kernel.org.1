Return-Path: <netdev+bounces-31881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41749791134
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 07:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBAC280F7C
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6A137D;
	Mon,  4 Sep 2023 05:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C40813
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83390C433CB;
	Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693807094;
	bh=2UXdCycH3+RyP3hJKObaDPQ9IbSELZkZb5uAflzKeAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NX/0DUIW8mhJevT/tG2w8ZPyB8nkIBA/Jr4RlgWGdMgRYdL+IcTFFU/OGSNu3m9F8
	 7xkac7+Fp2RJJxnefnsn6cTSnsGAkqOhRsX44y+E9UqvqUYmu3PlJpkLG5yn3vrosB
	 wGV1qYB3h8o/a3BOS7LmwuBymM2+gH7oHH3IS7PqUU7+5L/Z/WTrkH/AgRxL9tVfb7
	 v2gJ9SUFTGESPKkRelYtXyFt7nS9jcPpwc67ukGBwN4PdcNlNgIkvWpT+9ccKFfoVL
	 eZSFD5EHa9Wib6gmZUj6SOZNX8yiQiU/WnQWYjtOd8IlYejSf2so7wBboskq1spZ49
	 yBWKtWVJAoouw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6972FC04E28;
	Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169380709442.30982.6406917722058861276.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 05:58:14 +0000
References: <20230831183750.2952307-1-edumazet@google.com>
In-Reply-To: <20230831183750.2952307-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 zengyhkyle@gmail.com, keescook@chromium.org, vbabka@suse.cz

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 18:37:50 +0000 you wrote:
> Blamed commit changed:
>     ptr = kmalloc(size);
>     if (ptr)
>       size = ksize(ptr);
> 
> to:
>     size = kmalloc_size_roundup(size);
>     ptr = kmalloc(size);
> 
> [...]

Here is the summary with links:
  - [net] net: deal with integer overflows in kmalloc_reserve()
    https://git.kernel.org/netdev/net/c/915d975b2ffa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



