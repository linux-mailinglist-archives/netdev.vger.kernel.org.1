Return-Path: <netdev+bounces-55847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4FB80C78A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0456D1F213C0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044D3454A;
	Mon, 11 Dec 2023 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+sX/IXP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA72D78F
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB296C433CD;
	Mon, 11 Dec 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702292424;
	bh=EA+GNuTu75zFv2ng7r3WriSuXaoclbQj87+Nxlut1Uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+sX/IXPqRxWPmLONmuLMXNTsqqhpHAK6PvNg7+XnnreasucBHenyurBCEiiWWmm9
	 JKBw9lRF3vMF2f4SRUHgEXUf7HAQ34erlhFzPFYXcYJTdPCyKmrRv2cTcsCyoOAi88
	 NUJ8+EZSwkTiVA5FsR+NkCWaq3YNuScFWDdfX1+OtBArOCEj0JjgOzkGBEl621Y7ZA
	 Jlh7owN5QovCAOkzE+8/+JWKyAoX8gq2yTIZ1rLtA/tVMUSyk8sperptgro+K4SXnP
	 rk/Xa0ghlobruenoV+qYEl5Tbe2edx0z0+qy+CDVda3+k1tT1YPau3hGQoRkl3Re2+
	 crBbXT6v3uwtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADE32DD4F10;
	Mon, 11 Dec 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ipv6: more data-race annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170229242470.25377.6220092880786520051.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 11:00:24 +0000
References: <20231208101244.1019034-1-edumazet@google.com>
In-Reply-To: <20231208101244.1019034-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Dec 2023 10:12:42 +0000 you wrote:
> Small follow up series, taking care of races around
> np->mcast_oif and np->ucast_oif.
> 
> Eric Dumazet (2):
>   ipv6: annotate data-races around np->mcast_oif
>   ipv6: annotate data-races around np->ucast_oif
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ipv6: annotate data-races around np->mcast_oif
    https://git.kernel.org/netdev/net-next/c/d2f011a0bf28
  - [net-next,2/2] ipv6: annotate data-races around np->ucast_oif
    https://git.kernel.org/netdev/net-next/c/1ac13efd614c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



