Return-Path: <netdev+bounces-199240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A4ADF899
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42384164801
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23940279DDE;
	Wed, 18 Jun 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxhMhAN7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338F215077
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281584; cv=none; b=APp38dMltNkJ/CfKvJK5ByQRdqgkI9huCPYneF+8njYBKlw9dgpNai6MTTQxaBJ5mpwU2SDq86S31BYoImHUW4P97abB6GhVH7uTzOFiJZvbbmAMdQ9q4r3balkd5GJ8vJ0G23trBzTRVyHNZRGUO8bxcejTKJWq1v23yNvpsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281584; c=relaxed/simple;
	bh=ISZfq8QUra9jyxk33xryobMwLRXR5HJ8VY2263KtrUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hN/pKbXhF4TsIZO5IewqbUCACPxV5Oovhf30u/A5Vy7PFWJ77nhnxNDa/0FaXYpqJ5jFuaas5RGDtjXI+Zh5KtYdvn0dS6Z0BttTDuCDvJ8WBr3R7OtEIKztb+XvlzXdz60zW6EmI1zHGg6Q8nukEea3SzMStAuNFRqYgk6D/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxhMhAN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA9C4CEE7;
	Wed, 18 Jun 2025 21:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281583;
	bh=ISZfq8QUra9jyxk33xryobMwLRXR5HJ8VY2263KtrUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NxhMhAN7omTWKu3vzA5RNPX9XXIK+ee25dc7p5l51qV2HA8QclBMk1kY81hR7xXju
	 Si7kTwufa4Tyun2NuWnzm/zk/R9aOXJtw6HJUru5cunCltUgsfayW3UoTXUirbeG5V
	 R0Edt3yPt30QSWBo551MnM+u4S1Y7zNPp81vi8sH6Yzzfxs0B+j1jA2+fGIt5UAbgf
	 6DmzTWagQFoSJyfZeT9KOnOm95WJYVrIpMLPAtoZI2cMkO5aHUa/m16Rz9q0mufQzl
	 uujYmNn65bqyTyZgIF5utBXX+MBEadX229gz8w1bilyBrM4yoRdzukfDX4nEOuwJLV
	 4Up3bNrvzLBdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1233806649;
	Wed, 18 Jun 2025 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2025-06-17 (ice, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028161175.259999.12955264513898085028.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:20:11 +0000
References: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 17 Jun 2025 10:24:40 -0700 you wrote:
> For ice:
> Krishna Kumar modifies aRFS match criteria to correctly identify
> matching filters.
> 
> Grzegorz fixes a memory leak in eswitch legacy mode.
> 
> For e1000e:
> Vitaly sets clock frequency on some Nahum systems which may misreport
> their value.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: ice: Perform accurate aRFS flow match
    https://git.kernel.org/netdev/net/c/5d3bc9e5e725
  - [net,2/3] ice: fix eswitch code memory leak in reset scenario
    https://git.kernel.org/netdev/net/c/48c8b214974d
  - [net,3/3] e1000e: set fixed clock frequency indication for Nahum 11 and Nahum 13
    https://git.kernel.org/netdev/net/c/688a0d61b2d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



