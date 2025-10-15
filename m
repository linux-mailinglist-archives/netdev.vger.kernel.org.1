Return-Path: <netdev+bounces-229659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BDBDF828
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DC03A4AFF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECA92741C0;
	Wed, 15 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm7HJhff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE776FC3;
	Wed, 15 Oct 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544023; cv=none; b=BzDDRm7CbRF+bM1iPcMbauaDggPvmE6wP6uhvnq2YVhiy/PfC9UREdCksR2eAwFkA8+V/QIBZGeJCX09KAKjyLFctGH5+xAG32XLuKF2Ccfr5XcbUt5zpWwMxkUFMSlNPe6ZtOX5IRditFZaKGexw94jZ/zNexQZRVZmPJPq1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544023; c=relaxed/simple;
	bh=XgNQyS4xJk9AwpFEXFv2Dqc0gylkDMvbRX1+lZnNB+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utOJZRLzStgU+wWcQCOpjEMmgPDZOs+J7lMuFGmZefTUJQePWS1ASYrtRuMDpO0wFlROPN4XIifja7SoYvFevVFp/ubr/1CKLpyftv5HQRp992yBy82zHubRm4kek1orTJ9zGolrLB0iUe4NomtDNwz/rG1ehaUNJ/EB5OJaors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm7HJhff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37580C4CEF8;
	Wed, 15 Oct 2025 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544022;
	bh=XgNQyS4xJk9AwpFEXFv2Dqc0gylkDMvbRX1+lZnNB+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jm7HJhfftMQhB80d8l2zeJP+I39+nas/gSTGGouFxZqX+ZngemkcGvQRkUY7kKzmU
	 ry7TwAmbasG95srSWY0wJ0al6bn+FZZV7wshyShp5GHKIby0bFBuR3dXq4xa/jX8pS
	 fb2Rdh9uDy3UsBZq/kt5j1PkeaneMBUV09deQ+vrP6AjTomt7q+BH0WbvvBVCJaYHZ
	 9eDXAWxUvxkGUOLvBsMthP98NwhoP9XsA83hmJzSW+gQCrGnchUV+yD97NaJCNlAcY
	 BJ0fAi2h67aj2dhusdlvUezsnIvL7DXC5pBO0ejTzrc0i/UfbvS/KrtUoeUvOXm01D
	 dhthqLaKXg7UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF8380CFFF;
	Wed, 15 Oct 2025 16:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176054400701.936044.5003964691251298942.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 16:00:07 +0000
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
In-Reply-To: <20251010183418.2179063-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Oct 2025 14:34:17 -0400 you wrote:
> Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q): Unevaluated properties are not allowed ('clocks' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional clock
    https://git.kernel.org/netdev/net-next/c/6378e25ee1ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



