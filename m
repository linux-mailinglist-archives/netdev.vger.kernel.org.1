Return-Path: <netdev+bounces-182860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C026A8A30F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800681631D7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF58296D1C;
	Tue, 15 Apr 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgLeyOsN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A22951C5;
	Tue, 15 Apr 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731603; cv=none; b=jFuDgg+BGUyLKpw3Sv/dzZUsfYyKfr+mTddxL1kVYBmOCnCc5lkKRuh3dN6ATN8RvY9vS3HpR/inWgrQHZ8wB2pB15qVEJDEUTQt7RMNNV9Dh+PVEbgLEwxfvL/DX9TwRzBBc4lbLebEHwpd6iLynbc4mIWMMzC1D6kXIwRuSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731603; c=relaxed/simple;
	bh=9dL+7sxEBn0HqmNk1zwuk8hfwZcm127WopxwN7xJ5nY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eC831wEi+V4dBoC5lgQTL649j/RbpekYCnRJ2Sxkzky0IcRsGpDgbIuQl1kGazsbWCd/9HZ+qmwJZW+mY9pk2FvyxQMdka4yctyrgKJqV33mT6y79ZhcYXS+Q5vnW2tayA7NFAstK5RLG5NI9HBEaydPHNQFk+halsw8fLO/eQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgLeyOsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6EC4CEEB;
	Tue, 15 Apr 2025 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731602;
	bh=9dL+7sxEBn0HqmNk1zwuk8hfwZcm127WopxwN7xJ5nY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cgLeyOsNuL77AcAcQet4LtelmuE1kxrOn1myljxz/MDL7oI3tEbNlVGujF4V4fKQQ
	 udQGvZR/carvEm35xXz7hmwgOS5hxmnwM9+ciRK9BgV8loOGRF+QANLq0mjho8cq6Q
	 4YGfevOcO/slXg+ibjogEttJ0Adc0a0H4axXxFwtTCXB0bSpZs6V8GPH8tdjIMYb4G
	 kX9V5uAtE9P2fgFNPdfK0KLl7ZP5/qrNDL7S9DpomdygKnBjFllfzd/LsCSQASvmPl
	 tnA1WyB/kBidYdb1YVT2elTo4MoZBJuoqsnEw1rzepX5dQRBSc9l6E+LqUtY+PUvfL
	 2kQm0qGIbQjSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC543822D55;
	Tue, 15 Apr 2025 15:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] net: Introduce nlmsg_payload helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473164049.2680773.4741397198265025853.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:40:40 +0000
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 kuniyu@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 06:24:06 -0700 you wrote:
> In the current codebase, there are multiple instances where the
> structure size is checked before assigning it to a Netlink message. This
> check is crucial for ensuring that the structure is correctly mapped
> onto the Netlink message, providing a layer of security.
> 
> To streamline this process, Jakub Kicinski suggested creating a helper
> function, `nlmsg_payload`, which verifies if the structure fits within
> the message. If it does, the function returns the data; otherwise, it
> returns NULL. This approach simplifies the code and reduces redundancy.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] netlink: Introduce nlmsg_payload helper
    https://git.kernel.org/netdev/net-next/c/95d06e92a401
  - [net-next,v2,02/10] neighbour: Use nlmsg_payload in neightbl_valid_dump_info
    https://git.kernel.org/netdev/net-next/c/7527efe8a416
  - [net-next,v2,03/10] neighbour: Use nlmsg_payload in neigh_valid_get_req
    https://git.kernel.org/netdev/net-next/c/2d1f827f0642
  - [net-next,v2,04/10] rtnetlink: Use nlmsg_payload in valid_fdb_dump_strict
    https://git.kernel.org/netdev/net-next/c/77d02290366f
  - [net-next,v2,05/10] mpls: Use nlmsg_payload in mpls_valid_fib_dump_req
    https://git.kernel.org/netdev/net-next/c/72be72bea9dc
  - [net-next,v2,06/10] ipv6: Use nlmsg_payload in inet6_valid_dump_ifaddr_req
    https://git.kernel.org/netdev/net-next/c/e87187dfbb9f
  - [net-next,v2,07/10] ipv6: Use nlmsg_payload in inet6_rtm_valid_getaddr_req
    https://git.kernel.org/netdev/net-next/c/8cf1e30907de
  - [net-next,v2,08/10] mpls: Use nlmsg_payload in mpls_valid_getroute_req
    https://git.kernel.org/netdev/net-next/c/69a1ecfe47f0
  - [net-next,v2,09/10] net: fib_rules: Use nlmsg_payload in fib_valid_dumprule_req
    https://git.kernel.org/netdev/net-next/c/4c113c803fdc
  - [net-next,v2,10/10] net: fib_rules: Use nlmsg_payload in fib_{new,del}rule()
    https://git.kernel.org/netdev/net-next/c/8ff953036110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



