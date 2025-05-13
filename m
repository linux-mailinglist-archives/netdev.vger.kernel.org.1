Return-Path: <netdev+bounces-189956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71830AB496F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B6D16B612
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B551B87C9;
	Tue, 13 May 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUf3rX0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FF1B4141
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102800; cv=none; b=QkJHLCAhbI6gH7H2GEobCWEKo6bhqtAj+IKF5T1OA70E/zobCfYs+RwLiw2+ao1Efy/DodgshUJbYi5hSfVGDPlUhW4vIKyokUBjAkKPRCiPSi+DTLtxnuR1RIUOqbByCZgeBO8QS5EMwJzBbAL39NgxJFuqPdPwC2tWE+joKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102800; c=relaxed/simple;
	bh=OJb7dPAZhOnwBNUYtUC5Yi3nuVbB7+9KRLXItBHh1qU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TtuaLGLiRG0eD0QBqZWHzsty7WrTPwBN+90VeWCjwYfEHP6d3VKqMvBjlrI7sgCjBjO9D8/OTz37t9hpIxNJOkIwAiNM21YMYHpk+I5ySaYlOl1UXDcq3Rod3XiU/RIsySGJk9kHorlBdsybDD82+yTj6726aOpHvhBJDg951mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUf3rX0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84642C4CEEE;
	Tue, 13 May 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747102799;
	bh=OJb7dPAZhOnwBNUYtUC5Yi3nuVbB7+9KRLXItBHh1qU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XUf3rX0iCaxHE8gMyfbyqwygI+OrrZk0zAMhPn+Z06gDcrAbXNPSqvFrOpcMV9pS4
	 rhgKj4VALMjFg0r6etre+VrQa8XpzzeJQuNBOoyO4H8NGdMF02d75HCzFRjcBjX+Hz
	 oztcUYHo76MoUNIxHOAsSLZmFKuU6H4Ti7ti9MrepR8bhhAltGez9jjQFMNfkvjjvK
	 WikemQn19wyqw2vz5E2rwIzKOkXUI/4EOtuLZwJFwayzuIKZS8D9E2PmtqfRt7Z4yr
	 kSyT2v6SIo4n9oXINzw5WEioNLKKKmexexgtoWS8wgFPTIj6ffcIspiMiRWzUgWNhG
	 vucEeni6QY4Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B4C39D6541;
	Tue, 13 May 2025 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag
 when getting ts info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710283724.1148099.14794480302116464100.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:20:37 +0000
References: <20250510093442.79711-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250510093442.79711-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 May 2025 17:34:42 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> As mlx4 has implemented skb_tx_timestamp() in mlx4_en_xmit(), the
> SOFTWARE flag is surely needed when users are trying to get timestamp
> information.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info
    https://git.kernel.org/netdev/net-next/c/b86bcfee3057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



