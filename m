Return-Path: <netdev+bounces-218036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E6B3AEB9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14301582DAA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C82D323E;
	Fri, 29 Aug 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpTKBkAs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA725BEF1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425610; cv=none; b=p0NxhcCpvLWkuQU8my+wfpJS+ATALNbrtwMn8ap46cAFUzK8WxUrOLO4rOrSVtlHR5HcCzdiHUtcAgUGbXiUiofMpBg7w/OVeB/B4ExtPtrMcMIFlBOUm8x47KAvwSvS6JVCibgfeM43klOBl5k0X9gy1ZWWtgAHhjkAnP+smXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425610; c=relaxed/simple;
	bh=eXmwX4jayiACfSLHfufiVC94bawx5G/rDLS5z9wmANo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=os9P/q968e2dKN6IvVbndapBSPheKznDVEPXpqWoIoV+zDZNZyl1BlkiLueZkXQN4iOMRrCfY0ftKhjb2APl2E78Zbg+o7XnoKLM3BXJIi88nLHpo8nLO4PBGw0vq49bEfpmOGQQWOFBZOCKI8dyRFdFLXctClY6vro+0E8g6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpTKBkAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F2C4CEEB;
	Fri, 29 Aug 2025 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425610;
	bh=eXmwX4jayiACfSLHfufiVC94bawx5G/rDLS5z9wmANo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UpTKBkAsJ1RjkU0hNstES+PeVMQNFQ1OKCpdQZS0gEocC8WEALm8NAjMKhFTLX72x
	 f3YSJ8b3zNKlctJ58c74KlseUcQxkZmb58idA7tXosfmHPYUVYgaBf9j6R2xCAiKPx
	 KAy2joAWkYGIJvZfR/e7ZMGKv0qDwGM7mJiIpUqUd7CdvWBpUE6VBCdLoSf65PK035
	 Kldp3zofAsjg1IcEM44UIRaUX3eDUWPUup6xw995drSYEkx+rSxWl87uIThNSMnPjp
	 w5RIPqCCjIouPqysUz8o3kPLMmRacwgSdOOZz064m1RLhlCe8TLcpF4a42yPoTRWVJ
	 RF0g2lhY07qZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1C383BF75;
	Fri, 29 Aug 2025 00:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: mlx5: remove Kconfig co-dependency with
 VXLAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642561700.1653564.13512562692041281053.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:00:17 +0000
References: <20250827234319.3504852-1-kuba@kernel.org>
In-Reply-To: <20250827234319.3504852-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 16:43:19 -0700 you wrote:
> mlx5 has a Kconfig co-dependency on VXLAN, even tho it doesn't
> call any VXLAN function (unlike mlxsw). Perhaps this dates back
> to very old days when tunnel ports were fetched directly from
> VXLAN.
> 
> Remove the dependency to allow MLX5=y + VXLAN=m kernel configs.
> But still avoid compiling in the lib/vxlan code if VXLAN=n.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: mlx5: remove Kconfig co-dependency with VXLAN
    https://git.kernel.org/netdev/net-next/c/15d157c3ad01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



