Return-Path: <netdev+bounces-97224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7688CA178
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C5E1C217A8
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EA137C3D;
	Mon, 20 May 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7wFseYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF00A2D;
	Mon, 20 May 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226635; cv=none; b=bSf8IoKA3WLpZyBkb7nXc41LCweAOKGDHLJBdmgi7c7B8oobps0AZSGqyx78C/q9cxAgKE+jVCymv05y7KsKwB0gn7cj6ZkvPioZdsHoQMlXlNPNdQNepfTNbm2vx1nW2evxvo/Q+/2c/0WwO7+HYrnUKPr7JmZw0hg2dXV7a1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226635; c=relaxed/simple;
	bh=+c35VY+nM47X5XU7nqvHCYGuJZVzvWQ2lXzYGoxUU54=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XeWRA8HxYorhoV8gH6pD7ga/xs2deJVdtXeWXiApWdq38L6o5IDuwRtob05ZP2VkVq5/lf4LlIMn17lcVf242xBBPh9ATCikCluA1KhoocKZnw5tJkgXbKcCHnRr8I1rx/V5f+6qR/Y1H74fYvPmzD7I48cAhiR5XiHQE5G4dhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7wFseYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3C8FC2BD10;
	Mon, 20 May 2024 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716226634;
	bh=+c35VY+nM47X5XU7nqvHCYGuJZVzvWQ2lXzYGoxUU54=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h7wFseYLo24P9ZZjRB4bcTxBZ1NhQqs6cvuDtTdfMN3swLH6h5PdnbFHbzDOjGxPe
	 TKFOZDG82tLaklAPt1ipsftIh/zVsqmEJCsQqU0NHFbIqSNOw4vDc0kKmc8Q7QZKdc
	 b0JggNKorgM8AEHeacZTmBqrXuCsfE7xlo3Vz4rX45Z9sg/eialupB9bwGbgNrqQeS
	 JSLtdX+U/RNB9+U3ommInbL+u/gQdRP15wJyB+MWGRfQ3E7BgF4aiDLJEbxVsj0lKU
	 7QvVDydSsSDq26lA7ZGAAR5Q40uXiAKIR1HSzb8agEulQsSRVDxjELO9XnSrXSwA2H
	 cCw6m0axLYTsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA240C43332;
	Mon, 20 May 2024 17:37:14 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZktYriALqC7ZNQpa@infradead.org>
References: <ZktYriALqC7ZNQpa@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZktYriALqC7ZNQpa@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.10-2024-05-20
X-PR-Tracked-Commit-Id: a6016aac5252da9d22a4dc0b98121b0acdf6d2f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: daa121128a2d2ac6006159e2c47676e4fcd21eab
Message-Id: <171622663488.4663.13899900592813092105.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 17:37:14 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 07:05:34 -0700:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.10-2024-05-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/daa121128a2d2ac6006159e2c47676e4fcd21eab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

