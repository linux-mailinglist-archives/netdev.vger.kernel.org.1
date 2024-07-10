Return-Path: <netdev+bounces-110471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4792C84A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41C2282C47
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7DD534;
	Wed, 10 Jul 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfG7O7he"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE2B660
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577433; cv=none; b=Y5YrfvZX4eh5sPH4bG6xcSw4JZI9YxahApcH9/ZP4PyMnNZjvbg7VCpRs1sRRixD+XH7UYP6rLhGKVndcua5tEtzQLiIHyF86tyNGrhC5+Bpr0h6WKERn0b6u8nWJFNsP3zdfopakJCm0RvdL5hTZKP/kUZlzirbIX23GGAEUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577433; c=relaxed/simple;
	bh=BkutZPX7OvRbUXyLt4dyO4F6UqWVhC+PWnZzTx0Evu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uzIkIhc+55sOu4DvCvKAmluUJMtsLTWtGs4Q2HdwnBtO19aemhNydU8zpYC0kivM6d8JftiJ39WAQ35j5KLUyT8+rJjPlexMzyE8crE1RsdiaARtOyy4HgqaNUOmUlz9NQkOdEWQkWv90YIUmbEkLhWwbMTq504Y73AQegGAVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfG7O7he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA535C32786;
	Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720577432;
	bh=BkutZPX7OvRbUXyLt4dyO4F6UqWVhC+PWnZzTx0Evu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TfG7O7heUi8DaKcmHGTW0ojFUZMEsREq0yH2ZKPQ8TfvOR/7XrgmHUtOno82GeNE5
	 vnFHYTH9VxDnm3MmyHM3KMwfromS44yNeqh5lWm/AtzG2SgB36uPE7TvDCg19bCOQ2
	 HvaItO4HFP2BFd9E8WcSW2P85HHoS2yynRwpaucyL52BUnZVCO4R48HBN5LVZMOqiE
	 kmiBkcwqLgQyyCigR60NTPaBDEW5WPpt9JHEh8+tvamaOCOFq3yMk6l0Ld4cyNF7x9
	 DgywHCxgHcFtVTgGVol6MpK7wwp6ekSrA7cOR1nAcnaUxu9NSTEUuovMI3/6J7jgaW
	 rfHjvPO7OnLyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE0DEC4332D;
	Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/10] mlx5 misc patches 2023-07-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057743270.1917.6200807747301952478.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 02:10:32 +0000
References: <20240708080025.1593555-1-tariqt@nvidia.com>
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 8 Jul 2024 11:00:15 +0300 you wrote:
> Hi,
> 
> This patchset contains features and small enhancements from the team to
> the mlx5 core and Eth drivers.
> 
> In patches 1-4, Dan completes the max_num_eqs logic of the SF.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/10] net/mlx5: IFC updates for SF max IO EQs
    (no matching commit)
  - [net-next,V2,02/10] net/mlx5: Set sf_eq_usage for SF max EQs
    (no matching commit)
  - [net-next,V2,03/10] net/mlx5: Set default max eqs for SFs
    (no matching commit)
  - [net-next,V2,04/10] net/mlx5: Use set number of max EQs
    (no matching commit)
  - [net-next,V2,05/10] net/mlx5: Add support for MTPTM and MTCTR registers
    (no matching commit)
  - [net-next,V2,06/10] net/mlx5: Add support for enabling PTM PCI capability
    (no matching commit)
  - [net-next,V2,07/10] net/mlx5: Implement PTM cross timestamping support
    (no matching commit)
  - [net-next,V2,08/10] net/mlx5: DR, Remove definer functions from SW Steering API
    https://git.kernel.org/netdev/net-next/c/e829a331ec28
  - [net-next,V2,09/10] net/mlx5e: SHAMPO, Add missing aggregate counter
    https://git.kernel.org/netdev/net-next/c/7204730b3304
  - [net-next,V2,10/10] net/mlx5e: CT: Initialize err to 0 to avoid warning
    https://git.kernel.org/netdev/net-next/c/f1ac0b7dcd49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



