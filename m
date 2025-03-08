Return-Path: <netdev+bounces-173136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92BA577F5
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381573B6676
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B45917A31F;
	Sat,  8 Mar 2025 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK7o49El"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEE15B54A
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405213; cv=none; b=QnMLqgQaDuTqQG11Z5lPpqBh21v7hgQFFPL5Iurr1AYQH1WA57CvPYn71meSUUneZnveAYYvRdgwxemmCQlWASpAqlkGnKNm5TwOpKsAvLiMlsAklyq0OBVJeTn7n+z7fKk3JPCP+xjVJq9Wno7rMJApuDSp7YHb8wXSOE59J34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405213; c=relaxed/simple;
	bh=fj5fvMcezdL/7tih9ZwoLivh3Uq3+CfRfIeF5zFZ+iY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tguhyGDZYy5x0Vi/+qOsTIG1Y4XuoOmgNGcdcpFcoaiGkytFf/AwH2cqhJqsDdYXIifBXRWzT18vQDeWZ3bLNRyc2sqU4uKpVhv8iDRqOOREhZ3HVcPt0KS26V1ApRzFaOs5QjiAzfjJDSodo6WmVapidn/Vz54l7wBYe6H5tSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK7o49El; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF8C4CEE2;
	Sat,  8 Mar 2025 03:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405212;
	bh=fj5fvMcezdL/7tih9ZwoLivh3Uq3+CfRfIeF5zFZ+iY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cK7o49ElFvORRvDODcyu/nfPcHDXV6Icek7XHsF2+yPxElIo9UnlA6WfSLPGicRAW
	 kzqyAc/Y1mo5F/Gtgjwayit26wzE7JcEs21lF1KzG6QVLcKkbvM5cgbv3ONURZhaU2
	 YCTYqW1kqkFwhTlTeidNpnLeeBg6z7FrPDD8ZEN7SEU9lDLC5graA81eirgGeJOu/x
	 MVMVUiF6meMQODlsSLgv/uiFwo0ACkvgSyyJTAqEaA57izv8EISc1gRM0YEQoo8OEy
	 gCQxLtOfZpfjUKwm0vGQIfb9D7Ihp8TivTYR5tYfD0m/J/gjr5zr9Fc/7M3stGGXwq
	 B6DJioIkeV8aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE389380CFFB;
	Sat,  8 Mar 2025 03:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: add proc_net_pktgen to .gitignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524624.2565853.18100216640201210403.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:46 +0000
References: <20250307031356.368350-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250307031356.368350-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ps.report@gmx.net,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 22:13:44 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Ensure git doesn't pick up this new target.
> 
> Fixes: 03544faad761 ("selftest: net: add proc_net_pktgen")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: add proc_net_pktgen to .gitignore
    https://git.kernel.org/netdev/net-next/c/7ae495a537d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



