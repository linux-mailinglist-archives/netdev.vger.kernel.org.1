Return-Path: <netdev+bounces-154608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25109FEC54
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 03:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5E13A2899
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41AE22071;
	Tue, 31 Dec 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmAgziRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874F2F2D;
	Tue, 31 Dec 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611010; cv=none; b=uBvXA4sIboExdwNEFcEMf4lx6GCMHwEeeejuo0XUTYgaLmDciu4Gf5Aufgzt+57pj1Nx1/2wSgBVv1lgZ9GJoD0Q6wF4ge6QlrsX9B+zMp9xiVGe8NT6r+k4A5xA8WzNmdw956Hv9f41UCJmzpTH4fGJ763WJJ6qMgsIvIp6Yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611010; c=relaxed/simple;
	bh=0F/Ey6sDOLeF9xiGTpkg95bQ5kIhcbZarDJpOn2pIQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PobRd82SHbxWA0ya0UvdA3J3GYeXGyGYq9UOaBYK4MLEtuawA3+c6/dDfOKqiE6RfywNiOn7dPVbgZSYKwDhoUdM/JeOAa8uLUq2F9BzDiGlsaeFPLr8EITBq2XpwquB+t4dSCTTml/5gJnUroMZLLrZJoziPWxBVjGZZ0jppDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmAgziRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CBBC4CED0;
	Tue, 31 Dec 2024 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735611010;
	bh=0F/Ey6sDOLeF9xiGTpkg95bQ5kIhcbZarDJpOn2pIQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SmAgziRemSr8JNdJ+I6vo4FGRpoNloxNykHv9R6Eog1eexY0ZUHZz08qTIyxTOyoX
	 zkSFh+3Kaf3tsRGbBh1St3BG5t6dWeCprdzUZGP27xRTppY757O9D+bkIOxltmztoo
	 RceghsSE57yO10e5qXBI6P2tqpx8EF4P2JPt/oWTvqcBe2K9h3IJ6K4ROJulFwo46T
	 ve0Q51w16z9rrDKCna94a+9ZufIGFHM8JOlYmYmPzHIvwraDPaJKveeaIuDYayhuC3
	 x3KYNPYWLP7wEGkNHZo2dUFnVcFx1r4BAcs15ofeYe0x1c1EtKyTHiUH+am8kIvtRg
	 PJnYkdrV8s91A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFA380A964;
	Tue, 31 Dec 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sky2: Add device ID 11ab:4373 for Marvell 88E8075
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173561103026.1487469.3921887647919479854.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 02:10:30 +0000
References: <10165a62-99fb-4be6-8c64-84afd6234085@plouf.fr.eu.org>
In-Reply-To: <10165a62-99fb-4be6-8c64-84afd6234085@plouf.fr.eu.org>
To: Pascal Hambourg <pascal@plouf.fr.eu.org>
Cc: netdev@vger.kernel.org, mlindner@marvell.com, stephen@networkplumber.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Dec 2024 17:44:01 +0100 you wrote:
> A Marvell 88E8075 ethernet controller has this device ID instead of
> 11ab:4370 and works fine with the sky2 driver.
> 
> Signed-off-by: Pascal Hambourg <pascal@plouf.fr.eu.org>
> Cc: stable@vger.kernel.org
> ---
> On a laptop with such ethernet controller, the ethernet interface works
> fine after running the following commands:
> 
> [...]

Here is the summary with links:
  - sky2: Add device ID 11ab:4373 for Marvell 88E8075
    https://git.kernel.org/netdev/net/c/03c8d0af2e40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



