Return-Path: <netdev+bounces-171906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23AAA4F43F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B54D169F1D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0FA155300;
	Wed,  5 Mar 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrYGr+e+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8F1547C5;
	Wed,  5 Mar 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140001; cv=none; b=Hh1ECnvWFdeXd8Py9DmQSKfRQ9MjjGqlRJfrcwrq5XtypEoPk0t9fZS4Hmm0/1V9roFSVMwfXI2l04LXdtOK9aME08yH87f8fOqf82nuG/d5ID/0ldYG/nGdmLHw6fLBFcwBigFShraSeXBPUz/RZnl3z0hRmvuJomYjVxLbeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140001; c=relaxed/simple;
	bh=DAmK5+WOR87/AUFgh4Alv9+JRF5ekJjC1q0zBCvDMjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNF/8+yGqeza4RhKpeNUDhejKbmWe304PgwchdU+l0Io1+7a9vOq7ImbQbV//cBtu7POBhZvouof1bhfifNP5GbGlUAMJ+Xo2qrmo1+RHFSj82oB4awE72ffSJmh4VCjIcGFV6uUApdyNztVKZrREWx5AABzsjzz8gg642NMrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrYGr+e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD393C4CEEF;
	Wed,  5 Mar 2025 02:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741140001;
	bh=DAmK5+WOR87/AUFgh4Alv9+JRF5ekJjC1q0zBCvDMjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XrYGr+e+BzBWWxHDzukI4d1cyYDFLu6keWc4kJjUqcZIJrri3cxtECfza/ahuRpPc
	 fmHb8e+R48BY+rQvuRmquFj8zbA0Vos/9t1YCP7k7quJlI96vWjdSnAcGBRRIaOxLZ
	 dMLuB3Nq0w4ctFCJ2noBe44sK+zmI6vy0rKUoj9CADQ70d4uKyaRxTkOeUbGMTPa7+
	 B79tU4toGCiqzQusYvNp8gbisIDo66MOpH6r9IZbP1M7UjGtbe6I9UhcVo3nD+LLLh
	 2eBzFJSnr9MfuY/VF2kgw0P2GWrNraE0nzVfdPw6JZakjiH1ZLfCiPfcRybgh+6nEg
	 dUu51t6dTGs1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE35C380CFEB;
	Wed,  5 Mar 2025 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: cadence: macb: Synchronize standard stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174114003352.368364.16564391709152136650.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 02:00:33 +0000
References: <20250303231832.1648274-1-sean.anderson@linux.dev>
In-Reply-To: <20250303231832.1648274-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Mar 2025 18:18:32 -0500 you wrote:
> The new stats calculations add several additional calls to
> macb/gem_update_stats() and accesses to bp->hw_stats. These are
> protected by a spinlock since commit fa52f15c745c ("net: cadence: macb:
> Synchronize stats calculations"), which was applied in parallel. Add
> some locking now that the net has been merged into net-next.
> 
> Fixes: f6af690a295a ("net: cadence: macb: Report standard stats")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net: cadence: macb: Synchronize standard stats
    https://git.kernel.org/netdev/net-next/c/b9564ca3a2c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



