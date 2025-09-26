Return-Path: <netdev+bounces-226816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA805BA55AE
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035ED3BEDF4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8762275B16;
	Fri, 26 Sep 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3OjYO4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC015278E;
	Fri, 26 Sep 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926417; cv=none; b=n+gM6IrMEctDAhOKOQT+bbVTU6gTNpvj0tzx83KkQ2/a/7Ltc9O3e0VkZIieZGUVX6y57+spgnRHRf/kLWdan89X4ST6EYCSLhXOCrY05TwJzlW+tCJ4LxkvQYrXg1Ey1uMGkC9tSidbx5LtCLAgHxYcGIz0Q8594593YHcvrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926417; c=relaxed/simple;
	bh=eQzc4Q0h8XcaMlb4UGs79EVBMhAKWd5o8JWig9NItxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Krosy4wAbowRjYrvR1eV8rOk2XBWbXmDa4Wc0IlYqT8qbZilKyuRSy9QElQMc4C4t//9Z1u29IZe4qManxTimiBTBUSxqB0cyI/wA2UtCdFvPPozSR3ZB1A6052JdmdOOxiUwx4qo17rpZTeIDbePwI6LPrg+36buoLPjIUXt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3OjYO4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463C1C4CEF4;
	Fri, 26 Sep 2025 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758926417;
	bh=eQzc4Q0h8XcaMlb4UGs79EVBMhAKWd5o8JWig9NItxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k3OjYO4bvtorKORglOqzOEqc9et3Yd+ac2k7qLnCcJBr/PLZ/Z/7WFpZ9t87s34An
	 4fK7BzJZwVPCeW9Bro2olyZZjHeuC1eJXjmzmInMfGwo6F9APCflZwkJ+1+ridvlCx
	 zv/EutcYQhy2dWslIkpNOWHONVFY/na8OWJwkiI1vXtQqjWokNPiMDNtIQlfrPmNTx
	 Y95SmmT6nE7aweTaXLaIc1aix3LwqrwnsBitGDlwdM9wyNL82EpNeQxhT3BuSKU5K7
	 QPUu4MaT0UqDNH4egGjx0r6lsOylmfSt8BbDB8D4eCZZRDQ964BOxB66rF/6MNNzha
	 Q94BkiZwZ4eXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEEA39D0C3F;
	Fri, 26 Sep 2025 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftest: net: Fix error message if empty variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892641224.83117.18217809973759169577.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:40:12 +0000
References: <20250925132832.9828-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20250925132832.9828-1-alessandro.zanni87@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 15:28:23 +0200 you wrote:
> Fix to avoid cases where the `res` shell variable is
> empty in script comparisons.
> The comparison has been modified into string comparison to
> handle other possible values the variable could assume.
> 
> The issue can be reproduced with the command:
> make kselftest TARGETS=net
> 
> [...]

Here is the summary with links:
  - [v2] selftest: net: Fix error message if empty variable
    https://git.kernel.org/netdev/net-next/c/81dcfdd21dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



