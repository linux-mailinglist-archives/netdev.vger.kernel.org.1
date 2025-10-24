Return-Path: <netdev+bounces-232644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50845C078B4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B319A727B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995F343D93;
	Fri, 24 Oct 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duBXUyKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4C76026;
	Fri, 24 Oct 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327028; cv=none; b=WNoqj75RsKgOw2NUooxKm1PcaZodm0pIPAQgH185meIPS8rUP9TclPWKV+YFty/ZMU3MDGkxK4k5hgPQ6KQiD96YybTY1N0lFytrvSIR+0txAIhe2JN7WgsMJeiHll0O9DvVTLeTR9VgU+yA6mz4SSPExYCJAqOCpzZUR06dKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327028; c=relaxed/simple;
	bh=srsHMANt5Lk/UaQ7m5DJ4Z4en71AEbC71W6CSZjih38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gr7g5g6K+1b3P8fb4Q6SbR8Hsf+OG8aJwTAngx32SrPfuBgNHEaf5NRyxuQWLdm0JhCnRqLh8ju+gvpmss0M7EDtOnSUMqlv+/zsznu6rkpMNeGdteODfwIWUD1XaogJZPsHw54DU+5OJ+igk2sx4PKGDQbypipLolKxam3O968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duBXUyKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C20C4CEF1;
	Fri, 24 Oct 2025 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761327026;
	bh=srsHMANt5Lk/UaQ7m5DJ4Z4en71AEbC71W6CSZjih38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=duBXUyKiWqIYFbG9OikTq2XGFolLTL1gvY3rGyNfr/yFroYIrSgY33+1eKUBq3JIb
	 Y2cJqqoVEuRrvCfzTo0fsNeQf/yWkrKsIggljYxOpkseixlpQ5gN/vKJEMKbRfWlJt
	 /OChc+XrxyXpaOCrQYp717hPtHRcYpOhjFMcpLaTx4Q5vBXjTD+IZ5c1/2dpubh348
	 iFdD2p+qKJMllZUg5Bllq7UL+kKDZA355GFsA8p3c0Rbpvroto3zwHGmUMFA7Sxgm5
	 H6dv7G3qP1WFRn5Yx3VRUeQ4ndhDYtdOBMgvtmDzCf/0b/44mijvaBzbW1aqa5JrAC
	 9KflvqB5OeHmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC5380AA4A;
	Fri, 24 Oct 2025 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT
 schema
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176132700625.4002741.4029402760245569227.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 17:30:06 +0000
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
In-Reply-To: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 conor+dt@kernel.org, davem@davemloft.net, edumazet@google.com,
 krzk+dt@kernel.org, kuba@kernel.org, luiz.dentz@gmail.com, pabeni@redhat.com,
 robh@kernel.org, devicetree@vger.kernel.org, kernel@collabora.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Oct 2025 15:33:20 -0300 you wrote:
> Convert the existing text-based DT bindings for Marvell 8897/8997
> (sd8897/sd8997) bluetooth devices controller to a DT schema.
> 
> While here, bindings for "usb1286,204e" (USB interface) are dropped from
> the DT   schema definition as these are currently documented in file [0].
> 
> [0] Documentation/devicetree/bindings/net/btusb.txt
> 
> [...]

Here is the summary with links:
  - [v3] dt-bindings: net: Convert Marvell 8897/8997 bindings to DT schema
    https://git.kernel.org/bluetooth/bluetooth-next/c/f63037a3f252

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



