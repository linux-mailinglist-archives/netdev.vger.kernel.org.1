Return-Path: <netdev+bounces-34066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E953A7A1F35
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6CB1C20B57
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714BE107B0;
	Fri, 15 Sep 2023 12:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2710785
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F41C4C433C9;
	Fri, 15 Sep 2023 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694782224;
	bh=j7EQ9egi6nTkZics5u17+M5e6Vfs08LcWcvUYFnL07Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DbE6seDCh8Li8HuuPxH9WXN1A0VMAfNLd6QlsQdcJ1H837duqvum5q23x0cbyjFeW
	 oD3awROKETSSu7vdkYkiidlS0ez2j1LGYMnMyee5MQV7JHreID5C09t9/jFz1bNH1+
	 /5rfFokG6hCaNkXOY5DBDOp4GOFHSqQavczUGWvSQo1eTyPLp6h7dlXPI1nrz0KljV
	 7hbj439Zg/AUzA34DuUy5gOY28mngtqCHp3ofv7Cc9onww8qtsbH3pwPQf0bmOZrL1
	 dWXxftSj9niLzg7ejxFCkS2v6bMQRWi5opUD6ohzTOEgdgnSBkKE1c2lWPVcWVeG7S
	 SVka4yijFWbQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D88B0E22AF4;
	Fri, 15 Sep 2023 12:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169478222388.4767.9033689483567758945.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 12:50:23 +0000
References: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: michael.jamet@intel.com, YehezkelShB@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, alex@alexbal.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 08:26:47 +0300 you wrote:
> Alex reported that running ssh over IPv6 does not work with
> Thunderbolt/USB4 networking driver. The reason for that is that driver
> should call skb_is_gso() before calling skb_is_gso_v6(), and it should
> not return false after calculates the checksum successfully. This probably
> was a copy paste error from the original driver where it was done properly.
> 
> Reported-by: Alex Balcanquall <alex@alexbal.com>
> Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
    https://git.kernel.org/netdev/net/c/e0b65f9b81fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



