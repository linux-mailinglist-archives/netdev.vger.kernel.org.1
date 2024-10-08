Return-Path: <netdev+bounces-132927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB097993BE1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D071F24FD7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422308494;
	Tue,  8 Oct 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmzXtG5H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20429A5
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348025; cv=none; b=t4y7BESUejGr8m8jiJCTUtYmJ/3JJdW4tRiJ1NkjrTmgEYqYDcirNWJ6XACQSLbwwRr2Okt19xq8Gss8zLlO6/j2mByl6zd6NMx37pgnG9c81lQhyiVTQMRG0mPX8sxzRnsQeUtPYOz45PTO9Ti1DXYkQhTEaB5BCF2FPNxi8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348025; c=relaxed/simple;
	bh=ngoL8tWnqZwdr61VyVfbRw1NEBAJJIYMc6WKSCo/joA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mfaKLNf4uyixTScK6yn7Syt6MBj7Rj2Km3YBoBXxqk/LFWYgxKtmNQlZDBBpbd32f9g2TcCzTh5CQJDBgx5yYGzq2GZEcOjRXGg7x+MOcQJwoPgD/+Hs9DBrhCN2c8cbqtf/lOaHgV2Rt+Gm1csAma4cD4yEUd1RIB6OuUO2KPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmzXtG5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A320C4CEC6;
	Tue,  8 Oct 2024 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728348024;
	bh=ngoL8tWnqZwdr61VyVfbRw1NEBAJJIYMc6WKSCo/joA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UmzXtG5Ht6QMy7jWPXeZqckQChXYja8q0NRB3IoiGlyn3+8aPb4QYkAD5TuiRhHEm
	 sTolPsBfOjDMFxfuaaV+vwCfEeWK5SHsu+8ilN3s6Pp9KErfPkszMlRa9yoV2T2FTf
	 uUBc3jEv7nbZjOi+d2D1NcEktCsyIpSf5o+yA1HAsUb/UAISPOe8IZ0DrFVYjke/x+
	 31Zf2n73hI4dK78Vti2QV7A9VfOaJ7OMNPSjXXO/WwqT2fLSKGVgyngYoxG1892mMr
	 4E4haErqyE4OBXvYaD5jnvzTEqj8xQuKCf1LdovtrTesJq8EOOtT00xRPT7GcTgQ+E
	 zZzNkeR85sg0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCF3803262;
	Tue,  8 Oct 2024 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Update tx cpu dma ring idx at the end of
 xmit loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834802875.31485.3860611664672766759.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:40:28 +0000
References: <20241004-airoha-eth-7581-mapping-fix-v1-1-8e4279ab1812@kernel.org>
In-Reply-To: <20241004-airoha-eth-7581-mapping-fix-v1-1-8e4279ab1812@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Oct 2024 15:51:26 +0200 you wrote:
> Move the tx cpu dma ring index update out of transmit loop of
> airoha_dev_xmit routine in order to not start transmitting the packet
> before it is fully DMA mapped (e.g. fragmented skbs).
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Update tx cpu dma ring idx at the end of xmit loop
    https://git.kernel.org/netdev/net/c/3dc6e998d18b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



