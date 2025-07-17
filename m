Return-Path: <netdev+bounces-207980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E9B09318
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2273BB0B4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EA7301154;
	Thu, 17 Jul 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXdhIIRI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9382FE336;
	Thu, 17 Jul 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772895; cv=none; b=KatsCHVZpxBRWwXKM/yNBuvY6SYq1lazvXhgJzqkG3XfqzPeZfR3b4oWy+pzMIJi43lSN5CrlqzHeTbwz0g3twlP5jvIblmitZHguS4LukivIHMEuIevzkzpHaOTGA5HN2zRGj1tfJisYyNxReU6BGumMCQwVXRunMUyhchqKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772895; c=relaxed/simple;
	bh=zoCaIb8PbCxsoJuhxCwuodiDu9p18ncxXn5UPHXh8QI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jnSuAOhk2jplPTmMC01azcqrYa++6KWQpoPNdyP+mNQWZVlr8TzFxeDxY99kUorZmHbuWX91KRl36QH1szygiCGDk23+OwnN+ydoSVPGfLYoDGYyQb4+4eF7PCfNNZh1li01fILqUa8wCzLbxZM3BJ6yxJHwijyBP7XMlQphDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXdhIIRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81CAC4CEE3;
	Thu, 17 Jul 2025 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752772894;
	bh=zoCaIb8PbCxsoJuhxCwuodiDu9p18ncxXn5UPHXh8QI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EXdhIIRIP0G8jcr+NK0+fZHWCp4kDayoTMLMwS0aoWwBWEdqrmQShTBeB6x5C/w7c
	 W8gfeLMxRU3eFCaRslgF0uyFcELEpQPSvj4rkBC60ry0CSbF0rjjJFbYl1ctgJ3MAA
	 u6ocZQ+EmHAH+UZxVOaZ0rnxsZ7aLpafGCER9eUSSw9fo7QkcQxPJIUE7kfNKnHpI3
	 tLzZNYRa+G6PENel2d6FHMzk996SkLsmC9hb7fVLDg5RudR/VFL4lvs7Vn872w0oWG
	 xtWfJZdbwjDazFUmurYH5du+U8ozM0AoxHM699bXTDWhtuYjViJMNlPHg1PnvDm1Iv
	 IT+64K+3cBjew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF45383BAC1;
	Thu, 17 Jul 2025 17:21:55 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250717160408.2981607-1-kuba@kernel.org>
References: <20250717160408.2981607-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250717160408.2981607-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc7
X-PR-Tracked-Commit-Id: a2bbaff6816a1531fd61b07739c3f2a500cd3693
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6832a9317eee280117cd695fa885b2b7a7a38daf
Message-Id: <175277291445.2014070.6643295637472221145.pr-tracker-bot@kernel.org>
Date: Thu, 17 Jul 2025 17:21:54 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Jul 2025 09:04:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6832a9317eee280117cd695fa885b2b7a7a38daf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

