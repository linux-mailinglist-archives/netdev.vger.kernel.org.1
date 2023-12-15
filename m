Return-Path: <netdev+bounces-57715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9007813F95
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E3B1C21B5E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7377EA;
	Fri, 15 Dec 2023 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzKTiyVi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2E7E4
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03E0AC433C7;
	Fri, 15 Dec 2023 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606224;
	bh=WRp/hJzjOyAvD5NrklD0PIiuF+P3l/7wQaPtGJy+p3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qzKTiyViF6R1jmLATnyOIhO6zmyyxn32J40enqdcTmG8i/kuhLZ2cJEy52MorbZBY
	 syD+0jFlyQb9pmXAQ+9PWGJ72dbBemHZEFnBtNyWe56sWHFn2DgVO3hOQp3tgPzTEt
	 V9gMg6ndhofgykfjAgN4zfR21LJ/bshOVMfeHiUvCbRbji58Us6ZVXP8BJJusQXZRE
	 T9ps/Alubuk22euUSt7cePXL9YMFIIoqBEcri1J93xeo/BUW9qh+jpZ6cVAfGQQ9Up
	 Su/r99t3OwyG+pMBbIyAy3r6lkYleeaJDL0phP6nQ2C8yAdlaWQaIuETK+WB31SRt9
	 6ECfebd5tpktg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEB63DD4EFC;
	Fri, 15 Dec 2023 02:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: mscc: ocelot: fix eMAC TX RMON stats for bucket
 256-511 and above
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260622390.3967.4355664367598521059.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 02:10:23 +0000
References: <20231214000902.545625-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231214000902.545625-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Dec 2023 02:09:01 +0200 you wrote:
> There is a typo in the driver due to which we report incorrect TX RMON
> counters for the 256-511 octet bucket and all the other buckets larger
> than that.
> 
> Bug found with the selftest at
> https://patchwork.kernel.org/project/netdevbpf/patch/20231211223346.2497157-9-tobias@waldekranz.com/
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above
    https://git.kernel.org/netdev/net/c/52eda4641d04
  - [net,2/2] net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above
    https://git.kernel.org/netdev/net/c/70f010da00f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



