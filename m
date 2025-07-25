Return-Path: <netdev+bounces-209941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA9B11622
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D59AE0258
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788415E90;
	Fri, 25 Jul 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5E2CkcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ABA137750
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408807; cv=none; b=hxFlGujeDSH7rgsuqlFbZeEEtrSRDwkN6EIpSvJvgoarHXUFfV+cuwjTQdj7HEKczJ5KY4q7EK1559pZGSkdTBPr7OQJK7rAwG6/pIEkhKj1UL4HLDG2hAfzrP9w/Z9ErLs7/oDhiFVaiZxnvO5/+1q5AuHQgX62zTlxYoeg8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408807; c=relaxed/simple;
	bh=/8tegidxVKeauZ79Xs4FvNbdF+l4pkvk54mdqtIY7Us=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PcV8iFYYiwwX43kedCFexuHc/i1m+njcLs1kXBfs3CdwdV9q08Jx0qt4vAffLuetNnZTl6Sp0v8y/cTE5bnBU+iQJNsLFGyLKBYFM8VClcTKG00m2vvi7ort8V3rWH8ZaMKSs9s1i0+3JfDUC+oaX6UHNI6YinAi8+OTq6a01V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5E2CkcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8021C4CEED;
	Fri, 25 Jul 2025 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408805;
	bh=/8tegidxVKeauZ79Xs4FvNbdF+l4pkvk54mdqtIY7Us=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p5E2CkcLEXsE0nl9g/iCQO2dLjAVrkZF+fFEyARtIkiGNTn7uCEvsfNmTZXOygFan
	 Jm0tF1Ht3spPLFI+jB4ytqxH0DiQWYu7mzc5oGmls1t7M2ELundRBzrk8Kzc2k72V+
	 I0jYmr4HaURu13odxnJZPXGpXQactpdNhgJiTjl/NkUmO94LRn/oe9XXAWDJLFefY9
	 6y8th9rhLtOW/zfJIo7TX5OfD8pwsCV1MLRj6nspjaaQXAZ3Cz5AsORVScGEDxsvyM
	 c7Kxtan1yqM0IoEbe0V/x1b8RiCEkI3Xrwt8bke1d0lk4PR2V557DBQtC2qDAqaz+e
	 aOk0rRTYVQ2ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC66383BF4E;
	Fri, 25 Jul 2025 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] Use enum to represent the NAPI threaded
 state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340882324.2604761.15771679897501425014.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 02:00:23 +0000
References: <20250723013031.2911384-1-skhawaja@google.com>
In-Reply-To: <20250723013031.2911384-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, willemb@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 01:30:28 +0000 you wrote:
> Instead of using 0/1 to represent the NAPI threaded states use enum
> (disabled/enabled) to represent the NAPI threaded states.
> 
> This patch series is a subset of patches from the following patch
> series:
> https://lore.kernel.org/all/20250718232052.1266188-1-skhawaja@google.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] net: Create separate gro_flush_normal function
    https://git.kernel.org/netdev/net-next/c/71c52411c51b
  - [net-next,v8,2/3] net: Use netif_threaded_enable instead of netif_set_threaded in drivers
    https://git.kernel.org/netdev/net-next/c/78afdadafe6f
  - [net-next,v8,3/3] net: define an enum for the napi threaded state
    https://git.kernel.org/netdev/net-next/c/8e7583a4f65f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



