Return-Path: <netdev+bounces-159716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87145A1699A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E818850C2
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3AF1B21BA;
	Mon, 20 Jan 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxkrJx+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3D192B9D;
	Mon, 20 Jan 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365407; cv=none; b=NGykk3cHlv40ITzjrEF55sgCMzRxmqZgXJ0UlAgRHGfaEbA/CcropW9NcKV9sQMT1ux1gzgRKXZVyynxXAlOMv6WbfLqCfHVoUj0ffDE7amvdV4MJ57HJSsH0Q2GM7crZaeWDwYBd+rhAzElAhxyeiuhkVB6ZSU8GFf1xpgG8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365407; c=relaxed/simple;
	bh=DYeH9jl/rbdh5LWfjxeeCO6j+Mle3v+oCo/ApNFXrUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hKBkk78Nmuuqt0CwVY00tXTNKbbgOmIXdDvBpaYs8u/df2wlztyFnbYUZYLcOM5qfMt1b+aucj+O+v/sLuGtMt1pZCc6xJPBlPQhth/V+e0OwOtVt4GbA4bcsCR+4B3SAaRWQXMKzksEbXjDZzR/zQmSYiK0OtSL58jOg2ion3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxkrJx+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E9EC4CEDD;
	Mon, 20 Jan 2025 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737365407;
	bh=DYeH9jl/rbdh5LWfjxeeCO6j+Mle3v+oCo/ApNFXrUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IxkrJx+JBjv4Ha5iGI94wHOxdvLXAN+aeBeDMg/+02PzEtL1oXNcsbmjLfBtTUCYA
	 fR7R+pKibuWejMu5EpgafpvXvDEA8D3/Qo4ukZEvhIm1Slp8X0PcDjz+xw7AH9bUMf
	 yYCE2XgCTA1OiwcH78zyAsJeO/VIiu6l9m3tpPgeJWedyWH8yexTtEFUXU5hAWypsp
	 f1p2IVfBoHSR8g3ILcfVJ75kLvVZLwP0NMy3vb9p7SXqtw+7rq8QPEeLIj5VQEk4JR
	 XfxXcF8eHkQCqW6N8ZtleY5vvoalyXYHaZqQFL0jyl2Ou7V2oibz49L0f9f4j8072S
	 UkuhkXaWQBqcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA9380AA62;
	Mon, 20 Jan 2025 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dsa: Use str_enable_disable-like helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173736543100.3461630.10452403872202995121.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 09:30:31 +0000
References: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, alsi@bang-olufsen.dk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Jan 2025 20:47:03 +0100 you wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Here is the summary with links:
  - [net-next] dsa: Use str_enable_disable-like helpers
    https://git.kernel.org/netdev/net-next/c/544c9394065f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



