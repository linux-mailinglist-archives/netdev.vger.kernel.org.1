Return-Path: <netdev+bounces-52373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D67FE82C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9631C20B77
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076016435;
	Thu, 30 Nov 2023 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYhfCaQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EB156E5
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0438C433C8;
	Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701317430;
	bh=ustUBrdwjT1UF6KXQQfjALxiIjfGhuEfURpw/7Lht+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KYhfCaQ51AYDqQlnSMHgaMH2cVnXWSy+Plrhz19I8Z69MmFaP4080xq9AjhDyY32Y
	 dQ9xI5hbmiP45Tf7A59R9A3qdu+RVnAiaGdZ51brogJUZolxEdsoEYPjyV0EWXnfjf
	 bygo/XkNUzK+Srm0KXeNEmgMV92ULm+XHIl1w1rWglBKg7HZHCHuUwnuVI+q05vbXo
	 SgLN+QC2nG6bVvAujTh70rrorR9t7JyNTKMxmq8gwZeR08sxQasuk0RodMOYL+v1GS
	 TEGgzQTjwlMdyJXVDB3KYD+uVY9t2Nr4cHnfhGOGqIc7Lhv+PtqOTXjDxnyAGOwUZ1
	 ZnMyzkLXMSS3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A48E1C691E1;
	Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/17] mlxsw: Support CFF flood mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131743066.26382.7879261566889666842.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:10:30 +0000
References: <cover.1701183891.git.petrm@nvidia.com>
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 16:50:33 +0100 you wrote:
> The registers to configure to initialize a flood table differ between the
> controlled and CFF flood modes. In therefore needs to be an op. Add it,
> hook up the current init to the existing families, and invoke the op.
> 
> PGT is an in-HW table that maps addresses to sets of ports. Then when some
> HW process needs a set of ports as an argument, instead of embedding the
> actual set in the dynamic configuration, what gets configured is the
> address referencing the set. The HW then works with the appropriate PGT
> entry.
> 
> [...]

Here is the summary with links:
  - [net-next,01/17] mlxsw: spectrum_fid: Privatize FID families
    https://git.kernel.org/netdev/net-next/c/01de00f439ab
  - [net-next,02/17] mlxsw: spectrum_fid: Rename FID ops, families, arrays
    https://git.kernel.org/netdev/net-next/c/ab68bd743af8
  - [net-next,03/17] mlxsw: spectrum_fid: Split a helper out of mlxsw_sp_fid_flood_table_mid()
    https://git.kernel.org/netdev/net-next/c/82ff7a196d76
  - [net-next,04/17] mlxsw: spectrum_fid: Make mlxsw_sp_fid_ops.setup return an int
    https://git.kernel.org/netdev/net-next/c/17eda112b0d8
  - [net-next,05/17] mlxsw: spectrum_fid: Move mlxsw_sp_fid_flood_table_init() up
    https://git.kernel.org/netdev/net-next/c/1d0791168ef7
  - [net-next,06/17] mlxsw: spectrum_fid: Add an op for flood table initialization
    https://git.kernel.org/netdev/net-next/c/80638da22e11
  - [net-next,07/17] mlxsw: spectrum_fid: Add an op to get PGT allocation size
    https://git.kernel.org/netdev/net-next/c/1686b8d902fd
  - [net-next,08/17] mlxsw: spectrum_fid: Add an op to get PGT address of a FID
    https://git.kernel.org/netdev/net-next/c/e917a789594c
  - [net-next,09/17] mlxsw: spectrum_fid: Add an op for packing SFMR
    https://git.kernel.org/netdev/net-next/c/f6454316c8b9
  - [net-next,10/17] mlxsw: spectrum_fid: Add a not-UC packet type
    https://git.kernel.org/netdev/net-next/c/a59316ffd92e
  - [net-next,11/17] mlxsw: spectrum_fid: Add hooks for RSP table maintenance
    https://git.kernel.org/netdev/net-next/c/315702e09bed
  - [net-next,12/17] mlxsw: spectrum_fid: Add an object to keep flood profiles
    https://git.kernel.org/netdev/net-next/c/5e6146e34b9c
  - [net-next,13/17] mlxsw: spectrum_fid: Add profile_id to flood profile
    https://git.kernel.org/netdev/net-next/c/af1e696fdf1e
  - [net-next,14/17] mlxsw: spectrum_fid: Initialize flood profiles in CFF mode
    https://git.kernel.org/netdev/net-next/c/d79b70dbb760
  - [net-next,15/17] mlxsw: spectrum_fid: Add a family for bridge FIDs in CFF flood mode
    https://git.kernel.org/netdev/net-next/c/db3e541b59e2
  - [net-next,16/17] mlxsw: spectrum_fid: Add support for rFID family in CFF flood mode
    https://git.kernel.org/netdev/net-next/c/72a4cedb3760
  - [net-next,17/17] mlxsw: spectrum: Use CFF mode where available
    https://git.kernel.org/netdev/net-next/c/69f289e9c72a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



