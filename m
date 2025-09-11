Return-Path: <netdev+bounces-222354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A813DB53F3F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BA81BC4771
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94052EA74C;
	Thu, 11 Sep 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3hnysdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138C2E6CA4;
	Thu, 11 Sep 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634612; cv=none; b=sARHAt9lOReovNwWf2cp3mpNLrAWikuJ1KpE0XYMf7imCI68Z/cy9EiJJPe83Yl/jzroWpde2uyJrhLHYS60G4tN6g3DF1EtLFf8hj9S/2kH3Lcief16p5iPE7BeCDHLeDzvyc4jJ+7Lc4yImnUZyw5WD1WzL09dRqLzsbJ1fFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634612; c=relaxed/simple;
	bh=tzxMAvkGMKFlfP/9W/qKzkJcEbGCB6dgQ+x6p6zTgfo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aPWwFsWiREiptXCKVDsm/rzNoTj96//gqaln51uNUoNQob7b8EYsoCklXMe01N4rclB/pPqFCndv6MC2M0tWYOyxUVvKfUuqm8VHSZEsECEv7cJfnAYkmm425cmvP0CJUhZ0wKXm4vNfiXIfAUl0rned7g8oMrgd4Gu+sqYubOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3hnysdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8D7C4CEF5;
	Thu, 11 Sep 2025 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634612;
	bh=tzxMAvkGMKFlfP/9W/qKzkJcEbGCB6dgQ+x6p6zTgfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r3hnysdgRLfAJVbys6ARHHjr/nNnZvNqm8uFojim5V0hl3FQyLBgZti3J/RtFCXYh
	 F6UfMAn4K7ymCzIxnjhZu7h0Qv4sYKzNOjBGplUzdA6dej7lNBeC2reD1J91WC7cwM
	 SjoIMBKQrqR5lneuF7Nf0gyoLkB1YaQSRUmc3EH8KqAZROkZZqDxxpho4Ex7rwx4Ti
	 xLA/0eYKNyXWPviNIoV27g1vTpN+VoVeBymjn8/X9PPwShRxHoScCv1AP1NiZRbgCG
	 Bmfcn2D8KNOlMvLXn27UTAL0sy1AXcOQbRerjzBLxFcCNvDSkm6nHUmkiMqCRn40QM
	 j6//TzBqHmJmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB07B383BF6C;
	Thu, 11 Sep 2025 23:50:15 +0000 (UTC)
Subject: Re: [GIT PULL v2] Networking for v6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250911150655.60220-1-pabeni@redhat.com>
References: <20250911150655.60220-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250911150655.60220-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6
X-PR-Tracked-Commit-Id: 63a796558bc22ec699e4193d5c75534757ddf2e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db87bd2ad1f736c2f7ab231f9b40c885934f6b2c
Message-Id: <175763461489.2348576.7046877524975745020.pr-tracker-bot@kernel.org>
Date: Thu, 11 Sep 2025 23:50:14 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Sep 2025 17:06:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db87bd2ad1f736c2f7ab231f9b40c885934f6b2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

