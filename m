Return-Path: <netdev+bounces-161310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F69A20A81
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9F1615B5
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528E12F5A5;
	Tue, 28 Jan 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwfFHpDO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F18BA27;
	Tue, 28 Jan 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066807; cv=none; b=UyWcuv3BzG9UOdF/wSU3Vn1BkYfcQGbCFCinPfq/whCJOqNxV2A55GBHAjgJD+5bedXniqmZUKjWBWG+SwePgRbXKzfO7G5uks/wifY8a9lO8eGRpjw5A/Eoma+xy9BEP8SzYGipkWGT6IjPU4WYQ39USndZ9bMObR2Sp05git8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066807; c=relaxed/simple;
	bh=hGRAHKFUCDKAuwe3CGHbeVZG49CT7ecXG5otU32lUgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/I26gFFtiMcf9X4S3Zg/UHtCwx2AFXzA1ZNNNHyIyNtWTHpxoLHCmulFDMzJX+2WoSDBW1xhI+/hTqt8oL2kbYc9QtP/iu+3/vjMpib+m2wR1KgX4TRrNNHbjM9lLsjCFR3r7s+0xIpun4XaE6sL5l/lo63Qxd0uTjalYQ3vHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwfFHpDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0064EC4CED3;
	Tue, 28 Jan 2025 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738066807;
	bh=hGRAHKFUCDKAuwe3CGHbeVZG49CT7ecXG5otU32lUgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwfFHpDOMF43ZbhuhVr3ZbDmUOPsIf6c6Vodr6d6bghMyPyiTQkHVYIaIe/Xx3HIy
	 /V/vnFFZScwU1qc/UYs6QoOOY2cWJiW1FggvRQShQtcvjdXMQU4wZ6PdgUXhMFxLd8
	 uWBn8Kxovfo0/FjOrQnXozJHDFodHowcPTgKU7W9TPsMnlw/CxcUSbKyJTkkyaFu7J
	 4uMdWFYFkOV2ql+Wzn4KhJJYeCuuA5QuhBUnle4cKGmXQJiFJH19u66yr88MsWbdEa
	 EFwjykFH471jvawzyB0RKdDURsq86lKnTkys/S8TNBUf1C6wrcPjMgZ4IrSLk4+hqu
	 jWH6782480JNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB249380AA66;
	Tue, 28 Jan 2025 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] Limit devicetree parameters to hardware capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173806683276.3776163.12860723746760741556.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 12:20:32 +0000
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, si.yanteng@linux.dev,
 0x1207@gmail.com, Joao.Pinto@synopsys.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 Jan 2025 10:38:17 +0900 you wrote:
> This series includes patches that checks the devicetree properties,
> the number of MTL queues and FIFO size values, and if these specified
> values exceed the value contained in hardware capabilities, limit to
> the values from the capabilities. Do nothing if the capabilities don't
> have any specified values.
> 
> And this sets hardware capability values if FIFO sizes are not specified
> and removes redundant lines.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: stmmac: Limit the number of MTL queues to hardware capability
    https://git.kernel.org/netdev/net/c/f5fb35a3d6b3
  - [net,v4,2/3] net: stmmac: Limit FIFO size by hardware capability
    https://git.kernel.org/netdev/net/c/044f2fbaa272
  - [net,v4,3/3] net: stmmac: Specify hardware capability value when FIFO size isn't specified
    https://git.kernel.org/netdev/net/c/8865d22656b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



