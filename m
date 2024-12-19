Return-Path: <netdev+bounces-153222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBD9F735F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EEC168EE4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70B19D8AC;
	Thu, 19 Dec 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H07iKZon"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B63141987
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579021; cv=none; b=CVy7q3p1OwHP07IiaD9kE/ftZmjHoMr3Nbf4uvlh4WvXg6krYEw90R793gG+VPRYJR3vAtmXhhLkb7mAARWPfP9G3i85JU0/7YaxPZr9A71wK+qw5FUsRttnzCuB/XpcQH685JPuJGPgu07z/lgYDdAESgZzZmczhF1wmF2o+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579021; c=relaxed/simple;
	bh=qCffcV7mpoQmCHv2TJe38D75RSt3Bo5L/+luEIpqL9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aBQ0bQ6cbcMsJfTabsq7c4JFKJ6RHGwWkHkGT/WIwl+QLnQzYn/AH0fU4OiPhYMX8g8C22WY/F35yl1cwXWFYKRG6rgQJR8QloSHNtO8HigjKchtZqc1F+XnyPiMwDPtC54El9sX5Z7h4pdz/vLkcICgYirre+SzGouf83z8TPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H07iKZon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BDC4CED4;
	Thu, 19 Dec 2024 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579020;
	bh=qCffcV7mpoQmCHv2TJe38D75RSt3Bo5L/+luEIpqL9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H07iKZonN4gSoiTg4pFVbU3tr+TlnQb+TDWXYKViW9YJKep3G7upQ5OH+Ahx4a0qg
	 1LtlSbaN1CwpXmhYkEET7pzpUXl0I+vrjgfQogXUKUXnl9/mbAhp0WbBlVBakLftPH
	 Hc/08jvxhYvaQ4PwvWHd/dYRRNJiEC1oWXVvV3nl1iZPMB1722F0Jy6k+XG4DIOfTT
	 Zfou+rNRkUHPGPktHjvCLkWXeJ0AW03sSXFAnwMR4kZHChEzFkjE30ypcGjwRSbbyP
	 xbDdK47La8SK3ZoFEKu+hq9H7E7zLiLjjd/tYLOvVA3RMLdLQFyHMeQLBNNlIaOOCG
	 104f3n5QWXLAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710533805DB1;
	Thu, 19 Dec 2024 03:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev-genl: avoid empty messages in queue dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457903799.1807897.248859377724715688.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:37 +0000
References: <20241218022508.815344-1-kuba@kernel.org>
In-Reply-To: <20241218022508.815344-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com,
 jdamato@fastly.com, almasrymina@google.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 18:25:08 -0800 you wrote:
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).
> We should return an error if the target object does not exist,
> in this case if the netdev is down it has no queues.
> 
> Fixes: 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
> Reported-by: syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] netdev-genl: avoid empty messages in queue dump
    https://git.kernel.org/netdev/net/c/5eb70dbebf32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



