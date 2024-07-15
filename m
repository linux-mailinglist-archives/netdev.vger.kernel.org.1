Return-Path: <netdev+bounces-111502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057C931648
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E221C221C9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B518EA6B;
	Mon, 15 Jul 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frlfZ05W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518918EA67;
	Mon, 15 Jul 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052033; cv=none; b=Xz/ebqMZcDcckXPscM7trLzDXHXgSYLXouJ04rwffe3cuFl0CqzuaP6/bEJ5op9dzKOkQxUA2idsqRP6JWjB3Klm0dw36OXIGHuM7YGKvHWNf0sv5Yro24Xhoc2YZDgV1d3tgnfM7ZA9R5iST+4MLmN7jnKspUTcEqI5XnEVPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052033; c=relaxed/simple;
	bh=UUQEoGL74YEYHEghcUe6a7oFl/lf5mys5Ep/k71xbzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rOaV07waQvn+OwRAYkamo7eydWqeaPSK1G1gGCCSFEZr4JGe+Ull/412u5fj+aHm3leodiIDSYwto5LO3/2K3s5i4IQoylU1N+U+hP2P9yiEqlkv3ESrek5McAhgQTHNHoZza+WMYyS4lHfzmaG/a4w+Sx9nX2QZ9YXSLyxe9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frlfZ05W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44855C4AF10;
	Mon, 15 Jul 2024 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052033;
	bh=UUQEoGL74YEYHEghcUe6a7oFl/lf5mys5Ep/k71xbzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=frlfZ05WqE+IUYKNlDgc46bj8zeCEt7Awni0a+iEIZmdlMWR3DRNdBwyHNhPSVOHc
	 m4HFQITj9rnSEUMqDb5OpK6tnRkntiAy05bo160IBoSaeEg9x9V9H0KJMg0veA235u
	 4CRqdmgCxd0E0pPvtG3vbW4Pl7sWlALz1UyYXoft5IuPmiOTZtYwOF18Slr3my43uf
	 PyblnFF/ibKiIiufeWekeFTbJ4IbIckhTox1PAdcHkQACnV7HYB8QOxI3wwmRrPmgc
	 OJd+/SzTbBk8rmUKN/o0UGCxAxePaaEIF/Xtes6NOKou+Ev0N0zQYl0VxJYoVgKrny
	 nf+YMpwdST60g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 302E3C4332C;
	Mon, 15 Jul 2024 14:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/12] net: dsa: vsc73xx: Implement VLAN
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105203319.25785.8590538549374697996.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:00:33 +0000
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jul 2024 23:16:06 +0200 you wrote:
> This patch series is a result of splitting a larger patch series [0],
> where some parts was merged before.
> 
> The first patch implements port state configuration, which is required
> for bridge functionality. STP frames are not forwarded at this moment.
> BPDU frames are only forwarded from/to the PI/SI interface.
> For more information, see chapter 2.7.1 (CPU Forwarding) in the
> datasheet.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/12] net: dsa: vsc73xx: add port_stp_state_set function
    https://git.kernel.org/netdev/net-next/c/1e5b23e50ffb
  - [net-next,v4,02/12] net: dsa: vsc73xx: Add vlan filtering
    https://git.kernel.org/netdev/net-next/c/6b783ded364a
  - [net-next,v4,03/12] net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
    https://git.kernel.org/netdev/net-next/c/dcfe7673787b
  - [net-next,v4,04/12] net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into dsa_8021q_rcv()
    https://git.kernel.org/netdev/net-next/c/0064b863abdc
  - [net-next,v4,05/12] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
    https://git.kernel.org/netdev/net-next/c/823e5cc141c6
  - [net-next,v4,06/12] net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()
    https://git.kernel.org/netdev/net-next/c/d124cf54df6f
  - [net-next,v4,07/12] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
    https://git.kernel.org/netdev/net-next/c/6c87e1a47928
  - [net-next,v4,08/12] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
    https://git.kernel.org/netdev/net-next/c/e3386ec4ec90
  - [net-next,v4,09/12] net: dsa: Define max num of bridges in tag8021q implementation
    https://git.kernel.org/netdev/net-next/c/ce20fdd670ac
  - [net-next,v4,10/12] net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
    https://git.kernel.org/netdev/net-next/c/85aabd1fe9d6
  - [net-next,v4,11/12] net: dsa: vsc73xx: Add bridge support
    https://git.kernel.org/netdev/net-next/c/6dfaaa276337
  - [net-next,v4,12/12] net: dsa: vsc73xx: start treating the BR_LEARNING flag
    https://git.kernel.org/netdev/net-next/c/259a7061c2f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



