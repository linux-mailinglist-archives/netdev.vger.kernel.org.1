Return-Path: <netdev+bounces-232747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC1C0888D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468463BB1EA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24C23B632;
	Sat, 25 Oct 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0je+6y5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EE1AB6F1
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358256; cv=none; b=YqoWs9LGslvhCzSlG7Qga6sAPnmXBgWAssu/C6Vt/Et7xzHZ9MzTK1tK5Y1Hl2uZ7j/hsWfH6/wPLiGt8BsDs4FQRCe4JB5ZWXn1Juyx9vZpOaD6LvQHQTLwAzwpLCxIJ5PzTQ3jllelO8Yew3OXtUnOJEbvD3SK2CcCtBfjoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358256; c=relaxed/simple;
	bh=mCPoHtHlO0sapP4Re17dwckEUzpCJ4F8z89uuFCqu0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AFB2DhL9MrvAiS92lPeGKFnDJWwQbcajnNYIOSZMijndPHArmJ1u6PqveaEYRQ//mHXSQwMKrmR2GTIXQ+h+Pw5SnOe1+KxtdH3e82USKnIu0oPSR+HNZL0k8Tu55JplZEJuuoQN1S3DRKq1A8jv7o6vNc9+XMZaTNKywiIn1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0je+6y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B53EC4CEF1;
	Sat, 25 Oct 2025 02:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358256;
	bh=mCPoHtHlO0sapP4Re17dwckEUzpCJ4F8z89uuFCqu0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X0je+6y5nPpzgYupq5+dgtahZgIOJb4dskI1lP7bde+T/WckmlVpgTqkILW09L0Rq
	 7n9N/R1wa1FdVfWAZ/tIEwQTFSJQsqXZCod1rLnlkb1vMBhf1Wnl2hFrR9lHJJfZIc
	 CyqnNCtO4IWnqMRQ1hg2y+fCBHfLSW7RDdTlQOmKdQ/Kg0Gxr85zHETe1FntPypm6a
	 RwEWB5FB83QYKBdtuYVr7x3xqxinK3FU06vXvgdyVQa4mF9EwNh2ilcU5YcwFSoIsa
	 ThuNMXV8dH8jM6HJWodq3JKt9Onfj4HYw27Pr8T/CzLWcH9iVBg1rEY78pVHz4Q9lE
	 TCHbZegaMf1mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAB380AA59;
	Sat, 25 Oct 2025 02:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: pcs support part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135823625.4124588.6828085723534144457.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:10:36 +0000
References: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
In-Reply-To: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 10:46:09 +0100 you wrote:
> Hi,
> 
> This is the next part of stmmac PCS support. Not much here, other than
> dealing with what remains of the interrupts, which are the PCS AN
> complete and PCS Link interrupts, which are just cleared and update
> accounting.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: add stmmac_mac_irq_modify()
    https://git.kernel.org/netdev/net-next/c/442a8c68f083
  - [net-next,2/2] net: stmmac: add support for controlling PCS interrupts
    https://git.kernel.org/netdev/net-next/c/eed68edac508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



