Return-Path: <netdev+bounces-168291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484BA3E6A4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C12424666
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C79265CAF;
	Thu, 20 Feb 2025 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJpRQ35+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEA26460A;
	Thu, 20 Feb 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087016; cv=none; b=Sq+CyuvkNzmqepz2AakKYLbZavDF700IFNpI5soCTlICnSdx6dSFuKvIWW/Kpits89lHIwZekoJgbvK2uXSesG9FkfHgOKBZ4oCSsA9nlfXkaR3L69W11yOb8DGGhLBrexcOxqiWcMTDNjnA0mFZgZ+47yKpMfR2a5t6UFWac5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087016; c=relaxed/simple;
	bh=x+lcCfLn7zJqONbg2zEFSggCerXZTIz6kVyEF832M3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AEZv8f7RVaNoepeHCnVH8zUv+BiHohQfPVBPdNoy3ZcQDNi9wHxo9JqdwzVmZuA/94o7Hx5z6lIpAeSMSRkf5YjI8+DT9FVMdXqJuvMnzkFlXQx407nUgGPikX58qQllAZ138FuLajU/v7H3PjphNbN7tmJ4oypgTAaCTOaodkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJpRQ35+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6E7C4CED6;
	Thu, 20 Feb 2025 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740087013;
	bh=x+lcCfLn7zJqONbg2zEFSggCerXZTIz6kVyEF832M3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BJpRQ35+VXrUKCEpYe/PMx7E5HknWFwGTA9Q6TrEwijt+LF2VLJbGeWg03hYEa6iZ
	 FwnHlcR50nQZDRBPnONG1YRnQPce44Gg4503HXcfdQUr8ge7B38KiEH45vWheqRc5T
	 aRQB/co9Hu951fEppx2F1WvwcGCGKP5Aa2/rHHOV/mfLaWE6XFRwl/FdjvXjux7Jlz
	 1UljBbkjd8eyC0hLxbP2N6bGDkyhvO8RzrGdx3kl881stfpCmCxkM3CokpQjySNiAx
	 So8PEarvtRoW80V3n8bNqGWmAi06xk1iMX73M/QO47JKM/4+TRG6kk3ZwNQavnyeXU
	 faO+BuTBZv7dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFE84380CEE2;
	Thu, 20 Feb 2025 21:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Flexible array for ip tunnel options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174008704426.1463107.10329060909123981805.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 21:30:44 +0000
References: <20250219143256.370277-1-gal@nvidia.com>
In-Reply-To: <20250219143256.370277-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, tariqt@nvidia.com,
 louis.peens@corigine.com, horms@kernel.org, dsahern@kernel.org,
 pshelar@ovn.org, yotam.gi@gmail.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, kees@kernel.org,
 gustavoars@kernel.org, dev@openvswitch.org, linux-hardening@vger.kernel.org,
 i.maximets@ovn.org, aleksander.lobakin@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 16:32:54 +0200 you wrote:
> Remove the hidden assumption that options are allocated at the end of
> the struct, and teach the compiler about them using a flexible array.
> 
> First patch is converting hard-coded 'info + 1' to use ip_tunnel_info()
> helper.
> Second patch adds the 'options' flexible array and changes the helper to
> use it.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] ip_tunnel: Use ip_tunnel_info() helper instead of 'info + 1'
    https://git.kernel.org/netdev/net-next/c/ba3fa6e8c1eb
  - [net-next,v4,2/2] net: Add options as a flexible array to struct ip_tunnel_info
    https://git.kernel.org/netdev/net-next/c/bb5e62f2d547

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



