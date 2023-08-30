Return-Path: <netdev+bounces-31343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A478D43D
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCFB2811DC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06382186D;
	Wed, 30 Aug 2023 08:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5284636
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C1A6C433C8;
	Wed, 30 Aug 2023 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693385422;
	bh=L6hzoSSZrlwbMGeFsq3PFhTqWQJ7CpYOafqeEcEa1/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rRl/E9CSIek7SK1/tdRMEg9exrqQwwT8PKgPB2wFOWPoK77KCYFg9827AazLihyoX
	 Amw7Z/buDFSlfbocn9eV4n+eKqz43AkGGxMr7iyp5uf/brJI53Nc1NegjN/5XB7ks1
	 S7cNV3o5IghscabtwY+8SEmC9UURsPwO8VTLGn941Zrijx8J1HPSiMLv9LrfclrnvZ
	 FLlYYDso0o6CeFpUTD0oo1a+jw4bngtVR+oyyw/vFHCPxyjlXPYugIwl6Ft3nmCg4Q
	 JaRzzObWkjZ7TzmlArI//C5ew5kVWHqt2Cx0HB7coe3f2pIyrJJDVezQoxBHpoi2IZ
	 IDlMtyDcKjHug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EECFE29F3A;
	Wed, 30 Aug 2023 08:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Issue description and debug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169338542205.27846.810600135070334068.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 08:50:22 +0000
References: <20230825075505.3932972-1-heng.guo@windriver.com>
In-Reply-To: <20230825075505.3932972-1-heng.guo@windriver.com>
To: Heng Guo <heng.guo@windriver.com>
Cc: davem@davemloft.net, sahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Richard.Danter@windriver.com, filip.pudak@windriver.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 15:55:04 +0800 you wrote:
> Hi maintainers,
> 
> The IPSTATS_MIB_OUTOCTETS increment is duplicated in SNMP test.
> 
> Reproduce environment:
> network with 3 VM linuxs is connected as below:
> VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
> VM1: eth0 ip: 192.168.122.207
> VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.104
> VM3: eth0 ip: 192.168.123.240
> 
> [...]

Here is the summary with links:
  - [1/1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
    https://git.kernel.org/netdev/net/c/e4da8c78973c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



