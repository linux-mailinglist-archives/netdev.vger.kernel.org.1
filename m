Return-Path: <netdev+bounces-110410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADE92C395
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C31C228ED
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891213B7BE;
	Tue,  9 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmnULTgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA51B86E9;
	Tue,  9 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551721; cv=none; b=DFb37x5ZbS8WN3Ncz05a/j8rW9wDTBttkeurjaLkVFsVdWQHZxjwM9cTnbkBA3FoqMnPW0LYRK0TJg5vnLAw51gftoZajKaOzA4KiDRYVXUvvfSrZfw///E/imiOLkpnmgdnRdwmBAF9T9hBuqC9dyOCZJAoO1Pp5CIhSpQ1b3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551721; c=relaxed/simple;
	bh=Al2VHrv2XwaTlILHG6XC5ug04hKLUItBwLn9cEtX2WE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBwX26lNZy3Q51tPl9ctEmE2XUBvlplSbrGQ+hu3dq6+AzJmdeQJuryR/Vl2/7fTLqVm8G9j2uhUpwX/azQ6E1lVM2+BJd9qpZ6QdRiTmGZ9j1JCUcoJ3d1T8xiq+1MnW4fNLaSYNvuf1Hn2B7GvNUVnWoaSm83fhQYsnvJ3178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmnULTgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDB8EC3277B;
	Tue,  9 Jul 2024 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720551721;
	bh=Al2VHrv2XwaTlILHG6XC5ug04hKLUItBwLn9cEtX2WE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PmnULTgHKYDZogKP5WrHSBAGVqJzjYElbbSuO2VQ6M0gwThXxiNalQIC6773vqPIT
	 iwzrzIQEkBuj7zp5q46xneW3kxs/dgYFKFN0xxEqcEUCet4oZ62s/Y9UbxR16pId8w
	 Mts93LdnSP1W0O8D26BxgICviOiVGMAtQzykLkHHXF4Ak2T/TX9wpAHvy0dZmFQtBQ
	 xAedDzD3W2foCgeJD1FYfxP4Ik6G1s4wNYmhQSt7T3iBek+vX5IJ1KM0H0p71fyz6f
	 zXQG6AUT8yTEK2kICFvBxN6b/BGdp2VAn/J5pGfL/FGsf5DrYIGBvyJL6blhyjsDFJ
	 AVy3C5nWMTPng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0459C4332C;
	Tue,  9 Jul 2024 19:02:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: add missing deps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172055172091.32169.17333506236815187966.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 19:02:00 +0000
References: <20240708-net-deps-v2-1-b22fb74da2a3@baylibre.com>
In-Reply-To: <20240708-net-deps-v2-1-b22fb74da2a3@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jul 2024 16:31:34 +0200 you wrote:
> Add missing dependency on NET_SWITCHDEV.
> 
> Fixes: abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Changes in v2:
> - Fixes shaone: put upstream shaone and not internal one.
> - Link to v1: https://lore.kernel.org/r/20240708-net-deps-v1-1-835915199d88@baylibre.com
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ti: icssg-prueth: add missing deps
    https://git.kernel.org/netdev/net-next/c/d69471135574

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



