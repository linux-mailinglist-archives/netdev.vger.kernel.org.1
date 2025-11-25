Return-Path: <netdev+bounces-241552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C999EC85C1C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CD83AFBCE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F0328257;
	Tue, 25 Nov 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUNtesbG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82F32824D;
	Tue, 25 Nov 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084313; cv=none; b=l2OZHL1Y1r2mp8a9twefd/OpzBITamy/iETcxQ53zp+wJfHa7LybtcHaAQqQsZAHHW2SfvsCBSJUssF8IHqBIZTvx3s8dDLhmDwJ6pi43Rup7kksHoMtjfgXJW9n1BhB682Oyy4Ko//lUBy+noxt32QWsbS9t5R2DIE0MephqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084313; c=relaxed/simple;
	bh=4RYDYfcK9a7GnCvt/hsJs04ut+5Or3oUlb/hIAQDe1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xs0Rh6xp3K7xLWQIowEj56+5URuJFctPG5lzp+LZaYHKl53PUm5uU9Y56i4KzdOFQ9fdtPu84pt1prErjNnsJvASouu7rq+9NK1/IOdvgqz5d512Ty53mtDKVao8F3WmIPpj7PbIACwAMIKzsehMDgZXPz7ZTvoQ3nAj+2wumZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUNtesbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828BAC4CEF1;
	Tue, 25 Nov 2025 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764084310;
	bh=4RYDYfcK9a7GnCvt/hsJs04ut+5Or3oUlb/hIAQDe1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VUNtesbGSiDcmZNojBsKvKnYtux0W9Ub9dBEWYzknaFFF6VURXQPuI8X4sYpu1nPj
	 XvzS4DMFTxOhMmtvg1PU5VNGx5vWqVtv2SLLu6oEBWE41/0kppfaT6MD0YKSGIyl1I
	 ZOiMentRi0cyhKokc8qeJ1K59jUvKJzOhzvEB3mDTiqrj0ZWPn2BEYFwS1NiHxghb+
	 GtmHiK3RHywrq3bG9AuzF1TQNEyj1eC+efCjuhwWA/XjgylwlpztVYDv9P0loqfPkc
	 h3wHIXkVyEzkqfLHavlkyYXdkcBtZ7Te25E4wYLYo1a/O/kpjYhsVGD89EKodDq4RT
	 BPNxfhRYCZD/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D28380A944;
	Tue, 25 Nov 2025 15:24:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: lan966x: Fix the initialization of taprio
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176408427301.752950.13478162782457293955.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 15:24:33 +0000
References: <20251121061411.810571-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251121061411.810571-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Nov 2025 07:14:11 +0100 you wrote:
> To initialize the taprio block in lan966x, it is required to configure
> the register REVISIT_DLY. The purpose of this register is to set the
> delay before revisit the next gate and the value of this register depends
> on the system clock. The problem is that the we calculated wrong the value
> of the system clock period in picoseconds. The actual system clock is
> ~165.617754MHZ and this correspond to a period of 6038 pico seconds and
> not 15125 as currently set.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: lan966x: Fix the initialization of taprio
    https://git.kernel.org/netdev/net/c/9780f535f8e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



