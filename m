Return-Path: <netdev+bounces-199637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E1AE105E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 02:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0F317FC82
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EE1C36;
	Fri, 20 Jun 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HixbY1oq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55890EC4;
	Fri, 20 Jun 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750379379; cv=none; b=NRxl+f5F2Z1bAOpAhsZwtqd7l9TMqlJpJDOeLMM+G4VrPDa4gFAnDHZw35BzB+VTO0/JSz0d+g0cIvrFJBf/v/9ICDAdmHfRvHh89ulQbKQPBvcjOL0TIJH+Mw0Vi2jxfQA2Pl3hqzPXr4POM/fBWVh4TOAal7wvowxXZ5jzlMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750379379; c=relaxed/simple;
	bh=N/gX/lWCEFFVFMQQ7VNG4vFBfHvEobL5B9N1XSTxf4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GsrHH0SFrrL5KrO3JaVsgKaMueN1xo6JMOeV1mIYke1X//pN+m3re96JftBGRoxKPLnsNJt4sePsUcCqxtAA4siRlKUCyMZV2CDGo7zCXMm66zIVRutpJmS+ibEgclHzFIQXMAIjYA15OwotRqlmSqmGeY1NVJd/PFNy7hqC/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HixbY1oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED43C4CEEA;
	Fri, 20 Jun 2025 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750379378;
	bh=N/gX/lWCEFFVFMQQ7VNG4vFBfHvEobL5B9N1XSTxf4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HixbY1oqNPcCqNjxGWpm4tvHipUmhS0SLjJZ05lfdwT4b4aq3PJPaa49yyqUgzEeo
	 rGg5Fcpb7pOstveHIE1L/BW/suhRF047nDzkNuFDU7c5BgxkDNhYspBP9tdjpkMP3O
	 1Q8a6UUijaYShbxgpsQvA7xl+S1+qR8MCqyHMlfGp5rIoP3Y328m2rKwenE5UrGn/v
	 OE0jqAa4Gx+Feiv3qikzUt85pzRlit2MfjDkzpjsgCW04DKntqBJX3y9qmpuung4QC
	 rnpSow2TDGkjFRNA/yvpdUQSgju14xQ4EYnSov2vgVgrAl356pdwqNR4X5xNM5xeYF
	 vtbhnL8bfIuPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE538111DD;
	Fri, 20 Jun 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ti: icssg-prueth: Add prp offload
 support to
 ICSSG driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037940675.1029963.6639645780461563048.git-patchwork-notify@kernel.org>
Date: Fri, 20 Jun 2025 00:30:06 +0000
References: <20250618175536.430568-1-h-mittal1@ti.com>
In-Reply-To: <20250618175536.430568-1-h-mittal1@ti.com>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org, danishanwar@ti.com, m-malladi@ti.com,
 pratheesh@ti.com, prajith@ti.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Jun 2025 23:25:36 +0530 you wrote:
> Add support for ICSSG PRP mode which supports offloading of:
>  - Packet duplication and PRP trailer insertion
>  - Packet duplicate discard and PRP trailer removal
> 
> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
> ---
> v3-v2:
> - Addresses comment to fix structure documentation
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ti: icssg-prueth: Add prp offload support to ICSSG driver
    https://git.kernel.org/netdev/net-next/c/83010fd9225b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



