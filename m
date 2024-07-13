Return-Path: <netdev+bounces-111299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA149307DB
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85642282B02
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81C145350;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ5eOX3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB313D62A
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911030; cv=none; b=jzj0g0JV/wVLR7IzHJFdOoYnboFGXe/3qfX37Q9Kt3b14qc+VACqoTODGngr+cEha7p2gTuamZiWAi8pMy+fG8swjEKGEJDvt0A0b2I5YF2J++1XsqreoS4uYywNunm7HLhYr1ZCQsrDNySavCCHy2io4EuMnOCYCOSZoviTNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911030; c=relaxed/simple;
	bh=ChRUtLIok09LtdYUYk8OOiDu3KVX5jJbQjgTszY2Xls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R0UJhJ5b3hkfDERwYOTaLFM5rkNuHnCoSwTii5keYz1uCCt/Mw+QUb4sYjyI05QIufBb067ji6w0ulcco5Y2qi+g/EX+WyZNfEd2s7/feOlwYGcWA5hHqQb9PTPlCg59oDLiK0M4ZxTohAHh4QARk5bUn3AfIJRLQ6Bf6qXFkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ5eOX3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7432C4AF0B;
	Sat, 13 Jul 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911030;
	bh=ChRUtLIok09LtdYUYk8OOiDu3KVX5jJbQjgTszY2Xls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQ5eOX3pw3a+EPJ2+qqWc6O1UYLLkl7GUxmaPppHNKfcjmXalKk51R6cKn6Gf33nU
	 EgHISm37U6D9JvSTPSnP3x8VxVSYwr2GjpzLsRxgow7SFcLgEnGU3YVoxPnUIkscmx
	 mYCT8zuGfyVwWMCENBjAJWpR0vWas/oynTbOpj0A5QvkgLzyPnu1uQ71VxVZkEygem
	 fqG8wVkbLSR1Z4Qp7Frm7DUiWAunP/UVtfKB0cvjkffYmvcqa3dCdXGil6JxG2Ev/R
	 EPcSoBQSx/SN0MVE3VQz1NUJkvhuL1Q4Q11gWiCSpu2X9cOKb+Hqw1wUoe/eJzjSaf
	 TLQM4UraKPaDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4EA4C43168;
	Sat, 13 Jul 2024 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/4] mlx5 misc 2023-07-08 (sf max eq)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091102986.32137.16261440749275842859.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:50:29 +0000
References: <20240712003310.355106-1-saeed@kernel.org>
In-Reply-To: <20240712003310.355106-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 17:33:06 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Hi,
> 
> This V3 includes only 4 patches out of the original 10 in V2,
> since Jakub asked to split the series and fix the commit message
> of the first patch.
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/4] net/mlx5: IFC updates for SF max IO EQs
    https://git.kernel.org/netdev/net-next/c/63c6e08eac8e
  - [net-next,V3,2/4] net/mlx5: Set sf_eq_usage for SF max EQs
    https://git.kernel.org/netdev/net-next/c/2ece6c72ea04
  - [net-next,V3,3/4] net/mlx5: Set default max eqs for SFs
    https://git.kernel.org/netdev/net-next/c/20d80b95a7e4
  - [net-next,V3,4/4] net/mlx5: Use set number of max EQs
    https://git.kernel.org/netdev/net-next/c/4b66be76a6fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



