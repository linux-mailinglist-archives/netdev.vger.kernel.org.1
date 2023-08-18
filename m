Return-Path: <netdev+bounces-28677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49DA7803C3
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FAC2821E1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130BECB;
	Fri, 18 Aug 2023 02:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEB39C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E475C433C7;
	Fri, 18 Aug 2023 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692325222;
	bh=fzMfcDCMPOfhc1JFVng5hMHd4Nrk4/vs8+/cxhsj7Bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KLjaMH8dV7NaisGFkW4bE4wtQl07Rz+7EfQ/Gl0IL1qtyrD1I/zOT2nGIJkzJqMFF
	 03355rXnOJ/oDr3zmijCQYiUnz5urzwAaz7eMe+O3il1FQQ1iwG5h+slUYqkjgknFU
	 18tUtSsILMZoxTsI162U2Pdt6Zw8Xvh0t6fxgK52GxsudVWMylCue6UKrVV1fILufz
	 Hp8RFEBeOW4MBpUlx6vaHsLBONDTuEMQFxJkpsPsYRnL82/+2ah95etxtqVq+YoIq8
	 vCmBWMeU2l0ie4X5IwKx6ksGQa8HO9h/7zn2IW4xoFS6pPWDioj4EmaeXm6ITzq8zM
	 CfzhdQbp8OIvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02038C395C5;
	Fri, 18 Aug 2023 02:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tun: add __exit annotations to module exit func
 tun_cleanup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169232522200.19288.15380074072385571589.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 02:20:22 +0000
References: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan (William) <william.xuanziyang@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 16:30:00 +0800 you wrote:
> Add missing __exit annotations to module exit func tun_cleanup().
> 
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] tun: add __exit annotations to module exit func tun_cleanup()
    https://git.kernel.org/netdev/net-next/c/b2f8323364ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



