Return-Path: <netdev+bounces-165330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F8A31A9A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAED1887916
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FAB665;
	Wed, 12 Feb 2025 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsQiWd0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6EAD23
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320805; cv=none; b=Dne4QR1U7FTUO7nGNKqxsRI/B0jujfbaEu14iR3Id1ELCJwHAPLrKUQK+xzhL/xEHs9xuVx+dwKjc2sRQnBU1Zr+0TJp5U7TRWvpWZHm6B88nW5EJgH6ygBvQxAWJDhOg6p/gQNQCdsqWSXfmra1hvxs2PUEvbw0kTcMnfxLhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320805; c=relaxed/simple;
	bh=rPr3DQ1mfHydvNOZCEKNX9Fg783TOGh8EGU0segtvaQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfleEQR+zWLVVc2lHz78bbuysHtAaX4bpS8L0PLBVr9+dL2ZKA/tAehLKsEmwUojm/mCelMS36pg9WpkxghWdXKTkN3Jf0Ikkd8bnxm6dyLIg4n6IKnm2fpAvjlP8Ns3mNgaJ+oVTYi35HA/N4RiwYiteqWGWt4YrvC0waDTfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsQiWd0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE3C4CEDD;
	Wed, 12 Feb 2025 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320805;
	bh=rPr3DQ1mfHydvNOZCEKNX9Fg783TOGh8EGU0segtvaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OsQiWd0kB3ydM/E25spdAMV2mkLESjgc/SOWzGHqcsjxfC/94GSKTD/73RZYNQZgU
	 chxK2Fp463qFkQue3u4RniiqYk3MTavaXsGmxVTLvc99MzAi6MePyqicDyyMGMl5bo
	 3HtThid5MXaJ31fpsVkJoArDn0b3kUUY3PBbZjBjcWx3ucvbiGQgeUD2lc0EXSEnyr
	 7CXNE+rLZqj4fv/hv00IFFDCQPMy9DkmwUyiL4Sfu0PcrSv5oewUCxuFOpsCBUL0i4
	 EGZv4BkVwn9xJSgPyKhzYX5BPU034WSioZio+th6WmHIcFjDfKdJnzZTUqW70xvrg6
	 Jl8Ux2QUKcaNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36EA3380AA7A;
	Wed, 12 Feb 2025 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: make configuring clock-stop dependent on
 MAC support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932083401.51333.9009584154393432273.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:40:34 +0000
References: <E1tgjNn-003q0w-Pw@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tgjNn-003q0w-Pw@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 08 Feb 2025 11:52:23 +0000 you wrote:
> We should not be configuring the PHYs clock-stop settings unless the
> MAC supports phylink managed EEE. Make this dependent on MAC support.
> 
> This was noticed in a suspicious RCU usage report from the kernel
> test robot (the suspicious RCU usage due to calling phy_detach()
> remains unaddressed, but is triggered by the error this was
> generating.)
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: make configuring clock-stop dependent on MAC support
    https://git.kernel.org/netdev/net/c/1942b1c6f687

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



