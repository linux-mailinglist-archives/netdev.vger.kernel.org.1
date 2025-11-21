Return-Path: <netdev+bounces-240808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52607C7ACF4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DBB3A1ED1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196234C9A7;
	Fri, 21 Nov 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEWeIBeK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2634C838
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742049; cv=none; b=g5WchNgGoY8jV7ln3wOkHCtxRccNk7uUlttnUBqoI1TKD1MaQAiliOYFG84JaJyXunYXx+az83XfslGyERTjq4ZRasWMr2vrSLzPHibyMqxENxUbNYywKF1A7CJ+xUBik/BV1XiAwbueLfYGePWd+JjQs2XdQLvnG0q5jyxRZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742049; c=relaxed/simple;
	bh=6uD63G9bG5unvdGLVFpziWrZONgxhBixPttokQ+KGcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TaJX3ktIpykv4O4/zUdXWsK0BJwnBPE8tJd7pC4Pi+k44Jp+QqCCAGqt5AiPvK6fLh8yXKoEgbQX9Drt/iH8j4eVyZpByUsXU8EKo42upmVjGsPoA9vsrsJYQg4eIBPoOyiomQaVUcyGn4lkbvYbheQ03ZMWBjjrx0XVa/0XMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEWeIBeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D041C116D0;
	Fri, 21 Nov 2025 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742049;
	bh=6uD63G9bG5unvdGLVFpziWrZONgxhBixPttokQ+KGcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aEWeIBeKxUrmJ5sAduBOGjrmp9qnNYaMfARb7X2mcelcCEEi5DgbYA3kQUn6XyTxi
	 AE4/s+NE1pRHkGX72woZtAEwF0QVWj7cxJxWhylfSefQ/T8KaKCvT2i2yfQJpxj9LF
	 T2xItqdEc9pr+vRYyeg1mpu0Gl7yNpL+/tYsbMV9ukPSjCFlJQTIFOrgHFX2gOWFmx
	 obvsfQV2J6sLvyEJKBYgI+YCHx5yy7rAaIPkDs/xi5dijoLM0fut6AlUk1f9rO5QdL
	 19k6nKK8CneTT3sc0NHIYCoMHvw4oDO22+awO6gSZb0TKJwzH4xlH0NgJgfo3NBB81
	 /0rdAG8OKNUpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345EB3A78593;
	Fri, 21 Nov 2025 16:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 1/2] genl: add json support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176374201401.2493405.2218708038091698025.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 16:20:14 +0000
References: <20251115171958.1517032-1-stephen@networkplumber.org>
In-Reply-To: <20251115171958.1517032-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 15 Nov 2025 09:19:16 -0800 you wrote:
> Cleanup the old code and support for JSON output.
> The non-json output is the same as before the patch.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> v2 - shorten lines and extra blanks in non-json output
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] genl: add json support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0f678c6cbaba
  - [iproute2-next,v2,2/2] genl: move print_policy into genl
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=69942d75ccb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



