Return-Path: <netdev+bounces-175437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6BDA65EC5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5F93B6CA2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8C1EB5EB;
	Mon, 17 Mar 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzbAd2td"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DD1E1DE8
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242202; cv=none; b=fkzbXnh2CKsqfrMikus6BeVunGqyuSkwT9+HPbWQH5l0PNUGKCQnWmgzjvpY3dMNZFZFNrxUzktlC3lKXFSvUjkuyQJCQ5ZbyOlDXp8COM0/vUEIWwl1CZrqyfN7XD1g/P9by/2FOvDoMzxJ2DZf74MI/kqj4wcqi9ia3rvtNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242202; c=relaxed/simple;
	bh=Ey1SBS4ShbmGT7DZaMUC7tE3gXSusJniWJJQ6Dm68Oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HAzudSPKBWwZfPRr3yrPyx2270eYjs3DOpyTWJu+/EVorGGZib0PYLrRBjxuOQRl7Lvwv4q63LlY5MGRengC3czg+ZURyMz2gYxVwGVqNc3ElQNifTMm5NsWBpelZdDNUvpV+6Wtv1GzO35lO5PISdQBp3nyVsLPcG+j7CLE5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzbAd2td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B87C4CEE3;
	Mon, 17 Mar 2025 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742242201;
	bh=Ey1SBS4ShbmGT7DZaMUC7tE3gXSusJniWJJQ6Dm68Oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pzbAd2td+FYJ5O7ZseV9yJreWHmHWQ0kQDrq0GcBFi8EHYbjD+7hOteWA2kSdHM7h
	 bsB92crCTFJrez6mVHcOzjRS5TqfRihg43+9/inU4lm3fBqrwuoXL73hMcA2v/wGO5
	 EW7fhb3WWmB27s6V5D2ztD3p8AANSGt9CCimM5H1SD/0t+CNQYvdohJpHSQqOTyFwn
	 0gCa+hFsmfBqeFIEG2lFEpuzB7jxLmcWuu9yGsLZo8dVG1Z4x9Ss9XY5Ngym4VDuhG
	 hXb8uXOmu9JMuTGqI+viVF7zWAeriDDnl0J8g58yzLjSNcBlB+p7hTbPm4Yb4FDt1v
	 Wdruj6qHrhMhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3502C380DBE3;
	Mon, 17 Mar 2025 20:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: phy: clean up PHY package MMD access
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224223700.3899230.17257287936772541344.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:10:37 +0000
References: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
In-Reply-To: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 9 Mar 2025 21:03:14 +0100 you wrote:
> Move declarations of the functions with users to phylib.h, and remove
> unused functions.
> 
> Heiner Kallweit (2):
>   net: phy: move PHY package MMD access function declarations from phy.h
>     to phylib.h
>   net: phy: remove unused functions phy_package_[read|write]_mmd
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: move PHY package MMD access function declarations from phy.h to phylib.h
    https://git.kernel.org/netdev/net-next/c/43e2aa56aea2
  - [net-next,2/2] net: phy: remove unused functions phy_package_[read|write]_mmd
    https://git.kernel.org/netdev/net-next/c/8ea221b22172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



