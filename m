Return-Path: <netdev+bounces-199628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F7AE0FFE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E7F3BF38B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A2294A0D;
	Thu, 19 Jun 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNKanNCb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1E293B7A
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375201; cv=none; b=FXeSqf95wjoY3cmMQvQdpNhtglYoXlruuuqHHFQFHa+FvKHisOTbDrB5l5yMNHwx0JQ+kiKyQbdNOVGgYonYNJYEeDo+180eN2gyFKJSrEgmpXiPl3xw1mGjtUNyynF+0/2IDsL6QL+IbLS5vTqi2vaAn+JB6DQ0yv2k2uGf/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375201; c=relaxed/simple;
	bh=uYeoBr9QcZkezJb3e7WhCKcwKqmmouIvoUG8flSb+jE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+wabdYzAh1tR1PUomrI8qpGpzyetLiUAlKejDBDaoRyIYV39XcD0z3Ii+KGWWJJDJB/RWdSR/qVO0NQ4ifmQQSerfh1ZOlI9dY+mWfqJRgd0hGxaVAdtS9Axhj8wMjdPQTeVWNxbqOFqxpE+IwlrhvbISn5nZTBe1ly9F5q6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNKanNCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B75EC4CEF1;
	Thu, 19 Jun 2025 23:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750375200;
	bh=uYeoBr9QcZkezJb3e7WhCKcwKqmmouIvoUG8flSb+jE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VNKanNCbWQsgqVKe73U3cGNv9gNBam1eouJNU0nAIKhF5bX1PgUgIzp8J7SQDZnuI
	 v/rdQAMl3/gJ185d4lHdzZVYyQN5BYmhiOF0oKZOwK4kjMqS/2mqcOOK2KcYTxncEQ
	 6ysGaRIoW5yKPsQ2PN7OtQ+uZzeJRHnWkh6xGIHoIAO771Qys9HMDuCJTvFocxyIXB
	 EIt6OlcM3T4VIo3WBFrzSZagX2RGbTkzquatzAEAvLUr/XssysN2VKeMix60E0hByx
	 0qQeb4LyqAaAxgHjQH8VUh2cXBrlc5K5UzBP5c8Dqy5pvlrw9WV0T+uQW5UAYAXxw4
	 eObcTDCVY6+oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB9A38111DD;
	Thu, 19 Jun 2025 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: tcp_time_to_recover() cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037522849.1016629.1966630668341007947.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:20:28 +0000
References: <20250618091246.1260322-1-edumazet@google.com>
In-Reply-To: <20250618091246.1260322-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 09:12:46 +0000 you wrote:
> tcp_time_to_recover() does not need the @flag argument.
> 
> Its first parameter can be marked const, and of tcp_sock type.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_input.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] tcp: tcp_time_to_recover() cleanup
    https://git.kernel.org/netdev/net-next/c/f64bd2045d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



