Return-Path: <netdev+bounces-27597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73577C7C6
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F82813B5
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6E185D;
	Tue, 15 Aug 2023 06:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67583100BF
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D254BC433C7;
	Tue, 15 Aug 2023 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692081025;
	bh=/r9zQqPcKHXB+/YvF7yHrkr2SnbTZmcfogf/eo9mkOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cJxPxsG17aAMpcZSikIySt2PtxQWKUNj/mhChyqABDGEiXCKdQ07P9M/AJCnVmxGz
	 5oIQIJ4dSh3j38iEIgGswQWJr9RhGgCC3R1MxSXnbMVXYiSwMk+uyBxl3QDxW/odgv
	 XvktYKCquvmtwMppHmtSAs9LDVuefondZZwQVqqK5tvH9wJB3jcDgH7nirQhvtOBFU
	 zGNqAXN6i0z4reLupSqs7/QN2+XEeZx8S5/Lk6CJH/NISrkM+AnfoCHWnll0BlKiQI
	 xWX6BRIYgn5F0araMzIX1wc6RbQF2oJnj+6YW1fZ7945JoyzqKl/OYiZAz4lkdjgdT
	 ciTwsOVVVW/aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF043E93B37;
	Tue, 15 Aug 2023 06:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230813190803-mutt-send-email-mst@kernel.org>
References: <20230813190803-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230813190803-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: f55484fd7be923b740e8e1fc304070ba53675cb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91aa6c412d7f85e48aead7b00a7d9e91f5cf5863
Message-Id: <169208102577.2851.3010271963190642664.pr-tracker-bot@kernel.org>
Date: Tue, 15 Aug 2023 06:30:25 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, allen.hubbe@amd.com, andrew@daynix.com, david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com, gal@nvidia.com, jasowang@redhat.com, leiyang@redhat.com, linma@zju.edu.cn, maxime.coquelin@redhat.com, michael.christie@oracle.com, mst@redhat.com, rdunlap@infradead.org, sgarzare@redhat.com, shannon.nelson@amd.com, stable@vger.kernel.org, stable@vger.kernelorg, stefanha@redhat.com, wsa+renesas@sang-engineering.com, xieyongji@bytedance.com, yin31149@gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Aug 2023 19:08:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91aa6c412d7f85e48aead7b00a7d9e91f5cf5863

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

