Return-Path: <netdev+bounces-169685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD1A453D9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A141C3AC42F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4178235368;
	Wed, 26 Feb 2025 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYQXfVSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA422655E
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539417; cv=none; b=tUOQiUpLd+lHJQ7hAcFuqYKhRBhuIy/CSlBVrB1UIjAfuP+FqXfUdBlQDy2CXUtylPLzgsl84FbxWtJK2kQvAKVN0YlSYpVf1kCmwpCN/2/sHgstjEhtAxrklsaNfEH1bK4AEx3hxYzK9CU1LwMJYoREODYs/o3CsKLMlxeJBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539417; c=relaxed/simple;
	bh=WK552cCYj+smWqu4/t3qx5DWwjQHikmgvEfZx4+R7is=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WpgRX4A5TrShB/LMUpgtuEIzcsqmCyoqj/Q2d+MBkwuVj64N5WVJ+4NEps0oDom1tZ7/agaIZnhvDtP40ODf5q659iAD+L0i6oanUhIh3XXYG+WlbRJSSo9ZQ8M6QDfLvbsMENrLJIRBRmiOCNl+6NaSsZD/royJ4UuKH9GMnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYQXfVSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF05C4CEE4;
	Wed, 26 Feb 2025 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539417;
	bh=WK552cCYj+smWqu4/t3qx5DWwjQHikmgvEfZx4+R7is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oYQXfVSW7eFcTJ7KmyAECzFbb6XJrriRoeD5wGF0oNGsiRzoqpu5+PbcKq94xZtID
	 SAFEC18bZdYYEN6lsgV6RpJwPGm+arMXzki9yegwJDlo/67Pdy7LCw6Zd34juKx+QO
	 Kem5FjA+95avA7wqnIRtzjKK+NOnWSmYXm+i1mXX9/T2EGdgZC7wd7dbHvVc7z51qZ
	 dh7iVmTmAacaPyp4HA/Mo08Jh+596T3DiyI5BReDb/l+Tk3BwMMkPkJ0Fwp6JdmelL
	 +0YwN4x8++3nE50pVoDAVQnhugn9qecIDGgTCzYqa18y0qQuXLELHu68kBkxCUlsU/
	 BmH4AIfmByA4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A52380CFDD;
	Wed, 26 Feb 2025 03:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-02-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053944874.217003.17019065204850978971.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:48 +0000
References: <20250224212446.523259-1-tariqt@nvidia.com>
In-Reply-To: <20250224212446.523259-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 23:24:46 +0200 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-02-24
    https://git.kernel.org/netdev/net-next/c/ef4a47a8abb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



