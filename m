Return-Path: <netdev+bounces-159156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182BA1487E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DF4169F74
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945221F63F1;
	Fri, 17 Jan 2025 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ2DNCcf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5401F63E9;
	Fri, 17 Jan 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084610; cv=none; b=HPYxIC+VcRq4HKCR1+5bIHG0WXzrAx/LGcVlN1ms+cNt7kOPh6DsltI+LYhT/NIodTBifcMpCNdhoaXfwrvOVqqzSTDignjKE2vkQ7GeA6rAHl+akjdLwdA+pTN5I24cH9A298AtSfF/GR9gWPK5A/JAnIeHBUmTVPZu9CQf4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084610; c=relaxed/simple;
	bh=YXa5sBs+SbWzJpbmizkbAEboz4vW/eOpnaQPz7Ou5k4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PdOcNK4WnmP/gm8gkDAfPsMjAW7CpbPwDUh/WdAciPx4xDjImyKlDCg+h7Gz62uM1UZPD/9DiVxwC1tKvZlT1fk3eqHrwQ/VQczX4t33nv/lNK0x/Gp+U86ngC8IROJWlnYbUXlJNCl2WXXdeqI0ZhLhOTJbWrW90IXERVRdLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ2DNCcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF852C4CED6;
	Fri, 17 Jan 2025 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737084605;
	bh=YXa5sBs+SbWzJpbmizkbAEboz4vW/eOpnaQPz7Ou5k4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CJ2DNCcfET/W51SR1TIuRv6RYKMb1nnhiJogWXNmDfTzhBl/cKaHMBhm9O7hq/WDh
	 Dcqx8DVwUg4wCPkbnWbsE65w7zYtN4vUaAXHqhGVLdiB2BnDRDulCRMJORCiFfUAVT
	 O9q5VCU9JltzKgjCA8IDEPKRm8IEHCo3C14fdqQ7N9WPimcMT2N8VDSW0XodaYIno4
	 sik8qyFYKzVp+3nLtVDeAbzPqAWvjg28k41ycQr2V6C6iXUXmyr/6jocowc1rBUtmg
	 ejE9yAUPMidl85HeRDIHJjg+ENzwLzU2iA/hgwMHXItG8R1+A0IZOA8l5a6H8zt9Qy
	 /sQ2pyGv5sLeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF6380AA63;
	Fri, 17 Jan 2025 03:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Add PEROUT library for RDS PTP supported phys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173708462901.1672659.12804893284840338036.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 03:30:29 +0000
References: <20250115090634.12941-1-divya.koppera@microchip.com>
In-Reply-To: <20250115090634.12941-1-divya.koppera@microchip.com>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: andrew@lunn.ch, arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 14:36:31 +0530 you wrote:
> Adds support for PEROUT library, where phy can generate
> periodic output signal on supported pin out.
> 
> Divya Koppera (3):
>   net: phy: microchip_rds_ptp: Header file library changes for PEROUT
>   net: phy: microchip_t1: Enable pin out specific to lan887x phy for
>     PEROUT signal
>   net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP
>     supported Microchip phys
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: phy: microchip_rds_ptp: Header file library changes for PEROUT
    https://git.kernel.org/netdev/net-next/c/bf356a6df799
  - [net-next,v3,2/3] net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal
    https://git.kernel.org/netdev/net-next/c/8541fc12edcd
  - [net-next,v3,3/3] net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP supported Microchip phys
    https://git.kernel.org/netdev/net-next/c/93359197f273

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



