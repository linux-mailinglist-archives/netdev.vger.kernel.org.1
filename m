Return-Path: <netdev+bounces-78595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23188875D65
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E29283B5A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18339ACA;
	Fri,  8 Mar 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpXzh3I6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4002E84F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=aQUgjvIcYFcRh4WiYvqJv7ynPmE/g7Rf3AgU1fQZEeJQz9rB+V8XqhjMglr9sWPlVgljsjqd+LwxzNyqAwM/JVTCtg/WX/q0tfEMX/9VU0rQ8LmanKH2jO8mHmrrgoBim67DhTarN7JcoZvjMitFcYIb3sKd0sYh4t1xCVaSb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=xTT+emKsesJcU6HA9qrRHPKpGD+zA7nSNy5WZkeB0jY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LhJE2nD3sOMR0Xqby+zUrA5veM/QshJVkI0RoJ6zPYJ012WFTUH5Wl1LC9/Anfdm1xoyeM7i/31Qy/qOepO3qMMZkO3ffkCjr7KWT5eUKWOydLGvYr3N2to7HNef4CtMQrJx9FBx03FFXT86H3GAdTeQm6C26rzskr8hw61Jtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpXzh3I6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C198C43601;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=xTT+emKsesJcU6HA9qrRHPKpGD+zA7nSNy5WZkeB0jY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OpXzh3I6Yl0orDS2fMWIMjk6h7fCcRPZ6GzNn8d22xGXGrpNStoXCLt17JXY3f76Z
	 sUEeDmvJueftkySQr9Yn9f5Nx9ANzlTihzf6Qhz3XEBWMS/BKrVOxXfFtxEn30nJx6
	 jTcskPWcZUojrPbXcAmVfzwD2hEVuk+1GKtEXubVkk+sZkOxnFUjW53+DkJfUEF3oR
	 ZORKN6h0gyVuTLeNv0ez+uWEwEpW6PhjXbBsj3yFB5XlIKaxvKw8aON4QhjJ0ZU+Up
	 UPeAcvvDKdgS08XffutmX8frt6svb9q6QZR3+oCZc+bl7FUJ4pDBgMlLUyTsEQHQhc
	 xAqLA8WqcsHjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74942D84BDD;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next] atm: fore200e: Convert to platform remove callback
 returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403747.8362.14857085429688372577.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306212344.97985-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240306212344.97985-2-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, kernel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 22:23:44 +0100 you wrote:
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
  - [next] atm: fore200e: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/c12264d3fd23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



