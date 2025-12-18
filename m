Return-Path: <netdev+bounces-245334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE8CCBB6C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA57C3020366
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9B32D0D1;
	Thu, 18 Dec 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA+EwHw5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19832C94D;
	Thu, 18 Dec 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059406; cv=none; b=gtFDYUTVW2hEoxiXEhwuqcIPAq0Z8eoOJUyAtGxlAMSYYIbI6ozG64uDk5jSX9ckr7EDuOnRKAzDMS3EdFKy5TCeRNRabgA/uy96BsPWhSS3/iceud1LNyaIHIX1lwqxvnEzwDYH3WfyDWjAcl0qDzxhT0GJVTg3G5NxCTFcRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059406; c=relaxed/simple;
	bh=thOk0/zAMLrDRHBxo9vDLTeHTD3U0lOGd/me0VBpiso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oRmEX/T/N0qC29NrHV5xSnjgQaEvWPIPy2DW9IBX2VEgRlWUACO5JdmgQyxCeFAUkp/ZpGYuHkvTL9C/C50kAQ2FEcowf8D3gulu5Hw4EMxm4AnmBX4PO8MaUYj+AP7VWNOLC3DLLjy5iwiSWS5R3T+sYtuZ4WUMr6zET0xnfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA+EwHw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0745C4CEFB;
	Thu, 18 Dec 2025 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059405;
	bh=thOk0/zAMLrDRHBxo9vDLTeHTD3U0lOGd/me0VBpiso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nA+EwHw5bQPFx7L/l2WzYpc5pmQDvYGTcTDp9Xi8OfIzUU0j7/CE9s294tsDG1n4p
	 n0szxpP3mJzQTNImgAf5fhEU3LpIHRxYHAmb37cDNFek5aqZKGmfZHgBYDU5q3JNPO
	 07+REwT79EDhbyEB2cpLjMdxgKVW6Zzz3LrQavU3yCV/NrbuOUuzZSHZ1izz9W+cxu
	 cpKcKEAKkDbFsNscam89j74UvD1zuq4K2mMTVcieJpIhp9yvqBWI3PzF4xJhzaCEUh
	 Kj8O6pwZCqSL5mtQ8QQMPfp+TvEvwbTasWxzBmlhlj1HpIQXzP6UxFvAnTD0k7R00p
	 rzqFi97n1jOZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 791F8380A945;
	Thu, 18 Dec 2025 12:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/4] net: dsa: lantiq: a bunch of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176605921530.2920417.8697174687622339766.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 12:00:15 +0000
References: <cover.1765241054.git.daniel@makrotopia.org>
In-Reply-To: <cover.1765241054.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ravi@prevas.dk, yweng@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 9 Dec 2025 01:27:42 +0000 you wrote:
> This series is the continuation and result of comments received for a fix
> for the SGMII restart-an bit not actually being self-clearing, which was
> reported by by Rasmus Villemoes.
> 
> A closer investigation and testing the .remove and the .shutdown paths
> of the mxl-gsw1xx.c and lantiq_gswip.c drivers has revealed a couple of
> existing problems, which are also addressed in this series.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/4] net: dsa: lantiq_gswip: fix order in .remove operation
    https://git.kernel.org/netdev/net/c/377d66fa8665
  - [net,v4,2/4] net: dsa: mxl-gsw1xx: fix order in .remove operation
    https://git.kernel.org/netdev/net/c/8e4c0f08f6be
  - [net,v4,3/4] net: dsa: mxl-gsw1xx: fix .shutdown driver operation
    https://git.kernel.org/netdev/net/c/651b253b8037
  - [net,v4,4/4] net: dsa: mxl-gsw1xx: manually clear RANEG bit
    https://git.kernel.org/netdev/net/c/7b103aaf0d56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



