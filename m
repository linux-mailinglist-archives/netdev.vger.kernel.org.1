Return-Path: <netdev+bounces-169231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A1A43033
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CFC7A78A8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33DF204687;
	Mon, 24 Feb 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSC1h7n9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FB207DED
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436813; cv=none; b=efwsR/iQAAGhVFv5Xf5ZmAOenhc/zkLT8ESmW9myRiXDsCIapSrKvpWDAeHIsrXQC/7PqUx0srA3oJupXoHQXSZEGaen7ZPjYPrcyA4Yi3QsL0Oa8MFAhL2JIk3o+Xb8gD6ouzmS+OTIUeNhwwrEvWCBKUEQH8ZX0PIqHTLotaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436813; c=relaxed/simple;
	bh=7OgwWkTR+dw0Tqyw5er0axNmGjTr5b4RO9FTtda++rA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A1umAmNGBUg4RVVp1tzD+U3v8pCGxhohtmv+1aziuJCkhlxA0HeWRDTDDMlSHbJ1iLpLlQaC1LFBrYOyAalDzKFpf/Fu7q7afRtIdy9UB0cRIpSwrgq1E6quDFRsT1N78DmuM3W340nlSjVjGB5nENyligIGt2H7bDg6ddaHafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSC1h7n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB35C4CEE8;
	Mon, 24 Feb 2025 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436813;
	bh=7OgwWkTR+dw0Tqyw5er0axNmGjTr5b4RO9FTtda++rA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iSC1h7n9mcw5ovxEzPZs4Uit31UD3bCjZoIPvv3lAw64A/6SFv8JGEEORBdklogVy
	 6YstAptx6WthKu6FTXizx1bXkfqld/MGj39fd4sGptLWkxtgvsP+vkPPje226ePUNt
	 aM8oBbmuFScQh4LlovzNFE6N7SJGGz8ZK9r2UCr+AT7G5BHxrRu2SIUxG7HK7hqcHq
	 nBM59H433UDJqN/nRACN4w9shW1pXQ0hV3W3xvPi28wkitpEV9dHZ3SiDWocXFW38P
	 JHIupu6Eqgeb8X0XMgxsf+cotAcKM02Mse2AyBE80OcM4NcFiNI9ub6waiskAXOzXf
	 CDnABboVEvZDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE347380CFD7;
	Mon, 24 Feb 2025 22:40:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: thead: clean up clock rate setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043684424.3634134.11083697589097973471.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:40:44 +0000
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
In-Reply-To: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, drew@pdp7.com,
 edumazet@google.com, wefu@redhat.com, guoren@kernel.org, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 14:15:17 +0000 you wrote:
> Hi,
> 
> This series cleans up the thead clock rate setting to use the
> rgmii_clock() helper function added to phylib.
> 
> The first patch switches over to using the rgmii_clock() helper,
> and the second patch cleans up the verification that the desired
> clock rate is achievable, allowing the private clock rate
> definitions to be removed.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: thead: use rgmii_clock() for RGMII clock rate
    https://git.kernel.org/netdev/net-next/c/171fd7cb153c
  - [net-next,2/2] net: stmmac: thead: ensure divisor gives proper rate
    https://git.kernel.org/netdev/net-next/c/8bfff0481d91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



