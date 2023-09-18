Return-Path: <netdev+bounces-34426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2F7A4258
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D924A281839
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E807492;
	Mon, 18 Sep 2023 07:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD673C2C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C57CBC433CC;
	Mon, 18 Sep 2023 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695022223;
	bh=i9H9wZ77yZRa4B+Ukm/PXdGqgr9Ji45NiO/SqgEzmDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NcQ+hOdOTyyKDZSCZsE5K8FMHaUBYU1Xx9i/XssfmSBOkzVvBAjRZ1U/Ueg3Um+6q
	 twCt+0rJI2IeCIbJlBCfEjtDFSCIJHv0dfM8bnDhOnPt1YuZWUwLfd+1FrXRH//HRm
	 wig2p9h0JlPZr7sqGZJzMAKhWIu69xeuKAUdtXE5WU45ZCBiV0SK2nTvM1tStvkL7T
	 aSFNsfTJbGZF0MkY5h7U8grbbT7stM7uGBpqeWZN7usnnTsKrNjVht/YKXdXnKCjz7
	 hEnzzMm1cMJ2HUF3J95mKiukWH8JwLhpFe4Uj5aTnOLoliXbzR19pCLAUxH6c0Xz5k
	 SCM8kofa3VS6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB933E11F42;
	Mon, 18 Sep 2023 07:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] net: hsr: Properly parse HSRv1 supervisor frames.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169502222369.22191.13254113064617721891.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 07:30:23 +0000
References: <20230915181006.2086061-1-bigeasy@linutronix.de>
In-Reply-To: <20230915181006.2086061-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, ennoerlangen@gmail.com,
 edumazet@google.com, kuba@kernel.org, lukma@denx.de, pabeni@redhat.com,
 shuah@kernel.org, tglx@linutronix.de

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 20:10:01 +0200 you wrote:
> Hi,
> 
> this is a follow-up to
> 	https://lore.kernel.org/all/20230825153111.228768-1-lukma@denx.de/
> replacing
> 	https://lore.kernel.org/all/20230914124731.1654059-1-lukma@denx.de/
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: hsr: Properly parse HSRv1 supervisor frames.
    https://git.kernel.org/netdev/net/c/295de650d3aa
  - [net-next,2/5] net: hsr: Add __packed to struct hsr_sup_tlv.
    https://git.kernel.org/netdev/net/c/fbd825fcd7dd
  - [net-next,3/5] selftests: hsr: Use `let' properly.
    https://git.kernel.org/netdev/net/c/5c3ce539a111
  - [net-next,4/5] selftests: hsr: Reorder the testsuite.
    https://git.kernel.org/netdev/net/c/d53f23fe164c
  - [net-next,5/5] selftests: hsr: Extend the testsuite to also cover HSRv1.
    https://git.kernel.org/netdev/net/c/b0e9c3b5fdaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



