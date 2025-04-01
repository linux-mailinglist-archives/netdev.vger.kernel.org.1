Return-Path: <netdev+bounces-178469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F30A771B2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD773188CF68
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4182E3394;
	Tue,  1 Apr 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="focuZ6Vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D75F50F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466211; cv=none; b=GW1aio/kemrHzOxlUuqm5JbMZK7hTzo7MHvn2B1Pf8FDMwOmzCgFU6AXHIMnJZ1wN7NFnc8gmJ782WaWvPr9aiCZJ+H0HmrHOdGVDCP1zbVcXefgjSHWUNX82a0BYC9D7SWdG+jHdZeD0rkGFfWY8wyzJxOVksUDLtxtXTpIMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466211; c=relaxed/simple;
	bh=0jRWFkFt2mfEJsNjGXX8UxIQuo2lJoXzdyrge8fpvi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHDhgqg923Wc+4wNGNmSH1sVUdP6bi61lnrv79y7S/eZnTzIFr+vTK4Zw0ynzVrIJDi/NeISAwx9hbtZB+C4t9u2ZDE9NIy0efZLfjMXHisagS1b9S7BoarysDft20KcwjlylBSfnGvJ15K0Fh59c5f6SP1ZdRL+TXpbQnIgNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=focuZ6Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F30C4CEE5;
	Tue,  1 Apr 2025 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466210;
	bh=0jRWFkFt2mfEJsNjGXX8UxIQuo2lJoXzdyrge8fpvi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=focuZ6Vs/02DhDrksFSDuoetPGnV44+ju/8WD2+Yyv2QMCKwcIufgipSxIOJxfImP
	 mvLL9TQ3YTHZ8ieOiJWSfM1LK1eiymvxuW1WR9jB5F5RFlu6mFS8eywp4WN7eo6Svg
	 6EuMRfWz8enfrqLi+V218y/DHgxldu5cBrGu+Dof1PWTsNS01rZoXsAVtDyQ2UdgbQ
	 T54eTFQGsHH+j41eBd5ZjeL9uNnq90H3DCBFT2G93l/57CGkFOA3X5dLvs109SXJst
	 EiujKngoYZ812LXOcVLLYUHXiBuIUHTFCkfGSQUmiI1ghplypZMTr4FzDPKbI7Anwf
	 8IhExW5m4HRAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2B9380AA7A;
	Tue,  1 Apr 2025 00:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lapbether: use netdev_lockdep_set_classes() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346624726.178192.9663627894432233004.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:47 +0000
References: <20250327144439.2463509-1-edumazet@google.com>
In-Reply-To: <20250327144439.2463509-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Mar 2025 14:44:39 +0000 you wrote:
> drivers/net/wan/lapbether.c uses stacked devices.
> Like similar drivers, it must use netdev_lockdep_set_classes()
> to avoid LOCKDEP splats.
> 
> This is similar to commit 9bfc9d65a1dc ("hamradio:
> use netdev_lockdep_set_classes() helper")
> 
> [...]

Here is the summary with links:
  - [net] net: lapbether: use netdev_lockdep_set_classes() helper
    https://git.kernel.org/netdev/net/c/7220e8f4d4ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



