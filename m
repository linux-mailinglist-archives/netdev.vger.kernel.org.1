Return-Path: <netdev+bounces-31984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A1791D4F
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 20:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC9C281073
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA81C145;
	Mon,  4 Sep 2023 18:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC95BE6A
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 18:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EABEC433C8;
	Mon,  4 Sep 2023 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693853018;
	bh=P3waEknk93lpso15++IpTOfJPAM5bzNhE1bMrPIVuGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sViUpbyqkVXlv+vATJFmoAi3Q8ukaUKgpv2qd7NPVzJxoY4IX4NRs2tk7AOq8DZUB
	 PhM+6Z9G9DpU8XfimpDLGM/XloyZS+Jlu2OfFMCj/Bxy0NYwUkI7/mLQUneIZIjSau
	 ARjsCnKT5mcS5iR9dbTY9iNWfvRjA8n6iWeIeU8bW/yPwqmSLh3XEVwRSDCy3KD4N6
	 AXyPJadCGthdjr31o23gEAIui2CLUjppxRyIsuAiqSd/hob/HROCz5RsVurUSdOQMt
	 /ghwUhXVAkUOprAJcSq5jY9wgxtZTj+DfkM9SGELhx/NMCr373nCayNJVQudDMRxXw
	 ypLljV/qmmgog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BF9AC04DD9;
	Mon,  4 Sep 2023 18:43:38 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230903181338-mutt-send-email-mst@kernel.org>
References: <20230903181338-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230903181338-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4f1b8202fb59c56a3de7642d50326923670513f
Message-Id: <169385301813.15626.4404495470670396580.pr-tracker-bot@kernel.org>
Date: Mon, 04 Sep 2023 18:43:38 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com, shannon.nelson@amd.com, xuanzhuo@linux.alibaba.com, yuanyaogoog@chromium.org, yuehaibing@huawei.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Sep 2023 18:13:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4f1b8202fb59c56a3de7642d50326923670513f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

