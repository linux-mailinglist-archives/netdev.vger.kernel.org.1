Return-Path: <netdev+bounces-86922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1A8A0C9F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808911C20864
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4A14532B;
	Thu, 11 Apr 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c53vU+8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF11448F6
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828430; cv=none; b=SGaqknYnfmZ7Kiupl+/Veqs9GLI+Ccwxgv0ZOiw4e+d9igtJc6CsaqetmMhAr7COYT48H+gVI95PXWRrzQWw9C74alMGJx3xkB7S+iOEVPFqfFRYqeuubU/QRTy85C4fYfKBlVnz8cTSsL8GyVBkjqeSedrcGVM++QxxWbSScoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828430; c=relaxed/simple;
	bh=XOqG8CZdKu0SzFQw2gGjQil6P7+/iRZGuZIFuS6uUVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMksQWWYVuDvI4AGIX5ZQZntLWUaYYrYRj5smKI6Q6HyyBveCTO7tIFGDBHCxaXIf96gEumRquGVhGdnPxEa+D45rrXTPitoszmSQGNnNIXoiwU5r5nXN/qP5pkrWrH/gg/T5LJd4gjX3luwcbIOV1zwYi7OInReZXpRXrj/LA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c53vU+8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 980A2C433C7;
	Thu, 11 Apr 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712828429;
	bh=XOqG8CZdKu0SzFQw2gGjQil6P7+/iRZGuZIFuS6uUVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c53vU+8o00mlHPxt1pqIQoa6KwlUZMCnvqJIDS4PKIMGMJfBFJNo8CFLA1WMzSp2g
	 n56ElVFrZ22/UljkAbP9aPYN3i4IMIsnS4TgIfLxWEOao3MgpHljE+o3I40p0hydiF
	 Bi2RPzX0hsdqd7OBjd3swgk8fziWYwmdxpzmW4m0JfAEuOamETy2cy+ht1Syru0Tp6
	 3jvKDGGEnPmqZ95VCwfrWmClMwU2hrHO+f2xRl1ID+x3mr047zjlLNTRqsrtIdRxyD
	 PH6rzIi8KioI54Qfjm1fD6k/MuHbDpHBLkaogfn79u8I+axrZkIEkfy5cLCdX2Wcka
	 Mi8mlnlthFdLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86BBDD98308;
	Thu, 11 Apr 2024 09:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/4] ENA driver bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171282842954.17841.557508586983776545.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 09:40:29 +0000
References: <20240410091358.16289-1-darinzon@amazon.com>
In-Reply-To: <20240410091358.16289-1-darinzon@amazon.com>
To: Arinzon@codeaurora.org, David <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 dwmw@amazon.com, zorik@amazon.com, matua@amazon.com, saeedb@amazon.com,
 msw@amazon.com, aliguori@amazon.com, nafea@amazon.com, netanel@amazon.com,
 alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com, ndagan@amazon.com,
 shayagr@amazon.com, itzko@amazon.com, osamaabb@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com, netanel@annapurnalabs.com,
 sameehj@amazon.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Apr 2024 09:13:54 +0000 you wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patchset contains multiple bug fixes for the
> ENA driver.
> 
> David Arinzon (4):
>   net: ena: Fix potential sign extension issue
>   net: ena: Wrong missing IO completions check order
>   net: ena: Fix incorrect descriptor free behavior
>   net: ena: Set tx_info->xdpf value to NULL
> 
> [...]

Here is the summary with links:
  - [v1,net,1/4] net: ena: Fix potential sign extension issue
    https://git.kernel.org/netdev/net/c/713a85195aad
  - [v1,net,2/4] net: ena: Wrong missing IO completions check order
    https://git.kernel.org/netdev/net/c/f7e417180665
  - [v1,net,3/4] net: ena: Fix incorrect descriptor free behavior
    https://git.kernel.org/netdev/net/c/bf02d9fe0063
  - [v1,net,4/4] net: ena: Set tx_info->xdpf value to NULL
    https://git.kernel.org/netdev/net/c/36a1ca01f045

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



