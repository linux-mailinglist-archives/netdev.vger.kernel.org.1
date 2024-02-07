Return-Path: <netdev+bounces-69685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219EE84C2E1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43D91F28C25
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A89DDC6;
	Wed,  7 Feb 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9u2/vwg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC3F9C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274829; cv=none; b=DjbQPgFuuv1HTyx61niSjXQQg0sCsbTKHIWQBc7SW91mWZ53zl6OlfmFtvcH8ExYN2CkOy03Nm6W5gjhMCMUS5Rfvp/ZTRtZ0z9wM1NwRwf4bmkvNmQ4pakoIae/pZJWgpRrfHPgURFsWjnQEowaluXxsxGnx2JdhTzmS2M/z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274829; c=relaxed/simple;
	bh=9YApc8o/a9PRKdzbV7vD0zWRjv5nxsq01Z2EV3UwAu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUy9vKXkedrq6CpBfQGQaDFpKKRJE+ya4PanwH5giAMs8zHgIBRMIoOtODSlqfTQegupxppi0Xi8cnuzmNwtQCwhcF9MYMEMUWFFxGvVLgA9UnKgQG3WNmW+LbLzzGGkhU4m/eXbc3sjtRc7vIjBuj+xKzjfRD4HzADA+Pg1zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9u2/vwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4FF5C433A6;
	Wed,  7 Feb 2024 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707274829;
	bh=9YApc8o/a9PRKdzbV7vD0zWRjv5nxsq01Z2EV3UwAu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T9u2/vwg2NaERanMMGd6uYA5swsMvJheuY0KoN1CZpkOT0YcKnX9R4cOM52/AyVQR
	 q4ejxsLs1Nt2+Y6847kUhs2OpYs0b90HCAZn+q+PEebxI67KpriJ2NnnwKW4XF3wHG
	 UJrF4T9rCMMtp/OACeeHs80QCIWelE/ZTwK/OIyNrJ+uUYtiB+X6OjrH3zS4vXYsz8
	 wQBwEtlNClY/n2CDOC4olao7apFuinkzes3hoxxWtzC1cqfCXOFAGOYIDqObbsPWVw
	 JNTGUbvUFNSX18F61SofFscbuIQ3mn80jH7mM0FJ/KriEQByAZYw42zR6y1x4vIDLl
	 X+tn+p2FNhGcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B82A0E2F2ED;
	Wed,  7 Feb 2024 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp_async: limit MRU to 64K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727482875.2210.9189064134975201938.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 03:00:28 +0000
References: <20240206144313.2050392-3-edumazet@google.com>
In-Reply-To: <20240206144313.2050392-3-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 atenart@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c5da1f087c9e4ec6c933@syzkaller.appspotmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 14:42:58 +0000 you wrote:
> syzbot triggered a warning [1] in __alloc_pages():
> 
> WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)
> 
> Willem fixed a similar issue in commit c0a2a1b0d631 ("ppp: limit MRU to 64K")
> 
> Adopt the same sanity check for ppp_async_ioctl(PPPIOCSMRU)
> 
> [...]

Here is the summary with links:
  - [net] ppp_async: limit MRU to 64K
    https://git.kernel.org/netdev/net/c/cb88cb53badb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



