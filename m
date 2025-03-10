Return-Path: <netdev+bounces-173646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DDA5A51A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8723F172D8A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6591DEFF1;
	Mon, 10 Mar 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQujvZkA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E11DEFE6;
	Mon, 10 Mar 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639202; cv=none; b=Plfv4wgxjwB/CpOHV54WZCXcYW2AxofkfQAy1iZZxmkOT1DO6Q3L+5urftCtDJEFid2qbiYHrOSw4rnyxu3kMDV76Ksyxi0mjFaCEHM7sa6C+IDAOyTBJ1jvLuAiO+A/JBrXOhvc9k+IamQ/YE7BYI2QMdA5Sq3ORYMc9ASaJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639202; c=relaxed/simple;
	bh=tdk2dCIGvUnKdjJ5ZItXwklmt/f9bTd+FdT3BpHn/lM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lneiniFExIM6hPjk0Dp6Jw2yXutaFzz/OWihqZocupl0P+6vkLqAw/6kyd8HjXA7+rSMpkpcmxa4r4N6Zzq+QxZIZJZz9+k3/6f/5jGRueLxokF7bkwNpNsMop927Mdt+fAuFkg10ee3ga4Cu8Q7hOcuhaKcQkXaiIH7UQ9TTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQujvZkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFABC4CEEE;
	Mon, 10 Mar 2025 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639201;
	bh=tdk2dCIGvUnKdjJ5ZItXwklmt/f9bTd+FdT3BpHn/lM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DQujvZkAXiry1kJFp/SoT6iPmuOZ4VL7YqdpmvsQtniaSItmk1r0CG8xcMdPRhB2m
	 nSw4NEB1YBlKdIGGzOG+O0ufXBOziNhkqTLpi558hHoiHVvVCnQAvlfw5t9oZFeuOg
	 01GBTdURwq0U2QmxaKtYbVi5/Dw56onDIlNi7RaVO2ww6GrPr+f89T34igJpvxvT9D
	 e/MOsML9CqIPrRSrbanZP6tHpvp0P+WhQqL7/bTOON9fUka54j5njcmyHoGBruNLRX
	 w0Hq5hN+ytu2XZQY8t1kAjmlRMKrUQHWt1FqTclvdGVnZBL8BRseD1/j1Ro0NJh1hy
	 59t6y081jCDpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB07A380AACB;
	Mon, 10 Mar 2025 20:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: usb: lan78xx: Sanitize return values of
 register read/write functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163923577.3688527.14538492385967527349.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:40:35 +0000
References: <20250307101223.3025632-1-o.rempel@pengutronix.de>
In-Reply-To: <20250307101223.3025632-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 broonie@kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 11:12:23 +0100 you wrote:
> usb_control_msg() returns the number of transferred bytes or a negative
> error code. The current implementation propagates the transferred byte
> count, which is unintended. This affects code paths that assume a
> boolean success/failure check, such as the EEPROM detection logic.
> 
> Fix this by ensuring lan78xx_read_reg() and lan78xx_write_reg() return
> only 0 on success and preserve negative error codes.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: usb: lan78xx: Sanitize return values of register read/write functions
    https://git.kernel.org/netdev/net/c/cfa693bf9d53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



