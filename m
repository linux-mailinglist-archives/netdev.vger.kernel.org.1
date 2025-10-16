Return-Path: <netdev+bounces-229836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B171BE123C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2544EE120
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C21E7C2D;
	Thu, 16 Oct 2025 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDrtSySY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8E1DC985;
	Thu, 16 Oct 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575836; cv=none; b=GWskPNLVVhs3QNpm9v8Vaih3M2WOMZX2yj/F9fbtUYQIpFcq6s96mQTZoanyfaATSobU6ZPhXevL6dbadjc96jJoSTWRM13depClW8laR3ToFAPHrG5AND67ovFfzYskXgnme8snMkSNEM/KolNbiJ8Ot0d2kb+SnYr/SQXPRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575836; c=relaxed/simple;
	bh=iDk/AMq0vqC5Rs9PVQRCDYESUPU5gixiKQbMvjrQ7IM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ndhEOZLKmVN44m6P/lEk5k6NrAABPmnLaFn+En98wAEMHi7Ggb4PNVBM40mfMXaZYs9RKCjzl3Lj0AQ5PnNgSLDh4VesMM+DfrTYs8JMgiqrQb/Uz89WxwIkLMaHEmgJqYAbSorsAE+Dz+Q922vuuPPzkdBPi7SkrEkdB8eF/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDrtSySY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D026C4CEF8;
	Thu, 16 Oct 2025 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760575835;
	bh=iDk/AMq0vqC5Rs9PVQRCDYESUPU5gixiKQbMvjrQ7IM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fDrtSySYQAjolGeWuEnXQRQtKZEBAmpB/hc/k6gmWBtF48Vypc5fif8UT94RByCU1
	 j7OL/A6mdmNFfvKHxKkzqAcqtAwEG7CMABlWbyuTxIPX4gGBhqKgee8wt/joLfynnO
	 947sJCpDa3wfF8gSfRaRoWcGQCucYn3WQw3dMlXUoucqPkz8dDC1ZoCJeDNGLDioLd
	 JHyTob85Xg7rYHd0kGXk1DbAnsf7DWPrV8MLU8ZGBRKA11C+QczGfE9CPOI/9T28Na
	 fM++gVqIlcLY/ZCoySRpYW/f88YQDNWSs00AEqxxRiJVMgWPg/xeOxehLQZ0g98d2S
	 2RU+Z8VmrIz8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BEE380DBE9;
	Thu, 16 Oct 2025 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmasp: Add support for PHY-based
 Wake-on-LAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057581999.1114538.4002460705327771946.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 00:50:19 +0000
References: <20251013172306.2250223-1-florian.fainelli@broadcom.com>
In-Reply-To: <20251013172306.2250223-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 10:23:06 -0700 you wrote:
> If available, interrogate the PHY to find out whether we can use it for
> Wake-on-LAN. This can be a more power efficient way of implementing that
> feature, especially when the MAC is powered off in low power states.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: bcmasp: Add support for PHY-based Wake-on-LAN
    https://git.kernel.org/netdev/net-next/c/e1f5bb196f0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



