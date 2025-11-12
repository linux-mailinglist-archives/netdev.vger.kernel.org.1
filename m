Return-Path: <netdev+bounces-238070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927CC53A98
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7565D346E91
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D2345732;
	Wed, 12 Nov 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5fDthr4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7A3451DB
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968040; cv=none; b=kjDP5HZ76XHCwkzj2TabSt5qBTGE98pxQJ/t1WpitMq2HEJMiAlU1FaamgYQMSQ3CXmRuHB1GXhnBmknDvTG29QTvAmGvu/RlIDe/TU64VfBAUCnHjC7KqaPmEZWeQrfhPrTjFVy6XAEdPlYHgL3gtk7cOzYf3eJsnwtp71x8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968040; c=relaxed/simple;
	bh=4SXvqIUmralZtLxvLSfsaFD6hCMsoBtvKsE9dz+t0iQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sBzxxYpWZlXbTWSvGWHlrD4Jbf1pDyNLlFRTJVxUczMSv0PlCpbzvVIhR6OOqfjcHbnEYg4hTXcU2vbk4oxKXEUooEiZ598ZHV7L0EDGZkFH2Va+DdbAfquzi8t03oAFn1RERoHh5HL7Udt+E/wg9ADAXUgAJWZHp9jw0z2ZwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5fDthr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94686C19422;
	Wed, 12 Nov 2025 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968039;
	bh=4SXvqIUmralZtLxvLSfsaFD6hCMsoBtvKsE9dz+t0iQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5fDthr4D93MJprus9XGBNxhwvWbMF5ZmbrLKRtBIz7PjbdRnsnHHKVQvwUS6P2gh
	 CgAW3obRWsyB8px1i0FbxMnUPtXolt4dULoquCEIRiCstZ9a1Ldzsx8bzfG/OLHk6l
	 CnjEUZxrGr43u5pa2RWJ9ZImxI6hShIX8FXyJptCcnrn/DP104e4lIj9VKMCR7wKkn
	 orJ5NB67+m+RBtZooZmZXwCewNCXcjk1+Brep4FeWshlfdNTXP39G9QRU4iQa6fHDA
	 GEpnMPwEjz3m1K18WIaBAPU0syw/F9jvFrSJS1X3Ejsy4ZpsBZqNoXmtGhlxb7GNT7
	 6A9S9Nmr1evHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D3139EFA62;
	Wed, 12 Nov 2025 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: improve ndev->max_mtu setup
 readability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176296800900.91007.2385891703778454442.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 17:20:09 +0000
References: <E1vImWA-0000000DrIl-1HZY@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vImWA-0000000DrIl-1HZY@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 11:26:34 +0000 you wrote:
> Improve the readibility of the code setting ndev->max_mtu. This depends
> on the hardware specific maximum defined by the MAC core, and also a
> platform provided maximum.
> 
> The code was originally checking that the platform specific maximum was
> between ndev->min_mtu..MAC core maximum before reducing ndev->max_mtu,
> otherwise if the platform specific maximum was less than ndev->min_mtu,
> issuing a warning.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: improve ndev->max_mtu setup readability
    https://git.kernel.org/netdev/net-next/c/7e975caa0f7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



