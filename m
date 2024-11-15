Return-Path: <netdev+bounces-145170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4299CD5F4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74420282F04
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C3E16C684;
	Fri, 15 Nov 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYknr0sr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3D14F9D9;
	Fri, 15 Nov 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642022; cv=none; b=Vwc84K1rK9vrElg3+nacBQoUFJuFOi1cDA7JBsGYbCNBydJov53o51Ktp6viJpkFKarqVpzyeAn6lb9+8/1k9qyv6Fd45Kr/y0pBIrPSOtU2rxC4nsabB+OtdKmBjtcRpbeaPCgY+OOVZg9XTLmJojWuvgSAtcodUQP9p+wOn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642022; c=relaxed/simple;
	bh=TmzVa7BICPRYXimhMGB2sXmo5vUrLg6d8yWHvqUqKMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HNEW4/Xn0iRH58Wa7yJdd+RiSQhpx0JaQkGxUrPCsLWCIEWpx50IPwkEeSLnju5DgBfsIuEil+/cHRCxW/RzMYvqovj6E86dlu9Yk7muc2cviNqafic2IXqP2PYMARQWLtTNemvtGc/OncBnuv5wlozM3jjcbiA3QA3oHIxCUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYknr0sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AA9C4CED8;
	Fri, 15 Nov 2024 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731642022;
	bh=TmzVa7BICPRYXimhMGB2sXmo5vUrLg6d8yWHvqUqKMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cYknr0srTGhF8923dLr5J6gwNumAgPsSalr1Q7HHN/gVPRn4wWadKSrWkvOar4ZZT
	 b7IqUsDJvLOelo0skualIHtE5MzJ5Wvnia6+/0AVTj3yhcYqdBSl5CZYcukqWUhzyU
	 EShz5QoyDLiZg1QYumoFTlKyL4g8X8LRhxbsRkYgTja0S4PUo/zIVJsu9DKvIkOOxM
	 gLE2ErrIaSp1XgAJ+b9Bb1FqPGrMHE15VjLHnw14yfD2wT1sQW/GihpYqJ/X8R64fA
	 csN2t0BNx0Nd4gSyeTsrqjx4HgAwZLrusdVudoL1AFpGEvsWwC0O5RAXMQYVfQY4qX
	 VVEBWFLKDXtWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D193809A80;
	Fri, 15 Nov 2024 03:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: mdio-mux-gpio: Drop undocumented
 "marvell,reg-init"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164203299.2141101.3576967109936404388.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:40:32 +0000
References: <20241113225713.1784118-2-robh@kernel.org>
In-Reply-To: <20241113225713.1784118-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 16:57:13 -0600 you wrote:
> "marvell,reg-init" is not yet documented by schema. It's irrelevant to
> the example, so just drop it.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/mdio-mux-gpio.yaml           | 32 -------------------
>  1 file changed, 32 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: mdio-mux-gpio: Drop undocumented "marvell,reg-init"
    https://git.kernel.org/netdev/net-next/c/ac0928d5b6ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



