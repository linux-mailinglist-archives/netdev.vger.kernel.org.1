Return-Path: <netdev+bounces-45975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21E7E09A9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 20:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F6A281DC6
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553522F18;
	Fri,  3 Nov 2023 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBfZ76UI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C26224F2
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 19:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA332C433C8;
	Fri,  3 Nov 2023 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699041191;
	bh=gtUw4RPRjMt1Nyb0AWKTy04Y5Gx4hhcBEDtVDpIp5K8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MBfZ76UI0TpVznlRzVsSCaYD0TqdU0cCozfXuPtXvQZr/CJBUVBQwDGTT/bkEfg5U
	 3JhIrW0PwAGXTv8MJ3qqUnXWq/bE3ve81T3Cz6YQB7lqKqt0veCxLlpyASC2tB6OAp
	 OfdxEkKwtuKDUjUrGDlZPQMYhhJNO2uFfVC1rDLgq9AwM+KqcGsZryZEBS/VT/EN/3
	 X+xc+VF7Sj3Tqt5ZGSGqrnPZQ8D69kbyPfVddVvwA85UcESAdMaLYC8osFQsSMGEuM
	 rHLcejTBOfViWGD2DkIlt2SbkKAZtGKrLHiOxdNBhXHLYY8BukKBuBEfMJlNL/Cmyz
	 6SfFEvsX72npA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7119EAB08A;
	Fri,  3 Nov 2023 19:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231102131354.263678-1-mic@digikod.net>
References: <20231102131354.263678-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102131354.263678-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.7-rc1
X-PR-Tracked-Commit-Id: f12f8f84509a084399444c4422661345a15cc713
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 136cc1e1f5be75f57f1e0404b94ee1c8792cb07d
Message-Id: <169904119167.17286.18185542030780239189.pr-tracker-bot@kernel.org>
Date: Fri, 03 Nov 2023 19:53:11 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, artem.kuzin@huawei.com, yusongping <yusongping@huawei.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Nov 2023 14:13:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/136cc1e1f5be75f57f1e0404b94ee1c8792cb07d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

