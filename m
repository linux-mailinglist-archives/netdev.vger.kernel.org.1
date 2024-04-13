Return-Path: <netdev+bounces-87579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4A8A3A4E
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF882830E9
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC09DF60;
	Sat, 13 Apr 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki/hQ9I5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57AD52F
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973630; cv=none; b=G+K2+m3u1SjoT2WCbZ4A7zGsaBnGUex1O/ZhldbrJ44EhkhbwMcCLrsPsmZNzMIWvl4WcAVjHE32dpAww2M72H/ubfXMNRXUkKtArMgjoMtG9LW9eevER/RPSGHoNF3TLgwLhuKvSZjPPgQdty8hkNpFJ1mTQ9oYrSi8CV1zWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973630; c=relaxed/simple;
	bh=HBBxDrSGCn6rogKMmUY7bf5GM4J5AoRGGGdyBqNYZow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CTR1kYaR9IGD2pTqtZXnmo0V+3om8FY5YS16pQAX3LD227ZgqrWxNDNRoVS0gzkUUbCEmbwWdypGlLcOtuVb5WOIFO2yc3glP3gvI3wsiw7ruYVKMm89x3iA7fx7G5Krtl/FUNhSFxZxi8WBZus8edDDH1cGRtsVBBwq+uNsEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki/hQ9I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 079C7C2BD11;
	Sat, 13 Apr 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712973630;
	bh=HBBxDrSGCn6rogKMmUY7bf5GM4J5AoRGGGdyBqNYZow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ki/hQ9I5YvcBK+5EhLLntbLmxrOzCZlWMhsOKj6HXuOD0Alt1bbQXh8qg4zdrT/zR
	 Tjn4kdKPQe4IN7wPr8QVXRkIFRxVOw+BWcXg621DZrT6YN1dVaPqT2/KoB9X6KhWFB
	 QB80KIqCzzB0sQ+ZPxxwhtmSSljGCh6/ov/pmj1XAT7xQgdSrpcp8el87RpmCR1O5p
	 ByoLF0gPb+YAoOp3udIcVqBaDBbVJxqL+f6gt5clH0uxaeUHmBQaV/S9bRh4d8W9cf
	 enDSg6cd/RaESCu9SQ5EzNjPCMAv3YYru5jZBwFFJWsLibAZP3AiJpdGzY63IAtGvI
	 Wj95ZHMyuNmtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E613BC32751;
	Sat, 13 Apr 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ptp: Convert to platform remove callback
 returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297362993.26889.14036548461975979127.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:00:29 +0000
References: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, netdev@vger.kernel.org, kernel@pengutronix.de,
 yangbo.lu@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 09:34:49 +0200 you wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/ptp/ to not use
> struct platform_device::remove() any more. See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ptp: ptp_clockmatrix: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/32080ec2db65
  - [net-next,2/5] ptp: ptp_dte: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/5c025082f8bc
  - [net-next,3/5] ptp: ptp_idt82p33: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/740c031861a7
  - [net-next,4/5] ptp: ptp_ines: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/cff5236946b7
  - [net-next,5/5] ptp: ptp_qoriq: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/145473b2950a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



