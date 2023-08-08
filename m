Return-Path: <netdev+bounces-25597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343D774E0D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699901C20FD5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51E1802B;
	Tue,  8 Aug 2023 22:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B714F91
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71833C433C9;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532626;
	bh=BuB2xQKgAiGs/ajLxTYRntXfT+uLr3YgZbKu6Nc7bPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bJFnuFEE0xqvBEywt5VVYDOl4yOkHt2MdsOUrIvc+0KUjNt5rb1WqQ1k+5ODAfDlN
	 nnVT3IqYzpBBa54VTlEf4KtjHDlRlS0Q/Ztbmi4H0DiTY4qzlgTM7u5Si7ZdiPld3S
	 VDEzOJZGdux51PMN4yknH4pipaTl/DoifV+rVtqUOWS2QCZQw6MrpzlIjm31hQEngL
	 XuvTUxBeNkXiLz3/ntE8C3+NuX7LfzcS4uFA6Nz6JEcrowlW7T4T3Ia29zpE+PsgNF
	 3g8Rmqe1rUbuu3zOJ0RTXOLOBtpBhhHREf+7iG2T3LE/FYrwuQSZ4ljyune+CpFIT/
	 gTrSQM+2jtJRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54FA9C595C2;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmasp: Prevent array undereflow in
 bcmasp_netfilt_get_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153262634.13746.2768057345145881866.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:10:26 +0000
References: <b3b47b25-01fc-4d9f-a6c3-e037ad4d71d7@moroto.mountain>
In-Reply-To: <b3b47b25-01fc-4d9f-a6c3-e037ad4d71d7@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 16:01:53 +0300 you wrote:
> The "loc" value comes from the user and it can be negative leading to an
> an array underflow when we check "priv->net_filters[loc].claimed".  Fix
> this by changing the type to u32.
> 
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bcmasp: Prevent array undereflow in bcmasp_netfilt_get_init()
    https://git.kernel.org/netdev/net-next/c/48d17c517a7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



