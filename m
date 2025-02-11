Return-Path: <netdev+bounces-165030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D05A30203
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF39D3AC05B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FBA433C0;
	Tue, 11 Feb 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLkr/gL7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12526BD9E;
	Tue, 11 Feb 2025 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739243410; cv=none; b=DjrejOsXGOtAnnNyRu3DcbWGhM9Kpo0XxQPp39MgCiDMcChmn/tyoeTrglDq8Otfdou10wK9VNROFJWGnn7IximB+2Wv/xlVE2JwSmbFJTEcR9ZfOEMGFrSV3z2LN3g/k93Fa+RTsFpRusHNsJS8gfnqWOSUqEEnttM4yBMNVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739243410; c=relaxed/simple;
	bh=YJOBToaYzUqd9DyOP+SvGJW2ufNR3336/zAErdq2/20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDsZzjiI24K9HWoJWYh2p4Net42kW3F9h9ep3ebV/0nJpegYMZYz8fHWki4BxtUaJnN/3/RGE/56Sg+Tbk/yI2GTWIam0uPTJR930XOdztlM9cg62nUO+X0FCiAiXOhPVTjT2vQpFGAAotlYSG84lAheIvjpy6GV+QpOH2F8I0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLkr/gL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E1DC4CED1;
	Tue, 11 Feb 2025 03:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739243409;
	bh=YJOBToaYzUqd9DyOP+SvGJW2ufNR3336/zAErdq2/20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mLkr/gL7GMILaca8r3fdPmR6S/WLp5cbubv6Tl3v8+jFnUHALuNsMMlDr8YZ83rya
	 nZ/oAOgdzD8RFRGOx/rIFBVb8ywXdpThLUZxZhIFx++7zjR+/RvIE487pTKveQLcva
	 5Etmfshvb9TgDDJEeQQY0mwORHEhOWEen8GJcRIa/gii2pEaa8LsjqGaRmQOsBnduX
	 1n7vw9QPl6+hzei77a/g3blE4ht7UAsubqExNy17webSDmy4qdToLCpqKuMLoO0H+i
	 FWON+5tLp61Md5fB3weT6e1Reus7bTpmLc1IIZFnVIq3do6aoZ5/PhuXaEeuy9srHF
	 TdrVUOUvp4DMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 25F22380AA7A;
	Tue, 11 Feb 2025 03:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/4] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924343783.3943945.3127869136485517111.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:10:37 +0000
References: <20250206201036.1516800-1-sean.anderson@linux.dev>
In-Reply-To: <20250206201036.1516800-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, shannon.nelson@amd.com,
 hengqi@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 15:10:32 -0500 you wrote:
> To improve performance without sacrificing latency under low load,
> enable DIM. While I appreciate not having to write the library myself, I
> do think there are many unusual aspects to DIM, as detailed in the last
> patch.
> 
> Changes in v5:
> - Move axienet_coalesce_params doc fix to correct patch
> - Rebase onto net-next/master
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] net: xilinx: axienet: Combine CR calculation
    https://git.kernel.org/netdev/net-next/c/e76d1ea8cb18
  - [net-next,v5,2/4] net: xilinx: axienet: Support adjusting coalesce settings while running
    https://git.kernel.org/netdev/net-next/c/d048c717df33
  - [net-next,v5,3/4] net: xilinx: axienet: Get coalesce parameters from driver state
    https://git.kernel.org/netdev/net-next/c/eb80520e8a5b
  - [net-next,v5,4/4] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
    https://git.kernel.org/netdev/net-next/c/e1d27d29dbe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



