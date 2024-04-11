Return-Path: <netdev+bounces-86819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E5E8A060C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B7D1C22B5E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289313B288;
	Thu, 11 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBQwymop"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE386256
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803229; cv=none; b=WaawG0F3th/gY9UUo44o0ZtNn011A2UadmTLYyajJbHyStzlVt8JSqLhGhkwwFksbAdOCPDH3ax9+MnvjgftHDn8djxENhRFr4Ax7DbhenvjgjKSpnQ9pJpAxaWbKrTpxb3uVf2pZHJDDEZ9ytbLSu5t1BC5AjFy2Pze/NnXK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803229; c=relaxed/simple;
	bh=Zmk1fk70Hqu5bNMkAwUutOzHTLESrot20KQz6j4g7Wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PvMqAbth6IBaEhAmeTTh4NDMOB8DFKYF0kJ0/yQqTNk2RUWc0MyO4BRFt+dOHzeeYw/Hx81U7IEIMzAPjPQMQ9SrLRo91xfHPmpzzwVhShPOi1KCp/Fvcg/CWo8VEMm1uFhxh4rjYOA2a16slEWCxfMG5lcSeofWvTMHM0TmKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBQwymop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77201C433C7;
	Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712803228;
	bh=Zmk1fk70Hqu5bNMkAwUutOzHTLESrot20KQz6j4g7Wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CBQwymop1NuQqMI2sUsffEk0jvsHjzsJsMfqKvAvN1VJ7vWGsI+vbyndwP2eAdfzx
	 NIk3/pYQ1icJIH84HPo7L8s0zJ2TEfPBJ+cdDgB7Bos3n3Jxqx8G7bkpqi9XTd2/Br
	 fpRcPISV1tu15K2mgCf4Uexu4e53B/P2ri0Ju5ZvHTI0Kl+eGhwbhYS9UhqJubb3Ip
	 LViONdW5U5kPtuQSfX0Qbown6LuNfippQC0mcIzw30VFb3pUGmDSE+gS7CtWTsCewr
	 vzcp1hvpt5oDFWQaucm+jH3KbylH2vVHoKd5fuh+dwuPczUpvRDSfW6Dji4s0EJYzJ
	 /HUkCNMLqO+PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68382D6030E;
	Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wan: fsl_qmc_hdlc: Convert to platform remove
 callback returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280322842.23404.11616120911781131170.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:40:28 +0000
References: <20240409091203.39062-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240409091203.39062-2-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: herve.codina@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andriy.shevchenko@linux.intel.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 11:12:04 +0200 you wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Here is the summary with links:
  - [net-next] net: wan: fsl_qmc_hdlc: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/07409cf72844

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



