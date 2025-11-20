Return-Path: <netdev+bounces-240290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E27C722D4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D09CD34666A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5B28FFE7;
	Thu, 20 Nov 2025 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Hfshci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B262620FC
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612506; cv=none; b=Mbf4FPYStwMSvS+j7VPlUUs3+KXzafgS7XgHIsz8z1OhOGEaKLgrRFVhZ2wI2I3jafKwXmjXQBEXw46Qza7vpJOpAAhswVimsYlD5Zzumwzm+CAVayIZdqSkS+sZjkIN5GhpqfRdlInvugUZ1+dyXC7GiDboj19rjiSUpmvztiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612506; c=relaxed/simple;
	bh=YWiHVX2A91wBfaUOLTclPnR07NE4T5lGt937WdBPuIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bj4JcixSWR/vTo4KqyopyDfh2pM3Q9xSzglZqiQOm3OP2n47UjjvFnUlfc4Rlsytq+h9WCsGngXCF98amzpG88ASvs0CThoSm3tm0tOSKPSONPKGwY/EVy24ECbxwdoa1FimdVlT4dYErceK5mndWh+fldSx95PYXkoFoEXmkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Hfshci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A2C4CEF1;
	Thu, 20 Nov 2025 04:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763612506;
	bh=YWiHVX2A91wBfaUOLTclPnR07NE4T5lGt937WdBPuIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6HfshciLilq4qXl2kik1ED3Lsi6PBvSDLASThPvuvvOD7HDV5/TikEHnBkv6nN5P
	 hvvn9A2aUNlgMkWHEpp4GxmyzRMO0cLffNIConJmzsVRLW4YZQ+sBPAezrW6jMEY8j
	 kwc2rVuDpJ82G4l65447G57ntGVr48g05AnXIED/lW4GDOw+z/V8xijat4577xIz9A
	 wLww03a0l9Si6nslSnAcADCkoCpIbFfToFOpyNkTJBFMER/DKjsdznvPOtiV02qO8b
	 vyXYNLb3tYOgSoJ1nDJqx344FmKZggecwQv+fqbFiF5sXdXzNyTrRLEto1t0cZwy7h
	 6tl318HnTLMSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD039EF974;
	Thu, 20 Nov 2025 04:21:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2025-11-18 (idpf, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361247149.1075817.12663085610916814588.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:21:11 +0000
References: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 18 Nov 2025 15:52:03 -0800 you wrote:
> This series contains updates to idpf and ice drivers.
> 
> Emil adds a check for NULL vport_config during removal to avoid NULL
> pointer dereference in idpf.
> 
> Grzegorz fixes PTP teardown paths to account for some missed cleanups
> for ice driver.
> 
> [...]

Here is the summary with links:
  - [net,1/2] idpf: fix possible vport_config NULL pointer deref in remove
    https://git.kernel.org/netdev/net/c/118082368c2b
  - [net,2/2] ice: fix PTP cleanup on driver removal in error path
    https://git.kernel.org/netdev/net/c/23a5b9b12de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



