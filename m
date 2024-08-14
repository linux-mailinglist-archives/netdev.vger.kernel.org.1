Return-Path: <netdev+bounces-118284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F12951268
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74DD1C20BFC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775C918E3F;
	Wed, 14 Aug 2024 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7NoJQZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545623FB83
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602636; cv=none; b=nbLCpbDizKAAOPJRGIh/p5xWcN9cL3EytE0fZewkjLtMwQHsT9fW96uOaxsA85bavSHy7dE1ER1ATU3/6rixdlRtH0HeOQYcrGE9QqcR0vYLZMoO03GX+MQG/wvbnnWIPZqoUvUc/QxHHsqSS4XCL20C/48TgIvTPMpGLcCt8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602636; c=relaxed/simple;
	bh=0lK/eqQvfIfbT3e2ZAuQd8Zi4pUwItDQYCTOojulOzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X3nPUGcRAmLWK3cFJR5WDQVO4Qt7UPhKTmsa1g6/J8ApbuRjbY8W18Ud7Fcw4YnjY98Xev8QB5yRvu+vbhfJ7slu35SxcygVe2qU4mxB5swuj/Dm0bljvzrdcNfDXvgJBdqWHIt5YgOGrLYjoRE7WlybMvLIADu1gc5kT809Gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7NoJQZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E00C32782;
	Wed, 14 Aug 2024 02:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723602635;
	bh=0lK/eqQvfIfbT3e2ZAuQd8Zi4pUwItDQYCTOojulOzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G7NoJQZCKRkkVZPf/bFMubRGEWWzZp4r12h6+bJ0Za13EQrEUl7CYqQ4Tz3tbBKnj
	 YayjYHEs/ZtCsPEhivGVY7xBmVSuZc+cAKmb4QLKFkmfE2GHTxMJ5S2OXL7FC7dXJj
	 NeYvy94DyvZJPf6oJOYK15zHcllqJwesXsuBxpxzCt60o7mrpkes9ls7HC36yc7yrF
	 nGlQRH+zQZnItGaKg9EQu540EumiMV13nmEdCTzFv+TjpsJ5QkOT7rw1U3+eBTg6J3
	 mWvQuE5hiM/W+G8BiClKsnof5RwurPpQgdY3TIxbvlnoOUXODGMrIZ72xo01S8SqQZ
	 OR3WFUcOb5jHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342553823327;
	Wed, 14 Aug 2024 02:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvneta: Use __be16 for l3_proto parameter of
 mvneta_txq_desc_csum()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172360263474.1842448.12842229512784993971.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 02:30:34 +0000
References: <20240812-mvneta-be16-v1-1-e1ea12234230@kernel.org>
In-Reply-To: <20240812-mvneta-be16-v1-1-e1ea12234230@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 12:24:13 +0100 you wrote:
> The value passed as the l3_proto argument of mvneta_txq_desc_csum()
> is __be16. And mvneta_txq_desc_csum uses this parameter as a __be16
> value. So use __be16 as the type for the parameter, rather than
> type with host byte order.
> 
> Flagged by Sparse as:
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvneta: Use __be16 for l3_proto parameter of mvneta_txq_desc_csum()
    https://git.kernel.org/netdev/net-next/c/29cabacef102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



