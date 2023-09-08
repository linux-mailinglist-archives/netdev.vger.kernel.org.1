Return-Path: <netdev+bounces-32501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2E7980AD
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3621C20BDB
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A113EDD;
	Fri,  8 Sep 2023 02:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5C627
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 02:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BCD8C433C7;
	Fri,  8 Sep 2023 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694141275;
	bh=dUuDOZoI7m1VHLYkauov4MfNyEtITYJV+zU6Q6hXNAo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d3vq+tt911em7TIEDNY8WG54S/fkws4yY36B0WqKTlLYvn4cEyz7dRvKnkgOVvsWc
	 XLt52A8XI5dQWoBpGryb7ADeg/lkpbKoCA3nEWSRAx2OkI/AWSl1j3VkDlGJXlwszV
	 8yjZoKoFYIoEkaaT/1J772aRWE0VMOfcB2uiAZvf9pHe9EGT0mgWb5ITU1WqtvNAyk
	 1kyCMBikVM7/2D6gisH9lYthwxRWMQBWWeJp0JqnBkUUDalieGsdbO8GS3vsIq56ry
	 swDEcTKTUfbiWFYkGz+DcY27flPKNXtFhE4V03DZTYsvHWbjPPFaSMuFhpJOxzoibz
	 KK40goPMTspxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68A79E22AFB;
	Fri,  8 Sep 2023 02:47:55 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230907220103.3900219-1-kuba@kernel.org>
References: <20230907220103.3900219-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907220103.3900219-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc1
X-PR-Tracked-Commit-Id: 1b36955cc048c8ff6ba448dbf4be0e52f59f2963
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73be7fb14e83d24383f840a22f24d3ed222ca319
Message-Id: <169414127542.11889.2442967335814102525.pr-tracker-bot@kernel.org>
Date: Fri, 08 Sep 2023 02:47:55 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Sep 2023 15:01:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73be7fb14e83d24383f840a22f24d3ed222ca319

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

