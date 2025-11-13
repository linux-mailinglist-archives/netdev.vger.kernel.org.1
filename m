Return-Path: <netdev+bounces-238183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB08C556B1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47986348B73
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEC32F7AAB;
	Thu, 13 Nov 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLBDPxXa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A82F6925
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000456; cv=none; b=L3U2jZKdXJNXTaUpPBxK+/5PIKeszSiMLf7souGnscWDjYUaBuPx341zhprFNOCtIfyMrgSAJhIqCamE7MefcQbak4MyC6+5nn4jO8yBqObrFGFNeN1UlR2OHmOMpqtQVoi0jEYFUV6XdP0cYKaAqj8L6blGZ7skRt2pV+U63OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000456; c=relaxed/simple;
	bh=PRul9qPgpAa+tEqbjy1wzcI1TvjnKlmYgIht2eQy3v4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C9FyxxXX9j1yVwQ2EIxPd8eHUm4+D6ryIcwuTy9am8Heq7m8sDxucJUcj5sPoH0Hm5AsGoguR6ZyxdmAqA3aN3KPGPStC80dmXXDXp0ZOovAvF6ebxfaIu0syIsrfxWG+w027+yB3O2jD9uNHM/jKpYHWxFFH/RPOQr0cU9liQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLBDPxXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0486AC16AAE;
	Thu, 13 Nov 2025 02:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763000456;
	bh=PRul9qPgpAa+tEqbjy1wzcI1TvjnKlmYgIht2eQy3v4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLBDPxXa2NGJiRfA5EQq7SkfEk/fI/70UUCYc9fRYHNUCyKfR/mwscSS0HhNz2J9G
	 x9GJPzP90HA1oPQoLCBNsF8P67bkAV5TofRW13QV/zarVJR5H8oSzKgiZV/lZ6qAO/
	 MFxtmJcp+OY9N1bd7BouFM4XwUM6r2JGBVWhY/tyTi+B0YE7g2nW6VdiRQnqeZg+Ax
	 Nn13+ODk5sBcLoT/CjJduc8sinjU5nQFvqPiyUAiwB0LyGQPoHO1Sy3P5ObWYp03Nb
	 8MbtChxPSjIuY0J6DS4vrfQ7HSGJv8hcRRsR/f6ooIrsQPaiKNCdaSiwT5tyScEFMz
	 F0bQlB9bt2Dmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1A3A40FD1;
	Thu, 13 Nov 2025 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynltool: correct install in Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176300042550.285552.568373176581908659.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 02:20:25 +0000
References: <20251111155214.2760711-1-kuba@kernel.org>
In-Reply-To: <20251111155214.2760711-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 07:52:14 -0800 you wrote:
> Use the variable in case user has a custom install binary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: sdf@fomichev.me
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynltool: correct install in Makefile
    https://git.kernel.org/netdev/net-next/c/9c577f09989f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



