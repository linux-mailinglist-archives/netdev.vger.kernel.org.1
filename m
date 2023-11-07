Return-Path: <netdev+bounces-46531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F57E4BEE
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA38AB20F0A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAF2A1DA;
	Tue,  7 Nov 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL8+q5eu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C22A8D6
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51367C433C9;
	Tue,  7 Nov 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699396824;
	bh=pYPaAOKhkOnqMQPnBq/62m98rcoU7/1+8vw8apMNzgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mL8+q5eu+LM2wSD4En4cmCUzt0LHvRqyo5jRjoqADmvpKDRl9ri6ynEdIS9ptSP8J
	 kIL75F2T4B/x5cwhR18Ey0ASLblnPH1pJvrPVY7chXO+e9oEn4isNKVsXTLzWmZIFk
	 HrRkqKaIx3fb1p/daIcpV/MlR78Fiuh5wGLsuZH/OZ9jlwu726KOZPmd3h/q6eRtGC
	 B+lsFuF/Trc05W8jp8Letis+nUqH5aEXrhgV1KK3SgKn16fZz8aiP0eGibsjNSJFo5
	 L80Rl6VY26TWYNZ+pJoOOeUInr2hquqwFdOx+xh+xKeKblRWRtuw3VrqYCOrs4OBAM
	 sSgnWWmG2gD9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 342FBE00084;
	Tue,  7 Nov 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phylink: initialize carrier state at creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169939682420.4464.18159621143495635365.git-patchwork-notify@kernel.org>
Date: Tue, 07 Nov 2023 22:40:24 +0000
References: <20231107174402.3590-1-klaus.kudielka@gmail.com>
In-Reply-To: <20231107174402.3590-1-klaus.kudielka@gmail.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: rmk+kernel@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  7 Nov 2023 18:44:02 +0100 you wrote:
> Background: Turris Omnia (Armada 385); eth2 (mvneta) connected to SFP bus;
> SFP module is present, but no fiber connected, so definitely no carrier.
> 
> After booting, eth2 is down, but netdev LED trigger surprisingly reports
> link active. Then, after "ip link set eth2 up", the link indicator goes
> away - as I would have expected it from the beginning.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phylink: initialize carrier state at creation
    https://git.kernel.org/netdev/net/c/02d5fdbf4f2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



