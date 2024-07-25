Return-Path: <netdev+bounces-113126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7FE93CB40
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EE01C2104A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B1143759;
	Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeuoYnKN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF913CF9C
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950233; cv=none; b=bgeNnAeUsIho00j0jy/kQZAiJ67b7y3lwtHzbD95WnsaMK8q0Yd2Xy0NyOhXXzB9ZiB1Dg+OYhQkmS1oWSss464wnvx313/eMBjVcYuljaZ+TbL8/3fgUgFw9Z0NTbvLgpNMj0TAbAPGv5aqCF/KawWV2D7IZFaNrDq7xhRmX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950233; c=relaxed/simple;
	bh=7MIzDUaar3eIV5V6H+qSR3q1Jkm9/2SPJclO4pelPVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gu/qNhmHjRrjhfdyGIS9dbEAJBTKqZVKMM1AkSq7V8gMR+RcF6c2hsb3lJRS7Kx89j7ve6aygIUKkip0wQfgrjS0I3tWzbuWcfGpPtYMNaiWExIHIBVLgKlELaJB3QBzmzPZ/nfWVsFLcu0xDzflgVB7XPSk1nMkkcO472F2v4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeuoYnKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C7DC4AF0B;
	Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721950233;
	bh=7MIzDUaar3eIV5V6H+qSR3q1Jkm9/2SPJclO4pelPVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BeuoYnKNLQy9yaRuKut66toyfxwCLAEerW37WqCE2d6b12YBF/h2varWvLn0QYzyf
	 BZcF27sd6gmMQq56UckH69d2u/C91ZF86hLvQj/ulrAqxHbESsQiBTUbShFkmFtko1
	 pIaPYlXi7nzK6bBfT1TYLajTSq3Dzis+HqzIDQyCWv5clnzIMDBWiRvvMRBnMRerNq
	 lB0T7M/UkXIcmFIBMw6ThCqSsjgr+2vqB53zFl1agcuDtdJBNFOx14wu1dieclwLl3
	 +ftgdGp4VZ/eHhqFavXYHGbPFSiAS5w0wB07/4Tu5o3ElInaBQxcIlrM9kVZTYEc9j
	 hoaBO+fdqsMxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F5ADC4332D;
	Thu, 25 Jul 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ethtool: rss: small fixes to spec and GET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172195023312.25262.2402068327643188695.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 23:30:33 +0000
References: <20240724234249.2621109-1-kuba@kernel.org>
In-Reply-To: <20240724234249.2621109-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jul 2024 16:42:47 -0700 you wrote:
> Two small fixes to the ethtool RSS_GET over Netlink.
> Spec is a bit inaccurate and responses miss an identifier.
> 
> Jakub Kicinski (2):
>   netlink: specs: correct the spec of ethtool
>   ethtool: rss: echo the context number back
> 
> [...]

Here is the summary with links:
  - [net,1/2] netlink: specs: correct the spec of ethtool
    https://git.kernel.org/netdev/net/c/a40c7a24f97e
  - [net,2/2] ethtool: rss: echo the context number back
    https://git.kernel.org/netdev/net/c/f96aae91b0d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



