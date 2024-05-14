Return-Path: <netdev+bounces-96236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1154B8C4AFA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94614B20B2D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FB469D;
	Tue, 14 May 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZpcZv2e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD917F7;
	Tue, 14 May 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650832; cv=none; b=AE7D2lYhUWBry48Qh+Wmaa+A1kVwVu78egLcxC/+tPjvuV+acS2p0CknMvuHf1pk49/80rf8QUd4yWjgIIsWwgAb1OcC8iZ57m3BNvazAsj+MuOLwjpAgsAMbOyFsxrwKaX/6m9n1kO6ZWz4Jr+9WDgWJsyEjcJIQsa2tE3xrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650832; c=relaxed/simple;
	bh=m9ZcLTYc1SAEPKpUe9V1F7bYmbm2pz9HsBw//F/2arE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSWeEagKNt+n7Ew8JjtjrtmEXewOYVlfQkIITbuH1avJ3N/QGp+IgmmnfMLiCIYvTUKffcW+FMCq6T/QrcgodUKeOTCWVz9xJ9KRZu/FKOPsK6WY9cN/Vj5c+frWZB7HVNngbOJIiAactJv160cGOw/jFDEwQ4+NMA5kcvZR318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZpcZv2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FAAC32782;
	Tue, 14 May 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715650830;
	bh=m9ZcLTYc1SAEPKpUe9V1F7bYmbm2pz9HsBw//F/2arE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZpcZv2e6bHthYt8gXXLGfLJ7s+Oqa0Lh6F7gaVuMrUr6kalYZJ2kl2u4s/rmvjmV
	 iqRztbGLBbmTnfazCtYCCvuoxPH0C5ag/IWN4hBFewJaw8QbivfV5c8tJGUDTOTktt
	 mu3AEckeNG2orO4Iis7U99lnDM/PnkaD+r7wvxdKiYZi92fbn63VX/3Nvq8H85Y2qJ
	 w/XDQ/fGb9RkvWThSKhPsarZp67k1Z+OpU8VEu6clSVrLfY84Jfu9gYnOlR3L6TlaG
	 S62a2fzrIWK2tj7rrEAV2D2ZOzbdUvJbo4/uZO64AyAu52OoAcaCPuzT4t8JUov74q
	 bfhx51kuQ54LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98A16C433F2;
	Tue, 14 May 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] mptcp: small improvements, fix and clean-ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171565083062.25298.8765294977053470199.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 01:40:30 +0000
References: <20240514011335.176158-1-martineau@kernel.org>
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 18:13:24 -0700 you wrote:
> This series contain mostly unrelated patches:
> 
> - The two first patches can be seen as "fixes". They are part of this
>   series for -next because it looks like the last batch of fixes for
>   v6.9 has already been sent. These fixes are not urgent, so they can
>   wait if an unlikely v6.9-rc8 is published. About the two patches:
>     - Patch 1 fixes getsockopt(SO_KEEPALIVE) support on MPTCP sockets
>     - Patch 2 makes sure the full TCP keep-alive feature is supported,
>       not just SO_KEEPALIVE.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] mptcp: SO_KEEPALIVE: fix getsockopt support
    https://git.kernel.org/netdev/net-next/c/a65198136eaa
  - [net-next,v2,2/8] mptcp: fix full TCP keep-alive support
    https://git.kernel.org/netdev/net-next/c/bd11dc4fb969
  - [net-next,v2,3/8] mptcp: sockopt: info: stop early if no buffer
    https://git.kernel.org/netdev/net-next/c/ce5f6f71b029
  - [net-next,v2,4/8] mptcp: add net.mptcp.available_schedulers
    https://git.kernel.org/netdev/net-next/c/73c900aa3660
  - [net-next,v2,5/8] mptcp: prefer strscpy over strcpy
    https://git.kernel.org/netdev/net-next/c/5eae7a8202f3
  - [net-next,v2,6/8] mptcp: remove unnecessary else statements
    https://git.kernel.org/netdev/net-next/c/00797af95f5e
  - [net-next,v2,7/8] mptcp: move mptcp_pm_gen.h's include
    https://git.kernel.org/netdev/net-next/c/76a86686e3f0
  - [net-next,v2,8/8] mptcp: include inet_common in mib.h
    https://git.kernel.org/netdev/net-next/c/7fad5b375611

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



