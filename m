Return-Path: <netdev+bounces-184025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AACA92F87
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCCB8E0DC6
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C7925E46E;
	Fri, 18 Apr 2025 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaHvwIFA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD925E467
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941021; cv=none; b=QEvOHaE/0/A9uAMjruYyhQljFxl49sxLFXn7u4CGrDyqqbspzAGCOHXel7+V54LOrpP7MrT05QwNN+dW54ZSH8EkgXDPZjdAFFxg3wzoIlMF44nW0xytmKs3vGKyZS016Amo+K7Llyz0fgMAixS7Fl8y8qcd0ZEtaJ54qk5LUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941021; c=relaxed/simple;
	bh=gECNqAfi0tzAirLvp0LdlAcNtPrmWy1fuTeTaPseC6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=al5h7OffpcOrpuYA7Y15rOQofv6jHD8liVRTPYtV5Ozzqy+CZiH+dWFj6U13My1wYYLygjuUPBSb0j2TPRfLspiIarg8xKelTc3dWkzEywyI3GyfGGkeK8T5LRFyD15P5FIxRvLh/tXGpCq0/DBVlQLdaayxVQWYWYHE6sFF0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaHvwIFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406EC4CEE4;
	Fri, 18 Apr 2025 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744941020;
	bh=gECNqAfi0tzAirLvp0LdlAcNtPrmWy1fuTeTaPseC6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PaHvwIFAdZyi1Vw9lbt1q6cqPRkKgpk1rWuticsgRDiv5c9DkSp5kO5WAWoUMbCPn
	 f0e1Uc3SZ+209ad+UkixRDuleqzlOlprBSUwVdfYry6hZoe03kBrOnqnxxlUCBd6Wi
	 RqSssnywLalbeLiXT66iCFEj5B1dKgVc3SljJqjEdhWuisqa1yUqvLv+yhgEdpYPkR
	 e2RmOcUndmtobUMW2sFMEKb7icSH3BdClWehoBQnjQ5cf99SEKW2qbxyEr23xOoWeg
	 JiGajTQmjsCmy7JfaCyFn5w7U2EtvgNReGCSb/8WGZ7awm2ZsPTp1Yl0ViQ5N9nYXI
	 J59sl74G4EdQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE47380AAEB;
	Fri, 18 Apr 2025 01:50:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add RTL_GIGA_MAC_VER_LAST to facilitate
 adding support for new chip versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494105844.75375.3332374808078592951.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 01:50:58 +0000
References: <06991f47-2aec-4aa2-8918-2c6e79332303@gmail.com>
In-Reply-To: <06991f47-2aec-4aa2-8918-2c6e79332303@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 21:39:23 +0200 you wrote:
> Add a new mac_version enum value RTL_GIGA_MAC_VER_LAST. Benefit is that
> when adding support for a new chip version we have to touch less code,
> except something changes fundamentally.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h      |  3 ++-
>  drivers/net/ethernet/realtek/r8169_main.c | 28 +++++++++++------------
>  2 files changed, 16 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [net-next] r8169: add RTL_GIGA_MAC_VER_LAST to facilitate adding support for new chip versions
    https://git.kernel.org/netdev/net-next/c/fe733618b27a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



