Return-Path: <netdev+bounces-25777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81296775718
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF2F2816C7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809F6131;
	Wed,  9 Aug 2023 10:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C41774C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7516FC433C9;
	Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691577021;
	bh=LyTyAYcCWhy9P1GM54GMnaf4Zhfavzu7QLAWbY47FA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W0GqgS7sx+m94LDu/2FtqmN0I/VrpMU+lcjinEdW/yiYvzh1KWPjE+Uqb7uw04oPB
	 aB0U9jttBb3uZTUv9yZN1cmZbp236k6lQeSYhHvA0wqXs139UOBeziJWiX1G3xOabj
	 Z6n3g4i89DTWDhGCBQs5YA26ADJu6guVYWNd0apJo+l2GVKtpJB8wYUNCVg4ZzIoFf
	 Ow30ss0aT9IVD8JVJNf68REM0p4MAq/YK/hZRb2sUyvspbCjVqExB6wiCbQdoMpC/j
	 PJg+wrjHNoKrWVo8TgVj2MyzmiRrIuz40K3px1IxJOSsScctMMB4XTVZ/7mySCEfAZ
	 TIHrf0ggW5lLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AEA0E505D5;
	Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net/smc: Fix effective buffer size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169157702136.3448.10286079156198080744.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 10:30:21 +0000
References: <20230804170624.940883-1-gbayer@linux.ibm.com>
In-Reply-To: <20230804170624.940883-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 pabeni@redhat.com, kgraul@linux.ibm.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 19:06:22 +0200 you wrote:
> Hi all,
> 
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> and make them tunable") started to derive the effective buffer size for
> SMC connections inconsistently in case a TCP fallback was used and
> memory consumption of SMC with the default settings was doubled when
> a connection negotiated SMC. That was not what we want.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/smc: Fix setsockopt and sysctl to specify same buffer size again
    https://git.kernel.org/netdev/net/c/833bac7ec392
  - [net,v3,2/2] net/smc: Use correct buffer sizes when switching between TCP and SMC
    https://git.kernel.org/netdev/net/c/30c3c4a4497c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



