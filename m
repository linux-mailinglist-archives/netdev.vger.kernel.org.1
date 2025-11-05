Return-Path: <netdev+bounces-235685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C0C33B9B
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA461897869
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2020F08C;
	Wed,  5 Nov 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIb7afxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157371F5435
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308040; cv=none; b=Rb3ZUTW8SgAN1Q0WaWlR2e6zOnOVsSDiQRameuoGY7f1qD/uKU6wiHt0Ll4OX+9hu96xUbkf8oqmTZBpDsAgfyDriYyPWf9Ac5D3FTUzIqxzIzh4qRSNoNn3cU47RRw3lLiaO9bNx52GAeBbJVEMHnOeIamXq7/U1NKS2diMce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308040; c=relaxed/simple;
	bh=RX3ZvKbnzqatsB+1JNX6VtLEHq7v8KvfV5ThlftqE4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HpWtSxcY8PudYykmTE4AdEqDo7XRZmZPhhF0IbgjFop4lfKyo7dvJD2CcE9F1DugAaIJSkd8hBKuVlu2ILScC0MmKdSbvgD0QbWFWozXj1jQmdWaHmDVNwm3z1WbAemqSTMaTvSo6kGy6M/o4zshdb6upsgJbRqv4Xz4Wnp2d5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIb7afxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A775BC4CEF7;
	Wed,  5 Nov 2025 02:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762308039;
	bh=RX3ZvKbnzqatsB+1JNX6VtLEHq7v8KvfV5ThlftqE4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nIb7afxgeDwpXayPhN7HvZU+eIqdHgCPBSiHg8mZSIJTLZOigviRIB+xNFv/fC2Yt
	 SUZrKlNgHznc36Gz7XSfrYi2pHjLTrh/XPkMwmc1OEmIfj1bNpfQV1sJs6r2R7QlW2
	 OOgYnHMaaSQkNB7sWiSqbw2D8/hyQlEPGWMhkY+/Fpnd0WekT+qjbhck+2+QJ358sy
	 YsCQW52pQ7dFIApzf3x/+YcA6KxPcgExZ5b1UUpOSnhoGooK7F0qexLrAUAgoyJEW9
	 Uf3NDx4+kaGvGU/38Z8DjM5xAQhQ56QOgBREZy8gc/zTcbg/L2BLXr2JISRq56NtGm
	 bzdgkC9m2Kd5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD39380AA57;
	Wed,  5 Nov 2025 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ti: netcp: convert to ndo_hwtstamp callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230801349.3058815.8002127925280609699.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 02:00:13 +0000
References: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kory.maincent@bootlin.com, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 17:29:02 +0000 you wrote:
> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
> callbacks. The logic is slightly changed, because I believe the original
> logic was not really correct. Config reading part is using the very
> first module to get the configuration instead of iterating over all of
> them and keep the last one as the configuration is supposed to be identical
> for all modules. HW timestamp config set path is now trying to configure
> all modules, but in case of error from one module it adds extack
> message. This way the configuration will be as synchronized as possible.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ti: netcp: convert to ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/3f02b8272557

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



