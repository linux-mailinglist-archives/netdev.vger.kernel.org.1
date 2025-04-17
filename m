Return-Path: <netdev+bounces-183587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB2A91152
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716E2179F56
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248ED1DE883;
	Thu, 17 Apr 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3VTKc+3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC01DE4F6
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854028; cv=none; b=HrKtb5Yfj5Cc+DkEvrWlCVlu5eECWVwtNF/z2/bozPd7Hr6D+HK35iJ9QIk9Rlod6/cALXcdRUyr3Z9p39lJY0nr2a1pPQvA2Kc83U6f/R2jIzSXXoOEiIPBp3W4XuDGTLdC0khJTOn7C5szzR8RmSzvZ7g+BMcmxLU5aBSXRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854028; c=relaxed/simple;
	bh=nKwR+3jYPBI/0L4UPSEMt8dNksHHNBW6YTloUwWu/5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NqSXO0rMDIdbvWLvdin7ck3e5N5ReqbGiSo/nl3VCGuabNbnUROg1DTzPcncJ2o6+1/Pz7Ble3P/tOGHYW0X4kdCN+dVfrqJWFxCkMB+af/L8EGWqvRK/2m1oJSE+nQbc/pIekivSi9tBR1FfWyWb0sY9f+UKi/6jVfNcDrCftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3VTKc+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738D0C4CEEA;
	Thu, 17 Apr 2025 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854027;
	bh=nKwR+3jYPBI/0L4UPSEMt8dNksHHNBW6YTloUwWu/5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3VTKc+3MIMpjnSv3Gt3L8oNdhinKffD6WdAgSSrzV9SR/eE/rpF/GK2KIwQp6x/U
	 qHgteXKk8sn4S1259HB/hczQhVWQCLXn2BPOZ/r+opmoUhsfe4rBe792XIX+J7Q2S/
	 cuhUptnMpc65Rb46G68QT6nZ5ZBbUs/k2nybjHt6QuwP/s7FHFpy3chrxxuIMIP6GI
	 fOyKy9janZgxQXiNiz7l1yIz+ly2PBm9Mm2Xz9fxsATmhzkb0MYzSCYL/rSCEki1gL
	 Rd1T411D1kGwTmuuHNRiaVSadN/OT4B0IE7zs+W3elqCHb9ac88Sqn4ANhjJHAPhd4
	 81ucT5tGe1MgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3EA3822D5A;
	Thu, 17 Apr 2025 01:41:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: intel: remove unnecessary setting
 max_speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485406520.3559972.9842565280064480120.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:41:05 +0000
References: <E1u4dIh-000dT5-Kt@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4dIh-000dT5-Kt@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 11:13:55 +0100 you wrote:
> Phylink will already limit the MAC speed according to the interface,
> so if 2500BASE-X is selected, the maximum speed will be 2.5G.
> Similarly, if SGMII is selected, the maximum speed will be 1G.
> It is, therefore, not necessary to set a speed limit. Remove setting
> plat_dat->max_speed from this glue driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: intel: remove unnecessary setting max_speed
    https://git.kernel.org/netdev/net-next/c/978d13b26ab3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



