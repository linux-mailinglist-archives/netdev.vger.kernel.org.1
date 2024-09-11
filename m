Return-Path: <netdev+bounces-127170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84218974745
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8011F260FB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630879FE;
	Wed, 11 Sep 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u50MFV3V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C212746E;
	Wed, 11 Sep 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014032; cv=none; b=ElD8YmJu45vTvhp8Q99+t+5M9AD9m6nW7V+xXR/jBXzbPyslkh8NxBwXq0e23xcdtPBWMivrf+i4S7um+oO31xQtoxKqB9Am5kYMKTrhtWlvuicGdJHxNowsNmklhy9c8CN+YGRCeetREe/rM0Ff459d3PWxU9kLm74fr7NdsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014032; c=relaxed/simple;
	bh=PY1O0A0R/pfoRTcw5WV6CQa8X2D5lqJ8LYaGP73jnEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FfAxm9TQTWCwYwSERAlU5OmbYDk917g//RmKAyENzF8HLzBgeGufHB9qzUbjUQMdwoEltD8PdONTKZjX6OFHHUe9bUfIeUWDVZw/kZ0alOsMKF7awwiKI3ahPeR4JryY09p1Oox12gIzhK4KN/eYhiOP+rSXm2Yp8Q/Jceude4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u50MFV3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB06AC4CEC3;
	Wed, 11 Sep 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014032;
	bh=PY1O0A0R/pfoRTcw5WV6CQa8X2D5lqJ8LYaGP73jnEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u50MFV3VjsxzH3/WDVcmYRhDXFKDRCmb2tO4jgcK7YN0hB7TaraQt24oR1G9KSJEU
	 AhttR3EX+ra7JJtIA9ZQ+r+LCOSjDzabvr/Pl+38REQWZEe9hS65I2iSp6JwRDco+B
	 2KGrFCZzi1GXcAqArDxmA11Lqct6V67YFCUTjRaNeQ8UyqFpLQ9uD13kWdy7n+LGPN
	 u5PMjYMzCad4T0lD7fgXNH3gUo44DHCD1jTZ53vzjDYbfmE0bgOrZAlH+TbX57DAk5
	 qkAXiod8yTz+vu2xXy6gJaWLauGB+FQ7RAcbUqpD5SfjFRC4qGQ4n45i5Qo6uRo7IX
	 eu7Qt+zY068UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AB43822FA4;
	Wed, 11 Sep 2024 00:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net-timestamp: introduce a flag to filter out
 rx software and hardware report
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601403300.437762.14539964956688733812.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 00:20:33 +0000
References: <20240909015612.3856-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240909015612.3856-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 09:56:10 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When one socket is set SOF_TIMESTAMPING_RX_SOFTWARE which means the
> whole system turns on the netstamp_needed_key button, other sockets
> that only have SOF_TIMESTAMPING_SOFTWARE will be affected and then
> print the rx timestamp information even without setting
> SOF_TIMESTAMPING_RX_SOFTWARE generation flag.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net-timestamp: introduce SOF_TIMESTAMPING_OPT_RX_FILTER flag
    https://git.kernel.org/netdev/net-next/c/be8e9eb37506
  - [net-next,v6,2/2] net-timestamp: add selftests for SOF_TIMESTAMPING_OPT_RX_FILTER
    https://git.kernel.org/netdev/net-next/c/fffe8efd689f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



