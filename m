Return-Path: <netdev+bounces-159539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2450A15B58
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 05:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F2818897AE
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41613B58C;
	Sat, 18 Jan 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgBJRtek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757077102
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172811; cv=none; b=tullUMHHNWnI3SMwzvb9KVOw1yhAltPCBmfYa+9Dn3dcrvYxXtCmsRPymmlzGQhYZZ6brinc/LVCeEqubhqC7gNErVgp3zkB5rEcKSzmNBOAUTDtLQ5LNMa/W4wV0T4n/9zMAnL73YfTU0xS0pTVkXa2ANbt8zGm64M7u/ybDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172811; c=relaxed/simple;
	bh=8WANaz95+wd0Bb9oSL2RGF7zyta5J1yBQ6fSSNP5Lnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d9tajA4PrneWEPVP3d97C+Zbe4P77XrqgkgYbvNRTYaCyg2gSvUPlVOnAbJznvB1UBUxNUXuD0+FzoZBNA55vSLPJo79/ZLH2ReS7NnBWGFEYhNgttyUS3SQozxPPBYQT2QIqNiMLJpS1+zqiY5LQ/kdIW6GvRPucpnh44CJDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgBJRtek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59562C4CED1;
	Sat, 18 Jan 2025 04:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172810;
	bh=8WANaz95+wd0Bb9oSL2RGF7zyta5J1yBQ6fSSNP5Lnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OgBJRtekU8hvEJg/uKftxahrPeVwJQQaxVcUQw9H4Y9f2+QxLBsLhGI8mmio/EPZ0
	 C4gMlkEYq2qwWQ2x2pPH2OepwC03y2ZnovoZCocpifRBmVivOp5K703kwsoUsiOd11
	 JzQgNgGZ9c2Ahov30CTZzEeHyrBfpMcpPYulXJtTw1cfYMhtRWzJXZ9nY9O8k2FfI8
	 AkC44d+5E38PK7lbG2dKuIHHsT/BN/VAkSOzSV06LC+YTReecrkJGbkQlW0IbkIfli
	 9vltN68yhaQdOZam2XG+qkulWyUitrvDVySxZPie4l+pSe6RHLPpY+5tbN9PvHfwnD
	 Z+K2HcltaZxrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2C3380AA62;
	Sat, 18 Jan 2025 04:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] ice: support FW Recovery Mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717283375.2332438.1378859454745229069.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 04:00:33 +0000
References: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 konrad.knitter@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 16 Jan 2025 13:20:54 -0800 you wrote:
> Konrad Knitter says:
> 
> Enable update of card in FW Recovery Mode
> ---
> IWL: https://lore.kernel.org/intel-wired-lan/20241106093643.106476-1-konrad.knitter@intel.com/
> 
> The following are changes since commit b44e27b4df1a1cd3fd84cf26c82156ed0301575f:
>   Merge branch 'net-stmmac-rx-performance-improvement'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] pldmfw: enable selected component update
    https://git.kernel.org/netdev/net-next/c/d4679b79ffae
  - [net-next,2/3] devlink: add devl guard
    https://git.kernel.org/netdev/net-next/c/0502bd2e0605
  - [net-next,3/3] ice: support FW Recovery Mode
    https://git.kernel.org/netdev/net-next/c/1de25c6b984d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



