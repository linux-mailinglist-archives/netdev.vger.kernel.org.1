Return-Path: <netdev+bounces-37854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3E7B75ED
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 02:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 985C628139C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAA36A;
	Wed,  4 Oct 2023 00:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3956182
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 00:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1198EC433C8;
	Wed,  4 Oct 2023 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696380025;
	bh=KetrmMAUGEXoH/6y1Ezjmso7zLcGbqOzBEqDa1SojPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKyxnqp1my9u0QlzHSvo9iTdc0aI53pI8CsTyrYpulswazmsQuWb4pMUUD45x2ydT
	 5eviY/hv90t8T83xoqTC62MeEof8PplMJoAHJyfz+sSNBqDeN3QwH5hvM52fpj/8Ab
	 M344gYZb2uczvcE3LrquXKJz08tqsT9j7mowt6NbOethUEkfbAuMRjBll5KFp93CqB
	 W+mAHdsjWP2q16Z7WKRyOUT2GquIMedRcp3rO3S8WfRRsZXA9IZ1bRqi+T+Xc+aZu3
	 Pdx+ZA3efNuegwm88QsbE/1ea95uxrtoRg+NmECFxDj0itlk0FNxuwpjHzTpUx66DJ
	 y9x5IfeHpvgNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3DB4C595D2;
	Wed,  4 Oct 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] rswitch: Fix PHY station management clock setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169638002492.30838.643667282615565934.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 00:40:24 +0000
References: <20230926123054.3976752-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230926123054.3976752-1-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, tam.nguyen.xa@renesas.com,
 kuninori.morimoto.gx@renesas.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Sep 2023 21:30:54 +0900 you wrote:
> Fix the MPIC.PSMCS value following the programming example in the
> section 6.4.2 Management Data Clock (MDC) Setting, Ethernet MAC IP,
> S4 Hardware User Manual Rev.1.00.
> 
> The value is calculated by
>     MPIC.PSMCS = clk[MHz] / (MDC frequency[MHz] * 2) - 1
> with the input clock frequency from clk_get_rate() and MDC frequency
> of 2.5MHz. Otherwise, this driver cannot communicate PHYs on the R-Car
> S4 Starter Kit board.
> 
> [...]

Here is the summary with links:
  - [net,v3] rswitch: Fix PHY station management clock setting
    https://git.kernel.org/netdev/net/c/a0c55bba0d0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



