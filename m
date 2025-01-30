Return-Path: <netdev+bounces-161615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31CA22B8D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6E162D62
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5C1BAEDC;
	Thu, 30 Jan 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz91c84M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020D20328;
	Thu, 30 Jan 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232405; cv=none; b=PKXUjLj9ROLUuOPMcSHRIXGcvet9U3cu56IVj/I2IsJ88yVW22ia4HLn1kmVkX8Lda4ml6ykh80yQct8jumroDx0X4CMImz7Ea3hy8o8eB7m29D/hQX1ilN2jN9ZbR99vk+kVryrOeKBGGKSqMAytoWwe6rN+7n4WIYyjUuqdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232405; c=relaxed/simple;
	bh=JP5J+wJfjEdrOtbQ4xgoGx8iupwsOhze4VsbLk5e5hY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jCUAf649AUbEKFvkE4aAEmFhpF0FThRu+FJYoKNaaUqohfLng7ARlX8N+mtNFFQN4nUn1ZIGpR66Opowi+n5LLExqpgVHMYCBAymY3IEWH8XBfgMjQbv/KUyRNrAhzU2d5eRT7W4Th9mBhP23/7lh/vyNBB6vpk3BWY8Ui0B3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz91c84M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB825C4CED2;
	Thu, 30 Jan 2025 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738232404;
	bh=JP5J+wJfjEdrOtbQ4xgoGx8iupwsOhze4VsbLk5e5hY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cz91c84M+IkS+Sp+u40tRNY/Vw/6Ay5nOf0B2JCXWnYNPwsUlErSjNlXyz44UfNJW
	 vsgULonzfvJFuQdDtA+woF54I3ecdirV0p/VScDRenrJtHwyV5rwqPeaA9Jdr7ihGq
	 Aq6rlXMjfN56W6fgU71LqSk8lt0E1hWaWLwqk6fow8dJ3SfcnmxkRPEcD3cM0Of/yB
	 bU2qhhP8c2V8EvWUZL5yQejZfNzex/zz1GCAgn3F0IOnuf4sGDOJ5HuExdCc86gvsR
	 LzorzKtqc2bVOwzNY7h2bE1LOcUlOzg5gVR6L+4rxdpgWKT3YRiu1/AN/2hzr1EGMU
	 FG25RfforFVyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F43380AA66;
	Thu, 30 Jan 2025 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2025-01-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173823243101.914097.16724698184237211143.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 10:20:31 +0000
References: <20250129210057.1318963-1-luiz.dentz@gmail.com>
In-Reply-To: <20250129210057.1318963-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Jan 2025 16:00:57 -0500 you wrote:
> The following changes since commit 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a:
> 
>   bonding: Correctly support GSO ESP offload (2025-01-28 13:20:48 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-01-29
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2025-01-29
    https://git.kernel.org/netdev/net/c/da5ca229b625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



