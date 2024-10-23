Return-Path: <netdev+bounces-138290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 088B39ACD8A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A519AB24E60
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7081CB53D;
	Wed, 23 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVRn2Ekl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8D1C232D
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694424; cv=none; b=ajaHb73/XcLwcyCmPIuppCbK9ZNHFgWHFFvRzjLZ/Pf5QK8/ttFf/m0Q7p85Ocb+hepo3ydyQ1D3qJGvW7D/O1+NofVZ8IM95No1GMtJuu3f51uYSy3gpA6TN7hzsYWVJOvbWdVxbIWlpxGhIblm+v0kfAQwBYNv3El4mAq7Tco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694424; c=relaxed/simple;
	bh=DnaqBZSuom3atESzWnwxXO/gl4QZsfGBoZkEfIWy5uQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XEOJlxk4eSiJT63VztZaoAL2i05pCfJGqGQVhdcioumMca/bst3qVkbxPgKWkkwtBsdor0ANnp/8nmHh2JCTP4Kz2u+cDAt7ro2O9DdWXFuTALLfqnVZvjT/iJC79wMC1zk3vpkVjbEk63wM+X7H7bvE7XJ5rVBT0qpwHhMgccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVRn2Ekl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F83C4CEC6;
	Wed, 23 Oct 2024 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694423;
	bh=DnaqBZSuom3atESzWnwxXO/gl4QZsfGBoZkEfIWy5uQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dVRn2Ekl5Xa5yL270d9bgGfC7QFXbmUb936rDF1sOA96/JTqbozqaBOXSPJXVPOWJ
	 5lhdxQTySW5Yb+l8Ht6Kvn9N2vBsOnkqkUy1bsRPFZl2Y8ld7LYeGoZbyLb7quDFS/
	 /UU6G8BWtNP4IOT867Rkrw2cvvc5h0OL7RvNjVt+XjaLKju3zoU7YgqhAsDmTAYJRm
	 ult7XVS4eDw8UUH+OjgZj/eZ0FC5PJMEkYEw4dPJF06UKnJjKI0nK2pL5dqliqIcEd
	 k4mvhgyEisj+bIZB7KK53aOvjwLEmDhKIVI5kklPC//fO815QtcGBHlCiGgD3V6jUF
	 RnTnjtF+DvULA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F773809A8A;
	Wed, 23 Oct 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172969443002.1617019.2864114644993231138.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 14:40:30 +0000
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 12:52:17 +0100 you wrote:
> Hi,
> 
> I've found yet more potential for cleanups in the XPCS driver.
> 
> The first patch switches to using generic register definitions.
> 
> Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
> which can be simplified down to a simple if() statement.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: pcs: xpcs: use generic register definitions
    https://git.kernel.org/netdev/net-next/c/1d2709d6d390
  - [net-next,2/7] net: pcs: xpcs: remove switch() in xpcs_link_up_1000basex()
    https://git.kernel.org/netdev/net-next/c/8d2aeab4ce78
  - [net-next,3/7] net: pcs: xpcs: rearrange xpcs_link_up_1000basex()
    https://git.kernel.org/netdev/net-next/c/b61a465a7619
  - [net-next,4/7] net: pcs: xpcs: replace open-coded mii_bmcr_encode_fixed()
    https://git.kernel.org/netdev/net-next/c/1c17f9d3fe17
  - [net-next,5/7] net: pcs: xpcs: combine xpcs_link_up_{1000basex,sgmii}()
    https://git.kernel.org/netdev/net-next/c/4145921c3055
  - [net-next,6/7] net: pcs: xpcs: rename xpcs_config_usxgmii()
    https://git.kernel.org/netdev/net-next/c/11afdf3b2ece
  - [net-next,7/7] net: pcs: xpcs: remove return statements in void function
    https://git.kernel.org/netdev/net-next/c/fd4056db7aee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



