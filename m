Return-Path: <netdev+bounces-117888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFD94FAE8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7171C21115
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68E6FC5;
	Tue, 13 Aug 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmcva77r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A496FB9
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510836; cv=none; b=TMZFmf9vvQ4Cl7ldYYgrjmo0rgVEUd03MDdpPm0WR8NKLWbgkDdcKDzy8k1gAQgZwOlwYEKJpqUsNMuLn/IeCwkMnausmvLU1ImE9+wiFGyinkz6nfM6xfe47EHCUQmMCtIBQ86A9y5/0FD+6Wy7GGM0cs5rq2+MnrGB3SiFblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510836; c=relaxed/simple;
	bh=dHMvEqAqg9wv21ihjZnoZlOhMrEyA5/lwKGaRnUacgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U97lrAHoxv1X3s169O7b1kmjDBPYmZDfeRdWLQ2t9Y3Tc0zcGin7pazERpfCF2RpSqLKhfq1UJYSzZth2al6RETrrGMwyJprPI8AHme8nFIA9I3X5gC+YtndaXSkMQAb+rjR7nEFIXMzI5WIT9Oq/haBZJsxb8O/OQjWg19q+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmcva77r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38506C4AF0E;
	Tue, 13 Aug 2024 01:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723510836;
	bh=dHMvEqAqg9wv21ihjZnoZlOhMrEyA5/lwKGaRnUacgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dmcva77rFoIcCaybSI1XmXj4icIFRCxxDvXZXxRL0StoVpqolWGGZRJGpjKkKQjTM
	 DRu4I4tMdXBPbdcBIUHBz7AbyB1QilMKaykqeuV/0c/YVTmyrqebBxttuTMOp7hDcM
	 LU5Tww8zNVjqkfmEtaWlZB1FJQ4ZKFfAjhPrs/JSURC5eSORyiZjed4Jxxc3pZi9oO
	 wAG3noXo+wzvRTjiMmmIXwhO0PEEbSmCw5eh1M/glgZzhLnucVx179QD+S8Z+Ssdju
	 XBjq4xIt6ThwqDwL7VdEMUS9ZwayMpjIdgYsCEIvOksXQzkXxSv7rvJAt+e+xfc6uO
	 5UKGgo9EaM/3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F06382332D;
	Tue, 13 Aug 2024 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: eliminate ndisc_ops_is_useropt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351083512.1180801.3336772662367211099.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 01:00:35 +0000
References: <20240730003010.156977-1-maze@google.com>
In-Reply-To: <20240730003010.156977-1-maze@google.com>
To: =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@codeaurora.org
Cc: zenczykowski@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 yoshfuji@linux-ipv6.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jul 2024 17:30:10 -0700 you wrote:
> as it doesn't seem to offer anything of value.
> 
> There's only 1 trivial user:
>   int lowpan_ndisc_is_useropt(u8 nd_opt_type) {
>     return nd_opt_type == ND_OPT_6CO;
>   }
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: eliminate ndisc_ops_is_useropt()
    https://git.kernel.org/netdev/net-next/c/246ef40670b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



