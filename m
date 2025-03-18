Return-Path: <netdev+bounces-175679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ADA67150
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E351693A4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B52207E11;
	Tue, 18 Mar 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVGPsRCQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3020767B;
	Tue, 18 Mar 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293799; cv=none; b=LA/gdRYqmFTxZHE0DGVDsUhejTrr2fh2Zzw9ZYOhj/EMK/+fvol5U7ZCnpdQwnUK8VnttzZ1n1LQs8EHWN5Fojl6u4TcLCCRxjkfMfxx7W/x5X8++S4YMb03IIomZJ3O5z3IgfjCP1bJI60rlxoEKlhuk7GvrIIxdT+zohcybdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293799; c=relaxed/simple;
	bh=GEyWmAuKyt53yQnLXeprXRpXd8Gr1UAJGEAO81CNlf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XlNuJywONjfWTNf+OWsuZRL3BKbbLn+HMKDvy3t0N4EDdDI2uX4h5qDCk4AKEUCj7i+VbCCe9gusdjZQJGH5D25kUug+C4k14tAFt1kK4bfDfqpz8YRkL8aHh1UxRxdd4/dY8Db3x2bGUa1YbxTQLhniA0+RFHm62/Gyj8kWR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVGPsRCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06808C4CEDD;
	Tue, 18 Mar 2025 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742293798;
	bh=GEyWmAuKyt53yQnLXeprXRpXd8Gr1UAJGEAO81CNlf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVGPsRCQwFTEZngbGzaWWnmzTfiuq8UjnKK4UDTZdjXfAsl20tqkt8barAi2UL7Ys
	 /RU7IQ8xNTkjEUpxWLc4C9gJL0DJNUb2JQQrnaj1I2xa56mMx7Fdd/gFFHUgUGAZRb
	 taNX+CJYV2ZWJ/kI+GXpD/nixiDsnALdQ6BQuRM7kedN0epHn+kjXQih0IpYtLVzTR
	 /sXBojLHIjxtpi/SHjFRHhQT4cXXvuGbSEFStQiO52dvS+kBzy2FrMWOnTUR1JBwgd
	 1bDoWdOWmsfbiwfuKu4FpW7oVoEK16ER/YndH5Zm8r6P3dUj0E336n2r7IiRMSQ4yA
	 sv6ERxCxK/1Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE0380DBE8;
	Tue, 18 Mar 2025 10:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229383352.4118139.13974344587777019051.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 10:30:33 +0000
References: <20250311154259.102865-1-s-vadapalli@ti.com>
In-Reply-To: <20250311154259.102865-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rogerq@kernel.org, horms@kernel.org,
 alexander.sverdlin@siemens.com, dan.carpenter@linaro.org, c-vankar@ti.com,
 jpanis@baylibre.com, npitre@baylibre.com, vigneshr@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 21:12:59 +0530 you wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Registering the interrupts for TX or RX DMA Channels prior to registering
> their respective NAPI callbacks can result in a NULL pointer dereference.
> This is seen in practice as a random occurrence since it depends on the
> randomness associated with the generation of traffic by Linux and the
> reception of traffic from the wire.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence
    https://git.kernel.org/netdev/net/c/5f079290e591

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



