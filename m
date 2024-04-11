Return-Path: <netdev+bounces-86839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6A8A066B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35561F25E12
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDA13B7A3;
	Thu, 11 Apr 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI43lIFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC413B794
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804432; cv=none; b=DWMSOEtWqAYjaF4mXWKTvIzZknCdm7LXCmtOsh/5L+aOzUfTLsaluoHLkpzoGr/ec5KlWavu70W3OROtYZ0pH2mTyssKMcKrUkAc5UY6JgJrTtUZJiYaNnv8PDTm/mmiUj1nB5Qx7qATgoHvcOWm1L28dtmcwLEVqOY7N445mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804432; c=relaxed/simple;
	bh=GiiAz4EkNSEhzVXF8w7OkUIXU9rxQtdhS3M8FlqLgBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdmmkDctM54VaXrrZ4sWGTlXIyar/14Mxsk5HU64fu7qr25CX03KuAKxaR4HDZlmpQYfNUyIV52VSpyYPzgh/JBxJPKRjmxyqoPUAgL0gOj8Px4QIPmhkdFihB1flshlwTfRrIdUh/oMat58BoBqEhXbVqIcGF3UcryOGUfH8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI43lIFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B163C43394;
	Thu, 11 Apr 2024 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712804432;
	bh=GiiAz4EkNSEhzVXF8w7OkUIXU9rxQtdhS3M8FlqLgBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fI43lIFGmlintbwx6KpveZRnv+lgDDjoPgfIhWnU0dOMSB84ct1ityXQQpitSs0an
	 6vRdno0rIimnY0MhF5lvc9ueM4qvTshNBxKQPge6HeqX5QJT5KP0sBwHkdbftRglHj
	 F9GfOxp73UkRtT219yqX446t2eWoW46PnTV/1nVFBNufIxexLos3hricnyXVxsO99W
	 kYC5F7SR1ZjyhFDJ1LW2ivINMpOUVKB0rw7qFjss/pl+JocRLF8W0UtUYXn8x5MkS0
	 HFnghiPaMy6TZWb2b2wZnQctP6JQl1qAXLsmox+Lf8EdY397jNTDI7kNM+6j3sKh05
	 SD6IIj1klQXuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41770C395F6;
	Thu, 11 Apr 2024 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 00/12] mlx5 misc fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280443226.1698.7858481474022694709.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 03:00:32 +0000
References: <20240409190820.227554-1-tariqt@nvidia.com>
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Apr 2024 22:08:08 +0300 you wrote:
> Hi,
> 
> This patchset provides bug fixes to mlx5 driver.
> 
> This is V2 of the series previously submitted as PR by Saeed:
> https://lore.kernel.org/netdev/20240326144646.2078893-1-saeed@kernel.org/T/
> 
> [...]

Here is the summary with links:
  - [net,V2,01/12] net/mlx5: E-switch, store eswitch pointer before registering devlink_param
    https://git.kernel.org/netdev/net/c/0553e753ea9e
  - [net,V2,02/12] net/mlx5: Register devlink first under devlink lock
    https://git.kernel.org/netdev/net/c/c6e77aa9dd82
  - [net,V2,03/12] net/mlx5: offset comp irq index in name by one
    https://git.kernel.org/netdev/net/c/9f7e8fbb91f8
  - [net,V2,04/12] net/mlx5: Properly link new fs rules into the tree
    https://git.kernel.org/netdev/net/c/7c6782ad4911
  - [net,V2,05/12] net/mlx5: Correctly compare pkt reformat ids
    https://git.kernel.org/netdev/net/c/9eca93f4d5ab
  - [net,V2,06/12] net/mlx5e: RSS, Block changing channels number when RXFH is configured
    https://git.kernel.org/netdev/net/c/ee3572409f74
  - [net,V2,07/12] net/mlx5e: Fix mlx5e_priv_init() cleanup flow
    https://git.kernel.org/netdev/net/c/ecb829459a84
  - [net,V2,08/12] net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
    https://git.kernel.org/netdev/net/c/2f436f186977
  - [net,V2,09/12] net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit
    https://git.kernel.org/netdev/net/c/86b0ca5b118d
  - [net,V2,10/12] net/mlx5e: RSS, Block XOR hash with over 128 channels
    https://git.kernel.org/netdev/net/c/49e6c9387051
  - [net,V2,11/12] net/mlx5: Disallow SRIOV switchdev mode when in multi-PF netdev
    https://git.kernel.org/netdev/net/c/7772dc7460e8
  - [net,V2,12/12] net/mlx5: SD, Handle possible devcom ERR_PTR
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



