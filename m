Return-Path: <netdev+bounces-238828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84045C5FE1C
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A34E8CE3
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40C222566;
	Sat, 15 Nov 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC5NVNwl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B71F9F7A;
	Sat, 15 Nov 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173253; cv=none; b=LjCl/m+1EFK7Anodk0fhO40HFq5QbKJ1HjpCiehEA8IQaLDxj9NQaOQARlUNTh/iqPNcjXB75jcfEZuYcXkpEdc5qtQWomNyR6/FeRx6yCAyYfRx5xEjth+nkTbvfFijyVQKoY0fbbuCWtNBmfjbAMRrxkTrmd+lZ6sk8uq2rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173253; c=relaxed/simple;
	bh=w4j63Ym/myItZNCpWRWMj4l0tKBdcjV/Llj1mmv+bMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GxqCmhJjoWLZ2XwcpmnQ20swD1rhtDqfDF+/YlARGIygb4OwuYpsV9Gx5lKZMw3E8jvWoEL4XMkMKpiHLLzCzBLSx0nD4LXYcyp0htC+Eb3d0Ij0Ms7O3hN4ey6ul7EHKX9z3rSJskQtds5gakYwK61MQT+WjZjl3ivZsy4cwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC5NVNwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42722C2BC86;
	Sat, 15 Nov 2025 02:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173253;
	bh=w4j63Ym/myItZNCpWRWMj4l0tKBdcjV/Llj1mmv+bMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BC5NVNwlbRBPN6E+rdWUY+h86H1b8t41/E5Jcx+rafPcT2GPviZ4yQY3iNcnG82yL
	 xPjub6a+HGmbbYLl+RxtnkOWf9rt5XO6jQ+8SeOj+YcQ+49P1222tbGfw9nXgqLUbM
	 DXDEPw+4+V2G/sQbT8ACIqwHyoZgdqxSLWxtooLVh+KVob6GhHY59KEHL665tJZOij
	 doiuoNfWIKkIxJmwE0/B+AnG4Y+W7jyzDfL3PcssliOFEvHS7yiElq5mXhD/vlHgLj
	 +KNhH327Tlb9hVIxj/98YZCudZd7dLnQv2Dpv9nxAX7W0A7xO9/7RVEhKcB+Ram5Hv
	 d/HpydZSQbogA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF93A78A62;
	Sat, 15 Nov 2025 02:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bnx2x: convert to use get_rx_ring_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317322150.1911668.18252463930509565101.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:21 +0000
References: <20251112-bnx_grxrings-v1-1-1c2cb73979e2@debian.org>
In-Reply-To: <20251112-bnx_grxrings-v1-1-1c2cb73979e2@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 01:50:23 -0800 you wrote:
> Convert the bnx2x driver to use the new .get_rx_ring_count ethtool
> operation instead of implementing .get_rxnfc solely for handling
> ETHTOOL_GRXRINGS command. This simplifies the code by replacing the
> switch statement with a direct return of the queue count.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bnx2x: convert to use get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/04ca7a69a35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



