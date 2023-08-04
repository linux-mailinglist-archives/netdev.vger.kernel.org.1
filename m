Return-Path: <netdev+bounces-24592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C451D770BFB
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5715F281A7F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103FAD4A;
	Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F11DA37
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D342CC43395;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188822;
	bh=gumSZCuUZSA7xpu2yr1LoAirp3gVF4yZz3LempnP970=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VL6tdzBt778n2klQEJu05ZYKDI13Iult9n6N77ma4hd/4juGEspwgdmtq6Npl4p4X
	 Z+AszrzRJp8zIGMSsTpn/EDHUHX04bhQ0fXNt4pNCHqKPe0oxSGqd/T4GJkhraxmtD
	 nKsiSw+qbdsTzCfO7821/ORwVHE1IfXMMpqGYqQcGzyEN7+gEtoyKj1RYWQHeUjyoc
	 nTSUub/SgpobzWk5gzRGf7rMXlIxjo19uYqnw7P9mHdqYcxyde22OF4jgBHugJVFSL
	 6PZBQaD+g18KLfB7m1QqAV1Ih+MG7mQFB9I8ovQoXYJNoW/etS9hpGY8YTyPGjYruZ
	 R5LBF+CVwnOSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B80C0C395F3;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister() under
 rtnl_lock() on driver remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882275.4114.6235356466527637135.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:22 +0000
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 UNGLinuxDriver@microchip.com, colin.foster@in-advantage.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 16:42:53 +0300 you wrote:
> When the tagging protocol in current use is "ocelot-8021q" and we unbind
> the driver, we see this splat:
> 
> $ echo '0000:00:00.2' > /sys/bus/pci/drivers/fsl_enetc/unbind
> mscc_felix 0000:00:00.5 swp0: left promiscuous mode
> sja1105 spi2.0: Link is Down
> DSA: tree 1 torn down
> mscc_felix 0000:00:00.5 swp2: left promiscuous mode
> sja1105 spi2.2: Link is Down
> DSA: tree 3 torn down
> fsl_enetc 0000:00:00.2 eno2: left promiscuous mode
> mscc_felix 0000:00:00.5: Link is Down
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove
    https://git.kernel.org/netdev/net/c/a94c16a2fda0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



