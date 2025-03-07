Return-Path: <netdev+bounces-172714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48506A55C90
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D97177A0F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2892E1917C7;
	Fri,  7 Mar 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG5KRHUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03571190679
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309202; cv=none; b=jreBVEhrF7jP3ZFmoIzR1KVDMzbn05mU7OWTBjYTqpoXjRi/ntZLVttNJ+43UBMp07EzsfX/PGq94p1Xnl3VEBl6R15BnA+LiPaIcsbbOgIGE93THaGDXd76rPSFojYJuRoViBDckgzlJB7ZAv2OjXIkR5liTbxEHZRO8ia14fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309202; c=relaxed/simple;
	bh=C7n1sQ9spG0GmsQ8Yj5JaIBoVUh7s4FCjKwZJlcABvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pBRe1z0mP8CZxCmP9HGqizlLwnJ8qLei7ZbUT/nMPN0Zt4CGJ4/0jsn/b+adYEpoN/tijNhvC162j7fGHCsNG8ebVyWkxuYbfvTKvVYyfIYP4KsotgWCX0Fap1sr29kog1ch3xJHj6r/ZRZDFre1QPhoZi9gIUbMUyJVe4F4O4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG5KRHUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1675C4CEE0;
	Fri,  7 Mar 2025 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309201;
	bh=C7n1sQ9spG0GmsQ8Yj5JaIBoVUh7s4FCjKwZJlcABvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oG5KRHUPv45YHsBqGvHYW/tVRtPNgYRr7KMZkD9m4WzlZpbTShBKBRV834D4UV7m4
	 +Q+GwakRRN2aaCuYVaCT1YjlusQUNp27+LtLVnxDBRiZHBbG49Jlggb6ceSZUhA/Ru
	 x0M5E/njVRhDQ5kuy2SHjiOXtMKTt/7hK/nUYJWYtRwJgk9Lhcf/wG97Xc//xIwefM
	 PATlIdcu+VjSu2WceBLnlofN4Rr3WghUKgZbRrk6VD/GjuFgmfU4qamRsBBuWA0yT9
	 tFhHgc0/QKIp4dNz2A99c0KIoLdILmy7vnM7fID7ZKcUjuIQ4voWT8ajwEn456YcS8
	 93oaxjzx69K8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9C380CFF6;
	Fri,  7 Mar 2025 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix lan4 support in
 airoha_qdma_get_gdm_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130923525.1838424.11881654670329234218.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 01:00:35 +0000
References: <20250304-airoha-eth-fix-lan4-v1-1-832417da4bb5@kernel.org>
In-Reply-To: <20250304-airoha-eth-fix-lan4-v1-1-832417da4bb5@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 15:38:05 +0100 you wrote:
> EN7581 SoC supports lan{1,4} ports on MT7530 DSA switch. Fix lan4
> reported value in airoha_qdma_get_gdm_port routine.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix lan4 support in airoha_qdma_get_gdm_port()
    https://git.kernel.org/netdev/net-next/c/35ea4f06fd33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



