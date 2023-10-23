Return-Path: <netdev+bounces-43565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC57D3E7F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5493BB20C0F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31C2134E;
	Mon, 23 Oct 2023 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTid+8Kp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2321340
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A741C433C9;
	Mon, 23 Oct 2023 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698084208;
	bh=XO15aQ4OaTTwsEmZcdXBiWanfxRs+POYEmcfVMrr2lw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CTid+8KpEObxYzsmWNTkSTB3TZ7cfgnFSx3Lm3oOYagfFERmHC2k5TA8M1oHTFqHc
	 t/1DVjyduRj3cE8NbE/OT/v93W2Z43a3NaO8R/pvXQXN9Fxv9jha0Qm1e7qxExnAsi
	 WcuKsYtWoo+9CDWPZ9RWQJk/PD34TRlAr92B4HauLNYikhQpV9EJylX/F+kVfoNWw2
	 lzhaXev0drhvOOKvE2nA7SEZwcJwOOaV3R7fgd/1yqWguWdvFAo1HprWMjD1tCl0Iz
	 vfE96Zi2U6jYPk5cd2/xVuiKZPlYCqchq6oieryg9XWvNnCSwCvJJsFG7BlFWCDRGe
	 WL/id1mV2QNfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57A55E4CC11;
	Mon, 23 Oct 2023 18:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231023010207-mutt-send-email-mst@kernel.org>
References: <20231023010207-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231023010207-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 061b39fdfe7fd98946e67637213bcbb10a318cca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c14564010fc1d0f16ca7d39b0ff948b43344209
Message-Id: <169808420834.25326.6759202324452461756.pr-tracker-bot@kernel.org>
Date: Mon, 23 Oct 2023 18:03:28 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, arei.gonglei@huawei.com, catalin.marinas@arm.com, dtatulea@nvidia.com, eric.auger@redhat.com, gshan@redhat.com, jasowang@redhat.com, liming.wu@jaguarmicro.com, mheyne@amazon.de, mst@redhat.com, pasic@linux.ibm.com, pizhenwei@bytedance.com, shawn.shao@jaguarmicro.com, xuanzhuo@linux.alibaba.com, zhenyzha@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Oct 2023 01:02:07 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c14564010fc1d0f16ca7d39b0ff948b43344209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

