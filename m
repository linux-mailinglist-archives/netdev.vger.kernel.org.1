Return-Path: <netdev+bounces-187274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9955AA6028
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712BE9A4C8D
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D71F237E;
	Thu,  1 May 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr8gdcXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220252E401;
	Thu,  1 May 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110396; cv=none; b=aYo+TL4yfgV+neuQz0NZEH6TolLeo/M+CLWW4j7eNYYTUbtR5iolTf6BkpT+AzfK/f2pgEq5PO5afJponXZBqXPgit8CShrjT+EOoCEqEaO2QAcSaxZ2gwDUhpX8728G4+BHOcXDVXs166xLdNen+737jNHNBW08bkEBsVeHPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110396; c=relaxed/simple;
	bh=ebq6ZQKy0bz52JluprLeqgvaVWccGrWculDohvzKkpc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LAJvZphguSwFBjoqyLgFBqHyp94EMpSRrTXiJqd9WbaQLAzDJdvrTmA2UyhjzSMkozfByeUUTIIhmBZ8quJxc0Em+AzPgTXcijbFzpN5AvHDNwiDFA+D4gcO57zOaoCp85O784t41waI8ZA1jDWBpZOhErGniHnoQeORAGZgjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr8gdcXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E77DC4CEE3;
	Thu,  1 May 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746110395;
	bh=ebq6ZQKy0bz52JluprLeqgvaVWccGrWculDohvzKkpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lr8gdcXrPoek+R87kCKiwBX5fT+vBi5ug9yygm2pCurK/yef9aNVJq/rKmflqN+G2
	 5KI5TkENt4SZCau/OnVBQFOSXlkCQzrOGRDEjBFdThIVQLHTYCSPDxS9yqnS1ucvKQ
	 IKrmwZ9mWRPoPWk1N27FUZlyG08WmyjDhhDgU3EmY+lbeDgiJt3QYY7f4vcYyn0iqV
	 vhJobYCdRJayT6PlnzvJi81WCEBWuJvjTOwqaKDAyS8QsP9ZAGQVS826GUHvzub/Zy
	 2DWdv/t5n3oekD6QUTHGQ0dkVlpq/8tkAGKzIZku0c2wpimvBJxXjBkepCtc3QIyve
	 KeYCeQFsM2Hkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6FA3822D59;
	Thu,  1 May 2025 14:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/4] net: vertexcom: mse102x: Fix RX handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174611043465.2998093.14745156096722266784.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:40:34 +0000
References: <20250430133043.7722-1-wahrenst@gmx.net>
In-Reply-To: <20250430133043.7722-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 15:30:39 +0200 you wrote:
> This series is the first part of two series for the Vertexcom driver.
> It contains substantial fixes for the RX handling of the Vertexcom MSE102x.
> 
> Changes in V2:
> - clarify cover letter
> - add footnote to Patch 1
> - postpone DT binding changes to second series as suggested by Jakub K.
> 
> [...]

Here is the summary with links:
  - [net,V2,1/4] net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
    https://git.kernel.org/netdev/net/c/55f362885951
  - [net,V2,2/4] net: vertexcom: mse102x: Fix LEN_MASK
    https://git.kernel.org/netdev/net/c/74987089ec67
  - [net,V2,3/4] net: vertexcom: mse102x: Add range check for CMD_RTS
    https://git.kernel.org/netdev/net/c/d4dda902dac1
  - [net,V2,4/4] net: vertexcom: mse102x: Fix RX error handling
    https://git.kernel.org/netdev/net/c/ee512922ddd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



