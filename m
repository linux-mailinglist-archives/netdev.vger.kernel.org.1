Return-Path: <netdev+bounces-166648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC9A36BE8
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 05:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEB01896B90
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E915CD41;
	Sat, 15 Feb 2025 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3U78jqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682A21345
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592018; cv=none; b=Z/oTDFt4v40X/9YgXJhMUMn47FspgO0/sDJBASdyVFLWRc8PGx+eeWajyjklYOQruhh2WdgmE4PapdHssQPLbw7NwC2N0pReQioG8xXt2mboE0rITkV5o10CMOVbP5q5rbwyEHMon5p6iLRihlUcIHRD4BoVtNiaMKKkknM7pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592018; c=relaxed/simple;
	bh=kee9j1m2AVi6veA7SLzq/MwT8g6+zr/yKaCIxJ8+G1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oPlrDYB70Lv2GpiMcq678k5kW6SSHuao65+eXm0lt/pWBM18uoooZgv52LPbA5xp8BMZ4Hvs/w2agcypN/VMiZZIAwIDEld/1+e2X7s44uRjQYm7N3d4GGoQOYxTo95QiFxnh4hH/fGIs8xZzP7qhoj4EMZsmFqE3E9JreH6eZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3U78jqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685DCC4CEE4;
	Sat, 15 Feb 2025 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739592014;
	bh=kee9j1m2AVi6veA7SLzq/MwT8g6+zr/yKaCIxJ8+G1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d3U78jqH6dIXPUqcaqoXIoKf5886ZWVntKD094beun3O7CJU8PbIaCpqObYYqbhZW
	 APX4ifdrBWP75A1SvYs6ysytxfCnS1NKsn7igdutzn6myjzrAUNRfTaqY5jCGfZrb0
	 Y8SDT9L0E6/WxUQeJKAHveWw2jsdvQ+qs2ZXpEULtUh41E6dTLELf5EETZKJ184lck
	 3+blX6OZloMJ5NjkrVUoM2b+W0X9sfTSzKeXvVuBiSCGpPiosSjuNTWt20qFWolB5O
	 mUp0lv2WxYtsdCwA0AEjGx/8vZFPkOSxi8tzjFZku2+b9jddFXZbeW2tUDdOrdYpJl
	 ppcomTu2wx65g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F35380CEE9;
	Sat, 15 Feb 2025 04:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/11] bnxt_en: Add NPAR 1.2 and TPH support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959204374.2185212.11785093918509459346.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 04:00:43 +0000
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 michal.swiatkowski@linux.intel.com, helgaas@kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 17:12:28 -0800 you wrote:
> The first patch adds NPAR 1.2 support.  Patches 2 to 11 add TPH
> (TLP Processing Hints) support.  These TPH driver patches are new
> revisions originally posted as part of the TPH PCI patch series.
> Additional driver refactoring has been done so that we can free
> and allocate RX completion ring and the TX rings if the channel is
> a combined channel.  We also add napi_disable() and napi_enable()
> during queue_stop() and queue_start() respectively, and reset for
> error handling in queue_start().
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/11] bnxt_en: Set NPAR 1.2 support when registering with firmware
    https://git.kernel.org/netdev/net-next/c/ebdf7fe488c5
  - [net-next,v5,02/11] bnxt_en: Refactor completion ring allocation logic for P5_PLUS chips
    https://git.kernel.org/netdev/net-next/c/0fed290525d5
  - [net-next,v5,03/11] bnxt_en: Refactor TX ring allocation logic
    https://git.kernel.org/netdev/net-next/c/e6ec50485659
  - [net-next,v5,04/11] bnxt_en: Refactor completion ring free routine
    https://git.kernel.org/netdev/net-next/c/f33a508c23a4
  - [net-next,v5,05/11] bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
    https://git.kernel.org/netdev/net-next/c/09cc58d59441
  - [net-next,v5,06/11] bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
    https://git.kernel.org/netdev/net-next/c/e1714de53218
  - [net-next,v5,07/11] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
    https://git.kernel.org/netdev/net-next/c/4c8e612c9a36
  - [net-next,v5,08/11] bnxt_en: Reallocate RX completion ring for TPH support
    https://git.kernel.org/netdev/net-next/c/6b6bf60fc95f
  - [net-next,v5,09/11] bnxt_en: Refactor TX ring free logic
    https://git.kernel.org/netdev/net-next/c/c8a0f7652d61
  - [net-next,v5,10/11] bnxt_en: Extend queue stop/start for TX rings
    https://git.kernel.org/netdev/net-next/c/fe96d717d38e
  - [net-next,v5,11/11] bnxt_en: Add TPH support in BNXT driver
    https://git.kernel.org/netdev/net-next/c/c214410c47d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



