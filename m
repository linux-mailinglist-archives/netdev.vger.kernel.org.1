Return-Path: <netdev+bounces-34363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CC7A36F9
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E356F2816D3
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D226ABB;
	Sun, 17 Sep 2023 18:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE836AAC
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 18:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43FE8C433C9;
	Sun, 17 Sep 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694973625;
	bh=LQ3g1QCwxCFcakpyTSxvq83imo04pOWfnBxfgLv3iHM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UZtt14We0H0hAV2VGcw0V6qzWtxjVJkm++YLm1M3ibX4zVUQS+M2uJ8FdgdC7Lxcg
	 agug21KJh95o8MfYbvPUuX+9dugyPzZMyNy/aqvuUHbUI0kNC7AUJ95GzPAXPwbt2q
	 CwbmB9tTAEbZc4wR4hCA4kr7r5ydJVyB2Ul3rVc4VOUFRgoEHBJUdfFdZpxDlcQLo7
	 K1L1fdsydM9OkF/k4s2b2y3pi/ecC3SwL4D6/K6XZYTOS1h2+sTP43Fzf8q1Uz8zCQ
	 aLYb6uiyci+du5PvJWuSneWUXOQXNk7imD97BEL0XyTsEWVWtOhoaWJuA9o3YINoOF
	 wFQIM7mEm8quA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 276FEE26884;
	Sun, 17 Sep 2023 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] gve: Use size_add() in call to struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169497362515.18132.991778416445750610.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 18:00:25 +0000
References: <ZQSfze9HgfLDkFPV@work>
In-Reply-To: <ZQSfze9HgfLDkFPV@work>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 12:17:49 -0600 you wrote:
> If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
> protection that struct_size() adds against potential integer overflows
> is defeated. Fix this by hardening call to struct_size() with size_add().
> 
> Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> [...]

Here is the summary with links:
  - [next] gve: Use size_add() in call to struct_size()
    https://git.kernel.org/netdev/net-next/c/d692873cbe86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



