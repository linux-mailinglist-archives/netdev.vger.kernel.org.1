Return-Path: <netdev+bounces-26761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B95778C91
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C61A1C21617
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFD7472;
	Fri, 11 Aug 2023 11:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF75693
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBA3DC433C9;
	Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691751627;
	bh=a15wPchtiTRtpNjsVMEMPyxizYnehhV/FQ6oI5+CqNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJeS98tjK+wTU5OhXLYtHQRflE8coQ3uU9J5D8os2jZWFm5M/2lY8cTc+l0oCkVMq
	 /qL2S5mTmg0DT9PUqUZKVAhOeMvW/6rGmMsnw+SzVnO1mjSodvlW3kSSD8wd1T2flB
	 amCLgC6NN6rV8vHAnZgBjzWG6P9wEQaxCTKngPctqQ9DBcwJHsvTSr/ueqVKE0Bc3k
	 RUKYnRHX49+TO/SnPo5jOO9lku54NJGnn0j41nX6xciDI89Ym3J/159aHt8xenE8t/
	 4pIAs6/NnqmKOm5aulwT282hBQWtR4/wc9IHSlPhF6cI4oabjdP1kSu+PgwZ1S8HDo
	 71wNq6d5vvbtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C07BEE21ECE;
	Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: dsa: rzn1-a5psw: add support for vlan
 and .port_bridge_flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169175162778.30809.2651056116058056426.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 11:00:27 +0000
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230810093651.102509-1-alexis.lothore@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: clement@clement-leger.fr, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 milan.stevanovic@se.com, jimmy.lalande@se.com, pascal.eberhard@se.com,
 thomas.petazzoni@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 11:36:48 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Hello,
> this series enables vlan support in Renesas RZN1 internal ethernet switch,
> and is a follow up to the work initiated by Clement Leger a few months ago,
> who handed me over the topic.
> This new revision aims to iron the last few points raised by Vladimir to
> ensure that the driver is in line with switch drivers expectations, and is
> based on the lengthy discussion in [1] (thanks Vladimir for the valuable
> explanations)
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: dsa: rzn1-a5psw: use a5psw_reg_rmw() to modify flooding resolution
    https://git.kernel.org/netdev/net-next/c/6cf30fdd7b06
  - [net-next,v5,2/3] net: dsa: rzn1-a5psw: add support for .port_bridge_flags
    https://git.kernel.org/netdev/net-next/c/0d37f839836b
  - [net-next,v5,3/3] net: dsa: rzn1-a5psw: add vlan support
    https://git.kernel.org/netdev/net-next/c/7b3f77c428ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



