Return-Path: <netdev+bounces-144814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510879C87C3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DF8B33E03
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853120262D;
	Thu, 14 Nov 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baZf5bKc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16420127A;
	Thu, 14 Nov 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579619; cv=none; b=IG6td1dv5BqthIucB9oxJ2LcQpxkYPiaFXWQDziRA1dC2vgnc9hViCLx0exrIRXXHic3iYojq4mLEXHv3DoQJgGiVaQpmPqC2jTG+kzUflGICg4UQLjNK8sRG0ddBhUAxvc7GIgiIq7Q+FR8KNynRjPR2lZy0ce2FTEOQ62KkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579619; c=relaxed/simple;
	bh=WqoZPSZPRO3SiDo4pzhANc0aDEgAi1wQ2Z/rJ2p3oEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ql2Y84JdlO2xyLDUdsbc1iPa/hG5YwoInJPXELf56dIW1qn22Qcn6FkM5hgFOLJfQHSgYOcxmoaIcWLIczDbaTKQePTFTor/admqh1d6SUlS2V1l5hDin9PAqoFIFV7lZn5qKdrNGCXqvBpvyRzOXPuvgETIEUIiZrQQbN03SvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baZf5bKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFBAC4CECD;
	Thu, 14 Nov 2024 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731579619;
	bh=WqoZPSZPRO3SiDo4pzhANc0aDEgAi1wQ2Z/rJ2p3oEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=baZf5bKccUP3axDeJh3De7q4W7MlZStYyhsWAXRHVFKpr1y7yUNXBIeF0Plrcv+iL
	 LhkckTtFptLbqtAU5k2SySoDXldPvU/eah38HUm5mKPhTIIHZ+k9SsZZqShNKb6fEz
	 vzQpO6WHpag+IO8dyJxzq8yhNEc7CoOEtZ1Q1Lwls3F9I+ZhJX/UMlLXLSQoTnnjNd
	 Xp3k0IVLoxNSC2M3oY0P1dW4ni+Fl065IXaUFGMPkri+kL9K12WbfiGBQ0NRZJvqZ5
	 ML3vQTG0G0uiQLrf+A7Psdta9hE07cEg0nziWFJt6KrAN6of7QQOFVN08McBE9kcFN
	 swXKdeZgWIBXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC853809A80;
	Thu, 14 Nov 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net 0/2] bonding: fix ns targets not work on hardware NIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173157962974.1869204.16348527317957867096.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 10:20:29 +0000
References: <20241111101650.27685-1-liuhangbin@gmail.com>
In-Reply-To: <20241111101650.27685-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 razor@blackwall.org, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Nov 2024 10:16:48 +0000 you wrote:
> The first patch fixed ns targets not work on hardware NIC when bonding
> set arp_validate.
> 
> The second patch add a related selftest for bonding.
> 
> v4: Thanks Nikolay for the comments:
>     use bond_slave_ns_maddrs_{add/del} with clear name
>     fix comments typos
>     remove _slave_set_ns_maddrs underscore directly
>     update bond_option_arp_validate_set() change logic
> v3: use ndisc_mc_map to convert the mcast mac address (Jay Vosburgh)
> v2: only add/del mcast group on backup slaves when arp_validate is set (Jay Vosburgh)
>     arp_validate doesn't support 3ad, tlb, alb. So let's only do it on ab mode.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net,1/2] bonding: add ns target multicast address to slave device
    https://git.kernel.org/netdev/net/c/8eb36164d1a6
  - [PATCHv4,net,2/2] selftests: bonding: add ns multicast group testing
    https://git.kernel.org/netdev/net/c/86fb6173d11e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



