Return-Path: <netdev+bounces-144680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8B9C81A7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA691F23AB6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02711E9076;
	Thu, 14 Nov 2024 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzlhoKEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50361386B4;
	Thu, 14 Nov 2024 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556817; cv=none; b=LKPk8v8ueLBUz66YgjOVXREAm5ghW9vDSkTmOgfUWOav7X6ebs6NpnUMr2GYPCasnjTh4YLwDsTip3Z9z226JTPbCRPJYx2oC3qlN5cVDncdMpqPi2GVm/ZTx8JFxMBHPecNcBqf0P6f8s9YTlroiV4pjPRtMar8D1yKKxFTyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556817; c=relaxed/simple;
	bh=oFyEqg+Wi3bg6Jd+vWNtNIrKr6QAtBEfuLjYAZvCcL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E9aEe4ABGFKSz5AR2DjcfMiAaBR404d5JHnowefEyrNOP0oe0usTmS3954umBKLLt0RVng+18YYEOI9yBvtV0MJXrwOewrd8EjGYKkXubW9pUp8E+abQV01DbvtORCAmvgcGTervN3tfBkLmnRFbz3TNOAGtU6YV2x+2oJu4DCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzlhoKEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45061C4CED0;
	Thu, 14 Nov 2024 04:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556817;
	bh=oFyEqg+Wi3bg6Jd+vWNtNIrKr6QAtBEfuLjYAZvCcL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzlhoKEX4I76OAJB7pvtu5Ze2fcts8G9x8h3GSAoyP+KzoIy6C5/xzXwvJ9Ep05u8
	 HGGXkG+jktDO8LFOvUNZU/ddThiPLLQDlOVwAYralL/jhT9CqiImtgl2iTHIo+V70c
	 fzxkZwtkr2kIMratdRlGfnI66ekfT7VwI7UE9vqUig6MPC0qG++QT32oISGBRJFjAd
	 pDKVCff+API3hcYNfNkJLWMGrQFtWcOYRbtB+u2toKx8cF5z1QdUFBARoLRVWMtYsH
	 6zm+HjIMidPwri3aAOWhkZSvfP98AJ3cUysWAaaKz1N5NgtQioSJ7tQs7ry+U6kp7u
	 3y6Nj1UQ1PI7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBF3809A80;
	Thu, 14 Nov 2024 04:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net: stmmac: dwmac-mediatek: Fix inverted logic for
 mediatek,mac-wol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155682775.1476954.16636894744432122406.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 04:00:27 +0000
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
In-Reply-To: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, bartosz.golaszewski@linaro.org,
 ahalaney@redhat.com, horms@kernel.org, kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 09 Nov 2024 10:16:31 -0500 you wrote:
> This series fixes the inverted handling of the mediatek,mac-wol DT
> property. This was done with backwards compatibility in v1, but based on
> the feedback received, all boards should be using MAC WOL, so many of
> them were incorrectly described and didn't have working WOL tested
> anyway. So for v2, the approach is simpler: just fix the driver handling
> and update the DTs to enable MAC WOL everywhere.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: stmmac: dwmac-mediatek: Fix inverted handling of mediatek,mac-wol
    https://git.kernel.org/netdev/net/c/a03b18a71c12
  - [v2,2/2] arm64: dts: mediatek: Set mediatek,mac-wol on DWMAC node for all boards
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



