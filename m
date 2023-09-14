Return-Path: <netdev+bounces-33824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADD7A0646
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C4FB209FA
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92021A0E;
	Thu, 14 Sep 2023 13:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CA11FA4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E577C433CA;
	Thu, 14 Sep 2023 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694698827;
	bh=iqVvYLbChfVjfOdZ0uXuPkd9eZ3iwejfpi61u7RE3dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KA7bs88y8mRPXG9FOL8NnPAbUNDZOMdYUDlDxG9o2px5ceq0S4Y+Rt7O4fnN28zeq
	 hS+LZcNO8TXft0ILvkzKRKpkgfww4qX/lEeZ+OQIi+/fWX8qVkb++nDTd6zhSHLc8c
	 CPROPb927Q8qMrHSHTgM5g5W5wjKJtu+xgtOIxLkauX0DczNlhNI/LzYRpuljZoHDP
	 34A+d5SOFXQ3yKw5xhntMT+9E3e2A+Y3PzmzWrgIhIWbER/pYCuzo+QNqLWuXOcSyX
	 pgo9/zztfwAtHDTEWIlFOhz+/8yLqyu2iuDi/1LRSw3/7KpjhMLIW9NIcRjmFZrdCc
	 ImiqbdS7o0P4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9785E1C280;
	Thu, 14 Sep 2023 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: rely on mtk_pse_port
 definitions in mtk_flow_set_output_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169469882695.12542.16765686485820393186.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 13:40:26 +0000
References: <b86bdb717e963e3246c1dec5f736c810703cf056.1694506814.git.lorenzo@kernel.org>
In-Reply-To: <b86bdb717e963e3246c1dec5f736c810703cf056.1694506814.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 10:22:56 +0200 you wrote:
> Similar to ethernet ports, rely on mtk_pse_port definitions for
> pse wdma ports as well.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: rely on mtk_pse_port definitions in mtk_flow_set_output_device
    https://git.kernel.org/netdev/net-next/c/5c33c09c8978

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



