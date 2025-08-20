Return-Path: <netdev+bounces-215132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0011FB2D26E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA13AC334
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6422BEC23;
	Wed, 20 Aug 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ9ISqtL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB5298CBB;
	Wed, 20 Aug 2025 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659478; cv=none; b=HV1uC2YbSF04iIW3vcrnoy3yh70dK4BSAP7D6LcVlt5eWIx1RMCqt1GAuQylVvziLgV+qi1gSoSn6KnXmnCfSV5hbVJwxZqpg/Tn8V5Lx4F94XeqWs/VHdEDlcpZpDUoMyXEuOVxq++wFehOqBwL9bPoUC9AQAHRsCDmSmfutZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659478; c=relaxed/simple;
	bh=apgHJw2Ugi5MtNdY9jHJ3EZssORy93FCSZfy05ieiw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=We65ZErKkyvS/kmc5RlxdHpsPujV/wmWzEcro2lb+Ejq/UXY93Lodb09jrXslC1QPnui3RYPX3oSEtMH9HOiYgEDag+nk6uHYIvwA32WilPD3Y/tG8Fgq2w6rszGx/bHJG/3Tk5GKv4z8JtxC9xFqnmGWJgSx7s8lRwDs+Y/u7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ9ISqtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8E6C4CEF4;
	Wed, 20 Aug 2025 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659477;
	bh=apgHJw2Ugi5MtNdY9jHJ3EZssORy93FCSZfy05ieiw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aJ9ISqtLsgKnYm8v0RiOoNI2411hNe5kY3bAjoTHTjmS1k1KOEW3XrG1bmksLzJiE
	 AVek1D27+2HrLiHeaeKH5CQuYp9qI8yAptbOkLtV9pfFbbevGcIiWOdLwEQMFe5f04
	 yUMEaC3fLtGxDi5F+F8Q/vTGcew4zSSjm0NZSCU8ecvOO0e8CkYpUEmphuF5n3B09b
	 ASYOSLbrK+Qn88qIThIxei6UuBNasaXKCo6sffXfVfd4UC5sO437vr9J9hA2SdzTHb
	 1QxYaF3bmwDwzsIKFrIkDao2NIjcc9RbNy40nS+NUwMAAuPwQjTtSFsIOD/k1PdgpB
	 k1bh4sTJZaQZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF4383BF58;
	Wed, 20 Aug 2025 03:11:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] Fixes on the Microchip's LAN865x driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948724.3753798.7869341328702391528.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:27 +0000
References: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, parthiban.veerasooran@microchip.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 11:35:12 +0530 you wrote:
> This patch series includes two bug fixes for the LAN865x Ethernet MAC-PHY
> driver:
> 
> 1. Fix missing transmit queue restart on device reopen
>    This patch addresses an issue where the transmit queue is not restarted
>    when the network interface is brought back up after being taken down
>    (e.g., via ip or ifconfig). As a result, packet transmission hangs
>    after the first down/up cycle. The fix ensures netif_start_queue() is
>    explicitly called in lan865x_net_open() to properly restart the queue
>    on every reopen.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] microchip: lan865x: fix missing netif_start_queue() call on device open
    https://git.kernel.org/netdev/net/c/1683fd1b2fa7
  - [net,v2,2/2] microchip: lan865x: fix missing Timer Increment config for Rev.B0/B1
    https://git.kernel.org/netdev/net/c/2cd58fec912a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



