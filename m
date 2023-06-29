Return-Path: <netdev+bounces-14567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9C7426BA
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B758280CB6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256C23C4;
	Thu, 29 Jun 2023 12:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD532565
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A1FFC433C0;
	Thu, 29 Jun 2023 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688043022;
	bh=DKCUwS9fNnDUPqi4x9AuhHJ2m4N+pv/9wWzYhF4owzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQxlIXpuAZdK9RJhKIimXOhII1uH6J9scez4VPCbseIuxeuzbU9OnPT48h5v9WP+b
	 Vt3Qd1cmng2/XreIUWNucO8SaVvtjbLY7Tnrg2py+WtGHJZHbVX8a2N1F2w/j0kAou
	 eu44oEFEdiAqBW5PaywiMoRPQvnVysV9jlCNkU3jmvA9eCiIBQY5/hPl8oCUXgymMp
	 d9DkuThpcAuZqS9sApY2iQd42GKElkGRq7a8fUwCRACVDjYUM9mmi4B/aAI6rHJaU5
	 82xr3BdFx44GvVEkCiPY4lpBfwJKm7PWdgY88lgeWjEWvIfZWm7RZEJKg/dTwRNHng
	 KdGaUHXcP/IAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 352A2C395D8;
	Thu, 29 Jun 2023 12:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] Fix PTP received on wrong port with bridged
 SJA1105 DSA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168804302220.3649.11033934879595741710.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 12:50:22 +0000
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 12:42:05 +0300 you wrote:
> Since the changes were made to tag_8021q to support imprecise RX for
> bridged ports, the tag_sja1105 driver still prefers the source port
> information deduced from the VLAN headers for link-local traffic, even
> though the switch can theoretically do better and report the precise
> source port.
> 
> The problem is that the tagger doesn't know when to trust one source of
> information over another, because the INCL_SRCPT option (to "tag" link
> local frames) is sometimes enabled and sometimes it isn't.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: dsa: sja1105: always enable the INCL_SRCPT option
    https://git.kernel.org/netdev/net/c/b4638af8885a
  - [v2,net,2/2] net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
    https://git.kernel.org/netdev/net/c/c1ae02d87689

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



