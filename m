Return-Path: <netdev+bounces-44050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B22DB7D5EF6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4094DB20E42
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089C197;
	Wed, 25 Oct 2023 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA0pGddd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D77E2
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E721CC433CC;
	Wed, 25 Oct 2023 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698192622;
	bh=YLDQBj8+Yu+/E7BY6nQf4EifcZw9wjsm+tGAZouBt4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pA0pGdddtzazAnpRGtlbvUpgLREUnMrrB9v6yuKuUjNYRYGKkxrPh4cCQiYeYTznG
	 V+9pTa4YNFUBYcgLDbaB6UMqhCxjfO9HN25hHPY1TOPI4gHl/TxHnXas0hfZHDTObK
	 V0JXG1B/b+KbARrb5iE5/COp91/JDCMnEA8CwOJLfjZjYI2ro5F6uX1ZA87lgV2ogs
	 J8fGidZuovj5qoQwdsy9El/+n0Z/+bNYQUlNPC9YHYGEf8qBi3RKd2ggf2d9O+DVH1
	 4+FEzOCakP42avsGQOsRS6FJ/FPXKCOGvR7oXCkwA2vbkA0laJF7yXBZR87wNXt5lf
	 xZwK6OYwDgUgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D313AC595C3;
	Wed, 25 Oct 2023 00:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: fix firmware loading for
 MT7986 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819262286.24368.12218883035253058278.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 00:10:22 +0000
References: <d983cbfe8ea562fef9264de8f0c501f7d5705bd5.1698098381.git.lorenzo@kernel.org>
In-Reply-To: <d983cbfe8ea562fef9264de8f0c501f7d5705bd5.1698098381.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 frank-w@public-files.de, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 00:00:19 +0200 you wrote:
> The WED mcu firmware does not contain all the memory regions defined in
> the dts reserved_memory node (e.g. MT7986 WED firmware does not contain
> cpu-boot region).
> Reverse the mtk_wed_mcu_run_firmware() logic to check all the fw
> sections are defined in the dts reserved_memory node.
> 
> Fixes: c6d961aeaa77 ("net: ethernet: mtk_wed: move mem_region array out of mtk_wed_mcu_load_firmware")
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: fix firmware loading for MT7986 SoC
    https://git.kernel.org/netdev/net-next/c/c35d7636991f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



