Return-Path: <netdev+bounces-57881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40D81466D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E0A283DAC
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F891CF95;
	Fri, 15 Dec 2023 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEWtrFNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113D1C2BD
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 534DBC433CB;
	Fri, 15 Dec 2023 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638633;
	bh=ZeanRKAlfinpnCC8LF7reMt1A542iCyBgUV4PbcvM8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AEWtrFNzYYTFfW55uyCwp2G0rnUduVLuzZPmbdF0iFloDBfucEbkXCL8Y6wnymty4
	 CJsheTdEfmDEMksV/lYuGxnHdvh4jYmPKiEJrpbuqCZRhr3CNmGmI0DXFfU1qVEUl7
	 Zey0+08S6TJzv+LcatYv8uu6b8DUEXYbn+ejLoyhqBJFwID83DB1+H5Uo3rczOBru0
	 ldVXPLIShjD3grFOtzHimtph/dMkUfziwHR1X6B6yLmCoWeIwu2g0rSkQn4GEqVHXm
	 bnWL1ga3EXeMwB4bO/ydL5FWwu6DSGGSh5GE7ULoRxHb/NarG1/Q3mNV2JZdltQJcp
	 7GAQTHxSLGf2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A93EDD4EF5;
	Fri, 15 Dec 2023 11:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/8] net: dsa: mv88e6xxx: Add "eth-mac" and "rmon"
 counter group support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263863323.21335.9582784901328470443.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 11:10:33 +0000
References: <20231214135029.383595-1-tobias@waldekranz.com>
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 14:50:21 +0100 you wrote:
> The majority of the changes (2/8) are about refactoring the existing
> ethtool statistics support to make it possible to read individual
> counters, rather than the whole set.
> 
> 4/8 tries to collect all information about a stat in a single place
> using a mapper macro, which is then used to generate the original list
> of stats, along with a matching enum. checkpatch is less than amused
> with this construct, but prior art exists (__BPF_FUNC_MAPPER in
> include/uapi/linux/bpf.h, for example).
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/8] net: dsa: mv88e6xxx: Push locking into stats snapshotting
    https://git.kernel.org/netdev/net-next/c/d624afaf4c79
  - [v4,net-next,2/8] net: dsa: mv88e6xxx: Create API to read a single stat counter
    https://git.kernel.org/netdev/net-next/c/3def80e52db3
  - [v4,net-next,3/8] net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
    https://git.kernel.org/netdev/net-next/c/fc82a08ae795
  - [v4,net-next,4/8] net: dsa: mv88e6xxx: Give each hw stat an ID
    https://git.kernel.org/netdev/net-next/c/5780acbd2499
  - [v4,net-next,5/8] net: dsa: mv88e6xxx: Add "eth-mac" counter group support
    https://git.kernel.org/netdev/net-next/c/0e047cec7796
  - [v4,net-next,6/8] net: dsa: mv88e6xxx: Limit histogram counters to ingress traffic
    https://git.kernel.org/netdev/net-next/c/ceea48efa358
  - [v4,net-next,7/8] net: dsa: mv88e6xxx: Add "rmon" counter group support
    https://git.kernel.org/netdev/net-next/c/394518e3c119
  - [v4,net-next,8/8] selftests: forwarding: ethtool_rmon: Add histogram counter test
    https://git.kernel.org/netdev/net-next/c/00e7f29d9b89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



