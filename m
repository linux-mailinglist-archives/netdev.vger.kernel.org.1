Return-Path: <netdev+bounces-226839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E9BA57D4
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D3F7B1421
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49BC21B9C8;
	Sat, 27 Sep 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjUSryqm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF74217F56;
	Sat, 27 Sep 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758936050; cv=none; b=HhmxfI170e0aPIZ57wXqnFALBeQoIxSqLtOjWydZEU1ydy2y2xgLu/cfkctaT2vuaE7FnvsD3RTszjVBM8D+fYi2xALMJsi+rD4rnsPP65oIEYDNKwiS9BiK70gzk1sxzR16dLwBTPUDJby/Hgy70T4q7bTRVDnaWvoZw6XDFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758936050; c=relaxed/simple;
	bh=IjsonbPJaLwiHTDOR7ZZAIf4LmGZwgTZRRiRcSXDpWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kbD5cBANL+f+egQ8DEQC1+kCkIgfy6K+6LMkBYMknDara+dAulh+UMbCSf91fotfUIWK2mT7LmVOkhkRthiMLP8NJCM8/YPI9qslRm1vX7uY1S5IMDSFkD8nY+4TlBz68A1RPwgqxBWep/BFHWGM01o6K32KkGzCE9LgHe4yDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjUSryqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4CEC4CEF4;
	Sat, 27 Sep 2025 01:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758936050;
	bh=IjsonbPJaLwiHTDOR7ZZAIf4LmGZwgTZRRiRcSXDpWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjUSryqmE7OXR/y0H6vHN1l/69u96+e5EnxZ8+xS2otrEN4rHt1RmrZYobHcFV+fO
	 AUNO5TpjaVfdyv/dOFsMZKXzxEDalTgmtJkQWxEOUOKMsSPYpvaeza9SRacCtV7iDc
	 7b9TsFK+oyZ7AMnXRLq62Hgp7p/ZUZH+5gGIflyuY2cSnYtdJEhP26o8dkrotJR9Yn
	 LuBzI5RuPhGWDSejQSz8FHTfiYSPZVI8V8RJn7VtSjy8QFSur2wWO3CbZErUsMIe5o
	 E80ib7c66JTCKLYsFJ74lx2MnW3TPQh49co63ZInk3GSEMFcSJHZypEH2RhG8gFqcd
	 3Dl4VNQgiD68Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB839D0C3F;
	Sat, 27 Sep 2025 01:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2 0/2] Add support to retrieve hardware channel
 information
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893604524.115459.9846983049022155194.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:20:45 +0000
References: <20250925125134.22421-1-sedara@marvell.com>
In-Reply-To: <20250925125134.22421-1-sedara@marvell.com>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, hgani@marvell.com, andrew@lunn.ch,
 srasheed@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 05:51:32 -0700 you wrote:
> This patch series introduces support for retrieving hardware channel
> configuration through the ethtool interface for both PF and VF.
> 
> Sathesh B Edara (2):
>   octeon_ep: Add support to retrieve hardware channel information
>   octeon_ep_vf: Add support to retrieve hardware channel information
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeon_ep: Add support to retrieve hardware channel information
    https://git.kernel.org/netdev/net-next/c/24d15b6a17e2
  - [net-next,v2,2/2] octeon_ep_vf: Add support to retrieve hardware channel information
    https://git.kernel.org/netdev/net-next/c/6294bcd423ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



