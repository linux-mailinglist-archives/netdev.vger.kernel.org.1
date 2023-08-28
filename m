Return-Path: <netdev+bounces-31014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04D78A8F1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0AE1C208BE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB86125;
	Mon, 28 Aug 2023 09:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1354C8C
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37BA8C433C9;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693215029;
	bh=v1gr32bBIJ5C07MAKcoxSB43dH+IPc84xwYX/CT2vpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rY9zwwlQG8dskwtdxiP/WbPrE9aGL4/klhTu6h732vOvouE1FzRdfNcipE/uIVXbR
	 pkiuGtw1NMhcW0/vEJ5Dlvu0tQTh1vTL3STMmVsQDMyZKmx/tHnIsAq4/Ui9x8W1Hv
	 KaAxVhExkVsHnsJ760c20dgqTBhMAUnWNlInnYvYCNXUA/NwTmDXQJxWFUpyOsKnlO
	 mH6z7WTbHC17X8COQBIqKuVo767h9+shQJUQrsmbMYhGPw643ll2E73BmIwMDCJbMC
	 XesBxylQVitKx+MaBHpQ/bsZU1UuvVLN2xJjJlTcIGRhPVCScIP3cNJc44e73NM8tY
	 krCktm5LAWyOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12787E21EDF;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: fix IP_TRANSPARENT error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321502907.13199.7646505785035523534.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:30:29 +0000
References: <20230828084732.2366402-1-edumazet@google.com>
In-Reply-To: <20230828084732.2366402-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com, soheil@google.com,
 horms@kernel.org, matthieu.baerts@tessares.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 28 Aug 2023 08:47:32 +0000 you wrote:
> My recent patch forgot to change error handling for IP_TRANSPARENT
> socket option.
> 
> WARNING: bad unlock balance detected!
> 6.5.0-rc7-syzkaller-01717-g59da9885767a #0 Not tainted
> -------------------------------------
> syz-executor151/5028 is trying to release lock (sk_lock-AF_INET) at:
> [<ffffffff88213983>] sockopt_release_sock+0x53/0x70 net/core/sock.c:1073
> but there are no more locks to release!
> 
> [...]

Here is the summary with links:
  - [net-next] inet: fix IP_TRANSPARENT error handling
    https://git.kernel.org/bpf/bpf-next/c/8be6f88b9d3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



