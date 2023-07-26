Return-Path: <netdev+bounces-21142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AC76291A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A9C281A95
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0241C07;
	Wed, 26 Jul 2023 03:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE71365
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E898C433CD;
	Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341020;
	bh=+ajtJPlWkqiBolHDZStP+hnhkPbQ/RwAWCQlZcDPVAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lwPAGDtEOoed9lcKOTgl7DqSZHEHUT4DdEsTqhf1X2Y481nQChozovLhFyAUgOiUR
	 /xDcThWJsGahlMuIF+/tlxzXa5lNpvSHHTVeh6snuQBgqhftHbR9hhpml6dcR2xZHh
	 LwEHu3qpXE/Ff1mZjU4JEehLEmZAP+UhwpmF9pynAkSoNzfLKe/4SHJsdYva4kpx0H
	 UgkcTf1Ans9R7JRkqMx8Qgb8CHDnOwMUs4jU1EsRy04xVQsUFSQSuHeuD0Z/z8QuF3
	 4Zd6w/iO2e3MXUT1vprlxx77774khUNPEUn5YmexQQooh3o3RU8pO4+MwnyT/qqlr9
	 QOL2t81FgfAGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A670C73FE2;
	Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/lcs: Remove FDDI option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034102049.18310.14252409973492346016.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 03:10:20 +0000
References: <20230724131546.3597001-1-wintera@linux.ibm.com>
In-Reply-To: <20230724131546.3597001-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, simon.horman@corigine.com, borntraeger@linux.ibm.com,
 rdunlap@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 15:15:46 +0200 you wrote:
> The last s390 machine that supported FDDI was z900 ('7th generation',
> released in 2000). The oldest machine generation currently supported by
> the Linux kernel is MARCH_Z10 (released 2008). If there is still a usecase
> for connecting a Linux on s390 instance to a LAN Channel Station (LCS), it
> can only do so via Ethernet.
> 
> Randy Dunlap[1] found that LCS over FDDI has never worked, when FDDI
> was compiled as module. Instead of fixing that, remove the FDDI option
> from the lcs driver.
> 
> [...]

Here is the summary with links:
  - [net] s390/lcs: Remove FDDI option
    https://git.kernel.org/netdev/net-next/c/8540336adadb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



