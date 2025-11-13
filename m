Return-Path: <netdev+bounces-238498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59418C59D54
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27BB43513A0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2031BC80;
	Thu, 13 Nov 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULzDQ8A9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE132DEA78;
	Thu, 13 Nov 2025 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063260; cv=none; b=q7NJmU7+rdjzfg6aKm3VGP61lXnR0cbDCPYCs1kF79SjI540SGu63Cf5+tEIzQHHOXBaGwoP1BZuvY/0JhsoPk2BqAAOCh7jPgIaqKZcmtmsQv6bVwOETqxvPG+f3HG4x1+SXGMjigtNpiXYerZXg7S5RDm4oWieItgs3HJGA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063260; c=relaxed/simple;
	bh=4Vb6H19M6jtJyEbWs4eU7x3zHV0CrRap2H8CE7USYZg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c+fvHDYwHl3o8Dwvm38+cL0YjJUmny8Ay/4HUcXxeIiGzaJIXF3U2kxilpl0AXsVlYIYTyPsD0u8ec7kJ0irH/U4SmyLd+8eoyrpJaY6awTgj6igPM1gAF/8EBD9/8gInFrH9h6pfO5UC98eAuyDyUn4XFAzwUosjpVztS7MJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULzDQ8A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6386AC4CEFB;
	Thu, 13 Nov 2025 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063260;
	bh=4Vb6H19M6jtJyEbWs4eU7x3zHV0CrRap2H8CE7USYZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ULzDQ8A94za3/Kh1GGlElkXRXOQrjHbOoHHx/nwSaLh0ONKnMXzil8C7AFhnrpOH3
	 DgwLeOZ9f3lj47BLH5HceN1NDwvWcDFQqYgF6ou6iz8aX0m4HiwIlvjnu/AzIhVfuR
	 87o1+z/dVZTn6h9Hib9Ldz5GqC5jDbRAqULgRxZLzZfAS7osSEVYqXr4KCFsNgSR7N
	 kkICeGCwcY9Ca4yKnDi640St2vXIcjbPsaQWFGLQDaw31QK2oh3GoKE2Z65uXuTGBJ
	 7HK6sw1O7I/TOdIpTpKeA5bi/wSDYimel6tIPuBZNj6ME7cXrYML5Oe6YWi2LsRNiL
	 ku2dkc439K7aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE323A549BA;
	Thu, 13 Nov 2025 19:47:10 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251113160009.177530-1-pabeni@redhat.com>
References: <20251113160009.177530-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251113160009.177530-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc6
X-PR-Tracked-Commit-Id: 94909c53e442474a432c57c96b99d99357ac3593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0309c054362a235077327b46f727bc48878a3bc
Message-Id: <176306322928.982125.2268383127397160517.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 19:47:09 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Nov 2025 17:00:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0309c054362a235077327b46f727bc48878a3bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

