Return-Path: <netdev+bounces-38707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDE7BC2F1
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD849281F88
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904245F7C;
	Fri,  6 Oct 2023 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGE7Xia6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC0ED5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A4ABC433C8;
	Fri,  6 Oct 2023 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696635028;
	bh=dg72NsvyLzWcreB5+s/HJ6z49P7BaEYwjVWsow40gYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bGE7Xia6NG7mxkYRSxYmlRwAuZR2ZTU+iwhrpNuLvV8Y8saS7asDJ3MY1iNmxPdy1
	 IEdIogGGmUvIYcMeW0IrYEnDj55bC/YHoHE54o6z6JsPAL8rbFrDqtcfPmd/Vy3Tho
	 PDqTflR86HEWTozgwtiba/e5h6Q6fMDU+hR3nGhTXGVg9ZSO8q/pHaNHalsjb7cBZy
	 ey5ZV13Pnboz1GdC+PsCWs4V5npoy5HSDRiwz7sAtPPAqMabpb+gRQOiuYqV8OouAl
	 FRXzkmrwWewOUhpnlA+5GJqZAfRcEagXxrRuBW9bhQ5+keyUqRm4gGUYzYTPAsbm1I
	 qDMBpzWarlvDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8416CC595CB;
	Fri,  6 Oct 2023 23:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] ravb: Fix use-after-free issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663502753.14259.5824699296193501364.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:30:27 +0000
References: <20231005011201.14368-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231005011201.14368-1-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Oct 2023 10:11:59 +0900 you wrote:
> This patch series fixes use-after-free issues in ravb_remove().
> The original patch is made by Zheng Wang [1]. And, I made the patch
> 1/2 which I found other issue in the ravb_remove().
> 
> [1]
> https://lore.kernel.org/netdev/20230725030026.1664873-1-zyytlz.wz@163.com/
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] ravb: Fix up dma_free_coherent() call in ravb_remove()
    https://git.kernel.org/netdev/net/c/e6864af61493
  - [net,v2,2/2] ravb: Fix use-after-free issue in ravb_tx_timeout_work()
    https://git.kernel.org/netdev/net/c/397144287071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



