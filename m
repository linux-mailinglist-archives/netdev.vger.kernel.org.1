Return-Path: <netdev+bounces-15418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B7747861
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 20:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A1D1C20A02
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F36AC2;
	Tue,  4 Jul 2023 18:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CC63D6
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 18:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB528C433CA;
	Tue,  4 Jul 2023 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688496021;
	bh=IogvzP6FakYsbNXwJoo9CBdPhCAVxUWgbSnWiV+Ha94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qaTEFNIFHaLOTJDU900W6H656uWeLvDNHC7xuOOTkiEQcSgkc+IF2EBdMoeucrqmt
	 KRCBjN8vRQ8qjTDqcLMlnenNhOeZn0nou4n8eCLKBhdbn2lePTQRPNLWLHsz5TFPv2
	 LfSqFimz1TZg0ZnH00bzXkGLFAOmneOHTaHAb5aUD4Wicy/dBvVrVRSSV24k0Ft81I
	 lJwdVUCBEDbHAmpm84drEHI7/eWUniUcsoFFvmWwNI6zMGamRvEvB/5QOjkN69Sj4+
	 lhTxXPL8U1m7Yzu7hnqpY6ccRfKfxy/qOuEOjnN/B2U5yOGkHXs8XO2oqxS9sVWFGo
	 0B0NP33dj3bzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96DF0C691EF;
	Tue,  4 Jul 2023 18:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pptp: Fix fib lookup calls.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168849602161.25174.9350387635337780008.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jul 2023 18:40:21 +0000
References: <5cab1bbf6faba3277dab8fc36adfadc9cbf8722c.1688404432.git.gnault@redhat.com>
In-Reply-To: <5cab1bbf6faba3277dab8fc36adfadc9cbf8722c.1688404432.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, xeb@mail.ru

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 3 Jul 2023 19:14:46 +0200 you wrote:
> PPTP uses pppox sockets (struct pppox_sock). These sockets don't embed
> an inet_sock structure, so it's invalid to call inet_sk() on them.
> 
> Therefore, the ip_route_output_ports() call in pptp_connect() has two
> problems:
> 
>   * The tos variable is set with RT_CONN_FLAGS(sk), which calls
>     inet_sk() on the pppox socket.
> 
> [...]

Here is the summary with links:
  - [net] pptp: Fix fib lookup calls.
    https://git.kernel.org/netdev/net/c/84bef5b6037c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



