Return-Path: <netdev+bounces-225743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E642B97DB5
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9A82E8392
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD892C18A;
	Wed, 24 Sep 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWaJJHJM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0C1F5F6
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673223; cv=none; b=Bou1lHzQid2SdvJlStGsVugXnwyAOBhfPfMxh6M9l/4Y2HKQIak5zcsXyGLfQN4mJs+IWV0fKzBhLEinXC+CmE0yekh2MC8qx3dsbXq/f5/E9MQQsb/6/UI5jDvJDb3YBWUHme6ILXVIjP9ImsP/Pi7N95AU6tkXYqwK8u7Vz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673223; c=relaxed/simple;
	bh=AsLKiOnYrDDrClhwRLf39bXJPVdgZThDfAY5suNGOwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O+mbYZmpFbcvZMmfEJVb8CzwJyoz13tNlDc5LcIaYrl4PqekN7GdZUsuWbT6ONdEJ9UUPvTixppfWa1NeIsmArRfgiCNVZnhr2qoq4MX8coSFW0mR3tyRRvBjWN9D6b66/u2dbDnsKI1s9VZUXDxEMc15n9UynwZlso7z7hGtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWaJJHJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212DC4CEF5;
	Wed, 24 Sep 2025 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673223;
	bh=AsLKiOnYrDDrClhwRLf39bXJPVdgZThDfAY5suNGOwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWaJJHJMUCIWhwL8RV1GpbKmyL+MIbboAKqP144zgExqikew5HlVDS++FBvxfVccL
	 NNPYWbRd9SrdgbAysuQKK2nRHdrJsk88iBCt/gdxL/jtaFgneQP95egwbTBJqf9stw
	 LCX2xhfUcKzu5AmFDxk7steqlOEfatmBzlBqoJk8+9GYz3x8SenAefwWCfk1VcfrhE
	 rUXi+lle0Aja59Z9Z3A63NmjQIjJdQbqBeVuZdxObi6jzyLDgxJnFDHy7mG79iS0Ua
	 snYe5wOK5s/Dhl27soP9kSHtdO1kyasMLwrPghbSezx6Qjg5cXQOqntfjr7TZZVpi5
	 6x7UMImRC/uyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6839D0C20;
	Wed, 24 Sep 2025 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: bridge: Install FDB for bridge MAC on
 VLAN
 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867321999.1971872.15659581370165041096.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:20:19 +0000
References: 
 <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
In-Reply-To: 
 <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux-foundation.org,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 16:14:48 +0200 you wrote:
> Currently, after the bridge is created, the FDB does not hold an FDB entry
> for the bridge MAC on VLAN 0:
> 
>  # ip link add name br up type bridge
>  # ip -br link show dev br
>  br               UNKNOWN        92:19:8c:4e:01:ed <BROADCAST,MULTICAST,UP,LOWER_UP>
>  # bridge fdb show | grep 92:19:8c:4e:01:ed
>  92:19:8c:4e:01:ed dev br vlan 1 master br permanent
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bridge: Install FDB for bridge MAC on VLAN 0
    https://git.kernel.org/netdev/net-next/c/cd9a9562b255
  - [net-next,2/2] selftests: bridge_fdb_local_vlan_0: Test FDB vs. NET_ADDR_SET behavior
    https://git.kernel.org/netdev/net-next/c/f67e9ae72dd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



