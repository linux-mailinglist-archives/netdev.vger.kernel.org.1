Return-Path: <netdev+bounces-143547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE49C2EF5
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57768282281
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A31A9B27;
	Sat,  9 Nov 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2ROV8CZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C41A76D1;
	Sat,  9 Nov 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174632; cv=none; b=b71ed3M0oKH7QNYeHTR2e92jr7IMbJVk/40qlLSqow4vhdX9jsGQ7cHC+uII3RjhtFpMioAvRm3AGBLOktkuYGbNRm9j7UldACqqHnzT5AwnWFMaZ9GuNYnLaTP9gFeu08jq33FhP1y4QYCY6XOcWY9JrbCzSMs5RRV40d+yIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174632; c=relaxed/simple;
	bh=WemRC3LdH+kvHsIM5UBLlKXfbOA0gznBdn0KOUNTQf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqJBjZ+6PzuPTo9On4Hqn1O1Pz4lob7DyhvntS7By2FOVBxj9Hl6GcVHAEF0ibGVl6z/TuL6pc4ndkqrATb8hmMA6hLTAGlNvLHrYmOjGjmvnO3mj01WVIovxRoJ9H3+YPtc3frsJYh5VvX/o4LhBLHA9etWLKoBxBZbubUhAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2ROV8CZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC261C4CED4;
	Sat,  9 Nov 2024 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174631;
	bh=WemRC3LdH+kvHsIM5UBLlKXfbOA0gznBdn0KOUNTQf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2ROV8CZkASidP88ASSCuTLtBoKoEuB4Ctw9cVZwBdJOt5eJOpqf3aZZx5wKLd8Vw
	 ObwCMhWGQLCKVhiB17FCLfhbwm3a8tjMaUwSWYP76oeKfD4V6s4E3zj9eFHFnKvYhk
	 JVzmyXyIG6ouj69AftRzompqEvvUoVMakGDiyq3WrkP43SOzP6uznMP6aY1UicwKuO
	 DYJHzm2aYOytB6gCFRRrdgAzZ2cVYcn99RLczwu7CVFxm1CgqHuvz2+e3dShBjSOzl
	 YgrZQUqEfd3O1wII1ozuspVQdODs4a0CnGKye03NBP6fucxSD2sk9zekC3u81lJuwI
	 4neH2oTnGICeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF573809A80;
	Sat,  9 Nov 2024 17:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mISDN: Fix typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117464128.2982634.11050785533090944445.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:50:41 +0000
References: <20241106112513.9559-1-algonell@gmail.com>
In-Reply-To: <20241106112513.9559-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: isdn@linux-pingi.de, kuba@kernel.org, quic_jjohnson@quicinc.com,
 horms@kernel.org, dan.carpenter@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 13:24:20 +0200 you wrote:
> Fix typos:
>   - syncronized -> synchronized
>   - interfacs -> interface
>   - otherwhise -> otherwise
>   - ony -> only
>   - busses -> buses
>   - maxinum -> maximum
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mISDN: Fix typos
    https://git.kernel.org/netdev/net-next/c/2b08dfcc2ce7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



