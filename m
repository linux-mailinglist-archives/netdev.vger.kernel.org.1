Return-Path: <netdev+bounces-193464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DEAC4233
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722363A78DE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574220DD7E;
	Mon, 26 May 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVQl08AH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984A171C9;
	Mon, 26 May 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272799; cv=none; b=CSBxlzHI9lFwVwRPWezftmA73WF7/CkoNj712oaZxZA7OxbeABqLszVU0uUOT5ztjUhzhCiq8B7fWmGtl/z8/j7dZTWIUEi+ETHdSYJmeja9abDK7f2prYi9jQs9aaT9syyblnkNCpyIQceiEVKZbyz2Bh0VsPKCWj5mICfxUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272799; c=relaxed/simple;
	bh=/ApZuRMAuJoeBKWeY4aIkvjGzzqTlwlgmSqzbWSOhIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nsNNxvmcan5P9jt7hA0MoCcXYKp+n2Yy+zCQq1HBBbtz4fX8bKX9oeyZgaFkE2gNiG5tvQi6u3o7We/LplP9G8VA9e6Bg86fYVCB8xHkq2x4ruJYBa5fM1hji7cw8yPTlctVOnca7oGAn/vKd4eQHgvfDVtQYan2SGSiYJmPStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVQl08AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78423C4CEE7;
	Mon, 26 May 2025 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748272799;
	bh=/ApZuRMAuJoeBKWeY4aIkvjGzzqTlwlgmSqzbWSOhIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pVQl08AHV4JLrQcra0QNJqjG2MWCkdZo8Gp3XSZE7EV9K4XfvKJWweMpJAiNjxejG
	 UFLM3avHp7jqWASCoaW409E3+C0ZMiE5wzLoYWwZNME0Y6ndHs0T+3VqUNehEg1Aq6
	 p0EXp9+0p9Ui1CnHENEjZ2UjOp/m+pv6YdbFaT1iEGZZMaD5yWcTtxw5s9X46352Kk
	 UAEXgCK0Xbdt0UnF/aVgsR31A00AmAfOi9jzGu0xUq+x6B1h0NJILJ4tnbavJ93GZ+
	 7xUXe4I8aS2fBHrOZG5u4dNdn/XGPXA0x0ZASs/mxts2uHd0a7+5ZTxqBzXC+jvzkP
	 P5iYJ0BVa4I9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6639F1DE4;
	Mon, 26 May 2025 15:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: dsa: microchip: Add SGMII port support to
 KSZ9477 switch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827283401.956475.11720035173876833008.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 15:20:34 +0000
References: <20250520230720.23425-1-Tristram.Ha@microchip.com>
In-Reply-To: <20250520230720.23425-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: andrew@lunn.ch, woojung.huh@microchip.com, linux@armlinux.org.uk,
 olteanv@gmail.com, alok.a.tiwari@oracle.com, hkallweit1@gmail.com,
 maxime.chevallier@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 May 2025 16:07:20 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ9477 switch driver uses the XPCS driver to operate its SGMII
> port.  However there are some hardware bugs in the KSZ9477 SGMII
> module so workarounds are needed.  There was a proposal to update the
> XPCS driver to accommodate KSZ9477, but the new code is not generic
> enough to be used by other vendors.  It is better to do all these
> workarounds inside the KSZ9477 driver instead of modifying the XPCS
> driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: dsa: microchip: Add SGMII port support to KSZ9477 switch
    https://git.kernel.org/netdev/net-next/c/e8c35bfce4c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



