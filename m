Return-Path: <netdev+bounces-33939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CA27A0B6B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 19:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5E91C20DED
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DF26299;
	Thu, 14 Sep 2023 17:18:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730026292
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D755C433C9;
	Thu, 14 Sep 2023 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694711932;
	bh=S/oPRvCIOqAzQbXStblC4xSp1oIYNFBV4KDPAvO8sS8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hF3xaF/uvSraa/EktDanhHBar7+R8spLaO0vteMkNYdHDozrHjPyz/ccXknGZgBO5
	 gJVzoj7Ke/w7OiedTTQ69089ydUlrT1TVWYzMGzLvMniC/lGK59NQvkRJL4+QoNrkR
	 dqBa9gNH9Un5DU1lcSDE3YTBeHmeNKc7NV9A0LZL8dVnPAJToXfTE8nFCWwXPB1nUx
	 sNJZFYQ6Kr+0rvx8UBtFCeCEZHhjgVV5xQLlZKTGoo+IWpzxDdLfFY4NF3BcP8OqIk
	 MQgAlUzrcMWz0KB4V19/j/2aMaWfYQNDBRpFK/VjPOS2ERQPZ/2zH5N2xxTVuq6BZJ
	 s0HVxMYQJxk9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B7E4E1C28E;
	Thu, 14 Sep 2023 17:18:52 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.6-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230914131626.49468-1-pabeni@redhat.com>
References: <20230914131626.49468-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230914131626.49468-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc2
X-PR-Tracked-Commit-Id: a22730b1b4bf437c6bbfdeff5feddf54be4aeada
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
Message-Id: <169471193255.25746.5742986007553004024.pr-tracker-bot@kernel.org>
Date: Thu, 14 Sep 2023 17:18:52 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Sep 2023 15:16:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fdfb15a3dbf818e06be514f4abbfc071004cbe7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

