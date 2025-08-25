Return-Path: <netdev+bounces-216706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A781CB34FB0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F543AE446
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876292BEFF6;
	Mon, 25 Aug 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djyyT0EH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7729C325;
	Mon, 25 Aug 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164604; cv=none; b=ir1aleVmsSrT4/URlPDWyfhHKe2Y+8u3FbsfCJrfg56y5vrsa7A8aulq1m+kHy8GZj/B/IvWHRbB0AAr1TZsjCL3PhxWpJzNCmUTCPA51x2J5in6F+t4og8RoiDExN2SMabn1RlAP6E1I4eqzwoheTXzqkZxOQX5wFcCgLr7YKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164604; c=relaxed/simple;
	bh=g8wqZ3Zr0tCC79qz2WvFkGehZ8RXNBdGla6jzbSI/RU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElsZMz6h92+8d4SeFnsDfTxXOMSK7d2RoT5UBXv165+p/ap4aKb+e3pPWbkyD529SyCJrdERayRpeI1mxfPlx7eXdEKNLP2N/uEc+R9tB4dbs29PQ3YUUMZ50maEhCPCSWm5nG0kjxyICjrGot3gekftEeaUK6n8ZFu4mPVflgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djyyT0EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A59BC4CEED;
	Mon, 25 Aug 2025 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756164604;
	bh=g8wqZ3Zr0tCC79qz2WvFkGehZ8RXNBdGla6jzbSI/RU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djyyT0EHRX1QAxK45smHwN6IuRXDZbaFKiSjPS0H9kp5cmyWvJiJagZa1SL73JT33
	 /WqLiAtTBVnXYmux34tXeYh9ynLG9QstS2/FWn5EjcgOpJoHv6sfJU8SoEh+Vp3ibb
	 eU06ZjRrhTthDot+aykd0OlyarwYVPF506jSAbyIZoxs6xJ6oTHSZwJ5oskS/+G67F
	 iT2JdGBE2591uUIChR2HDK06+zKmwelF1lDnKmnDJ2g1iflKnSeqbbd6Lc9SDk2XUT
	 nxu3pdcNyqhVnRwRZo4OtVRBRWqfzRiSBALxa0AP2IjvGrJLXlS0BxBhPz1i+hXGKY
	 asKF2CSPdjTLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB7383BF70;
	Mon, 25 Aug 2025 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: ipv4: allow directed broadcast
 routes to
 use dst hint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616461204.3594857.2458593024741281518.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 23:30:12 +0000
References: <20250819174642.5148-1-oscmaes92@gmail.com>
In-Reply-To: <20250819174642.5148-1-oscmaes92@gmail.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 19:46:40 +0200 you wrote:
> Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
> whether to use the route dst hint mechanism.
> 
> This check is too strict, as it prevents directed broadcast
> routes from using the hint, resulting in poor performance
> during bursts of directed broadcast traffic.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: ipv4: allow directed broadcast routes to use dst hint
    https://git.kernel.org/netdev/net-next/c/1b8c5fa0cb35
  - [net-next,v3,2/2] selftests: net: add test for dst hint mechanism with directed broadcast addresses
    https://git.kernel.org/netdev/net-next/c/bd0d9e751b9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



