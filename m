Return-Path: <netdev+bounces-198836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C78ADDFAA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA15175E93
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2F1136A;
	Tue, 17 Jun 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwGoNx2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3828C851
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203024; cv=none; b=DZZv5zscCTMTh82KfrquCHAlH7b6Qclbjyf5k3NaXDNR6yk6W0lTnI2iLJYaCNaPN9ZivSlAtVmE49aeEpUXd8k3gSWXQuunSn+IBATy63QsvoqZW+nAA8PJlxfowD0yWJK5TYtBAcdyfYbEhurFvHJPa8dz5xUYBVSY1vEGBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203024; c=relaxed/simple;
	bh=tcMHWk4FkgjU/bW20uI6112m4lCsw+x2BSh1ZhtUv2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dwBEsogSeSv4u5mLGp0rk/5+OKX7PjH/Cc7a1RD4I28IMC1JQZiTkNeRlpYLzjS9ZVQbjPfLvS4B4rhD6nDje9u24fYSlRRYB6rkljC/vVUShbxBNzMgOTk7T8V3a7OBkUE0gy/rV8Dvq04GW0mytOqwzji76AFuNX8WC7RbCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwGoNx2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF843C4CEE3;
	Tue, 17 Jun 2025 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203024;
	bh=tcMHWk4FkgjU/bW20uI6112m4lCsw+x2BSh1ZhtUv2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lwGoNx2HcdoFIqXfNx2lyArccnRGQvr9Cbvt01sXr/oLXvauWbaCk71QzAFv9YQMz
	 fbtEU3kqLl3nno0scsgd/MYZ+kqIEJei7DwVEl3y2jj2BCF+elOaPWF9OVtY2bWbdF
	 eYHJu1VFJ3Z3EivQdMmBS9b0K9Ky+1yvhx6llYBuY009Jwhh/cDwkaDz8qOmDdEGJk
	 LKsfeABU/tnIP0x0k2eNWjZQnPNYTgdh8y6RYevgF8MWavZrcAFy6utYFb90s1EJ/o
	 NPW0I3dBICjMhLJZm9C1/CevHnSth/DGZuFbwl3oj/7G7SUFJRdZWUnScmMdda7RX0
	 4FFDgoecp44/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2E38111DD;
	Tue, 17 Jun 2025 23:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] nte: stmmac: visconti: cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020305298.3735715.14567227448478806213.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:30:52 +0000
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
In-Reply-To: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 22:05:41 +0100 you wrote:
> Hi,
> 
> A short series of cleanups to the visconti dwmac glue.
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   | 129 ++++++++++++---------
>  1 file changed, 74 insertions(+), 55 deletions(-)

Here is the summary with links:
  - [net-next,1/4] net: stmmac: visconti: re-arrange speed decode
    https://git.kernel.org/netdev/net-next/c/7d7525876b5a
  - [net-next,2/4] net: stmmac: visconti: reorganise visconti_eth_set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/1923c6c3a8b7
  - [net-next,3/4] net: stmmac: visconti: clean up code formatting
    https://git.kernel.org/netdev/net-next/c/1a3a638d2d23
  - [net-next,4/4] net: stmmac: visconti: make phy_intf_sel local
    https://git.kernel.org/netdev/net-next/c/d54d42a41b65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



