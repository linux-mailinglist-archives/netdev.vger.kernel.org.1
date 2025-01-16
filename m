Return-Path: <netdev+bounces-158741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D76A131C4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957BA1886B26
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051918635F;
	Thu, 16 Jan 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAtO0/LQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55164A01
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998224; cv=none; b=QnsUw8QVTIa7M0FJ1Tl92VtLXW2abzytqyP1Xy52LZmL7xNsC/UWCjudK9oWJgFUEuHFf0Mm9fm0ewvcI+S+cSBeghCgj+R+xoZRJB8NQuNcR+E8smblakiJywQw6bjxj0NM0nMv32GCkFhzeccbQO75gieHuxhXTXiXSWOz/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998224; c=relaxed/simple;
	bh=4qSsBP7fgDDXcEWdwhbNA1YWEH4NieBisVyNtal5uuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WF0W0T8/69EXAX+/Cb4BibDbf7lOP/UwKbAZM6t8NB90Qv4mjkGEM7Po3i6bOxIivoqWJ7vlr5TAk1dUu9eLu//k7Q+EmYiKINq9TD+X/HG4Mx3pkKvxlAQSZXc+de0fosuwqXE2m46Z7U5wX26sH7QaUDxDFzjATmhqoisUi40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAtO0/LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1CFC4CED1;
	Thu, 16 Jan 2025 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736998224;
	bh=4qSsBP7fgDDXcEWdwhbNA1YWEH4NieBisVyNtal5uuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IAtO0/LQ14TifS37VQ1skK49Wm4djzohulbDbE6TfaNwV2s45mR0pMK4fZ+QdjnJB
	 rLKxF5XqUeAfzJg71tEVpbtDe6dWk2rsPN359wwtqGaVIuVdJ52iDgy0xKQ41oBd3J
	 qeVdxg3p1fXuopczTLSx25A12Opik1Ur5dpnOYrzhmEa4bD9dtqUuMymB97tVXLNam
	 rL4KB/BrYRZ3eDUVMT5pkCvpc305howT6fvaqPI0RZx3ysXvbjrViRYPPSsjGCc/P/
	 vYQ27GCuN6Px4I3jMpe/JdHB8dWSc4+VKwRouTx6mngh7kfVjpL1FASO5vJvRslxxv
	 P0lLCr5Bv+H/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFC380AA5F;
	Thu, 16 Jan 2025 03:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net/mlx5e: CT: Add support for hardware steering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173699824754.995574.3826835038661589089.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 03:30:47 +0000
References: <20250114130646.1937192-1-tariqt@nvidia.com>
In-Reply-To: <20250114130646.1937192-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, kliteyn@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 15:06:42 +0200 you wrote:
> This series start with one more HWS patch by Yevgeny, followed by
> patches that add support for connection tracking in hardware steering
> mode. It consists of:
> - patch #2 hooks up the CT ops for the new mode in the right places.
> - patch #3 moves a function into a common file, so it can be reused.
> - patch #4 uses the HWS API to implement connection tracking.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5: HWS, rework the check if matcher size can be increased
    https://git.kernel.org/netdev/net-next/c/af02dbfe3740
  - [net-next,2/4] net/mlx5e: CT: Add initial support for Hardware Steering
    https://git.kernel.org/netdev/net-next/c/34eea5b12a10
  - [net-next,3/4] net/mlx5e: CT: Make mlx5_ct_fs_smfs_ct_validate_flow_rule reusable
    https://git.kernel.org/netdev/net-next/c/554f9773fdee
  - [net-next,4/4] net/mlx5e: CT: Offload connections with hardware steering rules
    https://git.kernel.org/netdev/net-next/c/066d49c199a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



