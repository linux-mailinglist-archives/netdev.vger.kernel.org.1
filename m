Return-Path: <netdev+bounces-116678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BD94B585
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E66B2241C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779AF14659C;
	Thu,  8 Aug 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYSUE26L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B4145B26;
	Thu,  8 Aug 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087845; cv=none; b=fkyoKyjx6bEYlhBhFEduJQQTUaJuYNvWAIn7YRgcnoRK/MS0/46MY+8eB75h9UWbMngXB72RropN/FS+BJHsbg2RIzIOnNQFVrrCKdbSMRiz6v3rZ1Z1i5mYJ4yIK9bj6h0HXg09l2RD0z8AfWs3chd/YSusuEHKs5emsm5PoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087845; c=relaxed/simple;
	bh=IORmMplDJEWb08I15uz80btVIKU0/cstZc4wUs5vtxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgVj3lP1ejvF0t+NdgNdsjetakl3H3BkngFydhd0psb38F/gTR/BPIRNgdxp/fdh42c8kbpJdRasZw481xVAaDEuSYvjJyHxCNff5ERpFMofrsVob/Y4Z8dfi2VjLYFE/kllkbFwA7iNRjEpDMGAB57fqfinbLvfT/7L0GgCd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYSUE26L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB0C4AF14;
	Thu,  8 Aug 2024 03:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087845;
	bh=IORmMplDJEWb08I15uz80btVIKU0/cstZc4wUs5vtxE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iYSUE26LC9buY6kc4f7UXSXApPDfPODhu8WOx1IRaAPcRGV89zjUML8xwTLr5/N1A
	 sEI3xFYuO+b6/IaZ4CTDV+6rW5IGIyGRkiT7HmelmfHz++ObWz7ICNQR+qiY79OWTB
	 RMpgFFn5ndya4Z1an5WJuhqMqx2Y8vj5VXjtBUp9wpMl+1jZK7qsOu9SXrkDeFK/qW
	 D0JSnqMBjRTGaRvRU+J61w7hHUAyRCPUWL8AknhPFLM+4wSp1ZREkxP+4fK/AMXhv0
	 w/y1zdWO7ADANmnHrl1u8IW1zdWI92V3PV9A0039nVvfrfPnRilU2+zt4P4OT6GMTj
	 gX+m4+7fpNByw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FDA3822D3B;
	Thu,  8 Aug 2024 03:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308784375.2759733.7700541552729739768.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:43 +0000
References: <20240806021628.2524089-1-festevam@gmail.com>
In-Reply-To: <20240806021628.2524089-1-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, festevam@denx.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Aug 2024 23:16:28 -0300 you wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
> RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.
> 
> The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
> allows the compiler to evaluate if the runtime suspend/resume() functions
> are used at build time or are simply dead code.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
    https://git.kernel.org/netdev/net-next/c/de6c7b9ada33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



