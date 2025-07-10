Return-Path: <netdev+bounces-205606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B0AFF672
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7DD1C48251
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E827E1DC;
	Thu, 10 Jul 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nelftVPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893C846C;
	Thu, 10 Jul 2025 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752111331; cv=none; b=XbhBE4jUnKg7ze2n5f/UelVS5VvZklMTRNyKhIWsQITrGlj8q//F9lr8ZPBbT/oHAn24tarGni9NhVOOERb3wE12wy2rlp69orSLxVKK+xmUPgOCa9vY+RlgI/wBptmkvHswQL/MUtuc2wEaGTLu0KfxqyZebw9U+3wCIyDVjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752111331; c=relaxed/simple;
	bh=vuaZDssHpq/J3jA0y7OFz/bVN7cmfEs2MmNf4DnX/WM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKqKh6foRQV/cequXq1j6eSVmLhXNm7vqAA0IEDYr3pCoNPVS9vqQHViVZXkPtP6g3RQKcg5n2ST2SH8T/6ZpXNmei27uysfftEa5QyFKYLglmpATyuyL1TI49CMN6geihog0FaeNdX97pL8TjTRS5+KCgKyYEtjR/R3dwCgEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nelftVPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F1EC4CEEF;
	Thu, 10 Jul 2025 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752111331;
	bh=vuaZDssHpq/J3jA0y7OFz/bVN7cmfEs2MmNf4DnX/WM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nelftVPXCJB7ObKBwuBT3hh6ozJyMcEuIainJ1cEzbC3iWzXTEA77rqq1z5fs2+is
	 zs8v8bbfSTTEKZyGjVQneoFkszzLVhyQym7SZEVdSRHut8t1Hk4Y7LII/G3HvvSQJg
	 Dds0gjg62ARS3uJJEd1yNLkjPCspikXvFfFYpxRUKS9+xDEkkW7aBVCvwedELP81Hn
	 E7Eqig0LBWy1BdiIQP4JrqNMDWP4T6DZunrtOBuW0bqgto6EOvBdQGtW38B0ong4kI
	 9B/KNkFiCc8ofQxLOHq8OsYrpWvgbMug6jG5r0ZF+uEaBs9lqSrPQ6YRGlXS1CmKEf
	 lBLM0KAqMN6IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF61383B261;
	Thu, 10 Jul 2025 01:35:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Add support for Sophgo CV1800
 dwmac
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211135250.897408.2127630772719110412.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 01:35:52 +0000
References: <20250703021220.124195-1-inochiama@gmail.com>
In-Reply-To: <20250703021220.124195-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, unicorn_wang@outlook.com, richardcochran@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, dlan@gentoo.org, looong.bin@gmail.com,
 conor.dooley@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 10:12:19 +0800 you wrote:
> The GMAC IP on CV1800 series SoC is a standard Synopsys
> DesignWare MAC (version 3.70a).
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: Add support for Sophgo CV1800 dwmac
    https://git.kernel.org/netdev/net-next/c/6a971e48e2d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



