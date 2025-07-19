Return-Path: <netdev+bounces-208291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D02B0AD15
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BEF7AC450
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1E1422DD;
	Sat, 19 Jul 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC94RXIE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A2130A73;
	Sat, 19 Jul 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886209; cv=none; b=GF5pA61buu8iL02pc2/03h6Bh3FJTwfBxth4ecy9WAezfGlqJ4ogD4TaR7ETVkIQpqRDbhFaaK7/UsteKpN6YWWbQYxAGr9lFSAADKGdQ0nhThPP+DcVZq/o9TiSOpBhw6AD1gkmenvM2jomjw7AaIeB/1VTfJSnlSj+KzPLOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886209; c=relaxed/simple;
	bh=pOCNF97ddEfHE3C6e1BqT8r5RSsqtKDXSC1RWom9FfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Md5FYLSpdDMkWgAYyF0CcwGWobd/EOKsC6Wq7g0k6wKtfuJ4lRiTsST8QLDFnxz91bpKs+8np0Is1GXX3o7+N2dWhvec44U78BuFEnPWNH/ypAFz0XJ/aKOQaaLRKGcEp6hBvNdcVtaPthHspW2T+VVI81V5T7J/pc1f53p+IwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC94RXIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1F0C4CEEB;
	Sat, 19 Jul 2025 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886209;
	bh=pOCNF97ddEfHE3C6e1BqT8r5RSsqtKDXSC1RWom9FfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rC94RXIEMUncfeEvJepabphkkE6u6sKlfhBFkYQqTrrSPNs2IAncl8R99ayeTz7SH
	 TR2Tu+GwlxgVPsMnKOVDIlL6LaJFawyrWFPPTdxhEK8fFvMsEjrqIgxry9N6TL9a/u
	 PsSLMdxBwa/OpKuGDIRVMPeKTmkmH/zFdLImL5gOkbSaXWps3fw29iol6v96LappeP
	 sZI8yETIlSnyLUjekpsopHLWQ64HjLqmeuDrpKFTDIiPFWl1Sa2rBQMz9QTPFt39R4
	 WR5tRNqA2wtktkIpoveqUeN0SiWnpzv2xPklB9XoZk7S46jbF6bke1yx/oO94nUvTG
	 aO9zV9luAfoDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA7383BA3C;
	Sat, 19 Jul 2025 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmasp: Add support for re-starting
 auto-negotiation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288622900.2839493.11455333079632181551.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:50:29 +0000
References: <20250717180915.2611890-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250717180915.2611890-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 11:09:15 -0700 you wrote:
> Wire-up ethtool_ops::nway_reset to phy_ethtool_nway_reset in order to
> support re-starting auto-negotiation.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: bcmasp: Add support for re-starting auto-negotiation
    https://git.kernel.org/netdev/net-next/c/190ccb817637

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



