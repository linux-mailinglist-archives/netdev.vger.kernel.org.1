Return-Path: <netdev+bounces-225736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07273B97D7B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C211AE2AA0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF542AA3;
	Wed, 24 Sep 2025 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0PtTb9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B402D052
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672033; cv=none; b=Gynq9xtAxoO7AVew1MlYhj23UbXRN/vZWpvqXJcmu9TDmUE/mtqFvZ3TVNl6VqDFMQ3ru+NbAzJ+zwdSSWkaH+4rlI3VdPt0D1GpTPDZ0tTZhqMSh4JFGgN57s+v0QEoORDII8hFmfhwBlMTx63Nnb+dFAgDBK/v+VpE19Lr0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672033; c=relaxed/simple;
	bh=NznbfBwSEHUtfjH1Y5BSrMbD2iq9ZC6tv3sR/mHhsK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRR1rT5ryfrWjTBRqIT5yfu+ZtVLUploQb3Q9jS5HrSCOp4+rzG0wuQP9BbwQ9gl3KWMrhkc9LDX8r/H8iSdgCHR2UtVSobnAP+D8+cmj0Xr8mDRYrIECHAYt+2Gpd+hG5BzjWyWcpL8lTNa3vFVyQg9tr9gHDFsx2ervapWaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0PtTb9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831D5C116B1;
	Wed, 24 Sep 2025 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672032;
	bh=NznbfBwSEHUtfjH1Y5BSrMbD2iq9ZC6tv3sR/mHhsK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M0PtTb9oCr8FYtwrjHs1BBefdRerVCoqwS9WfcMan0FNEfRfEz/lXO1cxPyuHINvA
	 rGLUqhvyOnwOLoROWJbMDgBZpkxQ1083FP/9VqU7oe7xjiyN9f9QXxbmB2+PMVNC8x
	 O89siLS9RBHE/r+/EN6S2Gvtm2SzTSgds94Dj+a4uBlw2jJ1uIa4Zlbrde28bGcv/G
	 y77i4eNJZUl3cmU+OO95iGFy1q9l+62oJKC4xeo+1alajlFEBHflrOWPlk8bXXa99Q
	 snxOkFXoc79A/A/FooevjGc0lbJ93++KlZjWe7wnzYULDWumFIKQHWzGcf1NDplSFC
	 wPhbKjNGra1zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFA939D0C20;
	Wed, 24 Sep 2025 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: move config symbol MDIO_BUS to
 drivers/net/phy/Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867202924.1967235.15183163004284003488.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:00:29 +0000
References: <164ff1c6-2cf9-4e30-80fb-da4cc7165dc8@gmail.com>
In-Reply-To: <164ff1c6-2cf9-4e30-80fb-da4cc7165dc8@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Sep 2025 23:11:54 +0200 you wrote:
> Config symbol MDIO_BUS isn't used in drivers/net/mdio. It's only used
> in drivers/net/phy. So move it there.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/mdio/Kconfig | 5 -----
>  drivers/net/phy/Kconfig  | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: move config symbol MDIO_BUS to drivers/net/phy/Kconfig
    https://git.kernel.org/netdev/net-next/c/7e554f317be8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



