Return-Path: <netdev+bounces-20179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18975E187
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E01E2819B7
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD6111A;
	Sun, 23 Jul 2023 11:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDDD7F
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 11:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BEA6C433C7;
	Sun, 23 Jul 2023 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690110019;
	bh=BTXNIM1+AbMVXtHBxaAzRFAkUP6IKSsEckZSmiEoKr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kMWqmdnQFCeKadohJqWT5aoLPTcYvg3+AaFVxq3/6LO6pHwJOIYG1ZfLRvni1ymkZ
	 5PI8pt9h0oAcjZrO7gbEQ/jEDy2XrlcWhxAUr54sNIC3t927/KVGl2BC790uVtPppx
	 vHSBWxJSJEdDxc6ECucptGQmN055YW1ud8VTCmh83bWs42PmnEsL8TCq0+2cmiqUKJ
	 FUSWt3boUdWr1SyWaUDioOpZWNELlhHVB8ELnnbvi04ffBE4Qn7VGAUBrRcqSe6c/f
	 hGPbZEUixm5DpUq8+HThnWQd8ktTIafgGyt/A640Kfwz25b5X2vDS8LAhX2Gx+sd6S
	 +K0I3CErvbpNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E5FFC595C2;
	Sun, 23 Jul 2023 11:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] net: add sysctl accept_ra_min_rtr_lft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169011001944.25900.13362860842205014637.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jul 2023 11:00:19 +0000
References: <20230719145213.888494-1-prohr@google.com>
In-Reply-To: <20230719145213.888494-1-prohr@google.com>
To: Patrick Rohr <prohr@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, maze@google.com,
 lorenzo@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jul 2023 07:52:13 -0700 you wrote:
> This change adds a new sysctl accept_ra_min_rtr_lft to specify the
> minimum acceptable router lifetime in an RA. If the received RA router
> lifetime is less than the configured value (and not 0), the RA is
> ignored.
> This is useful for mobile devices, whose battery life can be impacted
> by networks that configure RAs with a short lifetime. On such networks,
> the device should never gain IPv6 provisioning and should attempt to
> drop RAs via hardware offload, if available.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: add sysctl accept_ra_min_rtr_lft
    https://git.kernel.org/netdev/net-next/c/1671bcfd76fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



