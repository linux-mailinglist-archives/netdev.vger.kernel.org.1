Return-Path: <netdev+bounces-132205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35943991060
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D6B2A818
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C731FB3CD;
	Fri,  4 Oct 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfxvLMAV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A71F890B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069033; cv=none; b=qdzIuWeiJtq38TU7KSKUyv1RRj2X81VcuW71EMECILFfRq7YXNt3YnPJKhH8AHgdXATtBri4CRa+Cxo9GPXqPdemrFGv6QYyrk9t4QTO3n7aSdNqYD8/5n6QOye2dJD6DVgzfupNDv8KB2yVwmLUDXB9VSFdv/4xMfrXuu3cUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069033; c=relaxed/simple;
	bh=tn8siBKiBCxl2gFc+O0HPS3mUVPk4/rWlt/NGXIATlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SlCLt1xPjfkoVSkrUDacR6MfsEZgDulFN4OMIbPvLuJCuaCOhH7pXdFNFLqODRkliMkZ8SRtRoWe7LPYPtCx+MV1fuBoh78s4pvFiVmJ6+39U9B62uAc3BVye1tpB98t+lpvPcBeUb/VnCgma0cg4pl1zv2Se6lPXqCGPCs9Xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfxvLMAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDABC4CEFE;
	Fri,  4 Oct 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069033;
	bh=tn8siBKiBCxl2gFc+O0HPS3mUVPk4/rWlt/NGXIATlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lfxvLMAVD992YaTADF6NStA/jUhKtkq+FjJGhrarZav5ucqb8hDUPgDty9TrGVpnu
	 eB7djtupliV5IQyDvA4n313H2qDVF5gneh1koA7/X2TeIKvwWey5K5035D4ISSj9Rf
	 vmfTS4NGuoIPO7q50dBYYLLCskAaqaf8e6FMZa5bBGG88K0sQS8nfgKoB2+Sl+mjHk
	 cmr0ctzdzHOefAvcRpJV5Du5UeNdiLeeh1c7gkYsPvdITbnQ3uEOYZTYdoUqZSGZsc
	 p1NqE2OKJM+56LhdJmm/cEyypit2zgFDX4N9yzHhCpJ+R3BHm3QKqdQFKoUAvoFv2o
	 xn3T05ueyKujA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4B39F76FF;
	Fri,  4 Oct 2024 19:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] ibmvnic: Fix for send scrq direct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806903625.2708740.7897093517925120680.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 19:10:36 +0000
References: <20241001163200.1802522-1-nnac123@linux.ibm.com>
In-Reply-To: <20241001163200.1802522-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 11:31:59 -0500 you wrote:
> This is a v2 of a patchset (now just patch) which addresses a
> bug in a new feature which is causing major link UP issues with
> certain physical cards.
> 
> For a full summary of the issue:
>   1. During vnic initialization we get the following values from vnic
>      server regarding "Transmit / Receive Descriptor Requirement" (see
>       PAPR Table 584. CAPABILITIES Commands):
>     - LSO Tx frame = 0x0F , header offsets + L2, L3, L4 headers required
>     - CSO Tx frame = 0x0C , header offsets + L2 header required
>     - standard frame = 0x0C , header offsets + L2 header required
>   2. Assume we are dealing with only "standard frames" from now on (no
>      CSO, no LSO)
>   3. When using 100G backing device, we don't hand vnic server any header
>      information and TX is successful
>   4. When using 25G backing device, we don't hand vnic server any header
>     information and TX fails and we get "Adapter Error" transport events.
> The obvious issue here is that vnic client should be respecting the 0X0C
> header requirement for standard frames.  But 100G cards will also give
> 0x0C despite the fact that we know TX works if we ignore it. That being
> said, we still must respect values given from the managing server. Will
> need to work with them going forward to hopefully get 100G cards to
> return 0x00 for this bitstring so the performance gains of using
> send_subcrq_direct can be continued.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] ibmvnic: Inspect header requirements before using scrq direct
    https://git.kernel.org/netdev/net/c/de390657b5d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



