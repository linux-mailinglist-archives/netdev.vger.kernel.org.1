Return-Path: <netdev+bounces-241767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768FFC88044
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF73B2940
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40B306B06;
	Wed, 26 Nov 2025 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9ULTucn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652D523A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130249; cv=none; b=sFty7SR85dFCZW57oGCIct4zGBHMl1gcUgl92NXzNYt6SpZ6uX0AGk+T6ackbLmqImdUCPs9B9vwip8RawHZtngGgHJc574lj4gChe39lZ1fXjCIE2DhRe0siXZJ7pxePi6VxrJVwzPAnAKicEbthQ7n0ajjO5vwLuJJNZfHyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130249; c=relaxed/simple;
	bh=CpO6QRK6ofORKkJeBBqMcrn85mqqQU9gnEp3vS7+m9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cMgH7K+IyIbe9rEK2OX9MFqpa1xzlzdETHifEJ8zUYrPcNRfCXD+tozne5lnnuNifduyAAgWpnTB6S38k0J3756l00KOmoMJhVT4M5GRDfVE9EQGH+4y4RI0H/Vn4YFP4pDjtdIIkvnob7/Z0pM+Fa2dH6mybEcurxmRIUdR9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9ULTucn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE00FC113D0;
	Wed, 26 Nov 2025 04:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764130248;
	bh=CpO6QRK6ofORKkJeBBqMcrn85mqqQU9gnEp3vS7+m9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h9ULTucnRg94O8GBxtdDFPqtB01dpVJpZ42kErKJkKUwdXvukYHBwPJv9b4zd47M2
	 nStq2l5V2tfYQPQIxkfCSbg5KZ8uB4D9N1KwhLei3XeJdb+waAMLLPRupFT7bhiIoa
	 OuBFeeoQxmtQmgdxTYoURFg2mJAGzVGJ/rPhLftFOxRIsw4852hPK2KcACWScwFCpK
	 S0dgd/krwGBbdFVfrWUfoO8nj72hRNeZu/BQg/M5d6KYdZ8BoNH/eEmyjzBN1lUmj4
	 j8Za0zfAzUPDv/C5DBIb33yf9Wy7CLqxsBTAIjl7LE1yberGQx7JPMhWlJnniMHRBg
	 v5SyXSG10UKqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7A380AA73;
	Wed, 26 Nov 2025 04:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] selftest: af_unix: Misc updates.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176413021080.1516345.7488252395228812496.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:10:10 +0000
References: <20251124212805.486235-1-kuniyu@google.com>
In-Reply-To: <20251124212805.486235-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 21:26:38 +0000 you wrote:
> Patch 1 add .gitignore under tools/testing/selftests/net/af_unix/.
> 
> Patch 2 make so_peek_off.c less flaky.
> 
> 
> Changes:
>   v2: Rebased on clean net-next
>   v1: https://lore.kernel.org/netdev/20251124194424.86160-1-kuniyu@google.com/
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] selftest: af_unix: Create its own .gitignore.
    https://git.kernel.org/netdev/net-next/c/adb6b68c5060
  - [v2,net-next,2/2] selftest: af_unix: Extend recv() timeout in so_peek_off.c.
    https://git.kernel.org/netdev/net-next/c/ebe2f0b3cfe3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



