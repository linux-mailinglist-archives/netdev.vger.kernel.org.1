Return-Path: <netdev+bounces-20617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838737603E2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CF51C20CD2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB181861;
	Tue, 25 Jul 2023 00:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C864A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D06C433CB;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690244421;
	bh=c+BzqUQbiiMX/ltbMk+0YwPg8Ke15f2UHcVMv7m/L4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E0IGGztj+9WgtRiHrzWo4cwHArx9vVqFr+RTqChJwPEb7c1/nbTCSXN33kgQf1zJ6
	 5Hhg6H5revqSUXvYRxcDVjNICA4YqeBPHhgLlqUcj0+Yw9l0eOOlmXZxjeVWnSFiJW
	 J6hQTjrVUB8NgUId6qbQmkj+iY9n0EZlkEpIeeDy3P6WRZVuFZj9bj8hjBU+nfsgC4
	 5ALMK+IgrMhw7v47Q9XzDB5cCSGoKhejIACIE+LRIixm5MCftFAYWVmvVh1xmaJgem
	 sDlWv6RHMcshFSxNWKLUaVHsbbE3cRc8Y2d2UBkz8Eic/QguqGUQyZAUQjBjtQKkmk
	 AlHmaBbHiuf8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EF1BE21EE0;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: gs_usb: gs_can_close(): add missing set of CAN
 state to CAN_STATE_STOPPED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024442105.15014.10559557791748669718.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 00:20:21 +0000
References: <20230724150141.766047-2-mkl@pengutronix.de>
In-Reply-To: <20230724150141.766047-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon, 24 Jul 2023 17:01:40 +0200 you wrote:
> After an initial link up the CAN device is in ERROR-ACTIVE mode. Due
> to a missing CAN_STATE_STOPPED in gs_can_close() it doesn't change to
> STOPPED after a link down:
> 
> | ip link set dev can0 up
> | ip link set dev can0 down
> | ip --details link show can0
> | 13: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
> |     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
> |     can state ERROR-ACTIVE restart-ms 1000
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED
    https://git.kernel.org/netdev/net/c/f8a2da6ec241
  - [net,2/2] can: raw: fix lockdep issue in raw_release()
    https://git.kernel.org/netdev/net/c/11c9027c983e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



