Return-Path: <netdev+bounces-232335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335AC04260
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 409124F2354
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36A1261B8F;
	Fri, 24 Oct 2025 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCtpOo6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B3261B71;
	Fri, 24 Oct 2025 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273640; cv=none; b=n9JL/q/JnqW4zzJZ8YIAIVKWWMpQ7nPHsp4+eYq0dHyuRFRYvDTsztWUIDLfZddeiRPEI8l/KV72yOs222q2QLgvEGHnOteHl/ACHGpujBzzuAN1CSU6Yp2ntbv5eJggzVNUARP0TAWRL052iXsfSDQNn+m/EtynPuk8oeknOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273640; c=relaxed/simple;
	bh=8wh94ydNsTnN+ap5EQ1+1efQA07bbBq9obiTbG20+jc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCbnjV0HOb4NdZUx+mmXW3K9m5F5t/L3fGsGTxgSxFo38Kw+0EirwrG7T7UEFWVu1lpkGXO5ySumwot0+cZLFk0SrSj5g2rlxogVmzAakuGL5s/1uy/T/TETytGm2Y/f328FdQ5lR/DnGEFx2BFnP2gVighhq7pWCbnjsBNWRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCtpOo6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0DCC4CEE7;
	Fri, 24 Oct 2025 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761273640;
	bh=8wh94ydNsTnN+ap5EQ1+1efQA07bbBq9obiTbG20+jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KCtpOo6vygS4/lf6QvBJJpfl+Ces/nH2fWuXm4aOEjPMnFq40DytTJ3f1998v3yml
	 tO02VE5G0nSNTIZYgC5tQxU6UQA/ZAbz6IwSGM6B09ONHi7mb3MGC3UFCTiZmvQJCF
	 OzPzS9xL7ZUV6HxP55/2EsNwI79qAvmWPqCTzP/qmpnEgaUY4Sbj8Ptwsp2Vq2Vvlk
	 L2PcCyQr+9MycC/bbJhaRTmjw0CQrzf+VOcyLre4i32I0NZEQSGN+MJcckqy1Ka94k
	 QYhN7f59Wain3pcphM+gyb9Njvwnoe1qBGMVDZPi4evwPKinlU8FdUH9RiaEM1FPGO
	 2kdxMm8fJcIRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3CE3809A38;
	Fri, 24 Oct 2025 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] net: dsa: lantiq_gswip: use regmap for
 register access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176127362024.3327514.4303315908989422477.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 02:40:20 +0000
References: <cover.1761045000.git.daniel@makrotopia.org>
In-Reply-To: <cover.1761045000.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andreas.schirm@siemens.com, lukas.stockmann@siemens.com,
 alexander.sverdlin@siemens.com, peter.christen@siemens.com,
 ajayaraman@maxlinear.com, bxu@maxlinear.com, lxu@maxlinear.com,
 jpovazanec@maxlinear.com, fchan@maxlinear.com, yweng@maxlinear.com,
 lrosu@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 12:16:19 +0100 you wrote:
> This series refactors the lantiq_gswip driver to utilize the regmap API
> for register access, replacing the previous approach of open-coding
> register operations.
> 
> Using regmap paves the way for supporting different busses to access the
> switch registers, for example it makes it easier to use an MDIO-based
> method required to access the registers of the MaxLinear GSW1xx series
> of dedicated switch ICs.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] net: dsa: lantiq_gswip: clarify GSWIP 2.2 VLAN mode in comment
    https://git.kernel.org/netdev/net-next/c/41b66240e90b
  - [net-next,v5,2/7] net: dsa: lantiq_gswip: convert accessors to use regmap
    https://git.kernel.org/netdev/net-next/c/705359797389
  - [net-next,v5,3/7] net: dsa: lantiq_gswip: convert trivial accessor uses to regmap
    https://git.kernel.org/netdev/net-next/c/128f5cf40fa5
  - [net-next,v5,4/7] net: dsa: lantiq_gswip: manually convert remaining uses of read accessors
    https://git.kernel.org/netdev/net-next/c/4cc06901ef34
  - [net-next,v5,5/7] net: dsa: lantiq_gswip: replace *_mask() functions with regmap API
    https://git.kernel.org/netdev/net-next/c/748b0aebd48f
  - [net-next,v5,6/7] net: dsa: lantiq_gswip: optimize regmap_write_bits() statements
    https://git.kernel.org/netdev/net-next/c/1d88358303fc
  - [net-next,v5,7/7] net: dsa: lantiq_gswip: harmonize gswip_mii_mask_*() parameters
    https://git.kernel.org/netdev/net-next/c/b0911b9e0140

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



