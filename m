Return-Path: <netdev+bounces-55275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5980A159
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FF71C20AA2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41D1945C;
	Fri,  8 Dec 2023 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osvEBESB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AA1094B
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A4E7C433C9;
	Fri,  8 Dec 2023 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702032028;
	bh=tRilUraTLtFgqJBj9ZMf8r4Kd8AWtVC3k3YYDwqE63w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osvEBESBmTEBLj8+Q5+lHuvhYKsLdZyCNVMFNmRqj0vRUAdXxFZVW30LJO5VPDzPW
	 OC37KbVz3XGdkp3JaeBX0+zOxWXjMP4QhAtHJT1ukS1drWDvaHc1fNZ4UcSczrGwiM
	 +YWwyZuJxBsF5hwXbgV3aCvRzOqaAT+Sh48JaDhrK6WY7A4kcLb69nHtgpy4NgFaxt
	 okJMoS1y1jdctq/3x4ipoxD653Q0sSEATz616CWuZzACYy0PScZ3DxIkXhO/3qRPxB
	 SaPFz/5bGzQx6ri9rozduZPzI1X+uVCp5d2ScMcWINxCHMmnBbGUt6thiFN2M9FthB
	 FeHbO0rbRMzVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0283DC04E32;
	Fri,  8 Dec 2023 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net V3 01/15] net/mlx5e: Honor user choice of IPsec replay window
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170203202800.16211.5959491781450485697.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 10:40:28 +0000
References: <20231205214534.77771-2-saeed@kernel.org>
In-Reply-To: <20231205214534.77771-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, leonro@nvidia.com, phaddad@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Tue,  5 Dec 2023 13:45:20 -0800 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Users can configure IPsec replay window size, but mlx5 driver didn't
> honor their choice and set always 32bits. Fix assignment logic to
> configure right size from the beginning.
> 
> Fixes: 7db21ef4566e ("net/mlx5e: Set IPsec replay sequence numbers")
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,V3,01/15] net/mlx5e: Honor user choice of IPsec replay window size
    https://git.kernel.org/netdev/net/c/a5e400a985df
  - [net,V3,02/15] net/mlx5e: Ensure that IPsec sequence packet number starts from 1
    https://git.kernel.org/netdev/net/c/3d42c8cc67a8
  - [net,V3,03/15] net/mlx5e: Unify esw and normal IPsec status table creation/destruction
    https://git.kernel.org/netdev/net/c/94af50c0a9bb
  - [net,V3,04/15] net/mlx5e: Remove exposure of IPsec RX flow steering struct
    https://git.kernel.org/netdev/net/c/5ad00dee43b9
  - [net,V3,05/15] net/mlx5e: Add IPsec and ASO syndromes check in HW
    https://git.kernel.org/netdev/net/c/dddb49b63d86
  - [net,V3,06/15] net/mlx5e: Tidy up IPsec NAT-T SA discovery
    https://git.kernel.org/netdev/net/c/c2bf84f1d1a1
  - [net,V3,07/15] net/mlx5e: Reduce eswitch mode_lock protection context
    https://git.kernel.org/netdev/net/c/baac8351f74c
  - [net,V3,08/15] net/mlx5e: Disable IPsec offload support if not FW steering
    https://git.kernel.org/netdev/net/c/762a55a54eec
  - [net,V3,09/15] net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
    https://git.kernel.org/netdev/net/c/eab0da38912e
  - [net,V3,10/15] net/mlx5e: TC, Don't offload post action rule if not supported
    https://git.kernel.org/netdev/net/c/ccbe33003b10
  - [net,V3,11/15] net/mlx5: Nack sync reset request when HotPlug is enabled
    https://git.kernel.org/netdev/net/c/3d7a3f2612d7
  - [net,V3,12/15] net/mlx5e: Check netdev pointer before checking its net ns
    https://git.kernel.org/netdev/net/c/7aaf975238c4
  - [net,V3,13/15] net/mlx5: Fix a NULL vs IS_ERR() check
    https://git.kernel.org/netdev/net/c/ca4ef28d0ad8
  - [net,V3,14/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer
    (no matching commit)
  - [net,V3,15/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



