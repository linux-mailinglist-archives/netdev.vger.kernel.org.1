Return-Path: <netdev+bounces-155180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC87A015DA
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E68163723
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38B1CF5EC;
	Sat,  4 Jan 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/BZJomL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73331CF5C6;
	Sat,  4 Jan 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736008814; cv=none; b=lquXBzraNc3xRW55DnErhYaQTDsNiHbpRD9aeXnXrs5aSyMD2DCyvOT0GNCMHgo0km/qYVgPS1Iq11awdIauOaWSS60AU0w2z75c+yPas/NTHzdOeE2grXkFnB2XpQF/RukHn42qdCJ73PaM3vK7M+RJ0+ErelrvVJSQGjHCaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736008814; c=relaxed/simple;
	bh=9aLkpmmVf7SzNW23WKff/899vc2RZPaEX/C1AwTTjhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JCs3gl/Ua1zn5fr+cBW1o9d4+7RyTxhqe3xF3S1d0Q3m1WqadvPZKkN+4MaRRT1V9kSJgLW2zKDq1TZ+YduQ2I7MfRVx/5IPYlu11ZNry/DGhStw+/XBpqmptqN7hH4yKuWz1A8zDhZdUmkNZ9zZ/8mfF6ED9dlwNOyRxLhKcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/BZJomL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417D4C4AF0B;
	Sat,  4 Jan 2025 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736008814;
	bh=9aLkpmmVf7SzNW23WKff/899vc2RZPaEX/C1AwTTjhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B/BZJomLq8T6g/kbiUaMhUidDDsPvvrqay/EX9uUHoV7pUIJz/zzmF1A1twcdLlPZ
	 DFtjNK0sS/+uY9JnG3jBfdFxJj9jkMsPoaYPagEg2znZ0g5WSs6z0vdMo2cqXzScBi
	 zoajya8k0vGCMMb1SsB3MDZkxzBxXy0sOPgfs/MuyQ50ivPD+cpSyWFpC3rLiq2UK+
	 vdnHkBd2g5fRe0adRRFwhJJjzqxxmVlFFZxqp70Uy930y99rG9epMvqLqSmbxffz5e
	 IWr6Txc5+zqBMxXI4cAQuBRijO2K+vUZ++TY4pE3RdqPaxLUvRc43HS9MFvDzSh5R9
	 vs4wH7Ar2EV6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34D37380A96F;
	Sat,  4 Jan 2025 16:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: pcs-mtk-lynxi: correctly report in-band
 status capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173600883476.2467289.906250535981566950.git-patchwork-notify@kernel.org>
Date: Sat, 04 Jan 2025 16:40:34 +0000
References: <Z3aJccb1vW14aukg@pidgin.makrotopia.org>
In-Reply-To: <Z3aJccb1vW14aukg@pidgin.makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch, lynxis@fe80.eu,
 rmk+kernel@armlinux.org.uk, ericwouds@gmail.com, frank-w@public-files.de,
 john@phrozen.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 2 Jan 2025 12:41:21 +0000 you wrote:
> Neither does the LynxI PCS support QSGMII, nor is in-band-status supported
> in 2500Base-X mode. Fix the pcs_inband_caps() method accordingly.
> 
> Fixes: 520d29bdda86 ("net: pcs: pcs-mtk-lynxi: implement pcs_inband_caps() method")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> drivers/net/pcs/pcs-mtk-lynxi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: pcs: pcs-mtk-lynxi: correctly report in-band status capabilities
    https://git.kernel.org/netdev/net-next/c/a003c38d9bbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



