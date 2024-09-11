Return-Path: <netdev+bounces-127198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4263B974892
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794BE1C2516A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC873B182;
	Wed, 11 Sep 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMq/2Sye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848C39FE5
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024833; cv=none; b=Z6iMFjaihW2nj1xrH1GaZDv8+Ns7wVYO53o8kuL23NIz9V9/zbimp9Gg1VrmgXK7LaY+RjievAJs266ZFZ07r3tystIqb0qO1FCRXZcf8ooEQTsNDLOMvqxyVcE4jLsql/LxMu2haAVwj51jQvwvr/E6mIPB13q379yilkK3ATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024833; c=relaxed/simple;
	bh=aOpQ/JNvJWQZDWfWYSJudJD9JrQhchRkkWg5iptu+7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S7FxWJHziSHVKsVES20rz/Ht5I+FgCz1/Lxbjb7Wvk4DpSdqPjOyT0fCOQ0N8Lh5JBxVAvEckkttVl3FRuptc1zouFThjgNKPturoczEqIpub/1DgncQDY6nHEVH+ItXlBLLY4BGUCgEUNmR7LntGaiXfR5QoWEGwQIdIOyfQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMq/2Sye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA185C4CECD;
	Wed, 11 Sep 2024 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726024833;
	bh=aOpQ/JNvJWQZDWfWYSJudJD9JrQhchRkkWg5iptu+7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hMq/2SyeNiPIwImKT0noDUNsvUW1okvNVum+7NARDTGuzI7gQoMegUcdvHfopFSyY
	 pZmzVlQxNSI77cSbJR5qT9rFCadmRh1fRdh5dqAIXHqJRkt2ZSjtfOBNkD0D1t0Eul
	 Dw9H15WHX967tEwKya4gcm9Fb1SPFImI30dgriBy5E3zWccJl9+prDJGbekiyh07y1
	 irZ9F80ur+kKQaMYRiSEwqa14ZI7fVBfbbQ6maCrTP2uqJ3uSBmxSqpc8UPj6sMOnk
	 YaW2GI9L+ihUcYkmXokuQd+FFnql7AEfE7bW2TAV5Rv1zSAZdrTYCwL+L/vM4fPTdH
	 wP13KR1pUDpqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343FA3822FA4;
	Wed, 11 Sep 2024 03:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2024-09-09 (ice, igb)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602483399.473764.16215160599783054534.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 03:20:33 +0000
References: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  9 Sep 2024 13:38:36 -0700 you wrote:
> This series contains updates to ice and igb drivers.
> 
> Martyna moves LLDP rule removal to the proper uninitialization function
> for ice.
> 
> Jake corrects accounting logic for FWD_TO_VSI_LIST switch filters on
> ice.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: Fix lldp packets dropping after changing the number of channels
    https://git.kernel.org/netdev/net/c/9debb703e149
  - [net,2/5] ice: fix accounting for filters shared by multiple VSIs
    https://git.kernel.org/netdev/net/c/e843cf7b34fe
  - [net,3/5] ice: stop calling pci_disable_device() as we use pcim
    https://git.kernel.org/netdev/net/c/e6501fc38a75
  - [net,4/5] ice: fix VSI lists confusion when adding VLANs
    https://git.kernel.org/netdev/net/c/d2940002b0aa
  - [net,5/5] igb: Always call igb_xdp_ring_update_tail() under Tx lock
    https://git.kernel.org/netdev/net/c/27717f8b17c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



