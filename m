Return-Path: <netdev+bounces-235690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C459C33C09
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A389034D10C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A121CC58;
	Wed,  5 Nov 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQzylbpA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9F6A33B;
	Wed,  5 Nov 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309248; cv=none; b=OdehbwGsKP4hdL8pIv3kb+g7RCvGDnOO5AtxOLGrEC0wBIiYcBF3jypgeTknKgr/Pb++//R2kyP4HyA6afimUWfvx8g+Q6TkwCZpCfI6NtRf9CHya1PThQI7Go3iozry50AMww0AMRyscAB23g5Y6oPQmn9MsM9YnwYVu5X/8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309248; c=relaxed/simple;
	bh=vUUr2XFdky1DHdcm9CKQlk/4zsTC0gNhfTR8HeHE7ew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ssbEDp6hvU0GzCnutDhWHghozFpisQke8lZKOabcga4txDL6D3tGrObC+CdNUcAqaM7SUFZbV9bzlJzFl9caDIoE2pqIlNGgpXftLe+GylYBgwjfTm9Nl1iAgyEgcPFDZyBDM7ZAxCjF6HfToGXqI2d6Y12arXje2jdju0YoR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQzylbpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F8C16AAE;
	Wed,  5 Nov 2025 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309248;
	bh=vUUr2XFdky1DHdcm9CKQlk/4zsTC0gNhfTR8HeHE7ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UQzylbpAlyjLCt1dThSCM2CEBr11tawbPaU2AZlBxFeMhpavAS1JuOUfu/OwgRFty
	 dpJ4Zxn1Rp3HOjJAfamDv6zo5/QulMvRhxEeoxYU6KK8zK++Y7NI9S2QVGq0RZkV7h
	 XNjFUiNzHlLBrcLuV8zzc44I6Tp21i1c6pVb4bSowhEMb3Fti1rafZuLJLLUaBLD1E
	 CTEdZQTAdgCml0Fk/kr/Ey4C5Eohvj5XVVe+RK833JK9C5GwgfsZTNnG6UVln5QVOc
	 fVhDLnG4SRz2jQikWhEcUSe/o7AW4LPVZOCF8jiTRTkkr3cx2AmiTEsF+1lDdU/3ep
	 i1E1Nb/0MJDwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C71380AA57;
	Wed,  5 Nov 2025 02:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v17 0/5] Add driver for 1Gbe network chips from
 MUCSE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230922174.3062547.13202635035807581684.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 02:20:21 +0000
References: <20251101013849.120565-1-dong100@mucse.com>
In-Reply-To: <20251101013849.120565-1-dong100@mucse.com>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 danishanwar@ti.com, vadim.fedorenko@linux.dev, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Nov 2025 09:38:44 +0800 you wrote:
> Hi maintainers,
> 
> This patch series adds support for MUCSE RNPGBE 1Gbps PCIe Ethernet controllers
> (N500/N210 series), including build infrastructure, hardware initialization,
> mailbox (MBX) communication with firmware, and basic netdev registration
> (Can show mac witch is got from firmware, and tx/rx will be added later).
> 
> [...]

Here is the summary with links:
  - [net-next,v17,1/5] net: rnpgbe: Add build support for rnpgbe
    https://git.kernel.org/netdev/net-next/c/ee61c10cd482
  - [net-next,v17,2/5] net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
    https://git.kernel.org/netdev/net-next/c/1b7f85f733fd
  - [net-next,v17,3/5] net: rnpgbe: Add basic mbx ops support
    https://git.kernel.org/netdev/net-next/c/4543534c3ef5
  - [net-next,v17,4/5] net: rnpgbe: Add basic mbx_fw support
    https://git.kernel.org/netdev/net-next/c/c6d3f0198eaa
  - [net-next,v17,5/5] net: rnpgbe: Add register_netdev
    https://git.kernel.org/netdev/net-next/c/2ee95ec17e97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



