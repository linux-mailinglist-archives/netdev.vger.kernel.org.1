Return-Path: <netdev+bounces-148278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA9A9E0FB5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E101648FE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D651EDE;
	Tue,  3 Dec 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hisqccDB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCB370;
	Tue,  3 Dec 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185815; cv=none; b=rLNxq89JusJJ1cMF8vpL9DbvgnuYQziv28jlW3fldVEoMbJMT/uNjF0y/zu6cwguYq/bsm0LHlnQGNtWgBoiE7vHbjYYmUBXwa/t0whPDfk1le8GcLiMtNyA21zTKTGymRCGtJu6xILiK75XG/5hk4rPg1GNMM/ra3/UE0H18R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185815; c=relaxed/simple;
	bh=XmhgYk2x7GXJl2A5h4r9Cuq4mZXd4+wTyrcMFjA2fYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt0Bw9Xmml4QXMAcayaoI+qhOdAbG0bJ2JcmN74WzFDAzvvcp24h4C+pb3YZecwcHBQo6QS0WXLabVo7XOD4yeaS0U1wUPcEyyCRzdMmrHbUC3wqO99CzCvRMUl7SgaGG6fGt+4p+iZhgveeHJdeOzKUR1s/E+zGecWqqj5dgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hisqccDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D497BC4CED1;
	Tue,  3 Dec 2024 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733185814;
	bh=XmhgYk2x7GXJl2A5h4r9Cuq4mZXd4+wTyrcMFjA2fYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hisqccDBzdlw503kp2/yMWEQuElW7wbDwOU1b/q2XIZTZc7FeP7ex+cijj3An+KJB
	 HoTTrJRYsqCGq5yYASZkm93Zkkdy5am97lur0vwT2lBkB1e8Jy9dM7yXWZssXpOUKp
	 OOoAO3Pt4vXg9rBs2291IeWWSw4uMkgY2D/BUtYdmAfxW1xbd7ORD99aCr9NQPhpuj
	 0wmzl2+QIoYu5fwY3XvrnvRlw2wu7OAjVTnF5oxHVd9kDCxI4ZCzmS5yXvDEc0ErhB
	 7umUJNTGBniG1cyzRMBEtFLFMMj97NWFrrQG3zagxQjcsRb2wAw4cPE8ANzk58W1pQ
	 EKsSJMbMWE4tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342303806656;
	Tue,  3 Dec 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173318582905.3964978.17617943251785066504.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 00:30:29 +0000
References: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, yangbo.lu@nxp.com, dwmw2@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Nov 2024 15:53:49 +0100 you wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/ptp to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Here is the summary with links:
  - ptp: Switch back to struct platform_driver::remove()
    https://git.kernel.org/netdev/net-next/c/b32913a5609a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



