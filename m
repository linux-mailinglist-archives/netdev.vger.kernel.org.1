Return-Path: <netdev+bounces-105518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF89118CC
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07D9B20EB5
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9584DFE;
	Fri, 21 Jun 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seacLH7m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17A7E799;
	Fri, 21 Jun 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937627; cv=none; b=RW2gJSRnfwdYHf04zJzrkTfTkssyl3ynBuNtad6UstOI5qNKzPTRi1np7CZsWtERDGgl2YvB5aYPgsW8IiaXOKQDE2eNme5euziOZF4wy+kPkpmDNtsvVqRdii0tJby5xS+yuq7CLhTTyfIF9jI6qM7nE3aQpUgHbgo3wBSHqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937627; c=relaxed/simple;
	bh=xJZIYVbUP0t+JbPBKaSKgjcIw13Hyj2UtyKRDIikHCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r9iZlqiciIa3KFBCU+87vqGSYGwMfDXGYXOkKr/CR18GhHyXW/7ieyZShPElur4A7AZ8xvWefttp+QJIEPYmj/qwhF8pKeWdTxQwiOVJeOWRjidGV+RGKYEqGvwJ6b54OfuZchTZzUETc8BDxdMBe2USVkKxgOoOALqTYXF73KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seacLH7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46E7BC4AF07;
	Fri, 21 Jun 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718937627;
	bh=xJZIYVbUP0t+JbPBKaSKgjcIw13Hyj2UtyKRDIikHCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=seacLH7mXRCeWEugfPHXgqH3FDxgKL/ZBcE5P5twXfe8bjpEJbm6uKpmzFVJLbbBM
	 lLovx3vZYBm5po2rBJuh9cA+w4AJL+o0D6nfBG0zmxwvrhvMUtugPAe5VVGo0HC/Jj
	 +W4lb1zGsCi0nz/tQLxo62bKIUBTT1VwICL73o5Zv7x85IvlOjYIEuQyaigFxN7UEV
	 4xu1ALI9KFRxT2xKimDmdWYb89uN5Lmkyy/1RDituR3XO0cRQcIHXca+wWtDxxjtsq
	 rJo1r8XE0c5vAXV3flJ7pIS0daYeBFqFQDkxO8doLeEatNSkS3r5Ud7q5dXy+S9DX6
	 FvfnCQ9nRMhAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3545CE7C4C8;
	Fri, 21 Jun 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: dsa: microchip: fix initial port flush problem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171893762721.9082.9601801186482901167.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 02:40:27 +0000
References: <1718756202-2731-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1718756202-2731-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 17:16:42 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The very first flush in any port will flush all learned addresses in all
> ports.  This can be observed by unplugging the cable from one port while
> additional ports are connected and dumping the fdb entries.
> 
> This problem is caused by the initially wrong value programmed to the
> REG_SW_LUE_CTRL_1 register.  Setting SW_FLUSH_STP_TABLE and
> SW_FLUSH_MSTP_TABLE bits does not have an immediate effect.  It is when
> ksz9477_flush_dyn_mac_table() is called then the SW_FLUSH_STP_TABLE bit
> takes effect and flushes all learned entries.  After that call both bits
> are reset and so the next port flush will not cause such problem again.
> 
> [...]

Here is the summary with links:
  - [v1,net] net: dsa: microchip: fix initial port flush problem
    https://git.kernel.org/netdev/net/c/ad53f5f54f35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



