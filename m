Return-Path: <netdev+bounces-251130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE717D3AC19
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A91B13053B9B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA838A70C;
	Mon, 19 Jan 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPqZ9IPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BF37E310;
	Mon, 19 Jan 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832589; cv=none; b=J6S/AZ7uv7LFrjgHiRIM8UgT8KWkYW0lUeeo1tzLQHBsaV2i26G50RSaNHkidMqfAn3g1n8Fvh8k8jUlZ2WBt6eSfmeQu1LYEABuPq8YuwjTsPIKsdZbCBaOBHaSqws+vJNN4k/X5cn3ZgLAtawKlrYn8cbD+prHWohInZUT+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832589; c=relaxed/simple;
	bh=LJjLnN6amfNiPTJ+6xJqaY/dxPRnWRtRyXDuhcLzBzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CyO8qVAgSTlngO/7YAFLu6k4/uuql6urVlCUs5ofNGA0iHRWbepN037sJHTv7JacvZm6Q/XrUxy3hVkJAQd1rBLEFchWCsDb+WXEwk8t6614W2QpgKDJVXESLVT3t0GMq7sX4z4qRDqKl28oT34zeXBWELyUsJHFclJmlWEXaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPqZ9IPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3811C19423;
	Mon, 19 Jan 2026 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832589;
	bh=LJjLnN6amfNiPTJ+6xJqaY/dxPRnWRtRyXDuhcLzBzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uPqZ9IPObY9iR0mrzkaUt+LQ1bIX5B72FelCBk4UNy7DhODyn0BsAXhWaXZc6PIYl
	 OLxjwKo5YgUn1/B9Q+PSr1ugS7noRaObpcUEA0E2xKsdDirWP9kjknF9gi0QmBSuBa
	 BORTJ3PKBgpMzQPyc5NivReIwkMX5sffp6Z+eyc07EGPQ+LQ2QNFa+RZc3XeP0WTqA
	 uYsCbTzZnT0c62q3gDsPAdOWA40GYPDCXdD61jOmRHdy9TM4N7/GgoVj1CfWIRdtfC
	 vTkBmby1TWr6QC09OW2hqsyDXcr2rFtusIVoe2OHFs0mEyGkKI9RKsQlbPtbqFDZgd
	 K8Q9KqwYVsipw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B803A55FAF;
	Mon, 19 Jan 2026 14:19:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent
 MII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883237855.1426077.10049516839695920541.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:38 +0000
References: <20260113040649.54248-1-enelsonmoore@gmail.com>
In-Reply-To: <20260113040649.54248-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 20:06:38 -0800 you wrote:
> This device does not have a MII, even though the driver
> contains code to drive one (because it originated as a copy of the
> dm9601 driver). It also only supports 10Mbps half-duplex
> operation (the DM9601 registers to set the speed/duplex mode
> are read-only). Remove all MII-related code and implement
> sr9700_get_link_ksettings which returns hardcoded correct
> information for the link speed and duplex mode. Also add
> announcement of the link status like many other Ethernet
> drivers have.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: sr9700: remove code to drive nonexistent MII
    https://git.kernel.org/netdev/net-next/c/171e8ed48276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



