Return-Path: <netdev+bounces-196752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A9AD6418
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A297E189E096
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CB2D8DDC;
	Thu, 12 Jun 2025 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVEAAYbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC852D8DD6
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686401; cv=none; b=OQ/9UDVcL7k+dHruy08mOhJCV7qKedOnPUWGdpMusdn5mEuonR6wGkTWMRWraSVkGqv3k83wC/RsY2AskS8GYvqftu67VBQazCSaD0HSeo9A3OjfUpwLI8IN/HNGwewAPc6IzDg9QyMC9Pl7w3q+Pw1WCHWoyr4dWeXxIFTdrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686401; c=relaxed/simple;
	bh=cBztdt+UZBFzTNtDwhhJ09/QXgMmlBk6kYpU2JzUUMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sb9cNtVeJzm3r3ed9BNBilVzQoBRunUO0UElTnHJHbQMZ0577/3uSNxqPs3adCwrrS7vaFM3WtzYlsOPm88i2Ui41gwurqloBNbXVnv3V/pPM3SRtqnK4GzrDOmGBo7nCUJTYCEvaMhiI2EC69y/8Ad/yzoQWbITUJ0l9j5T+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVEAAYbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3C8C4CEE3;
	Thu, 12 Jun 2025 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749686401;
	bh=cBztdt+UZBFzTNtDwhhJ09/QXgMmlBk6kYpU2JzUUMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VVEAAYbKaHXMOyRfk+LV/mJJiPt4BlbKxPmUbrfClGjUYk0T/WNdN7kmofGjhOofg
	 lRqJMTPuGuGp7DrB71rBVWg0Eh2xWN6b/H/Yyjtaw3Mk6xfxHcIsavdhVg4U0nDWNE
	 5SuwpHeG71QMOBnrBKcDrcfofXf2RJfVeWGD4T6QmhvdQmaXkcfKFBxNw+akObOZ+L
	 ARTGR4ijTh/cH9LmJOAkMtUKXPJkumMrOyx/xHj6iLxYzS32NXKqiH1Nv/wnm6+QwO
	 pq6NJ1ko9+wBUYeUuDS102WLFLSevgfJpBkPBccBHnfDYvoIjbYjDWY5g+LsEwaewL
	 3dAxxBwYhea8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE59C3822D1A;
	Thu, 12 Jun 2025 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] fbnic: Expand mac stats coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968643158.3539505.12785231397217675717.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 00:00:31 +0000
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 sanman.p211993@gmail.com, jacob.e.keller@intel.com, lee@trager.us,
 suhui@nfschina.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 10:11:07 -0700 you wrote:
> This patch series expand the coverage of mac stats for fbnic. The first
> patch increment the ETHTOOL_RMON_HIST_MAX by 1 to provide necessary
> support for all the ranges of rmon histogram supported by fbnic. The
> second patch add support for rmon and eth_ctrl stats.
> 
> Mohsin Bashir (2):
>   eth: Update rmon hist range
>   eth: fbnic: Expand coverage of mac stats
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] eth: Update rmon hist range
    https://git.kernel.org/netdev/net-next/c/e1f4b1f16758
  - [net-next,2/2] eth: fbnic: Expand coverage of mac stats
    https://git.kernel.org/netdev/net-next/c/6913e873e7b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



