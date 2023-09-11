Return-Path: <netdev+bounces-32788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E0279A6FF
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FB21C209AF
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A3C13E;
	Mon, 11 Sep 2023 09:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24768C120
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89FA3C433CC;
	Mon, 11 Sep 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694425828;
	bh=eFYUf/yl5b4TzINWy5Wt4CBjKCBg34fkX1bqpWy5h54=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kf8Gw9Vvo08R4hDLDffmX19QVcH66QF++lX78jwWg1CztUb0R3kpByyqXyzMYOdUD
	 i+/erGknBnWbS/f52odAjxqhe6dNPM4vfVMamtNWdT7uW7jWvL1pctr3I5/ckRglqd
	 xCEW7lkH2LWvM9elmKdgTMwLpkiQdDAQuVIe6t/gEKxnXPIu6MuWZTu5qE/kIQTlO5
	 xaVzveqnNillGw4WRppasiDqmalDYCMYqKxjR/g+19jcU0vH3+azfCM8JGKJVTx87g
	 kc5HcE9hyTKkR9Luwm/dDQ6wNRDFqVYCx66mjVgLMLSNboJdUCeRl9GoQE2w+hbmx6
	 L8y714aMXNF9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C1EFC64459;
	Mon, 11 Sep 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix pse_port configuration
 for MT7988
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169442582843.3586.1128151725719459860.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 09:50:28 +0000
References: <717829d0b5aab2fa757e4de79a6328dd7a5b0a3b.1694284783.git.lorenzo@kernel.org>
In-Reply-To: <717829d0b5aab2fa757e4de79a6328dd7a5b0a3b.1694284783.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  9 Sep 2023 20:41:56 +0200 you wrote:
> MT7988 SoC support 3 NICs. Fix pse_port configuration in
> mtk_flow_set_output_device routine if the traffic is offloaded to eth2.
> Rely on mtk_pse_port definitions.
> 
> Fixes: 88efedf517e6 ("net: ethernet: mtk_eth_soc: enable nft hw flowtable_offload for MT7988 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix pse_port configuration for MT7988
    https://git.kernel.org/netdev/net/c/5a124b1fd3e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



