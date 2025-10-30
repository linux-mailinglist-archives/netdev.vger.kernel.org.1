Return-Path: <netdev+bounces-234220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3EC1DF3A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A91D189C751
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43806225761;
	Thu, 30 Oct 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkUGctQF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A10224B04;
	Thu, 30 Oct 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785440; cv=none; b=hmAeY34Z019rW/satapHciloYiQmhbzU/DDgZtlY1aeQtKdCCcKYtj5HueHIcojDPfMNeeXafbKgg1hLn1YhELJRH+BpnLkVWufkB5OrBZObpNsFGdqRKxef/iYO6Gy99HDGloBo2GtNTq4U2bOUWiJYrA0l1/14iBFULk9TIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785440; c=relaxed/simple;
	bh=vnZXyLq7CzL9sjypCE8RPeWNgbfaEYPuQIkY3ng49xM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DFnoIjsQkSBx7i6+oQjurRWtgCxbPYgbbSvFcqDNUzX2qkNuNVVDTQiMRSO8nlNm6Avic9RQMw8iURNwqUZqFr12SDDyBsFICMBiRNF99HkrtMAplIybH7c5huN0CpUlBz8Eqxu3gm+fjhEiWvB91M3mLuGU7Bwk1JpsbsnIaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkUGctQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1132C116B1;
	Thu, 30 Oct 2025 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761785439;
	bh=vnZXyLq7CzL9sjypCE8RPeWNgbfaEYPuQIkY3ng49xM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZkUGctQFyCN/F5lPecr/Ww8Xzjr4wKL60ofKS6LsodyB2o/CZQ7NLXu5B9zllme9+
	 5jXegUsxPPeIhTe9XgXmCBKKR7zNiA7jZUkSprWzO7YVN4DyeK+iCadHy43lMtcQUf
	 KoyJPmm8OzU+TMerX4SmdsQ2Zexfua6hO/rX97VDzZR9TKzH8jAeoggze4P7gBb/Ls
	 UFbupCEJ391BZaBJOljzYL0M7tYlsWMdV1TfdGRTdg24U2ujJnoZQf3SjAjwXorrfH
	 LSNPsPxsUkX6KhtL/ZOUd+S4Mv27wAHYzmWhmAmLBvzzyGDV8GhNlkKHSZ3UXrrNcn
	 elqn3iYC1uFOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF873A55EC7;
	Thu, 30 Oct 2025 00:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: netconsole: Remove obsolete
 contact
 people
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178541649.3267234.3277325099608180756.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:50:16 +0000
References: <20251028132027.48102-1-bagasdotme@gmail.com>
In-Reply-To: <20251028132027.48102-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, leitao@debian.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, mpm@selenic.com, satyam@infradead.org,
 xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 20:20:27 +0700 you wrote:
> Breno Leitao has been listed in MAINTAINERS as netconsole maintainer
> since 7c938e438c56db ("MAINTAINERS: make Breno the netconsole
> maintainer"), but the documentation says otherwise that bug reports
> should be sent to original netconsole authors.
> 
> Remove obsolate contact info.
> 
> [...]

Here is the summary with links:
  - [net-next] Documentation: netconsole: Remove obsolete contact people
    https://git.kernel.org/netdev/net/c/a43303809868

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



