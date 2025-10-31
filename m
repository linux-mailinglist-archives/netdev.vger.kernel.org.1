Return-Path: <netdev+bounces-234782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C71C2733E
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E243D350B26
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755A32E159;
	Fri, 31 Oct 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arGhy+zw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39032D44A;
	Fri, 31 Oct 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954033; cv=none; b=tuz+JfUPJYmOw8R9PDNAAcf0nzAQIDDMy5AsSYHemQbiZ+UVQDVhVJMAUX8E6T3oqCbF+HcuxMtZc8Idx4kqwf4jEpGMDEVZRfOsClPRVBS/Nqk78rn/3cm70+9ch4tTFjvmHMcmONOdDnwWmaypT08TYMr8unfcRKTUKf1UlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954033; c=relaxed/simple;
	bh=uo7HECQ3DRxvFuv+4IW4KiUNYaG6tKTxodiR/W5Ua3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OqG0tLNIGFgWKCIp+P1AZAEtMDhocgYdRibWHh+MQoMiDtInmTZ/eTajeWobsrVxV/4rVsfrSrp5foH+Wz8P130dV80bPgQYhKS7ablqUiCTcRnBquLZHTGwpBzhmXIlyiaLv5iouccTZ2V27r4L7DI3EAybwDu9mOZiOu5kH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arGhy+zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C260C4CEE7;
	Fri, 31 Oct 2025 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761954033;
	bh=uo7HECQ3DRxvFuv+4IW4KiUNYaG6tKTxodiR/W5Ua3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=arGhy+zwHubV9hiSpwM1Sa2D+w3yVOKsnuK3ua0WZ0PCBlnSbc9rhiFpn6mib7YGg
	 e+HbZKQlo9yHP/NCRC1zMn60QDuUW1zVtOzNPzAAh95bbTKVo5EOtK2wRY18XvuEJk
	 omcxpmqtXDdmyim4DK9n4H2xg4Q6i8C3RNVOfcgX7EhyVxOagmvBbZumeV5LB7Ec6e
	 H7g7uStT7OxBJ+Idl+Yr9ZDskWQcfF3M8Wcu1lZRxWsCgeJHpKvLVwZ136DGbSeEmu
	 ubEVVxaZwGAoFZxe8Xc0PBEji4Z3iovNFnx4ihbLMbAWyZfmI23Rbdz+iEmdSjk5hl
	 zgDikQjmir6IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5217B3809A00;
	Fri, 31 Oct 2025 23:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195400925.668400.9586354215719827229.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 23:40:09 +0000
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
In-Reply-To: <20251027194621.133301-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 noltari@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Oct 2025 20:46:21 +0100 you wrote:
> The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
> tags on egress to CPU when 802.1Q mode is enabled. We do this
> unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> VLANs while not filtering").
> 
> This is fine for VLAN aware bridges, but for standalone ports and vlan
> unaware bridges this means all packets are tagged with the default VID,
> which is 0.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
    https://git.kernel.org/netdev/net/c/3d18a84eddde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



