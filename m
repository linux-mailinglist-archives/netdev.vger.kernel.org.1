Return-Path: <netdev+bounces-251128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B1D3ABD9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C72300E62B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842DC38B98B;
	Mon, 19 Jan 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnT13sNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091837F0EC;
	Mon, 19 Jan 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832586; cv=none; b=q/ax1m0TLOm1kilGnY/gkMzQvLo7RkE/JjzcvOijbBRsje0P/j/I5TJnP1kCMCstHyS3AX6AiRxvlB1/8YH+Kr7hl9X9wBpjkCwpvKMKGE3BozrV8t2Vn19s8LtulimkH7g4rt2eM9fBnaYcdreiJvLH6ivF9o1WolkIX7b4Rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832586; c=relaxed/simple;
	bh=ZYiZ725tfFyrW20mX2KvJ82kGFOCy/TZaBcAEBaIHWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eccXkFzTHmFarvmxAvSepTctPPGJFjE+5RZd8dDhqE8RYdJJbsLl02D9RHehqqX2LEdH2YOv7D5H8w5L3zbmCWQSbEcnf8VLLNZtRzEGTp7MJp5V8kFpIyckvx+GmaO6daCD/rjPVU/m6XPgVvm5E/Wd3k5I0xZgzmiHLsAB++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnT13sNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F03C116C6;
	Mon, 19 Jan 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832586;
	bh=ZYiZ725tfFyrW20mX2KvJ82kGFOCy/TZaBcAEBaIHWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LnT13sNOcWqWByS5RO0YGVt82nVbnP+wZsG/aCjXeI1ioMhc5oyvrLjGPE1vYaTqu
	 heNtwwIfy4laWbagrtQcd5TZEsIFp8i+Ca+uXIeQWvhLepq+Cvcp1ejCOS0cyd6cx/
	 wA6aWGLSVlGogcSL4Qnt1wJDM9yqDKU8rg7oI8AAlkYP9fQ4eODybk7h2EdheUhIjv
	 XetPvntEXzBcdhL4s/oTJXtqHUnTxoXUF6gO4POG19hC0tAbz9RXclGujbjgdRSTAz
	 F7nq8n4RO/CYBxroemd8HeVNURTZB57g95Zm8J/rHGnCd56zYm8J7PjW2h8I6rzr7n
	 B8ijRgEeyO/9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2DCA3A55FAF;
	Mon, 19 Jan 2026 14:19:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2] docs: tls: Enhance TLS resync async process
 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883237568.1426077.9228549068251064160.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:35 +0000
References: <1768298883-1602599-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1768298883-1602599-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mbloch@nvidia.com, gal@nvidia.com,
 bagasdotme@gmail.com, sd@queasysnail.net, shshitrit@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 12:08:03 +0200 you wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Expand the tls-offload.rst documentation to provide a more detailed
> explanation of the asynchronous resync process, including the role
> of struct tls_offload_resync_async in managing resync requests on
> the kernel side.
> 
> [...]

Here is the summary with links:
  - [net-next,V2] docs: tls: Enhance TLS resync async process documentation
    https://git.kernel.org/netdev/net-next/c/8fc807104125

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



