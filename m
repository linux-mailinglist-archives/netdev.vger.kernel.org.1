Return-Path: <netdev+bounces-117357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3B94DAD6
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8721C20D1B
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793245FEED;
	Sat, 10 Aug 2024 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5pUcP+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190B282FE
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266637; cv=none; b=mMIJs3lNf6j7InquoI9LjFadjNSEpLUyqSbmWJBong+SaR9czoE7Z8sqgJGcg7iDcPqQSeV/BKMvMffDXJyEEeUQk+tZ6ekkTAMEnmWE1TlLPOxQpZW58ZUMNC1++sisCN3oWgq4K+X2hoHCy1nniWecGygIJWk4HNJXoQg1V9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266637; c=relaxed/simple;
	bh=BnVIFZ6JGOl3Sg53bojUBdMOM25M6FwzOLcqBepvhD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GOBB1/4Jgu+A2oVwBaUKMndrNSm1J3nmkz91OKSsnE/gHpC9uRHCkJZdp+RkZuE4YQClp9npMa3qidKGwGBXzvO/qBKtnkQpjfej9Hpan0ldMo5NrWU3FXN4uAVpHGOypWDLBCsJLI1V3tS3Rfd3iwrxU0ZVIZfQzKVLCRDJV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5pUcP+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB37DC32786;
	Sat, 10 Aug 2024 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723266636;
	bh=BnVIFZ6JGOl3Sg53bojUBdMOM25M6FwzOLcqBepvhD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m5pUcP+cmay03tfaa9WjH0acYI6aA/pg1OaNfJ4XTVSfTQ0v45nopckDitUnz+3Z/
	 nFlGx9p0pzSMikPxI/TGaygLCyfh+RohfY1GVWqpHJtzyNpB9XLyIc7up4uEBJ8Dpj
	 jtfYAT9FKbKdYJpQX+ZsYGMt8HyL5nfQMwCnSh+QuntuntSly93Qe1TcjdHrBHUUeO
	 0AbeinO8GoqLCzMZ3p5H9mbZ1mBjFGvAhqHLbhOBDieSc4yU48gyOzuYG3y0ZbcxJR
	 0Ko1CYW5wQ9KQMdLWt7pTb7O7Ws8im7dY4w09u0p5X4rBdprAeEWbQu7KgKxG65NId
	 TmErEUeCG8n2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB22D382333F;
	Sat, 10 Aug 2024 05:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gtp: pull network headers in gtp_dev_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326663577.4144110.3646843848333694986.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:10:35 +0000
References: <20240808132455.3413916-1-edumazet@google.com>
In-Reply-To: <20240808132455.3413916-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, pablo@netfilter.org,
 laforge@gnumonks.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Aug 2024 13:24:55 +0000 you wrote:
> syzbot/KMSAN reported use of uninit-value in get_dev_xmit() [1]
> 
> We must make sure the IPv4 or Ipv6 header is pulled in skb->head
> before accessing fields in them.
> 
> Use pskb_inet_may_pull() to fix this issue.
> 
> [...]

Here is the summary with links:
  - [net] gtp: pull network headers in gtp_dev_xmit()
    https://git.kernel.org/netdev/net/c/3a3be7ff9224

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



