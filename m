Return-Path: <netdev+bounces-12772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E6738E45
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB732814D3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002F19E5B;
	Wed, 21 Jun 2023 18:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272819E45
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12CE9C433C8;
	Wed, 21 Jun 2023 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687371180;
	bh=JXqUTk3bAL7lIp/+McuHuC6bhVEpHHo5RmL3WoZgySM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mpljp096lG/UOs983g+oL+GsTsdc4r3G+2alw0KJjQFaC1WpkF1tNF9oh8FXA+3iZ
	 CbO+IfHWL1mWmqttHiY66eRDNTu6E/RcxNbQPwWvVlxAA6zqhf6xkBhxX3UafUWrZk
	 BEdzZH4Ccfx7dAwaLx4LVc4yWNZdp8gwtnHMb/ne9DV0EFeD7X/o+3eGJR1u/9IeI0
	 mDnc7M+cll5/W+erxd81Fm6AbXfN6GAHeUba6vvjmiRzhGmMa+F6GUXpX2EUJ24GHb
	 Wcf40u1O7jeAyDsaQ8z/dPk6WbewiSmgCVrXb11r4rmqvgGXE4Gj4PBVeq+bPRwY5Y
	 1ZpwP/63yiIsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF8B3C395C7;
	Wed, 21 Jun 2023 18:12:59 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: last minute revert
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230621110431-mutt-send-email-mst@kernel.org>
References: <20230621110431-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230621110431-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: afd384f0dbea2229fd11159efb86a5b41051c4a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 007034977130b49b618a5206aad54f634d9f169c
Message-Id: <168737117997.28078.10365893103159189763.pr-tracker-bot@kernel.org>
Date: Wed, 21 Jun 2023 18:12:59 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edliaw@google.com, lkp@intel.com, martin.roberts@intel.com, mst@redhat.com, suwan.kim027@gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Jun 2023 11:04:31 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/007034977130b49b618a5206aad54f634d9f169c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

