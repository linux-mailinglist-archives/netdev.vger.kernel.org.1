Return-Path: <netdev+bounces-157359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22666A0A06B
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A07188E1FC
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C9148FF9;
	Sat, 11 Jan 2025 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfBCiapx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CE1474A7
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563811; cv=none; b=OYbhdL/JBFlOGoGtoZKqWQ+g4ChS3sww98FcQSI3TOof4rTvy1q/pm/WuS6dTqZaKuWm+7FOwhupuUqTn3WVvY1yD0X34dCp3kk6JqL++E7TzRgOAgWeKmV4rSzCvxiRNWT+qEenkPJWIHWYGN+mZMve2HCu1AUTMtrPPYLoQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563811; c=relaxed/simple;
	bh=HGZz2Cm9j/hO3JHoG13ROjPnYsxxaimYWUmdVAOnw6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usrJgaImMoA8fo9u85jA1iS84mX7Z/5Dck5EA7RH4QdW/bBmSbrS2OgN1Yl+55Ys2ZEUrhQRgyuB2x/fce20waClsDNdzpKxfIgl8693i32KtxfCZsnnkX7AW/IpA8YrnlJ+LRemvgOTHGXbD/Mt4ouKA1O5r3dChwcFC/8QEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfBCiapx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CEC4CEE2;
	Sat, 11 Jan 2025 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563810;
	bh=HGZz2Cm9j/hO3JHoG13ROjPnYsxxaimYWUmdVAOnw6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OfBCiapxmNG9IqHtys9t7QY0A7a3nSAd//8PoRQZjx452iuRfQ+zmYWfDHUiMNw3s
	 QKV4xABibHWSM+q7FqkzGvBI0PP5Hd3sIM2P9TtS7d78XCeh+lDJHB9dXnlz8sx7eY
	 jquKxssgRhRBGMuc6I0EvwRJlkDbGtXQeATHZc+VzXVoEr1EqU5C5AWW9x0yadnP4u
	 zq9R8fGJdkzPS7M5bxtx04vwX9Kf0YCRJwUHVFP+ojpNMcEyj9QW6qzPye/o/vEpQu
	 JjUueuiHHGiTVFX+utNKu+1OoTQbZVu1AkLDP2lm6CeQFOmQak0aasqy+dih/QgNa7
	 OSbVOKB3siiDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB40F380AA57;
	Sat, 11 Jan 2025 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hide the definition of dev_get_by_napi_id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656383275.2274657.14079899348377316703.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:50:32 +0000
References: <20250110004924.3212260-1-kuba@kernel.org>
In-Reply-To: <20250110004924.3212260-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jdamato@fastly.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 16:49:24 -0800 you wrote:
> There are no module callers of dev_get_by_napi_id(),
> and commit d1cacd747768 ("netdev: prevent accessing NAPI instances
> from another namespace") proves that getting NAPI by id
> needs to be done with care. So hide dev_get_by_napi_id().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: hide the definition of dev_get_by_napi_id()
    https://git.kernel.org/netdev/net-next/c/21520e74ba45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



