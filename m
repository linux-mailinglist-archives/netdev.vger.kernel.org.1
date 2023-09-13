Return-Path: <netdev+bounces-33544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AF79E705
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E3C28251C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555E1EA6E;
	Wed, 13 Sep 2023 11:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B918C2D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D834C433C9;
	Wed, 13 Sep 2023 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694605227;
	bh=Fe9V3fAeoTIWzn3vmerCsL1xnoDRfgdt+KYOXSw8htw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ctBmKGOfHJzWpYX2EDFqyY2szGRI8oegpT6Yb21YSBDU0v5OhxVpi55ulUDrZh8Gq
	 0CZdXRoSp9x7p4OIcSlfyAcmWNpHxgXm9Fj6QNpzjiL0kVuTdB5thY4IzMuTmDxM+d
	 8ENhVyjm5U+YLVfC9Ay/lJMcSipqBvbCieHdYOXqqNeFPb6xv6hkYUT7RViPVq112u
	 b326AgYca5LDc9wOwkfH3cle9bxIMA0FDhmkbSqRCyqktP+brXnRSlLhICXEzfB+uQ
	 Ke4aZJm/x57q+bO/NS8mGZ34rlggJiCXok8f9Alsfh10uA/cyS6vugNquXhW/R31Vz
	 sG6HD817wznlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2B8AE1C28E;
	Wed, 13 Sep 2023 11:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] selftests/tc-testing: add tests covering
 classid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169460522699.11253.18350477068462150356.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 11:40:26 +0000
References: <20230911215016.1096644-1-pctammela@mojatatu.com>
In-Reply-To: <20230911215016.1096644-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 18:50:12 -0300 you wrote:
> Patches 1-3 add missing tests covering classid behaviour on tdc for cls_fw,
> cls_route and cls_fw. This behaviour was recently fixed by valis[0].
> 
> Patch 4 comes from the development done in the previous patches as it turns out
> cls_route never returns meaningful errors.
> 
> [0] https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests/tc-testing: cls_fw: add tests for classid
    https://git.kernel.org/netdev/net-next/c/70ad43333cbe
  - [net-next,v3,2/4] selftests/tc-testing: cls_route: add tests for classid
    https://git.kernel.org/netdev/net-next/c/7c339083616c
  - [net-next,v3,3/4] selftests/tc-testing: cls_u32: add tests for classid
    https://git.kernel.org/netdev/net-next/c/e2f2fb3c352d
  - [net-next,v3,4/4] net/sched: cls_route: make netlink errors meaningful
    https://git.kernel.org/netdev/net-next/c/ef765c258759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



