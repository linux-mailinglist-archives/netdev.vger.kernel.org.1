Return-Path: <netdev+bounces-217115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D7B37662
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E703B2E58
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF31E832A;
	Wed, 27 Aug 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ/mvdEb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB01DF755
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256410; cv=none; b=rFNKV186gS8HIpKTAkte4zVR1cFrtisfEsKjGEHxMWdYZO7/aV8C8NdqVDI46/ekGIOLfsbb1SU9RQxpciJ6loodOYD6wu3d6PtcTWMM5E4CWdWMwSzldhHbBUoaeD3PaWw5H6DGcAQWeghqD3+0g4WKctoMaWHyOtkBRy19jcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256410; c=relaxed/simple;
	bh=2/slfL/neMkEd38IUqy5kzLgMu0G9o5h7SZjNTRuHkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UkF0g3TU++Aw+9xwpY18SIp2lHX3EuwkJkLhnTch90e9SDqbqzYcu4PfzcvjZQKiEFIiXh67l//dTSuxM7+8gfQnfse/pIMCu4B/7RfnFSD5/4Lr++OoYjFbFlMeGjl6tPPgqh8PglF8r53akboLJjU6TMv65XjZuYdLhXFEME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ/mvdEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BD3C4CEF1;
	Wed, 27 Aug 2025 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756256410;
	bh=2/slfL/neMkEd38IUqy5kzLgMu0G9o5h7SZjNTRuHkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fJ/mvdEbY3wwPkNiZveLmXJ9tMuPK8/R2iNDSniDutfyFqCROrs25Hkp91FcAz0Xf
	 Qna3TqVpqEPHc9kN0mlb9segYQbKchR8gnpbtaoUN3DhIFCLG0oD+rZd9KJOj3m09u
	 p0yrLzTP4FeNE20Mu2jaqj1pNeD2GCKOY9UwUozaZuMwxHN3A0A0DSXQhZjuT7Di/m
	 fKzjaUDhZgmLxTWmC4DSzgvB8TKfbMrsx60PR1gcrSUFTyXSwhoacIuY+5T15Bz6BU
	 q7vVYlytWoTwLZqWXY4y9CMD2J+tJgD7VRtmbNq+lyExmf0WkQYqTdYspRmfhEQs+g
	 2xx3JWrH9Y9yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2EC383BF70;
	Wed, 27 Aug 2025 01:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-08-25 (ice, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625641772.155051.13155790283466540733.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:00:17 +0000
References: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 25 Aug 2025 14:50:11 -0700 you wrote:
> For ice:
> Emil adds a check to ensure auxiliary device was created before tear
> down to prevent NULL a pointer dereference.
> 
> Jake reworks flow for failed Tx scheduler configuration to allow for
> proper recovery and operation. He also adjusts ice_adapter index for
> E825C devices as use of DSN is incompatible with this device.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
    https://git.kernel.org/netdev/net/c/60dfe2434eed
  - [net,2/5] ice: don't leave device non-functional if Tx scheduler config fails
    https://git.kernel.org/netdev/net/c/86aae43f21cf
  - [net,3/5] ice: use fixed adapter index for E825C embedded devices
    https://git.kernel.org/netdev/net/c/5c5e5b52bf05
  - [net,4/5] ice: fix incorrect counter for buffer allocation failures
    https://git.kernel.org/netdev/net/c/b1a0c977c6f1
  - [net,5/5] ixgbe: fix ixgbe_orom_civd_info struct layout
    https://git.kernel.org/netdev/net/c/ed913b343dcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



