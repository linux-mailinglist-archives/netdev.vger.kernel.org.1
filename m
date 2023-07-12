Return-Path: <netdev+bounces-17032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DF774FDC6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B2F28145C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB24416;
	Wed, 12 Jul 2023 03:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283D2101
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C52BEC433D9;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132623;
	bh=A+gRtdAZ8mcZuB+d+24Fu1Ezj/v+F1WcLq9RyyvBDwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LV1Ge056ckaYBdltXFZRoV0e2ZF1/AlfYgYrgxMXQMZzkhJ9b3Yhe99+v7fttKqSM
	 Vc6rqo0JL7zOaTad5u42O/SkZBiu3u3QZO67bvWSCXjp/eZCHf02MqYPuFfY23zyFR
	 Ft73qCkSJGQusyNKXGyq8b5vye53J3vwJ0oWJu/2f7Jmbz58bcyVby5YVqrKoDnS5z
	 x8Kv6N+JKllpSmIspjL/vWg+VrHpQMMHlmdZHKPTaXww9qkBVfcHanXvqu1kL7Ro01
	 Jp2t6ATOWog91p8x5bFyCfNxgKVG7boVifXvGiRwLQssLPV49vi219tFclBchs9RSY
	 cWEJuIGbMpE2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6455E49BBF;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913262367.27250.294062569408176677.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:30:23 +0000
References: <20230710094747.943782-1-imagedong@tencent.com>
In-Reply-To: <20230710094747.943782-1-imagedong@tencent.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imagedong@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 17:47:47 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> to clear the unnecessary noise of "kfree_skb" event.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
    https://git.kernel.org/netdev/net-next/c/47b7acfb016b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



