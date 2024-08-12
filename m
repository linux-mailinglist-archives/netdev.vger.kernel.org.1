Return-Path: <netdev+bounces-117685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7FA94ECFF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642AC1C21761
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D317A593;
	Mon, 12 Aug 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcjCkHiT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E9EEBA;
	Mon, 12 Aug 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465827; cv=none; b=kr33TBA93vXnPPton0i85zEddzQZj63DEZGxeVVBdAr2FfKweJQssgiMr7Zy0EOm+O+7M8hCV7p7eozAM7h5+R1DhsgVVTzNvT3oAvBJtlxcvBHqApo/HFBMQcdP1fkI5ep/DGps3wnSZLsapeDcwMk1kB1wYBosom0E/jQ4bBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465827; c=relaxed/simple;
	bh=aZC77bUCThC7AT/7z+u7TDuWH+xpFQ7I4SjrJ8HZm6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gY1HlO39gnEij3Dn72Fe03I/Awlijmv70xVOsihkW1ig70gku8u0Cklt//uEOETPK260CIAuL82BKY7v1f5jr2qLk7F+L0BzVKpPm9Rxc8tGDwt7+rHXt4CPkhBpY3Dbv/WVh82rFPaHk0LwgT7xQ4Hov6QpyNBJRcy2oEbQm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcjCkHiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451BBC32782;
	Mon, 12 Aug 2024 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723465826;
	bh=aZC77bUCThC7AT/7z+u7TDuWH+xpFQ7I4SjrJ8HZm6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hcjCkHiTyge7efh9j5xmiZXD7TdwXRiZHZgdY4Wdja/2nN7GHUHANqiizJ+pVPuMx
	 8TcxQa+gnBH5zc6IOdoJHQE+wEwzLHN+bNElUfyysFIcqR6MEiXt7BRkPZ41B0JxiH
	 YkbztLcR414E20axvrYt6fyZoG0XXo4L9kvMwu/UslVa6AUTl/V8Y7C5x9TD0mP53Y
	 S+xdT5/8DTxDdrq34AF93ZbnGDNkvhdfovHUN+FpeIOjQ1kPP3WecruKvbfj1oH8Tb
	 cWIEI2DQeXRNqh+HTUWTs6QIUtkCGPWDl5Lyf+8NswPSUitYX8pJnn2P7HHhkFQZxH
	 NlRdQEXiXl2jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF4382332D;
	Mon, 12 Aug 2024 12:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: add missed property
 phys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172346582526.1009420.14303851329355513128.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 12:30:25 +0000
References: <20240809200654.3503346-1-Frank.Li@nxp.com>
In-Reply-To: <20240809200654.3503346-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ioana.ciornei@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Aug 2024 16:06:53 -0400 you wrote:
> Add missed property phys, which indicate how connect to serdes phy.
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@7: Unevaluated properties are not allowed ('phys' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: add missed property phys
    https://git.kernel.org/netdev/net/c/c25504a0ba36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



