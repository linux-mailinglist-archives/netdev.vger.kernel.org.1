Return-Path: <netdev+bounces-119623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C9F956602
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412D5283EB1
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620715B560;
	Mon, 19 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF4C8kI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEB14BF8A;
	Mon, 19 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057425; cv=none; b=FyTNy0PuRwtP+dOePmzqrd8Chk7WRjsT20WVE8TxYFx0680ZWAMbmfsxEXkzv1zZDsYaiVuAb3bvvvp7XkJf5u072LdFi2HKh/uzNMcRyYP7udMd2JjSHZz4eA/isEO91vp6N2ux1WWyFkH+hpmYwBh+dgPB+VvWhWNpW+by5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057425; c=relaxed/simple;
	bh=OCRaPalAGsDxHnsThodnFYpon6u+zr5gMnTg0RBz0iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N37omILYWh9g6+pnV86ILH4Xsh1SZRXeohrOqto67YqSA6TvOb7e7NP/gDAWaX7O5iLkFLgL4+50K/1S2Y3Rs45fmghpM4AW/XBiGgg9/c+5V2/Q5k/KvCS9inyQrFalG1ZY1+gmvnpGHFQxXVwcYHAMPrnWKldSyJ27fcWoRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF4C8kI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AABC32782;
	Mon, 19 Aug 2024 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724057425;
	bh=OCRaPalAGsDxHnsThodnFYpon6u+zr5gMnTg0RBz0iU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PF4C8kI0co60PfDbF+RsNfA1uS7Y4OTN9qiSz/Cuv/mVcrnF5rc5aM5kcgXti4IAr
	 oPZ91DiecIhisuFsQ3dItPlsTC8LqBbMLDwZ52iLSCb8JJLyA9iZMadmmIaazvOSsF
	 hErhKQk7hnWuBNEDaB9xluI+D6IsdsiYus4b8nYdt3H8hdGuVB68qXxDlOYbVg3Pm1
	 6hy2fBNtb0a1kXaa8k3jIvGDu7yPNLGCl7qDMgxQ7VVVEErHalSXE1ZZYy7ZxxxFqY
	 hsT+AKbkpyu7xwLxvivZCsP+q3t/h4m0aEGzrghOqxGDA2NX0mnqVwCzIlVExBRsB1
	 C+rOmk/yzok4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD733823097;
	Mon, 19 Aug 2024 08:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] dt-binding: ptp: fsl,ptp: add pci1957,ee02 compatible
 string for fsl,enetc-ptp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172405742451.466743.15434541397168706407.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 08:50:24 +0000
References: <20240814204619.4045222-1-Frank.Li@nxp.com>
In-Reply-To: <20240814204619.4045222-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: yangbo.lu@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Aug 2024 16:46:18 -0400 you wrote:
> fsl,enetc-ptp is embedded pcie device. Add compatible string pci1957,ee02.
> 
> Fix warning:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: ethernet@0,4:
> 	compatible:0: 'pci1957,ee02' is not one of ['fsl,etsec-ptp', 'fsl,fman-ptp-timer', 'fsl,dpaa2-ptp', 'fsl,enetc-ptp']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> [...]

Here is the summary with links:
  - [1/1] dt-binding: ptp: fsl,ptp: add pci1957,ee02 compatible string for fsl,enetc-ptp
    https://git.kernel.org/netdev/net-next/c/1bf8e07c382b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



