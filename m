Return-Path: <netdev+bounces-127874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DBE976EC1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8575286974
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294521865ED;
	Thu, 12 Sep 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwDxi1AZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E713D531;
	Thu, 12 Sep 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158787; cv=none; b=D0xQA5J99SufxR0aJW7nFqjGGmByQToSNVDDt0sSJDtW7yot4T1xqwifoRiPp8RthL16t9GlGnvTvxZEq5idjm8FzXfZatTqpGYcC7rxOmJWIsuKOgiUczmxjau6CoMYKTeP1uQBN1RI1cm/mlOJxLDn6lE+RKaiaBhGjkyFjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158787; c=relaxed/simple;
	bh=4Z7jtrOl0UWubZdtzmzfoaPBkknC2ngZUN6Y+fHF4uM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aBsL9+S7eXqcIJmsc28fPRfDg91opLpY+jK+R9Ui4BAn4v7XUatE6DTX2Og/zloeTSDe16ZXd7KOZztzhS0jhgTsL4OfV1Vt15A0tWVc1l9zkHI8k98Twd12LzO+HLs16IMh9ijd4BZc5YKUgv422KwnilaF+FDlPwOVE2ajwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwDxi1AZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85167C4CEC3;
	Thu, 12 Sep 2024 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726158786;
	bh=4Z7jtrOl0UWubZdtzmzfoaPBkknC2ngZUN6Y+fHF4uM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uwDxi1AZVnCKJrOP6Y0r21G8qIPockhY1jsEOQS8p5rz4yvmQeUzvZj62kYrOFkjt
	 98Nfxuf2MiSw11iUZBg5aYCD+PdTxO81CWREDfYCWbvTMt+5MW8wXiWgM5vaUPXt6q
	 u+75J6ooX8P+kg17zCJly1Q1C9lNd8T07zB0yUqd1J0vxy7DT/BA4vkVG2AKY8RwbT
	 FufKnaGN4156Dn1xAtMgRqOSUtPwD107GJo3Y/bq4ke3dT+N+sdA3PDDcf5UoYCPEM
	 6ETfCTr+cNn9EuDI02OqDtux0k2oGSgNiE6NFEur6tr6rdU3Cjr389FUzuBWojvy5l
	 dt1Ns7Zqv/a0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7B43822D1B;
	Thu, 12 Sep 2024 16:33:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-08-30
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172615878777.1648954.15032352528421305228.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 16:33:07 +0000
References: <20240830220300.1316772-1-luiz.dentz@gmail.com>
In-Reply-To: <20240830220300.1316772-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Aug 2024 18:03:00 -0400 you wrote:
> The following changes since commit fe1910f9337bd46a9343967b547ccab26b4b2c6e:
> 
>   tcp_bpf: fix return value of tcp_bpf_sendmsg() (2024-08-30 11:09:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-30
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-08-30
    https://git.kernel.org/bluetooth/bluetooth-next/c/5517ae241919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



