Return-Path: <netdev+bounces-36830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A674B7B1EF7
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 598DD28118B
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28923B7BC;
	Thu, 28 Sep 2023 13:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37003AC3D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31ADBC433C7;
	Thu, 28 Sep 2023 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695909026;
	bh=Mk5VJpCLhizvHMR7qQ+55ID3ZfkiRBaA1JzYcVPLxqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PieMZH2ohuiKLlRTqTMsE/yX0rPJFxExRLxCWS+DAR6xpUM4VoMT1v3NxQR8fx2Ls
	 elS+nCpE3hiGN5NmwI3oVASELbDGG7CmLcRgR+rXo0ptA8G4FOeb5eI+Kk51ZN6keD
	 0SnUDV+P61RHbC8/wADdigtVzgqCVnC3f3jbT5DkIRI4CNSwMfIM+WbOStane63gs0
	 EJqzBa1buy0W6NCbNdqrnQ1BTf2paPCWAn7SUAL61LMDUvqQgsFiEHvk9QhkojNF5K
	 q616VZCVulObzKdKZ+zQ+DE1elQDakN1ZnEBLv2Yoa8Ce4NtxhyBJgFqMt3/6nLIsT
	 9QGTNIkMBxAKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12E2FC43170;
	Thu, 28 Sep 2023 13:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 01/15] net/mlx5: Call mlx5_sf_id_erase() once in
 mlx5_sf_dealloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169590902607.28614.2700544642191541684.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 13:50:26 +0000
References: <20230920063552.296978-2-saeed@kernel.org>
In-Reply-To: <20230920063552.296978-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, jiri@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Tue, 19 Sep 2023 23:35:38 -0700 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Before every call of mlx5_sf_dealloc(), there is a call to
> mlx5_sf_id_erase(). So move it to the beginning of mlx5_sf_dealloc().
> Also remove redundant mlx5_sf_id_erase() call from mlx5_sf_free()
> as it is called only from mlx5_sf_dealloc().
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()
    https://git.kernel.org/netdev/net-next/c/2597ee190b4e
  - [net-next,02/15] net/mlx5: Use devlink port pointer to get the pointer of container SF struct
    https://git.kernel.org/netdev/net-next/c/9caeb1475c3e
  - [net-next,03/15] net/mlx5: Convert SF port_indices xarray to function_ids xarray
    https://git.kernel.org/netdev/net-next/c/2284a4836251
  - [net-next,04/15] net/mlx5: Move state lock taking into mlx5_sf_dealloc()
    https://git.kernel.org/netdev/net-next/c/9497036dfbb8
  - [net-next,05/15] net/mlx5: Rename mlx5_sf_deactivate_all() to mlx5_sf_del_all()
    https://git.kernel.org/netdev/net-next/c/a65362f2be8d
  - [net-next,06/15] net/mlx5: Push common deletion code into mlx5_sf_del()
    https://git.kernel.org/netdev/net-next/c/a3cc822beacc
  - [net-next,07/15] net/mlx5: Remove SF table reference counting
    https://git.kernel.org/netdev/net-next/c/2fe6545ef541
  - [net-next,08/15] net/mlx5: Remove redundant max_sfs check and field from struct mlx5_sf_dev_table
    https://git.kernel.org/netdev/net-next/c/7c35cd836f21
  - [net-next,09/15] net/mlx5e: Consider aggregated port speed during rate configuration
    https://git.kernel.org/netdev/net-next/c/8d88e198dcaf
  - [net-next,10/15] net/mlx5e: Check police action rate for matchall filter
    https://git.kernel.org/netdev/net-next/c/4291ab7112ea
  - [net-next,11/15] net/mlx5: Bridge, Enable mcast in smfs steering mode
    https://git.kernel.org/netdev/net-next/c/653b7eb9d744
  - [net-next,12/15] net/mlx5: DR, Add check for multi destination FTE
    https://git.kernel.org/netdev/net-next/c/f6f46e7173cb
  - [net-next,13/15] net/mlx5: DR, Handle multi destination action in the right order
    https://git.kernel.org/netdev/net-next/c/3b81bcbaee28
  - [net-next,14/15] net/mlx5: Add a health error syndrome for pci data poisoned
    https://git.kernel.org/netdev/net-next/c/e0cc92fd945a
  - [net-next,15/15] net/mlx5: Enable 4 ports multiport E-switch
    https://git.kernel.org/netdev/net-next/c/e738e3550452

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



