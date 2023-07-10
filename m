Return-Path: <netdev+bounces-16362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9D74CE69
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829C0280FD7
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DDE79DC;
	Mon, 10 Jul 2023 07:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274B568F
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7D0CC433CB;
	Mon, 10 Jul 2023 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688974221;
	bh=a436BPex8yFqy/L54ZKP9O/09Ee0pERO8Iq8NR3gjH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRzZqhd2EZL6B1PtUJV7+R9YFHLCkohbAWz4E2lB9iHmxmeU5d5JRh4sOm2xyoI/r
	 YGMcY41LROhfAIxY73b9rSyGb6IdgtTkgPfqp5Flvzn2kHZWJiAnINx1zgjIu6ny7i
	 /KqeZOi7STqsbudb01Q5nyZFjSZ90JSbUUkaPqqxrZ8+AUQ9ESYRRSyz52UrRHOA2K
	 W2yf5hr6fvy/5m2a/wIzf9zP3xv299Hbtf5uK7v1thXnoyffhnxRlvdKQ8l2uGkE6G
	 TVnpdsLbboEpWyM3cFmBSfFoZmcGFMhVHgLKPPT9zdgOfGYoegq9GFbqqG0NlhoNVM
	 fUEmoEu2LTWvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF000C395F8;
	Mon, 10 Jul 2023 07:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: qca8k: Add check for skb_copy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168897422084.937.5935526114341397652.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jul 2023 07:30:20 +0000
References: <20230710013907.43770-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230710013907.43770-1-jiasheng@iscas.ac.cn>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 10 Jul 2023 09:39:07 +0800 you wrote:
> Add check for the return value of skb_copy in order to avoid NULL pointer
> dereference.
> 
> Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - net: dsa: qca8k: Add check for skb_copy
    https://git.kernel.org/netdev/net/c/87355b7c3da9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



