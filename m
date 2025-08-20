Return-Path: <netdev+bounces-215136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6727AB2D272
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5966171B52
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC782D23A4;
	Wed, 20 Aug 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsgA1j34"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242092D193C;
	Wed, 20 Aug 2025 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659504; cv=none; b=BR7vZ6llMCdgi/ny3r0pLjNq8ygtfZ1izORM75U/KJ3SLnhULU+MZC/5DNtiOBVpgF+MFIYU9zojXVHFrw3JFaUlCFZ/fgVOckwWnB09Yy32uoG9u1uvc8xxeIahqLDZQOLymbfJaFCs1qLc9rrkuiMSrVU54wDJII8SN+RqCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659504; c=relaxed/simple;
	bh=ogKew1U3pUqk+Z7jmzaJkcCKX8O3DkI4cnm/HGHH8O8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTfZ0qtapCBGybFYvBlT2r9Hc5QSoaqn3RiG2K/aHyGR1aDO0bvpJVj2WgA7BM4DWqUoqXu0yxavigP5lHN9QRHB6nmrrsctwsBHYJaqwrat1qPv3KDk5PDjqmtsZUAUiuTzwbHh9n4NyI3qGdzExPjVisfTj//xJKKzxlxUj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsgA1j34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55A3C113D0;
	Wed, 20 Aug 2025 03:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659503;
	bh=ogKew1U3pUqk+Z7jmzaJkcCKX8O3DkI4cnm/HGHH8O8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EsgA1j342RWKk0Bh9K0FXJ4ffHlhZWpgnbVw9Viu0OBVGDNNEGie3qOAzrypfTgpV
	 oSfOPxPro+cEzbDGIn85VONkw4U7DL1FBMRVSKOcfzGM8W43meqoJf1fM9czwtMmLV
	 PdRHZhWlc7160c/r+UBQFSKd52uW3x+uxDv2mp4f5qFXX3OIJpABkBhuh5IPRZEs3I
	 8QWR9k/WVas6g6obFcYPt0YzmBhdYt8+m8Q+7hsMdKly5v2EuDFqnh/OE6B6nL+Ie5
	 g7gH9EOSLdeBpyS4Rml5UiY6hvzEsN2iC9Mjagg/W3NBb/vc1DVbUEDJ6HYKEC5Lri
	 cvohNY36FP2JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE20E383BF58;
	Wed, 20 Aug 2025 03:11:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: ip6_gre: replace strcpy with strscpy for
 tunnel name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565951349.3753798.16066239520689231223.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:53 +0000
References: <20250818220203.899338-1-miguelgarciaroman8@gmail.com>
In-Reply-To: <20250818220203.899338-1-miguelgarciaroman8@gmail.com>
To: =?utf-8?q?Miguel_Garc=C3=ADa_=3Cmiguelgarciaroman8=40gmail=2Ecom=3E?=@codeaurora.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 00:02:03 +0200 you wrote:
> Replace the strcpy() call that copies the device name into
> tunnel->parms.name with strscpy(), to avoid potential overflow
> and guarantee NULL termination. This uses the two-argument
> form of strscpy(), where the destination size is inferred
> from the array type.
> 
> Destination is tunnel->parms.name (size IFNAMSIZ).
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: ip6_gre: replace strcpy with strscpy for tunnel name
    https://git.kernel.org/netdev/net-next/c/09bde6fdcd75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



