Return-Path: <netdev+bounces-99017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49538D3604
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99417288DAC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D15180A84;
	Wed, 29 May 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUOqqiI3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8053802;
	Wed, 29 May 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984630; cv=none; b=mGnAA33YcFIqVyjjaGqxKDrqkIHpRAmS08TrOpEwgxi5gsXxBCRFq3yy5eQb3HRcktnaQ0fhW7hky+xUfZzg3J4cZOHkxUyI6gl+DHO7+hAX5tMj9kcarhKvKEnX8xGrSF1o2Qr2PyMb6nndQZcpUl+tsHDbnCCVV1cwuqRSz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984630; c=relaxed/simple;
	bh=8NfucMNLvFp1QwhNmIS+QI1xk5Eqk7nGbvyzo69njHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEyw468Fl6UVtXPEnVR6KRZt1d4unTdm1LWm2RGzt2aFdoSk53QN7nKweeDCUsTXGkM6XWH0luQYVaQZsKh+RltM6vFl7ni3EhdohrOdydDy7YqkkX6dCHoNjzt//tGmfmYBVtf6kMjDh+YEjz6z+kXKWGMXWg5c1E9DNHsgwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUOqqiI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E66ADC32786;
	Wed, 29 May 2024 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716984630;
	bh=8NfucMNLvFp1QwhNmIS+QI1xk5Eqk7nGbvyzo69njHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DUOqqiI38l+G6AkVtWxJY3dfDJm6Db5b8pTbtr+4rz6+hGBX/Orzm/Duzl2gfwMQc
	 YaubxBgY7JY0oD7YXXNOGqPJCZ+zg6AO1PzADpLKnsYJ+RwDKVnRVlfpvmUyLbMDfM
	 GOI57/j/UWPRu7KPcB2kxGyMJAzv/d476FYcOmgwmzVJyOxDmG9F1adM6DnjawakQ6
	 DBw821zSYmMCwcQyDCtWJRkiLz7x4UhjfR5joanyKES8u22UCqfRSO7TvSwiMTK+YX
	 gYO3x+WJ5wQtfCZQSY1AdfQB3cFqQ9lS5peoUhP7pad4LA2Dnfl4WJzFpMeN0ynasd
	 T3pZF6TRBPbbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAA1ECF21F0;
	Wed, 29 May 2024 12:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfc/nci: Add the inconsistency check between the input data
 length and count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171698462989.27277.5441892226443327957.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 12:10:29 +0000
References: <tencent_53E8065F49BD2ECD2EC28C9AE7EC86EC5206@qq.com>
In-Reply-To: <tencent_53E8065F49BD2ECD2EC28C9AE7EC86EC5206@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 28 May 2024 11:12:31 +0800 you wrote:
> write$nci(r0, &(0x7f0000000740)=ANY=[@ANYBLOB="610501"], 0xf)
> 
> Syzbot constructed a write() call with a data length of 3 bytes but a count value
> of 15, which passed too little data to meet the basic requirements of the function
> nci_rf_intf_activated_ntf_packet().
> 
> Therefore, increasing the comparison between data length and count value to avoid
> problems caused by inconsistent data length and count.
> 
> [...]

Here is the summary with links:
  - nfc/nci: Add the inconsistency check between the input data length and count
    https://git.kernel.org/netdev/net/c/068648aab72c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



