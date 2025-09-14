Return-Path: <netdev+bounces-222885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC3B56C93
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99F2177671
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C92E5B09;
	Sun, 14 Sep 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDjrUp9j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767E2E717C;
	Sun, 14 Sep 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757885404; cv=none; b=A3CPpMziTQn3bJpcNrVWunWP5diZpayy1OPkbcLf0io1fNTBWEaM/JIBDQm/aidwWJn+nD49Ktow93obAJu9zUfI1hCBEbxEdpTsbxdCLe6o4SorIlMqFRgTYtvFrH+7IocILnkNH5RTA2Gh/w/xaO3hgip0EMpBT7//UWXLxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757885404; c=relaxed/simple;
	bh=qdNAZE46co51PsMtx7vB+iaFO+MJfasqcPEOEwuXDdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gBmZGNFNGjp/P61lDj1kin7fPOPDk7GR7YEYtJEGgCSCJbQB8q2Y52dRmckiNyUwawANpaN4CRbIsGHjyiCpBxCuuKcnjgY6j+Ig2TUJb6SsgnyyZOVMEHxdULHBVjjk6o5FyPC+J7BBI3wWNnWITsrC58KI0gQq74/RXR+u0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDjrUp9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492D6C4CEF0;
	Sun, 14 Sep 2025 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757885404;
	bh=qdNAZE46co51PsMtx7vB+iaFO+MJfasqcPEOEwuXDdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDjrUp9jFf9SB8Pw6Yd7WwOINQHg18y/bGm2e4Ac2jOLynp2fOta/lVDSxVxEHqtR
	 RtHilQZqlOsnLZ2ADaxQZNCWFwSrSROxmXjZJyp3/7ngInJ/TCeZX+Pd7V9XCnXDih
	 GzMuFE5/2/RUaz1YZWUlWX66JxDpWxQ2vhpJRAd3/FEeR7C+sCEGAtwBNp+OCwdfre
	 LBOHaolbo8arf8dKLCER7rEZMlBCBy8VTRJ/SVX7AobubzpA+pX2kAZXLZ77F4UF2B
	 e8dNrE+Wtr8bGn9AMRwrLe93bi+o50rAHae7ZE9/tfiet6DqKfreuZE2ORfMpgD/jO
	 LJ9232jM2Ll2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB839B167D;
	Sun, 14 Sep 2025 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] qed: Don't collect too many protection override
 GRC
 elements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788540602.3556271.17651649327034572830.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 21:30:06 +0000
References: 
 <f8e1182934aa274c18d0682a12dbaf347595469c.1757485536.git.jamie.bainbridge@gmail.com>
In-Reply-To: 
 <f8e1182934aa274c18d0682a12dbaf347595469c.1757485536.git.jamie.bainbridge@gmail.com>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: nprabudoss@marvell.com, kuba@kernel.org, manishc@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, manish.rangankar@cavium.com, Michal.Kalderon@cavium.com,
 Ariel.Elior@cavium.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 16:29:16 +1000 you wrote:
> In the protection override dump path, the firmware can return far too
> many GRC elements, resulting in attempting to write past the end of the
> previously-kmalloc'ed dump buffer.
> 
> This will result in a kernel panic with reason:
> 
>  BUG: unable to handle kernel paging request at ADDRESS
> 
> [...]

Here is the summary with links:
  - [v2,net] qed: Don't collect too many protection override GRC elements
    https://git.kernel.org/netdev/net/c/56c0a2a9ddc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



