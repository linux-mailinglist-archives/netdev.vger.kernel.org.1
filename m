Return-Path: <netdev+bounces-154874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ADA002D3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37622163135
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7A1865E9;
	Fri,  3 Jan 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfqpTpl5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D8160884;
	Fri,  3 Jan 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872013; cv=none; b=r6h3y1BxskE7Pg7cxRByuJy4O7cHOBl6+sZgsp6JdPjHERCBya06tRuixrLv0wjMngY+VWigeoKuraTLoqoGBxYQqlOsQOP5enY4vlvsRD1Ktnrseqy9oDBFlPrP4sxkYZDnEokIr23njdYAkIWObpLV/wyYsiJuSCNlf0JKnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872013; c=relaxed/simple;
	bh=1AsWfbNlCFqQvnlvtsPVgikvB2lUrOXRFL1YevhcMMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZwJrVthM8WZlBG2Ac4CbPUeyLxl6dUf81NumKdgE6s1D4s80g3umjr6NizurhW7SwbjGrGXEo3CJ5+kkDTYYlgmmfkXUfArQxpx9qCfz3O/PQUbyVVTGXzGNXTAEzleHmxRXLLQ53h2RxkJds9Um/SikmOcPU/9n4LlNCodYLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfqpTpl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53661C4CEDD;
	Fri,  3 Jan 2025 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872013;
	bh=1AsWfbNlCFqQvnlvtsPVgikvB2lUrOXRFL1YevhcMMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfqpTpl52QaJnDjBIN5um7S7uyLHmJb5+j7M1m8QAzcoxZXmswSSq84GKmN0cBaP+
	 60J6UjSOP+NvkxqzihFtakqs/RT5wNtzoIJ+nOeH0/HjEOaa1K+uPXNdjtl+AJxz7S
	 7LIeCiJr8ovcowX7pDwi+GASl+R7tcSggKZ9GmxzUVb3zcJ3OPt+xZwq+L6Noa/CwM
	 86KYotsciFyBGuE2YofuGrU2C4BtV61I43zjO+EBXgXVIx7uReLGhZ1SJHLHkXXGUt
	 anlOvqUbIzaPHcpFAqg7optk2U2zzT8rKaJvlOsT1P+HDIVqNkcOeIaLYJ0S7LSuKD
	 7/VRy+Ld5uEfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF6380A964;
	Fri,  3 Jan 2025 02:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dwmac-imx: add imx93 clock input support in RMII mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587203350.2088679.877800854993230996.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:40:33 +0000
References: <20241227095923.4414-1-othacehe@gnu.org>
In-Reply-To: <20241227095923.4414-1-othacehe@gnu.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Dec 2024 10:59:22 +0100 you wrote:
> If the rmii_refclk_ext boolean is set, configure the ENET QOS TX_CLK pin
> direction to input. Otherwise, it defaults to output.
> 
> That mirrors what is already happening for the imx8mp in the
> imx8mp_set_intf_mode function.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> 
> [...]

Here is the summary with links:
  - [v2] net: dwmac-imx: add imx93 clock input support in RMII mode
    https://git.kernel.org/netdev/net-next/c/94c16fd4df90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



