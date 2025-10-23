Return-Path: <netdev+bounces-231964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58570BFF099
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04986352D2B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC522DBF40;
	Thu, 23 Oct 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCLEK/2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A572DA76A;
	Thu, 23 Oct 2025 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191185; cv=none; b=HNCNLw1kRi/8RnNCl3v6K6xglRjaX8RrJY+nWrO7uKrHZEoVaCBX2BvirWF/a9/+ZlMRWSGF6EujOdgSvA0sRUbvDOUp1kPIBNf7HxeMmrMZqxMoHtrsVA2BtItH7NYzIpyjHnZw8WFBgzqTcPidbcDkXAd6Qeob+S9vVb32svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191185; c=relaxed/simple;
	bh=AB8XAeu+F/XX+PcokzhuE4hhP97fMxn/dhiEgCWBJFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qhiKQvd8NF/rvo4cJKvUn4cOwo/m75hLYdNAFzhMLabo24PA36zqLL4KzPeFk/3FBCwCJ/ExUXMz//MIxFkbYSensgmkSV3XYuR9F1h1Lhhakbda83I6CkAPb+YdSEkTO5nl71KngXLnj2kvwHGTxsoo78UAerIw4NZnbOkeJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCLEK/2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC654C4CEF7;
	Thu, 23 Oct 2025 03:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761191184;
	bh=AB8XAeu+F/XX+PcokzhuE4hhP97fMxn/dhiEgCWBJFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vCLEK/2h6pqyWP8x2LLawhfdxc476HeUfgkfzDFMFdPCAmk7ekoz1vQiidYLSwSmf
	 Wql1xTubiBwVuo2d2HGPHBXMyLxqCy6EFYCzhEyUE3fpkfvbxQk1DinXRbabpnNGZp
	 i18Mrgw8HgnufH6DzDuQvb5hOktvLRE9vse/dvRN4y509tldqxYtkCKMv0CmFmh9ah
	 tegMRZ7xG1aMjqxmnmFryDxk+twBitAkUbPAesWdc19JkTN1NCtS244g3+IvCiwdSP
	 WMeYFKfNIyKZ2PkcSaMJUlfSj+Yg8hxfW+uEwUMRovPZKkDzXTRkF/svAk0p8KrfFM
	 EZPCc7vn8shlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFB3809A04;
	Thu, 23 Oct 2025 03:46:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ocp: Fix typo using index 1 instead of i in SMA
 initialization loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176119116525.2145463.4425771831722355554.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 03:46:05 +0000
References: <20251021182456.9729-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20251021182456.9729-1-jiashengjiangcool@gmail.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 18:24:56 +0000 you wrote:
> In ptp_ocp_sma_fb_init(), the code mistakenly used bp->sma[1]
> instead of bp->sma[i] inside a for-loop, which caused only SMA[1]
> to have its DIRECTION_CAN_CHANGE capability cleared. This led to
> inconsistent capability flags across SMA pins.
> 
> Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> 
> [...]

Here is the summary with links:
  - ptp: ocp: Fix typo using index 1 instead of i in SMA initialization loop
    https://git.kernel.org/netdev/net/c/a767957e7a83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



