Return-Path: <netdev+bounces-230627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386CBEC0FA
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B601AA7DB6
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35BF4FA;
	Sat, 18 Oct 2025 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Qyqzti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7F10F1;
	Sat, 18 Oct 2025 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745629; cv=none; b=fPtumw+suU0aShdlncH97mpNaE2UZ6mfuBzBbEjMs5JIAp90j5Fz/eX6+8BLDsP7ZgJ4zYjxc1aIk7hwdvLj6y4aIBfx5sryEbUlBS4Fdob0HfHDCOLYarfNLl0aLEH8rxAle887XZldFBG3jEz80UQ4SNf488xHCiPYRcbYc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745629; c=relaxed/simple;
	bh=YnM6EsfCCpRhahIOYEdZz+Cepq+/DrNPJAmLfhIdVdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTBxDU3byYtZOZZd4eAhZ/eHRZC8QTdyIB+9beOyuakQTa4vAp/D+TdzfFdZQ+n2YRr+BVm6fucKeZBhHYKYcqRrxElf613R/SEqncE86s4Gs53gd+OQlXfoEV1Q+dkvx9/PIhV+DpwbfHZuEynqiM227jLjLcJoL9j0QmV51LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Qyqzti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77602C4CEE7;
	Sat, 18 Oct 2025 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745628;
	bh=YnM6EsfCCpRhahIOYEdZz+Cepq+/DrNPJAmLfhIdVdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p8QyqztikcGDnt4V48n5bsdohG6hV9tAJn8wegNqi2hKOF5LLNGpxlPGFy5jE1xFd
	 aAdnFqtZTFT7jTGCUKcN7u/cSrOcKHsadRGO0PyGOKu0t6xOA8T9jXiJG7E7NVMhhU
	 zSvo42H6mIpROGLL/N17AMw65KJoWZuCXSesfDhehp0aNfm6Z6xbTBSlxdbTMK6n4U
	 jgfX1G8578IBCKDllc5PV/SDwbIFLxLZxarYSMKZCKPePmlwKVBdgrJCobzP3qJZb3
	 QvZ+ckzIowa+jn9iR2Iddf+CfJQNoguPaiNMltvuiP81qo9AgsI1Dh3segqeKGafBg
	 T4R7SB/JqClFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA839EFA61;
	Sat, 18 Oct 2025 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: enetc: correct the value of
 ENETC_RXB_TRUESIZE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074561201.2830883.6352222282006424716.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:12 +0000
References: <20251016080131.3127122-1-wei.fang@nxp.com>
In-Reply-To: <20251016080131.3127122-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 16:01:31 +0800 you wrote:
> The ENETC RX ring uses the page halves flipping mechanism, each page is
> split into two halves for the RX ring to use. And ENETC_RXB_TRUESIZE is
> defined to 2048 to indicate the size of half a page. However, the page
> size is configurable, for ARM64 platform, PAGE_SIZE is default to 4K,
> but it could be configured to 16K or 64K.
> 
> When PAGE_SIZE is set to 16K or 64K, ENETC_RXB_TRUESIZE is not correct,
> and the RX ring will always use the first half of the page. This is not
> consistent with the description in the relevant kernel doc and commit
> messages.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
    https://git.kernel.org/netdev/net/c/e59bc32df2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



