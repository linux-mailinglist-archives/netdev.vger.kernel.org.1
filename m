Return-Path: <netdev+bounces-21693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850BB7644D0
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B891F1C21323
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766E1864;
	Thu, 27 Jul 2023 04:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960B185D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5D59C433C9;
	Thu, 27 Jul 2023 04:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690431621;
	bh=kmrgbL02FaDClyznM2zA9yizf4QNB2ZDh1YoZC6S9DQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uiQ+UM2GmXOg1rTuUUhJiTLYmqvrXJDRZ2cy+2G93UhlZzy6d50DTbmF9RvYD3ejC
	 7TosOtS92a5aOjA2DQjGnDGlLvZ88tnz10fRDvk9tOu9cPurtARlLmRMQ1rsTflbf+
	 R5k8aDNQmEk3KH7Njr6FsHLaXAi//sM/ug5PbFYTh1eYxNphV8OrtIHv7qhfJqz1T5
	 6mguYo+NYI1MduL5IRyINA9QR+zrCgBoO1YL2yTC+3mgJeGooA5wYmj/FUXf2s1kEJ
	 du/cOb/PFIqz63/IfrSIcmoa6iWrKvV0temfIdEVPNuvCIigMRDutojvObtig1EqnD
	 ffzszGV4PFjWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA30C41672;
	Thu, 27 Jul 2023 04:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: tx processing does not call XDP APIs if budget
 is 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043162083.26911.10210581447548929941.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 04:20:20 +0000
References: <20230725074148.2936402-1-wei.fang@nxp.com>
In-Reply-To: <20230725074148.2936402-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 15:41:48 +0800 you wrote:
> According to the clarification [1] in the latest napi.rst, the tx
> processing cannot call any XDP (or page pool) APIs if the "budget"
> is 0. Because NAPI is called with the budget of 0 (such as netpoll)
> indicates we may be in an IRQ context, however, we cannot use the
> page pool from IRQ context.
> 
> [1] https://lore.kernel.org/all/20230720161323.2025379-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net] net: fec: tx processing does not call XDP APIs if budget is 0
    https://git.kernel.org/netdev/net/c/15cec633fc7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



