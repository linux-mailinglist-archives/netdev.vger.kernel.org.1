Return-Path: <netdev+bounces-206935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE9B04CFE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191181AA36CD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21FD26158B;
	Tue, 15 Jul 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmHaE2oH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E725486D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539408; cv=none; b=LzQlIA8B24rGC7c8gO4mFRiGqnFB1S5PoFn5ec/p01UVsULHxvmMJD2YdEnGDGvI3X2wNulyAhCictBe40FUy+b1Xxhx5+AnKAG1c7gisOb2XYkViOP3vlJa/zJdjgOYNVj2J+nAo2yf9fUG52BPGwezi304jCXHixZ1+NetYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539408; c=relaxed/simple;
	bh=KJgO54QDzKjqes//C2aFjW+FWrvnQQXXjxRt1AYtTZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OWCyvAvRG7ZLbuwIaoMUY/wTlOM4XESfQcbaHOCiBTbxjHFihBQo4PpJUkl5ANmCZy1T+pKWaMAcopviBjrojoMJUYSoyh+L8I9ZP+w1GENNelXw6R9C2ZS5jwZYunu1+lFcA+juWh+3UZp0Cgn5l04JKEFiaswza3F6PEt/iCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmHaE2oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7B0C4CEED;
	Tue, 15 Jul 2025 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539408;
	bh=KJgO54QDzKjqes//C2aFjW+FWrvnQQXXjxRt1AYtTZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GmHaE2oHfwySyqCB53kuL0BEZIfcpURCs6RrxJLOjCwrcgPd4iaJdEndKYRpGbGbH
	 KQ2Ck6eu5jy8VEAdIukc5g7+7U36R2bpo0S+zFJADeuZaRCFQXTiI5D3gBjM+18vuZ
	 9B6gLDYu22SkMxSfOn6nfbDii/odRy+prQdtZJZYEpsaHhfzMGBkNUTxtGRkr1W/fB
	 Nvdu2i82zxfjxxGcj1oF++sue+zu3SFuHOxhP9Z4E9acA1ZrX0/ANu4y3RrKHL92VC
	 NNVEeYXh+BTHl4iEsO/WKTfaCz2GSj9Chf1sbHTULqz8KzbyrGw1XYmIknnmHuBaE7
	 7zXPLDqbwMhAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C74383B276;
	Tue, 15 Jul 2025 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] dev: Pass netdevice_tracker to
 dev_get_by_flags_rcu().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253942900.4037397.7252131903426955271.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:30:29 +0000
References: <20250711051120.2866855-1-kuniyu@google.com>
In-Reply-To: <20250711051120.2866855-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 05:10:59 +0000 you wrote:
> This is a follow-up for commit eb1ac9ff6c4a5 ("ipv6: anycast: Don't
> hold RTNL for IPV6_JOIN_ANYCAST.").
> 
> We should not add a new device lookup API without netdevice_tracker.
> 
> Let's pass netdevice_tracker to dev_get_by_flags_rcu() and rename it
> with netdev_ prefix to match other newer APIs.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
    https://git.kernel.org/netdev/net-next/c/2a683d005286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



