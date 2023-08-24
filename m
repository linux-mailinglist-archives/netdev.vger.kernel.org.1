Return-Path: <netdev+bounces-30449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EA787581
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207F9281683
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD228917;
	Thu, 24 Aug 2023 16:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598610E6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC358C433C7;
	Thu, 24 Aug 2023 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692894992;
	bh=zojQnKMPjWgB6L+bB1U1uTZbs+PF3pLzI07QWXtDWlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W7W6kWy1jbkvL9Jm4GuXRiYtQ1VFxu4zpW8W2i6ypd3sg+Y9fq7ojxZPAFO4DZ95v
	 qjEM60Paefq9nbz1aFMJ0wELxNgEnUIZffHtAUSJyU/OTiES5sEp7FHUK2E+N2Myz3
	 ruuvhhKj5N906xS4OPDqOW6/2JlfWWdzWIwOc0iZUFFKSTYIc6kQ2oNnLwUuJ8dw2s
	 A9AoieoUpGeKn4Jo00BmQBNAGN6AyFOO6KzwQggeS39cJfLUrjoi1T9wn+57zBx1d9
	 hvVymuJxlIv/AhbeSs7eFY0qt7hImOKbO473ZfWwH0BsuOTQN5riTzBt29UwVoesmA
	 WdrpUtnUce+Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8832E21EDF;
	Thu, 24 Aug 2023 16:36:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.5-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230824110037.31215-1-pabeni@redhat.com>
References: <20230824110037.31215-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824110037.31215-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc8
X-PR-Tracked-Commit-Id: 8938fc0c7e16e0868a1083deadc91b95b72ca0da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17
Message-Id: <169289499187.20770.4238949788785682159.pr-tracker-bot@kernel.org>
Date: Thu, 24 Aug 2023 16:36:31 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Aug 2023 13:00:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

