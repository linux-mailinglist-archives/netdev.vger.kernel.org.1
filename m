Return-Path: <netdev+bounces-235347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3BC2EE82
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158D018939FF
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8F1BD9C9;
	Tue,  4 Nov 2025 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgHSfTYP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179B154BF5
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221668; cv=none; b=R8ySc8TvLQF2f04lfSbRQyDhd7Kfs7THPpG1Arg/dN6oaieIdQcyTtQidGSPWLYM1MMP0TH2vh00bfCyyMJtYoYWcbrzzZzkJFj8oZqdagY/cH7mv9pgd5HvdC2xi4sdiI6NXfoNVP3fAxBA2WiNgpCTkV567rsd+IRGXyyQRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221668; c=relaxed/simple;
	bh=TyHMXFRwP//nhhFCBkutek49KZ+T0z1OM/LULQAYKZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FpkURIIbrtcuzjNpmtMY0M1xYIZe3VJgcpvvDp5TsOoJHg4JSxiLXkaxn5EKVIuEv7VfeZveQ+K/WH/HzLiyrDYOfLijWcpSIhMMAmBE7UgU4k4sHxIS4cuAGHH5rkYHyC7KUh9fo4D1DS6XfjRasUFDQAqECjsgziU1Ea+zBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgHSfTYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1DFC113D0;
	Tue,  4 Nov 2025 02:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762221667;
	bh=TyHMXFRwP//nhhFCBkutek49KZ+T0z1OM/LULQAYKZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tgHSfTYPRZLCbrICtIqbeBWo5gcf04/IUK3bQ8wKbRQHlHa3TR7/HJXC/cqQbeNfM
	 mFTnY/zEipTldSkoG4oleUAJeqBtap7aAmXswu6EOVgKHCFXpU/sf4SMfGLkAhkYsF
	 9lzhvTpXcDrtaqnUn2UXZCVZSxpWUsLnGFv8AURV/X8wK9TT+QGoXX3VZeXFJPAQR3
	 e6Ux0t9mWd4RmKjOsnPZnqOCjNXZRc5vEZ8WKiUJ+dghitiOHFl5ZpIXHkiV8sg7Y5
	 3FMNu68HTvYN9SPO4ORMSytzhZO02d76mVnDK8QWbKui0prABHBJSUiNcR1GSLFPU6
	 E/v/oH/vNnW4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD0380AA5D;
	Tue,  4 Nov 2025 02:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/13] mpls: Remove RTNL dependency.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222164199.2291263.4305248913571401581.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 02:00:41 +0000
References: <20251029173344.2934622-1-kuniyu@google.com>
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 17:32:52 +0000 you wrote:
> MPLS uses RTNL
> 
>   1) to guarantee the lifetime of struct mpls_nh.nh_dev
>   2) to protect net->mpls.platform_label
> 
> , but neither actually requires RTNL.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/13] mpls: Return early in mpls_label_ok().
    https://git.kernel.org/netdev/net-next/c/2214ca1ff6df
  - [v2,net-next,02/13] mpls: Hold dev refcnt for mpls_nh.
    https://git.kernel.org/netdev/net-next/c/f0914b8436c5
  - [v2,net-next,03/13] mpls: Unify return paths in mpls_dev_notify().
    https://git.kernel.org/netdev/net-next/c/451c538ec067
  - [v2,net-next,04/13] ipv6: Add in6_dev_rcu().
    https://git.kernel.org/netdev/net-next/c/d8f9581e1b7f
  - [v2,net-next,05/13] mpls: Use in6_dev_rcu() and dev_net_rcu() in mpls_forward() and mpls_xmit().
    https://git.kernel.org/netdev/net-next/c/bc7ebc569e8c
  - [v2,net-next,06/13] mpls: Add mpls_dev_rcu().
    https://git.kernel.org/netdev/net-next/c/ab061f334792
  - [v2,net-next,07/13] mpls: Pass net to mpls_dev_get().
    https://git.kernel.org/netdev/net-next/c/1fb462de9329
  - [v2,net-next,08/13] mpls: Add mpls_route_input().
    https://git.kernel.org/netdev/net-next/c/73e405393991
  - [v2,net-next,09/13] mpls: Use mpls_route_input() where appropriate.
    https://git.kernel.org/netdev/net-next/c/3a49629335a5
  - [v2,net-next,10/13] mpls: Convert mpls_dump_routes() to RCU.
    https://git.kernel.org/netdev/net-next/c/dde1b38e873c
  - [v2,net-next,11/13] mpls: Convert RTM_GETNETCONF to RCU.
    https://git.kernel.org/netdev/net-next/c/fb2b77b9b1db
  - [v2,net-next,12/13] mpls: Protect net->mpls.platform_label with a per-netns mutex.
    https://git.kernel.org/netdev/net-next/c/e833eb25161a
  - [v2,net-next,13/13] mpls: Drop RTNL for RTM_NEWROUTE, RTM_DELROUTE, and RTM_GETROUTE.
    https://git.kernel.org/netdev/net-next/c/7d99a7c6c6a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



