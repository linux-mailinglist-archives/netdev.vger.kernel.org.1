Return-Path: <netdev+bounces-136879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C69A3728
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230401F222EF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6A513A40D;
	Fri, 18 Oct 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncJphnVH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638713D96D;
	Fri, 18 Oct 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236645; cv=none; b=cNlZEIdvpvMXDx6EvP2jSDAsNSL5v6rOwh2zG6a1MybBLcIscAM3aV/QG9uC2lOrz7CQlruCpnsvz62dp1ETKpl1VwEAxbMztB4FWaYyggVyoNK4y/55oDG1pk2iyfA8flMsZTurkTI7RBKd5K8b5A26DblNpOf0lawUDV7KWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236645; c=relaxed/simple;
	bh=m43fdzdIoDLBpaLwCnX4Nku8XgZwC/0ohcah5I8Q/7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dRiVUPx0LIRuOsqYYPCOLWhEtHtFP8rjrJHKSCsSHIm1rXz9Ip/sOE6LovidFcvzTfIoH7RmRn4Mbh1XvJ0o00ChlF0OCr+VeWDvb9lUVfvRU3IFbdhvg2VNY96dmFTVLYdQ+q+j3WLsnDvB/sjitxkY5kf774Eyb6bdNmadB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncJphnVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C5C4CEC3;
	Fri, 18 Oct 2024 07:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729236645;
	bh=m43fdzdIoDLBpaLwCnX4Nku8XgZwC/0ohcah5I8Q/7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ncJphnVHkY07GS1vfnAxVsXaSM6aR1B2JKscWH231a4BmudCVAjrjCSwCAlqZmJ1N
	 tQaK7muAec2Im3i+PwkluPcKY5SptP/TXjzUaq5OM5z2vrYEKNS5mN1QIoIeSHV179
	 0F3AL2S4hnpF1rBdIozTHOrIzb5VyJKRV90NtfkiLeP6lnA7Vk/nkIFTGYsf1aPy0W
	 GtOwho0L++p182L+qCbWwI8C5Deau+Wlq5o4S17s8Mx/4Ss5KW4BCuBMRDwwvtjJbg
	 elaLqJSmLN8Bhp+zSObZlFAO9Rb38shj7npmnE57BOlC3W421WyoZI5bBkVDH2RUKH
	 XL5I+OW/mTjEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD13805CC0;
	Fri, 18 Oct 2024 07:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.12-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172923665054.3024291.11065813317278264417.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 07:30:50 +0000
References: <20241017132022.37781-1-pabeni@redhat.com>
In-Reply-To: <20241017132022.37781-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 17 Oct 2024 15:20:22 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f:
> 
>   Merge tag 'net-6.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-10 12:36:35 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.12-rc4
    https://git.kernel.org/netdev/net/c/07d6bf634bc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



