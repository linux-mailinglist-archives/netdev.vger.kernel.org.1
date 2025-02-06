Return-Path: <netdev+bounces-163707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A77EA2B671
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE971889822
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98A237710;
	Thu,  6 Feb 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyG9LgW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FBD2417FE;
	Thu,  6 Feb 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883536; cv=none; b=SO7OilbQQnHt7iWEzr91aw6XSShEI5GUZ2M7gmFG0w3sPk6b03DJPInojuedp3982eLuePQFVo9PDtmAg0/T4wqN14DjXlef2+PNSj5p6rjiujhtk7be8I1S32a9BBLZHQyE3dJda1B6pR8tn2rzeiVmx81p51s3OvuP+0SWdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883536; c=relaxed/simple;
	bh=1npVm0n2p9HBT5ahkxhrDPzfusA+uX6S9yjzKYFO/Wk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HRqgtQ00/F4+Uzcg84MjF0ErTFEOe9OO9TpUye00eElqft19fC0bPd7t3IPQXQTIFz6ukB1RRJF7+oD+I+Y63My2L5VpjR1p2teIKT+QVt+o1YB3PnsalpY1f2NTYCYX2dxSkH5lKoKdC1uvweIShqQ1joc8IUfbcQDViZT7Q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyG9LgW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B444FC4CEDD;
	Thu,  6 Feb 2025 23:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883536;
	bh=1npVm0n2p9HBT5ahkxhrDPzfusA+uX6S9yjzKYFO/Wk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qyG9LgW/XVnVmXek91Ju/frXFSol73Rw/SBlLZQgOEyQ0nQzTMmnu55ZpKK/Z9JS4
	 v8eq7Sya9ArEbukx0X56HhkhPGPye3dLILsYe4QboIuPkGuykStqSSuMIGZaWATWop
	 wzxWRg42sWuZQVyj+3Ih2ohWbCzwQe1Fqt1ZejxNQI8gTFZpI+KgpbCcehXNCW33KM
	 92d4hJo6UVc2min2WgFtIcXosKFYo0TM4UQg3Itof535rnoNTSIumAtRuSD8QyCdiz
	 jrYkoZLOeS8NMUPkwCMIgYUYmggfkvmrLy6Mh4ebM9l/oImxZWxgSyM7GhkR8/40pg
	 9U/Z+pDi6W51w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD76380AADE;
	Thu,  6 Feb 2025 23:12:45 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250206123106.37283-1-pabeni@redhat.com>
References: <20250206123106.37283-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250206123106.37283-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc2
X-PR-Tracked-Commit-Id: 2a64c96356c87aa8af826605943e5524bf45e24d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cf0a98fea776adb09087e521fe150c295a4b031
Message-Id: <173888356428.1693200.10627873510500617874.pr-tracker-bot@kernel.org>
Date: Thu, 06 Feb 2025 23:12:44 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Feb 2025 13:31:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cf0a98fea776adb09087e521fe150c295a4b031

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

