Return-Path: <netdev+bounces-15257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B6746673
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 02:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9182A280358
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 00:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571D36A;
	Tue,  4 Jul 2023 00:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825207C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48B7EC433C7;
	Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688429808;
	bh=4Arucsbx7xXqBiJTMaZ2sHKWBFMCtusx1d5m5Uphgso=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DkAAGrdnnnfiwiC89o0VZ3uslqIdbGQ6SfUpM7T/TzojYaMGDyAxiJ2vC2uTbN4zk
	 NssPpXz/RhgXyiib8WCc8DEqbGdbxZ4E1v2zDLT9CFBSnk9HVAQfERCOUV6XgdswW4
	 yRZ1eSozjbVnr8qyOpiGZ7tial8XQDe2GHfmWsl1GkbTJTy10GyHLhefqUq6nVBYFT
	 CffYwH9WR7ydcQoSL3QV+a+TLWW/StZElppe/qNzKvfgP3Ye9tDCetQykuTJ+iPuYI
	 EjyL1N2CHSQn2ckHuPh2bicLfW/tRh93bFF7XkKRzB9m3XOrEYxjtpwEW2bAiOYhCQ
	 0M1lH9fBRUkJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33BBCC561EE;
	Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230703123256-mutt-send-email-mst@kernel.org>
References: <20230703123256-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703123256-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 9e396a2f434f829fb3b98a24bb8db5429320589d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8d70602b186f3c347e62c59a418be802b71886d
Message-Id: <168842980820.28751.12949460743497751873.pr-tracker-bot@kernel.org>
Date: Tue, 04 Jul 2023 00:16:48 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com, dtatulea@nvidia.com, elic@nvidia.com, feliu@nvidia.com, horms@kernel.org, jasowang@redhat.com, krzysztof.kozlowski@linaro.org, lingshan.zhu@intel.com, maxime.coquelin@redhat.com, michael.christie@oracle.com, mst@redhat.com, peng.fan@nxp.com, saeedm@nvidia.com, shannon.nelson@amd.com, tianxianting.txt@alibaba-inc.com, xianting.tian@linux.alibaba.com, xieyongji@bytedance.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 3 Jul 2023 12:32:56 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8d70602b186f3c347e62c59a418be802b71886d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

