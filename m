Return-Path: <netdev+bounces-58168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F079815645
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445FD1F24B07
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3515BB;
	Sat, 16 Dec 2023 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHRPXW//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7F15AF
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F3A1C433C7;
	Sat, 16 Dec 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692625;
	bh=SNKwZo9mbTOfRPhCX+ApqM6HHRTSetFjH0MCcBqoCUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHRPXW//PXW65rjQ1NCN4rHTrJmwphMvW9o42MlJeuqvyjk/cLSZ3lWk7hx552tkA
	 dFjdngS+IR32k+Xbv0IU6pySBJyasbALWkLMyEZh/vxEQ+XBcKmqwCVjoAfGPFx738
	 nDVKbdn/lpbWM3psu9vOUDNlJDdqXbl6c1dwz3v/Qx6GZf5fWc/NmRmWg//HYe+s+7
	 sVYHUv0ZWIWcyL8g8VnYCnQ5PDehFJv3/4guTkedgzUNunS25+CgbxGUr5+KWW2ddc
	 VuaaRjcoTzdW4/y1qGt9ThedJWWYJe12SJJXL7FjX71lWc+LloxCMBVzwL5B8E1Tc0
	 3cOqbOq+2Z0dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9E4DDD4EF5;
	Sat, 16 Dec 2023 02:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp/dccp: refine source port selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170269262495.31252.17651074971058636230.git-patchwork-notify@kernel.org>
Date: Sat, 16 Dec 2023 02:10:24 +0000
References: <20231214192939.1962891-1-edumazet@google.com>
In-Reply-To: <20231214192939.1962891-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 jakub@cloudflare.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Dec 2023 19:29:37 +0000 you wrote:
> This patch series leverages IP_LOCAL_PORT_RANGE option
> to no longer favor even source port selection at connect() time.
> 
> This should lower time taken by connect() for hosts having
> many active connections to the same destination.
> 
> Eric Dumazet (2):
>   inet: returns a bool from inet_sk_get_local_port_range()
>   tcp/dccp: change source port selection at connect() time
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] inet: returns a bool from inet_sk_get_local_port_range()
    https://git.kernel.org/netdev/net-next/c/41db7626b732
  - [net-next,2/2] tcp/dccp: change source port selection at connect() time
    https://git.kernel.org/netdev/net-next/c/207184853dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



