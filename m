Return-Path: <netdev+bounces-149952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703719E8317
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AA9165BD3
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69247EAF9;
	Sun,  8 Dec 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkyGLXTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7AC149
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623817; cv=none; b=XKFGUfPYp88nWjLCYrp4Rhbyr5qLeUUmZoqjM2geuieU+H6x1H0njdylfHWAYtL+O+lyQiyaTz8TG9yNom05ofVHZUWiHZ52NK5vkbPwwh8dTNqA3oSWBhf2K0/42RBsc8wk/k6NjgaOku9P7tS4F0DteJo6xy+QrucRdAj3yaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623817; c=relaxed/simple;
	bh=9C8lEUFw4aT11Yxr4WU9eR5nFduL+IWsu/cSCMLpnvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HrJ3axI0GUkbdNd31Sf6nvg1hlnMa67plfUNj8tSDn4o6faI3KpTOok4MlAER65Gskl8InRwbXLEksBW9dSdR1ZdTCFwLcg4np7ZP0z5MrkLWbzMxLvzQULX1yzk+WKc2/PkZ7IfqGc0r1sNqFYN1zJ6G3yKcazW8HO6GpOzVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkyGLXTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95B8C4CECD;
	Sun,  8 Dec 2024 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733623815;
	bh=9C8lEUFw4aT11Yxr4WU9eR5nFduL+IWsu/cSCMLpnvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VkyGLXTBiu6MOYgW4LrW8OXLDwQLw76UQEm3sqxfCY+qGNv2lbi78myJhRvFj9JaP
	 Q0/cto2OkTUVSYl8t6EAsB11mj8yHrNUDdry/6WjDciQlQxWWtlLQMeUkPhW10wOXW
	 LZsSyYC4MewvdIde+gYVKyOU9YrCBMj7FM6d51sDArMXm5cWk7PA9UBCisKJ/x6yzb
	 h/Bqa+53QEBphh9NvRlGw1q7u4PfzGG9mqp6/1fqY6IIUH0Fp9lvbT5x657w99EsCn
	 +pYJbwYtMD/eY4YGWp1s4mCNskNvrN0QGlb5ciZIRwcRWSJm583QYKHhTSKnqF0yOV
	 IdKI7oy7O+VNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA7380A95D;
	Sun,  8 Dec 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/5] Ocelot PTP fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362383100.3133782.13276065571353098430.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 02:10:31 +0000
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, horatiu.vultur@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 xiaoliang.yang_1@nxp.com, yangbo.lu@nxp.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Dec 2024 16:55:14 +0200 you wrote:
> This is another attempt at "net: mscc: ocelot: be resilient to loss of
> PTP packets during transmission".
> https://lore.kernel.org/netdev/20241203164755.16115-1-vladimir.oltean@nxp.com/
> 
> The central change is in patch 4/5. It recovers a port from a very
> reproducible condition where previously, it would become unable to take
> any hardware TX timestamp.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/5] net: mscc: ocelot: fix memory leak on ocelot_port_add_txtstamp_skb()
    https://git.kernel.org/netdev/net/c/4b01bec25bef
  - [v2,net,2/5] net: mscc: ocelot: improve handling of TX timestamp for unknown skb
    https://git.kernel.org/netdev/net/c/b6fba4b3f0be
  - [v2,net,3/5] net: mscc: ocelot: ocelot->ts_id_lock and ocelot_port->tx_skbs.lock are IRQ-safe
    https://git.kernel.org/netdev/net/c/0c53cdb95eb4
  - [v2,net,4/5] net: mscc: ocelot: be resilient to loss of PTP packets during transmission
    https://git.kernel.org/netdev/net/c/b454abfab525
  - [v2,net,5/5] net: mscc: ocelot: perform error cleanup in ocelot_hwstamp_set()
    https://git.kernel.org/netdev/net/c/43a4166349a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



