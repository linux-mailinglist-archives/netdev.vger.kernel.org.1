Return-Path: <netdev+bounces-83480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9F8926EE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 23:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C3C28446E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B02335D8;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPl6KWXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0D849C;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752630; cv=none; b=biBVEMUQ0pD3FmSkiJ9sxBbHb4wsOhsdC/IdJPvSVut/O5ab4dGWb/JB4h7/kIEea7Isbp+0JWXbQcGvdHqbf32MGnBZgKI7LTgHmREL4Pk2n46xU4OUudeIhI1EVYcsawHRF/XjZfg9gyAd5m3VwiZcrlemZWbTe6IRaYs1fSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752630; c=relaxed/simple;
	bh=d6GYHZj1nwm/xAWq38KgFLCAjeu3oj6MG7PKrVN2dik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epB2fowdHfquABx1fTbw/pWYcb7zELL1S85TXQhbSuZrEdOy/Iw4/M0mheG84kZyq9ge+0D74lr7YAuOo4SHQnxknXl0v6xGY3rGARafXBaZC+G0Jox/R9OWJYbvCTSHCwEFwQljA768dYbO0avYQLgSYa/IHcgODQ4U7H9VZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPl6KWXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3013CC43394;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752630;
	bh=d6GYHZj1nwm/xAWq38KgFLCAjeu3oj6MG7PKrVN2dik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QPl6KWXQvu8etNRRr+r8OMKyD6R97QbdR9BUKsTPtOE7Kqjbj0Wzwr2xkLyiUBOCj
	 EhPM3BDLS7sB3nqz8OwL4C5r4EVrvhikxo71yksyhl6g8RZix/5BP7LjrYPeBKOfUp
	 wBDjGqQX99DbyBqqEiSjvjL/oqo3Zl0up2BrkC0QCEcbAAzoAyb4Ht/h7gmsISUFFH
	 bFa5SbbqTmqpeirrBBBF0jFPoiF2SQIFEgVHTAO0enqA8UJgc7iNjAzyhoGYr0Io7u
	 qqFGr/qSOegSrVvqT6lM2WA3H4zZrrLtdkBIK1J6oKBNL/j7HGWNFywkVMJdW0nwTT
	 vR5M4jXKxAarQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22B38D2D0EB;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-03-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171175263013.1693.13688049482640225166.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240329140453.2016486-1-luiz.dentz@gmail.com>
In-Reply-To: <20240329140453.2016486-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 10:04:53 -0400 you wrote:
> The following changes since commit 0ba80d96585662299d4ea4624043759ce9015421:
> 
>   octeontx2-af: Fix issue with loading coalesced KPU profiles (2024-03-29 11:45:42 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-03-29
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-03-29
    https://git.kernel.org/netdev/net/c/365af7ace014

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



