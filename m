Return-Path: <netdev+bounces-50251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7067F50D9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E481C20A5D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062BF5E0D9;
	Wed, 22 Nov 2023 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTrPY1Jo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5D5E0C5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 19:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9DB3C433C8;
	Wed, 22 Nov 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700682026;
	bh=vNLlJHGbpPG9VrqIAYeDhvM5lksx4SsgsHtuYsKF54I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTrPY1Jov/W0uHN7XB6o/LqROzolok6NYWOHZHaDEp5LhWl3rLYCVnIP0UMgeSzvz
	 T9INP4wTBSGSgY+jDAwkvf9HeQAd36qxtjfm2i87zAu5C7dKeBfRhhdcI4MEJEi3Gl
	 8swFUJUupacHVkxNtH0hBXd0pkJIzb1FZRm8ouiLILlfRNjLnsmPFuhI1jZdbmMCbn
	 gokp+FZ74pK4FXubKyNT04VFMW4Tcw5kXgZY75DHGASxKhrSs/ciYCwkKbCHqrCJpc
	 DKnl5Sm/EZImRmyiMNtqTTGg2cKTg/FliDO4XwaD6shTwTxPgjO9JdTtXQBX+EYYig
	 1sX+GpmLtnTiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9352AC595D0;
	Wed, 22 Nov 2023 19:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v3] ip, link: Add support for netkit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170068202660.20203.4531934874525203987.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 19:40:26 +0000
References: <20231120233341.21815-1-daniel@iogearbox.net>
In-Reply-To: <20231120233341.21815-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: stephen@networkplumber.org, razor@blackwall.org, martin.lau@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 21 Nov 2023 00:33:41 +0100 you wrote:
> Add base support for creating/dumping netkit devices.
> 
> Minimal example usage:
> 
>   # ip link add type netkit
>   # ip -d a
>   [...]
>   7: nk0@nk1: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     netkit mode l3 type peer policy forward numtxqueues 1 numrxqueues 1 [...]
>   8: nk1@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     netkit mode l3 type primary policy forward numtxqueues 1 numrxqueues 1 [...]
> 
> [...]

Here is the summary with links:
  - [iproute2,v3] ip, link: Add support for netkit
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e4956e7f1fd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



