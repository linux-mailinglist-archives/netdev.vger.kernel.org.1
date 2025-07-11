Return-Path: <netdev+bounces-206289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E335B027DE
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C8E1C87D9E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46433225768;
	Fri, 11 Jul 2025 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7sRJCyp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22851225403
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277788; cv=none; b=p2tO5Gnpna+K1pZJugoMDxKsk0aGRI5+a50CnSKbzdF61bgw3aJvnnLCEzXHv/tYToHmy7o3xMzW42inGkQpgmeFWYQ+kn7UFfC2m8kZhC+oCDGcMU85PLbEdjC9R2NFM0BEcO+EwoMH8Ggaee6z2Dp9dP2IyA4aGHuhCTbC9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277788; c=relaxed/simple;
	bh=Cs2QHtZX7pbuJibPYV577reP7/7tl8nKCStc7ZgmTQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOm6czIhCG2KlWnq7AfGPyNzuvmPCvlZQEjCJ0b3zD1w25Y5EapAXioj9KW+/Wggxuo+Sk39vh8QszwtMfIV3ZVVPdQMbLEyNCfZ9OagzZfzCUGCca1ZYiv6kC9GK9WhSLj9uc55GETBtEcNQU1wK45jus0PoB7fAUYTEpnZ/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7sRJCyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C63C4CEED;
	Fri, 11 Jul 2025 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752277787;
	bh=Cs2QHtZX7pbuJibPYV577reP7/7tl8nKCStc7ZgmTQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r7sRJCypzIJdOc/A3nArjLDOtIzV6dHNsLaIy1uYmFj3HZgvBbBrCV4RLghgpUYoX
	 sEEdmnHjna6Yp/lxph2fmPhT8FKrYKrgjV0tVCAzIlUs6ysUSTdt8i1D9BBM3wG1dZ
	 1Oty7MurjBzPfDPzrDqCp5MEMYWBJrSWt4waSUWiSIzdX52Q2U2VRHla1YFRUNXiem
	 aOdTTLuETxgO9OkAfVGXnHECUdDTTWpVeNnlHCzGxmOvkeEiJ9azmj0t+hslUpU3kl
	 E6vNt+cbdmDEFmdkQ+JI2V6pdGeJtIc2WxbCtp5K3jhpksxmeGOn5P2sEZTGo6SRBj
	 5nLEF2TJzTEWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7A383B275;
	Fri, 11 Jul 2025 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: flip local/remote endpoints in
 iou-zcrx.py
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175227780944.2437895.17726322216596872901.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 23:50:09 +0000
References: <20250710165337.614159-1-vishs@meta.com>
In-Reply-To: <20250710165337.614159-1-vishs@meta.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, dw@davidwei.uk, jdamato@fastly.com,
 horms@kernel.org, netdev@vger.kernel.org, vishs@fb.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 09:53:37 -0700 you wrote:
> From: Vishwanath Seshagiri <vishs@fb.com>
> 
> The iou-zcrx selftest currently runs the server on the remote host
> and the client on the local host. This commit flips the endpoints
> such that server runs on localhost and client on remote.
> This change brings the iou-zcrx selftest in convention with other
> selftests.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: flip local/remote endpoints in iou-zcrx.py
    https://git.kernel.org/netdev/net-next/c/650fe2a9dd29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



