Return-Path: <netdev+bounces-84695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0CC897E0C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 05:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7134A1C2159C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA42032B;
	Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNZhlDAM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4118AF4
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202633; cv=none; b=io0bw8J+OYjxiy2y5XOyvN0AXSK+A/n8iZjoFsqJqvczzBlnUH7h8CtgMz1naN+zyCy5Lhm5KzGbOikmtfbC4V37F3FXj8J1a5WAmzHsX3jvdIFoXB83RsJLZueO7IaOG3g/yQrIMzIKye6aEIS949QX0+s00UT4L9ll5kUDoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202633; c=relaxed/simple;
	bh=yitV3Y/nUMp47MpsrU4gfYwP7PfZ1YVyLf+GO+wyAtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UpZ0Ccl/pSFrt9couxqI7flXXY9+5snLVeLk9reXyi83rMSiesmLFy2+gOXYCf2RM6SZxm+bYbZ8PCKIzKqdR87TBWLfQBtpGttDly4VacRaUwmGa9CuQwdE6SNdajXU2gorF2eguIjYKadxMCqCrjXRgf/GW+cdn2CZwjrNFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNZhlDAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A145C43394;
	Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712202633;
	bh=yitV3Y/nUMp47MpsrU4gfYwP7PfZ1YVyLf+GO+wyAtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNZhlDAM1D5kzu/sAqZTQXPHT9XNFAs1za0UI3yUe3C+YSlpqRDyA14qBcTjP0x6y
	 0xDY5q7yHkaTLaodbIRwKcvwUJwm3H/rnqeHAPzXff7/6I3a+H3LoUvo0KqSFLyGXz
	 2HTGozw3BIUWDnsZPyOow1sGkgAZ0adGuzq386CQWMfNFY9r0FOZu5mJj2KDHeOUSb
	 Ur5/XOc/sRGXw7SVP59PtCE1WQ6S0hfsvvsiq73AoWdqEoHX8x8bmC3dpCprOb3kgp
	 N3KH0pSDXL3/hb0cY9oqCCZ0Xnm5wswpOHaZjzrhoMVfoUREzkPztALgxl1DZ3cy89
	 1lleooXBYaV4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED82DD84BA4;
	Thu,  4 Apr 2024 03:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] mlxsw: Preparations for improving performance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171220263296.6004.11333970605032251807.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 03:50:32 +0000
References: <cover.1712062203.git.petrm@nvidia.com>
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Apr 2024 15:54:13 +0200 you wrote:
> Amit Cohen writes:
> 
> mlxsw driver will use NAPI for event processing in a next patch set.
> Some additional improvements will be added later. This patch set
> prepares the code for NAPI usage and refactor some relevant areas. See
> more details in commit messages.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] mlxsw: pci: Move mlxsw_pci_eq_{init, fini}()
    https://git.kernel.org/netdev/net-next/c/d38718a525a3
  - [net-next,02/15] mlxsw: pci: Move mlxsw_pci_cq_{init, fini}()
    https://git.kernel.org/netdev/net-next/c/f46de9f0e70c
  - [net-next,03/15] mlxsw: pci: Do not setup tasklet from operation
    https://git.kernel.org/netdev/net-next/c/fb29028ae718
  - [net-next,04/15] mlxsw: pci: Arm CQ doorbell regardless of number of completions
    https://git.kernel.org/netdev/net-next/c/38b124cb4ee5
  - [net-next,05/15] mlxsw: pci: Remove unused counters
    https://git.kernel.org/netdev/net-next/c/57beea8e5667
  - [net-next,06/15] mlxsw: pci: Make style changes in mlxsw_pci_eq_tasklet()
    https://git.kernel.org/netdev/net-next/c/29ad2a990648
  - [net-next,07/15] mlxsw: pci: Poll command interface for each cmd_exec()
    https://git.kernel.org/netdev/net-next/c/d4b3930b19f7
  - [net-next,08/15] mlxsw: pci: Rename MLXSW_PCI_EQS_COUNT
    https://git.kernel.org/netdev/net-next/c/7bc6a3098c38
  - [net-next,09/15] mlxsw: pci: Use only one event queue
    https://git.kernel.org/netdev/net-next/c/6fc280a36515
  - [net-next,10/15] mlxsw: pci: Remove unused wait queue
    https://git.kernel.org/netdev/net-next/c/2c200863fcc7
  - [net-next,11/15] mlxsw: pci: Make style change in mlxsw_pci_cq_tasklet()
    https://git.kernel.org/netdev/net-next/c/a0639236d420
  - [net-next,12/15] mlxsw: pci: Break mlxsw_pci_cq_tasklet() into tasklets per queue type
    https://git.kernel.org/netdev/net-next/c/1df7d871e349
  - [net-next,13/15] mlxsw: pci: Remove mlxsw_pci_sdq_count()
    https://git.kernel.org/netdev/net-next/c/0cd1453b7e55
  - [net-next,14/15] mlxsw: pci: Remove mlxsw_pci_cq_count()
    https://git.kernel.org/netdev/net-next/c/82238f0ddb46
  - [net-next,15/15] mlxsw: pci: Store DQ pointer as part of CQ structure
    https://git.kernel.org/netdev/net-next/c/77c6e27df9e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



