Return-Path: <netdev+bounces-239308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6520C66C5D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E820F4E9437
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA92FDC35;
	Tue, 18 Nov 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvl2Ukq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26502FD67C;
	Tue, 18 Nov 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427648; cv=none; b=jjwPN4iJYFzJS+c3coiGBR5PWKnn3qkPNt2NMYEsoquPdDs8SGUpzhKTpK+CuRxlhcFgHPXSDl6x9vwxJZHIUuXWOz5LBtQKBvOjHICRqi4U2k6PAvKmWCdyRTz/mCcM4Bqr65VvGz1YAoBuLNVN+B7vpsubo9EmWFgN3KrynJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427648; c=relaxed/simple;
	bh=Y+ss9/v3fhfi7iOJtQ3BHjk2Cuo3Dg3jbtkAASl3fnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cUOgEV1k3as9Lil+HcFcLsTEw6JY2RT972BVY+5RhoCkO3rg7tsPIhRLUkBUzAaJDBoJhKzZv/ajlfW3+BxH1d/uEwgl3h0wx0zvn1t0NHbykiaWM2xv1oOSGE1cd7ImfUZXYHzqwO1P0iMej3ZjNPOKMivHy9ijs9Il0iKTxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvl2Ukq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B7DC2BCB3;
	Tue, 18 Nov 2025 01:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763427648;
	bh=Y+ss9/v3fhfi7iOJtQ3BHjk2Cuo3Dg3jbtkAASl3fnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rvl2Ukq0pcDzAnvVOGRYuO/ntDmToXhd35xjQHDBMO7T3NANaU5IR9Smy+DcrJ1WT
	 ypbWDBH6mzhjK9sTS242PuOQKh2zxr73oJN29/xtdVOa2uANIa53iLcGWVxDOCwtyh
	 L+qB5eTr0TsxcsqAP9m/BryKewP77dXXwVx03+4e3TpMDi+q3SJnLZW5iJG1Zp6Ilw
	 5/kN9vLFxLNnhq2VM/3bUUpJJiBj79JuaRz3eozjxERg7MqpAA2zZNwuv5+QwWZ3yK
	 Rw8+sNo2XE1pErQtoDsssmHZTuuB16+d4a9DkCD8BcMT6wI5VHcaVv0VAJadtU7nkK
	 0du8GY0koyY0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE11A3809A18;
	Tue, 18 Nov 2025 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2] eth: fbnic: Configure RDE settings for pause
 frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176342761424.3532963.7569003490275374200.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 01:00:14 +0000
References: <20251113232610.1151712-1-mohsin.bashr@gmail.com>
In-Reply-To: <20251113232610.1151712-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, almasrymina@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 15:26:10 -0800 you wrote:
> fbnic supports pause frames. When pause frames are enabled presumably
> user expects lossless operation from the NIC. Make sure we configure
> RDE (Rx DMA Engine) to DROP_NEVER mode to avoid discards due to delays
> in fetching Rx descriptors from the host.
> 
> While at it enable DROP_NEVER when NIC only has a single queue
> configured. In this case the NIC acts as a FIFO so there's no risk
> of head-of-line blocking other queues by making RDE wait. If pause
> is disabled this just moves the packet loss from the DMA engine to
> the Rx buffer.
> 
> [...]

Here is the summary with links:
  - [net-next,V2] eth: fbnic: Configure RDE settings for pause frame
    https://git.kernel.org/netdev/net-next/c/0135333914d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



