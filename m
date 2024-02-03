Return-Path: <netdev+bounces-68791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC418483FD
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 06:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC104B27AC5
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914A1118E;
	Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDJ9JIkQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B310A13
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937646; cv=none; b=BEbptQPAp0c5dGJgnPNhJFTfJURaq16oIHvKbtHDttoldtOo65vfFR56Jdr90t0TmWf7dlJMwK2L0R6kUUNGe95hSon51Ksu6Lo6Gzguw6AX0eeANxLbHG9bEgQ0Y/J3zL/0YHvFOUrMVutY8wwYuqcUlNmk4ZdtTjbQxDXwTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937646; c=relaxed/simple;
	bh=AamW/t6/ThXarEGJM4m6JRiEPL0tS8wMxLtuucNmkK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mlhRpY7TEVJ24cUmtHq6TGyTKRB781zKpiWfausndr7G0WOloysHCbELecVjvvf7jpcaD5LadVD2r+KX0I0zchYsSQCfnFOY+QJ4aUT/xTs0/Rly7DO8d5wilgP43btWJtSoALBqY2IpyHTnk8oHu99LfBycTUhZL2VarSfWAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDJ9JIkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61498C43394;
	Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706937646;
	bh=AamW/t6/ThXarEGJM4m6JRiEPL0tS8wMxLtuucNmkK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sDJ9JIkQjg7DXxGM/W1KfiPHKdPM0gpxx1a+uiK/EfnqIKpM/zlItXqGvi1wH58bL
	 IfRI1bIvCVdpBqkoGbUBM9E09XgJkGDddtS5n2rQn4j/A60qw85mYBOPgpnXWxSRAu
	 RX7vsu0Z1GAT0pmgS96BTRqeSj/AdtpPZm6nh/zmqlbSXFNAfw1N45pInngO+HgJvo
	 Hp4bNXPPy84jY6pO/j5Um7kCGCb+TG1RRghQIfD01vUdMTPFyBbV945S29hmMbL+2o
	 Xr+V7gJkt+Im3xitFpiZzVszIMdDzwyg7CSbw5Cj2d2SHQ5Z8fagytdbvXWrgI/qMp
	 quh79l0f7qBpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49680C04E32;
	Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: make addrconf_wq single threaded
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170693764629.3207.3146420586272611202.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 05:20:46 +0000
References: <20240201173031.3654257-1-edumazet@google.com>
In-Reply-To: <20240201173031.3654257-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 17:30:31 +0000 you wrote:
> Both addrconf_verify_work() and addrconf_dad_work() acquire rtnl,
> there is no point trying to have one thread per cpu.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/addrconf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] ipv6: make addrconf_wq single threaded
    https://git.kernel.org/netdev/net-next/c/dfd2ee086a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



