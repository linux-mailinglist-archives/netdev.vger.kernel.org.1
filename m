Return-Path: <netdev+bounces-229371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC95BDB4AA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627593AB057
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A7306B3F;
	Tue, 14 Oct 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHCyHCQg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4913002B4
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474426; cv=none; b=dnIbKjUlLswXlBKGCUI/v2Q9axsDe+/pc75DdpSpcdUnnzA9kNqUZ+uzMMM5GSTeFrovjfgP201mzUifm+3m8/yvtsLakc4oSuLiSGhVVLOqSbCjkQwuD5E2a6BkfOFWHo/YXV0qklFefg3gKslJWUWpn+6JTb9DpWKXTX9mo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474426; c=relaxed/simple;
	bh=9QkLlC+Nb0LBEuW7VXD1SAY4ymdM9LluOfk9Lz1/HBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D2Yw6DMtGgXHiroHcoccBeqtpwquAfffyUJvJr1+aIJjVlpSaXdcEfV5GZMfc1JT+IhXra7WE2tUQrle2/iP+SRCa6ncAS1I9fZOrlMYdn4YGHnE8BmXgclN77t6ogwq7Hm7Y8Nj5TLpLy1uaG2CG4h1SbPY+EnkFzi4l/s6cJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHCyHCQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446FFC4CEF9;
	Tue, 14 Oct 2025 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474426;
	bh=9QkLlC+Nb0LBEuW7VXD1SAY4ymdM9LluOfk9Lz1/HBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GHCyHCQgMpV+mY4+xLPC4f/bf3I8RpZsW6T3diymSKAuvHsejdLXWQMYZjmx5ER53
	 vRBLbewMC94RgGhg9gwlffARf3O86+0Q0fs9cSbZKy9YSwFsRJ6tqL+16cEIMNsgYQ
	 /FCKelJY5OsXS7UQ7RkSl5HQiXjQCo0B6iu+1rRwja4mWlCwh0Bd+ajkSpwP6ywQln
	 XcihvPKvqORsku6OsFFFaWHh5lvlDA6koBDqMDAzgKEi4ploeoiYN3fWm5dWNAQuMe
	 kMqNeY36hTcTutWwgQmzOySdQqAC4ON01bcGExDaraVZ/DYE+fXfnO2Gare3jwH23K
	 mkPIpZP5r4iqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1E380AAF2;
	Tue, 14 Oct 2025 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: fix various typos in comments and
 strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176047441124.88862.16877271048486843753.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 20:40:11 +0000
References: <20251013160507.768820-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251013160507.768820-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kernel-team@meta.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 09:05:02 -0700 you wrote:
> Fix several minor typos and grammatical errors in comments and log
> (in fbnic firmware, PCI, and time modules)
> 
> Changes include:
>  - "cordeump" -> "coredump"
>  - "of" -> "off" in RPC config comment
>  - "healty" -> "healthy" in firmware heartbeat comment
>  - "Firmware crashed detected!" -> "Firmware crash detected!"
>  - "The could be caused" -> "This could be caused"
>  - "lockng" -> "locking" in fbnic_time.c
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: fix various typos in comments and strings
    https://git.kernel.org/netdev/net-next/c/e0aa11527139

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



