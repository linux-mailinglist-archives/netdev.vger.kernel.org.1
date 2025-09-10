Return-Path: <netdev+bounces-221514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBFB50B09
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D6B5E506B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F48246770;
	Wed, 10 Sep 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrN7nsbk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406119D8AC
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471414; cv=none; b=CG2XFAeI/5ayhZkcm5lRaDqHZCLsLtvC89h68mdmydGwERNUUNBwBaQU8luh4AcJKJ16VR8CAQnfR8Zf/ERg9V4ailJj5G4GFe2aZiU4nYPILgDmdwe7ISM0BkYLDEu4zfUEEtCLpG6uAezvpOAqxQ///jadqTd6xBPmtsVfFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471414; c=relaxed/simple;
	bh=mY1dl4lrfNpL/PvXdAqeUc6vQMTZEdbD1dBR+0SXwUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SWkxVZd3Uw+GVOfwgi49mgjHst38HdLGV8m1H7SY1Teuw7gPGdAgKTOqPhAclRwX99anBE9QkNZLRKIwwKl9wPZZZC2DiSJMboHiTVNxEfsE0300O+Oa9ydpIIK3oFGcXJO+tiUlzYn2XomWtQNU4z4ev78mrIQWR7Nr56dDT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrN7nsbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96054C4CEF4;
	Wed, 10 Sep 2025 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471411;
	bh=mY1dl4lrfNpL/PvXdAqeUc6vQMTZEdbD1dBR+0SXwUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YrN7nsbkGdZ0n/9ZKkFVNenF9YH71scaawXlx++uDLZggTsvY319NXRDQqwBBLehZ
	 MYoX1IafdAWqginMnX/a53m6Yq3/bAZNbkT4d/KbNDqzvmURIXswmAI/2s2jDiW7+p
	 rofP1UmbbIBd/cNeCiPAk+/9+gYfxQLav6uzQklnOpWfqvwl97tdnKaV8PXIdNmG3z
	 uaNBPD708xX1U79YeDDQuONOiMqngzMWdjErSr0vqXLPoeSUN7qXXmOFiFqXUJdjlL
	 BHuOYkm94EniKfbae8fNDDfv2+SVUS7dS43Ler4ED1DpKSVXjpUZwbaWwoUJ7mYfGq
	 E8uyBTOTARaQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB118383BF69;
	Wed, 10 Sep 2025 02:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V7 net-next 00/11] *devlink,
 mlx5: Add new parameters for link management and SRIOV/eSwitch configurations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175747141474.881840.5527273005477069780.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 02:30:14 +0000
References: <20250907012953.301746-1-saeed@kernel.org>
In-Reply-To: <20250907012953.301746-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, jiri@nvidia.com,
 jacob.e.keller@intel.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Sep 2025 18:29:42 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> This patch series introduces several devlink parameters improving device
> configuration capabilities, link management, and SRIOV/eSwitch, by adding
> NV config boot time parameters.
> 
> Userspace(v2): https://lore.kernel.org/netdev/20250704045427.1558605-1-saeed@kernel.org/
> 
> [...]

Here is the summary with links:
  - [V7,net-next,01/11] devlink: Add 'total_vfs' generic device param
    https://git.kernel.org/netdev/net-next/c/ce0b015e2619
  - [V7,net-next,02/11] net/mlx5: Implement cqe_compress_type via devlink params
    https://git.kernel.org/netdev/net-next/c/bf2da4799fdb
  - [V7,net-next,03/11] net/mlx5: Implement devlink enable_sriov parameter
    https://git.kernel.org/netdev/net-next/c/95a0af146dff
  - [V7,net-next,04/11] net/mlx5: Implement devlink total_vfs parameter
    https://git.kernel.org/netdev/net-next/c/a4c49611cf4f
  - [V7,net-next,05/11] devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()
    (no matching commit)
  - [V7,net-next,06/11] devlink: Implement port params registration
    (no matching commit)
  - [V7,net-next,07/11] devlink: Implement get/dump netlink commands for port params
    (no matching commit)
  - [V7,net-next,08/11] devlink: Implement set netlink command for port params
    (no matching commit)
  - [V7,net-next,09/11] devlink: Throw extack messages on param value validation error
    (no matching commit)
  - [V7,net-next,10/11] devlink: Implement devlink param multi attribute nested data values
    (no matching commit)
  - [V7,net-next,11/11] net/mlx5: Implement eSwitch hairpin per prio buffers devlink params
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



