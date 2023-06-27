Return-Path: <netdev+bounces-14225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC2973FA3F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F1628107C
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF5BA33;
	Tue, 27 Jun 2023 10:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCB17AAA
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D5FC433C0;
	Tue, 27 Jun 2023 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687861820;
	bh=R38voaZXR74g7j6AGu6e9jUGzSMGKBcf62IbBXvdPZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LzMywWKqASFwoVLn4+bEW1NKWiQTMUosUJvWxZMvHXxEPkzewAPkv0SIK2VMdLp5u
	 v1pChSNqGxycB1mK1Dhgg42rZmumKr5okb0Bo5ZS7EozHCl+njQVDKkiwgXlz8Vtd7
	 Eo+fspgOvKa8GYyGsxfE7hWtegcQkLDCJg/3lI1tSQKDbELrIOcwwtq3CTtWVwtz+M
	 Uvns7WL9XI+0wNDFJIzROXCLxgFthbUKqRFwTz2FW+XNv6OZl2v1U4RFA9FzZGOVtV
	 OyWNBpwJ0WkfKCtsTrtgSXaVl3pDk5Nny0pWlUdR/SA+ya0ZLFW3Tn59fi+Anqu17h
	 qj/fnyxNY+4pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12ECDE537FF;
	Tue, 27 Jun 2023 10:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipvlan: Fix return value of ipvlan_queue_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168786182007.31138.6869118162868476838.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 10:30:20 +0000
References: <20230626093347.7492-1-cambda@linux.alibaba.com>
In-Reply-To: <20230626093347.7492-1-cambda@linux.alibaba.com>
To: Cambda Zhu <cambda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, fengtao40@huawei.com,
 lucien.xin@gmail.com, luwei32@huawei.com, maheshb@google.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Jun 2023 17:33:47 +0800 you wrote:
> ipvlan_queue_xmit() should return NET_XMIT_XXX, but
> ipvlan_xmit_mode_l2/l3() returns rx_handler_result_t or NET_RX_XXX
> in some cases. ipvlan_rcv_frame() will only return RX_HANDLER_CONSUMED
> in ipvlan_xmit_mode_l2/l3() because 'local' is true. It's equal to
> NET_XMIT_SUCCESS. But dev_forward_skb() can return NET_RX_SUCCESS or
> NET_RX_DROP, and returning NET_RX_DROP(NET_XMIT_DROP) will increase
> both ipvlan and ipvlan->phy_dev drops counter.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipvlan: Fix return value of ipvlan_queue_xmit()
    https://git.kernel.org/netdev/net/c/8a9922e7be6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



