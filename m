Return-Path: <netdev+bounces-219348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5FB41076
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7705D560B0D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144827FD4A;
	Tue,  2 Sep 2025 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxALRath"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F427FD43;
	Tue,  2 Sep 2025 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854027; cv=none; b=JD8QORQLEVv4YF7SIIVnb3AZ65X8MOT7FjcfNSNkb+1514orhgCGlJxFWmOTLEOG5sHM3gCuaVTcx1MAXb862KArs5puiTvQXs48u+EyNl3uDiDlyDsHYgKJMlQGj8n56POkwOQdo73+YEebaaB7US/aD89qhYYGtfCmiMY2AVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854027; c=relaxed/simple;
	bh=PMbDPBrZdFBF3Ihh1G6syUjIrq/w8TfmNFEsm1gU2Cs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O3HyJcHSnvfZqgON+gkf6ft5iqumfcuYqXpe0DMsVnXnSD8VDBS11A1B1EuJEhFRal7G6cXKt+s5j0Qx4mrJRxSoVABqZDHPZ4cjamOQcWNem8ePGowqPSZbTcEB2ZCneYl4GQpQe4Xr5eH9fvh6mCxZjvZLmM5lwmb8KhZlPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxALRath; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF5CC4CEF4;
	Tue,  2 Sep 2025 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854027;
	bh=PMbDPBrZdFBF3Ihh1G6syUjIrq/w8TfmNFEsm1gU2Cs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxALRathGDdhPuinntMxnTrfrvhKvi6jWBzMQBT2FwIALAFINjyscWqFhxkbqDu5a
	 QkMH4CmpqDKITcENJJED9XS6uoh5ZVErHXmSsNRThCxZ+5wwPC0pNQf0THJG+PS/2D
	 c3i+Z6zQ09/nfdfVgFBXt/F+pNcsq3pAMrbKfZftcxOuKVLw9GeSwSBCLjR8bbRCj8
	 aiGvlE14LAOiJqhc/TG4gSS47kUAX7Y6cbu5/i0GxyRJXplaJUKMZdHcxhbbjgAwCF
	 YIC6eNbvSlKNx2YuuI/h4NwIKdM1aj6eXzRxCJhdTa0P2w64PHCFfQUC1mu7uEoXqR
	 1mGSJEud1f9TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF19383BF64;
	Tue,  2 Sep 2025 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685403232.461360.16040068795389077182.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:32 +0000
References: <2029487.1756512517@famine>
In-Reply-To: <2029487.1756512517@famine>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 17:08:37 -0700 you wrote:
> Remove the implementation of use_carrier, the link monitoring
> method that utilizes ethtool or ioctl to determine the link state of an
> interface in a bond.  Bonding will always behaves as if use_carrier=1,
> which relies on netif_carrier_ok() to determine the link state of
> interfaces.
> 
> 	To avoid acquiring RTNL many times per second, bonding inspects
> link state under RCU, but not under RTNL.  However, ethtool
> implementations in drivers may sleep, and therefore this strategy is
> unsuitable for use with calls into driver ethtool functions.
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: Remove support for use_carrier
    https://git.kernel.org/netdev/net-next/c/23a6037ce76c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



