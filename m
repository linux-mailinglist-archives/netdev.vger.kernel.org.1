Return-Path: <netdev+bounces-230252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A29BE5C7C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74C894FC1AC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695D2C030E;
	Thu, 16 Oct 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdX2/npy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788031CEAD6;
	Thu, 16 Oct 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760656829; cv=none; b=itmhL8RGXxNUXr/xfYiFuC8XgZe+ZrKXAg6rFlrKM0MaKd4errfV30rEKJzvXNG0t9ag9zdTx2YQ7QD+Mxw+twbg2MnA5Zyx4TqPbhHrxmgJzefkOFo9mhgBCqc5g/mszc3lk+1jVEVWO1Z22gxvO9qgBXFcxAqNo32ryqG+kO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760656829; c=relaxed/simple;
	bh=XmFZ1aCPOavivGFm2MY2rpuXNMGOSeXgUjkf7jQ4ZSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n5To2Zoa4n4n6pw4LtRE19gyA6mICFVGO0Hr7VSb3MqdMNADkQXs4DotLQYMyGUuqL2si1TgjbuDLwaviZ81eFmPPVQI53c1GB3Cx00cuUgpJdK6SBhkSovL+ZPRePrvr3AQfzfaEGhPyS5oI/8rv6nPuLNZU/V0MTQaXJDhhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdX2/npy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C2EC4CEF1;
	Thu, 16 Oct 2025 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760656829;
	bh=XmFZ1aCPOavivGFm2MY2rpuXNMGOSeXgUjkf7jQ4ZSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NdX2/npyuApB04JWfGhacNAQxh7Odc9VcysylDLj6xMk8iShYkL+ZSQulPbmVQnBP
	 K5pg+2x4rOXIYLy6/MyMYeS6YblWpBHbRxa85mGx9Tk6J6BtgBwZEvq73JTA0pytjx
	 ArdCtEq5O8mdevH4P1QWpfnYtEyun22mdyT+Cb4iSUuo1rXgpb8dsxGPZS5jSmxjI3
	 JisiJn9jyFWATdHaf1lUoFioBvz9dCMI6MtKCCLWPD+H59kELGRRS+ljXrFV/Gdpm2
	 y3F5YA3qkcYciAK53CnN5e8x+tQREXUYNusfIxLgbYaK1Oiu7vSYJxbtxC+7PBPOPc
	 dVhsyg7mVesfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7739D0C31;
	Thu, 16 Oct 2025 23:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 0/2] Add driver support for Eswin eic7700 SoC ethernet
 controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065681299.1942659.16205838065637894819.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 23:20:12 +0000
References: <20251015113751.1114-1-weishangjuan@eswincomputing.com>
In-Reply-To: <20251015113751.1114-1-weishangjuan@eswincomputing.com>
To: =?utf-8?b?6Z+m5bCa5aifIDx3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tPg==?=@codeaurora.org
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
 vladimir.oltean@nxp.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jan.petrous@oss.nxp.com, inochiama@gmail.com, jszhang@kernel.org,
 0x1207@gmail.com, boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, lizhi2@eswincomputing.com,
 pinkesh.vaghela@einfochips.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 19:37:51 +0800 you wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Updates:
> 
>   Changes in v8:
>   - Removed config option patch dependency from cover letter, because the patch
>     was applied.
>   - Modify the theme style of patch 2.
>   - Remove unnecessary dependencies, such as CRC32 and MII
>   - Add "Reviewed-by" tag of "Andrew Lunn" for Patch 2.
>   - Update eswin,eic7700-eth.yaml
>     - Add new line character at the end of file
>   - Update dwmac-eic7700.c
>     - Provide callbacks for plat_dat->init/exit and plat_dat->suspend/resume
>       to optimize clock processing
>     - Use devm_stmmac_pltfr_probe() instead of stmmac_dvr_probe() in probe
>     - Remove eic7700_dwmac_remove()
>   - Link to v7: https://lore.kernel.org/all/20250918085612.3176-1-weishangjuan@eswincomputing.com/
> 
> [...]

Here is the summary with links:
  - [v8,1/2] dt-bindings: ethernet: eswin: Document for EIC7700 SoC
    https://git.kernel.org/netdev/net-next/c/888bd0eca93c
  - [v8,2/2] net: stmmac: add Eswin EIC7700 glue driver
    https://git.kernel.org/netdev/net-next/c/ea77dbbdbc4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



