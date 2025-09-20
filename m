Return-Path: <netdev+bounces-224945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D952B8BAFB
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33869586CFC
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC41EC018;
	Sat, 20 Sep 2025 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd6Ouboi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71751E9B22
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327628; cv=none; b=GvhDP9eqTbzh1Ci05aHPf4J7fm4bHqkLUR8bUCKNYJwac9rPL+uBi3MgOdr5whjbHN6bDj0GAEHMm7/Ks/enSn2l0kSCATLQ6zWNIFe+y+d3PSY4gRfBdy/MbRJOsgFvoXOLnEnK6qQ77CjIMa0urQHaIJDSoqDT5oltKD1aaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327628; c=relaxed/simple;
	bh=2Ax1bMftL57IEBLUZKn9k8R83oUDIeupmpM1qq2S5Lw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRyct7DP9l9k8G4QG3HOwU/xNY/wve6HRuLO6iEueFKt10vmYiVqKZhMCtu0rpqB/tCblD86LkiKVIPG0Eau9Sgapa6d7/tFojApuLRgHRbCNiOAela31GDz+4zkT92+QJQ03SR4z5AIHIIfPU4s8eT8TNPyxWW3s31TNhR0Q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd6Ouboi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB5EC4CEF5;
	Sat, 20 Sep 2025 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327627;
	bh=2Ax1bMftL57IEBLUZKn9k8R83oUDIeupmpM1qq2S5Lw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yd6Ouboian4UGjM69Cb80+lzlzBz1JwClboFwXjs6LH205bkiUTz8Kd4hZUVbb5X7
	 Pbjc6Nd31ofKPvHZkLrAM1fxuVuAeCrHrSrFx+i7nqvj4EVZijwLpwyZNOsexdLner
	 r/fNswtgcdMTKCti7lpAx4rr2Okng7I/dR+bGvWewCxmLbY+Il5jCa5XTUM5UTcLgs
	 s4EUmTBTYNUUK8th+r59gLounBT/Y5Wu7sCctB8nTbWf8fQKzz10l9qdDXlKUkzjHj
	 Zp8JoTUVO/35z4DHYIYtbe0yTKuRWtZb/k8Hf+b1g2jcyi1mDs+dzm9IWrOdtY1NfZ
	 2c/FKI9PdtpMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7C39D0C20;
	Sat, 20 Sep 2025 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Remove dead code from total_vfs setter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762674.3747217.8693234545773035345.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:26 +0000
References: <a6142a60-1948-439a-b0ae-ff1df26a37f8@nvidia.com>
In-Reply-To: <a6142a60-1948-439a-b0ae-ff1df26a37f8@nvidia.com>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: saeed@kernel.org, kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dan.carpenter@linaro.org,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, jiri@nvidia.com,
 jacob.e.keller@intel.com, horms@kernel.org, kheib@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 15:05:07 -0700 you wrote:
> The mlx5_devlink_total_vfs_set function branches based on per_pf_support
> twice. Remove the second branch as the first one exits the function when
> per_pf_support is false.
> 
> Accidentally added as part of commit a4c49611cf4f ("net/mlx5: Implement
> devlink total_vfs parameter").
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Remove dead code from total_vfs setter
    https://git.kernel.org/netdev/net-next/c/6a46e4faa8fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



