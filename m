Return-Path: <netdev+bounces-200530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D9AE5E63
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B44178ED7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8F2566E9;
	Tue, 24 Jun 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/t73dOs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244E2566D9
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751388; cv=none; b=A/pJ34Ovixm437NyswJdfMJbkiii60pE2xMpW3aUJu9G22hA9WsRAxh+qzN8MdihFs6mPKqHiecRztAVuBFtctf2YVTRiwX2FQ2Tm81hjRyeLUjwcc5q7aI+/+ITGvOHmHBC3sjArTR2TZhhjvBDj/iONlzHCj2P1LpqdxxJqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751388; c=relaxed/simple;
	bh=gRKZ+C8Q4IJPCNAELRvlLZ0V4HTmFdHVYpX+v9aspzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rD+fCO7fR4cGNo7TZijD5ExjxGCqlcFhjEFT8ZA8q+MfegjC8ZXctI1fpqXbJYz1/bFb7oQUKOMxRcGb0acF9evqotMo1AjtFNKxQmHozp9S+RZy4vLTjGeSDhEejECYeqwhzWPwQRMsReywtQEBaZ6G5sRrMSIpqe3VPjiVc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/t73dOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F7FC4CEE3;
	Tue, 24 Jun 2025 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750751388;
	bh=gRKZ+C8Q4IJPCNAELRvlLZ0V4HTmFdHVYpX+v9aspzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/t73dOscU+gxIaonzrx0OsKa7l0MYKNT/OEx1JkKM6dOr/1ejZSqq8Oi5FIGO5N1
	 E9/Z3cZREFBIyIA/QATOgIZ4GqQZ/Mse4H4/zKsVQYcv6k9Epo/zTI0UKjPMj7uOfb
	 +CTUx3dWLqb+aeOPg+ctBdzDbbolHF2xG9KOPsKQDHA/APFdFN60Z+LkkEQ84UIZxs
	 fhMLFMCRUIRDWg6sTJeH4+/dpHSutYk/k1PlUW4YtMmhVQ8FkNruchLF8P7UNpbhS0
	 L+ShqRnwp8qlWa1MxVbkTdTn2R7ZUMDqDTP+ZMLraEAys4v7BdyRXnGtYz1PS7+Ubz
	 wQHxRkfzFnY8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCB38111DD;
	Tue, 24 Jun 2025 07:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3 0/8] Add support for 25G, 50G,
 and 100G to fbnic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175075141500.3438879.5219974544393013062.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 07:50:15 +0000
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 kuba@kernel.org, kernel-team@meta.com, edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Jun 2025 15:07:15 -0700 you wrote:
> The fbnic driver up till now had avoided actually reporting link as the
> phylink setup only supported up to 40G configurations. This changeset is
> meant to start addressing that by adding support for 50G and 100G interface
> types.
> 
> With that basic support added fbnic can then set those types based on the
> EEPROM configuration provided by the firmware and then report those speeds
> out using the information provided via the phylink call for getting the
> link ksettings. This provides the basic MAC support and enables supporting
> the speeds as well as configuring flow control.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: phy: Add interface types for 50G and 100G
    https://git.kernel.org/netdev/net-next/c/bbb7d478d91a
  - [net-next,v3,2/8] fbnic: Do not consider mailbox "initialized" until we have verified fw version
    https://git.kernel.org/netdev/net-next/c/3b180b227eb1
  - [net-next,v3,3/8] fbnic: Retire "AUTO" flags and cleanup handling of FW link settings
    https://git.kernel.org/netdev/net-next/c/a6bbbc5bc4c6
  - [net-next,v3,4/8] fbnic: Replace link_mode with AUI
    https://git.kernel.org/netdev/net-next/c/f663a1abf39a
  - [net-next,v3,5/8] fbnic: Update FW link mode values to represent actual link modes
    https://git.kernel.org/netdev/net-next/c/0853d8521bc1
  - [net-next,v3,6/8] fbnic: Set correct supported modes and speeds based on FW setting
    https://git.kernel.org/netdev/net-next/c/22780f69fb45
  - [net-next,v3,7/8] fbnic: Add support for reporting link config
    https://git.kernel.org/netdev/net-next/c/fb9a3bb7f7f2
  - [net-next,v3,8/8] fbnic: Add support for setting/getting pause configuration
    https://git.kernel.org/netdev/net-next/c/eb4c27edb4d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



