Return-Path: <netdev+bounces-243693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95975CA5FF0
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 04:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEAF33171F90
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B427FB2A;
	Fri,  5 Dec 2025 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsZed2qL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2727991E
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904998; cv=none; b=H670yqZx7ATNpMWbORyGJZNSHkOzqrkHeril8Ku6p1v4gXOOQ5ssPGQyoIttQTt5Tceth/CYQ2gB2Gr42+5DF/0lHYIXjuoKvxH39kwnev6gkc1OqVXnR0aK9ikyfs4wlo0sQofavPv0PLeBwZHtbN0QMKT8fVvq/atzUMDGqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904998; c=relaxed/simple;
	bh=cQTebKj0yX+nJivoGdWZLwX89XL8KjhJXAeZTKvnD9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KMgrCqZ5hpEwaL3pAPsDZcL9h7pqQ8E3GMbikppQ5spsG3H4rnIJM6jigTi4qzX99ZzdfMAMbclVs1TPyuhrNb9rtsU2mANmVMU0e9HG4OCQMIFN4JVTdFw0JNzZsPWftR3PLHyo9rXGY6q6u3k0aWtHPfonXPPeS3Vr0Mj2PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsZed2qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31FCC4CEFB;
	Fri,  5 Dec 2025 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764904997;
	bh=cQTebKj0yX+nJivoGdWZLwX89XL8KjhJXAeZTKvnD9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsZed2qLaht2WmsUT3WM0gS+H7Usx0Hb9d2pzEoPiP/Ztto9oSjy3gIeCC8iADZVA
	 YO1H8pocDQ5XbeF1brTpRf34d2osbJaSKdvIkic0LI+DZTtl3Je3eRsr2aKBzt1c5j
	 Q9mtbGU7j1cyLK59L9wW4etHOFS7q8dPYzZnd2RB5XTHEeIbQiujtYh8OZCRMlv28U
	 HR2eXotstr88j6jrDFdltHeTxBh+iZsBSr/AW3e/IYnYX3LQMd79LClWeiLGR86xSW
	 JqjAhUu1Mn1BVMUufl6Qny/r65WN8+RNzjVQ5pnMAh7rNplzes5jC1UvA20KL/O2vx
	 P1yY/ebu4eAoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 034B93AA9A89;
	Fri,  5 Dec 2025 03:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Fix XDP_TX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176490481577.1084773.5573782764784253070.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 03:20:15 +0000
References: <20251203003024.2246699-1-michael.chan@broadcom.com>
In-Reply-To: <20251203003024.2246699-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 pdubovitsky@meta.com, kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Dec 2025 16:30:24 -0800 you wrote:
> For XDP_TX action in bnxt_rx_xdp(), clearing of the event flags is not
> correct.  __bnxt_poll_work() -> bnxt_rx_pkt() -> bnxt_rx_xdp() may be
> looping within NAPI and some event flags may be set in earlier
> iterations.  In particular, if BNXT_TX_EVENT is set earlier indicating
> some XDP_TX packets are ready and pending, it will be cleared if it is
> XDP_TX action again.  Normally, we will set BNXT_TX_EVENT again when we
> successfully call __bnxt_xmit_xdp().  But if the TX ring has no more
> room, the flag will not be set.  This will cause the TX producer to be
> ahead but the driver will not hit the TX doorbell.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Fix XDP_TX path
    https://git.kernel.org/netdev/net/c/0373d5c387f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



