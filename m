Return-Path: <netdev+bounces-228426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A7BCA911
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FB242571C
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E82566DF;
	Thu,  9 Oct 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJHX8Hk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C032561AA;
	Thu,  9 Oct 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034402; cv=none; b=QTg1w/lHDuMNWTJ3rM9OhRjAhpdX6L1z4PBn1kv3xcGNCfx9xqa898t7PSRbKlTdN50cFKtRTVch8p6jr67+E04of5ZY+mct8frMTBgaYZYm1l9nnYZD23Z8A3RmOux4IMcY0LKbBi9SKFzGyYdbe/68sYSVU0xYgtuV++Z4exs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034402; c=relaxed/simple;
	bh=b413BQzxEnx6+RBHiSAWKm+rPncljzxj53D5DacsEF0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oAYC+HxtTGeKGxqnnGFHyyDaWAqcCRpfMh6B8zl0p/VTbrqdEb1ClT6EO65AB0JJ5XH5r3TFOwEIiqZakv2ilCH1DZHdN9vQO2aL96ncEVQfABO19Ek2BPxk1JYHEhNzm8LJ4lhvhrPwKsWv7Odmf5Ku2p/R2KFtRoQIiHc207g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJHX8Hk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E0AC4CEE7;
	Thu,  9 Oct 2025 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760034402;
	bh=b413BQzxEnx6+RBHiSAWKm+rPncljzxj53D5DacsEF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KJHX8Hk5tuPJakWOpNAbTmurfmxKbREpHJ5uPKAWiez4TQTxqpWReQKFxHZnxwT1b
	 EfVT7lpET2uZcbJXmsB5OqyK4tygXPyAXOhoVfcJ6anrC9zkBT1oQhCuBIEzpuR6A7
	 6n99sfa47SrPLDIsyjsFucOjwWCuZ0uXBEKlXCejlYHfPP/AlgLOCc8kZhQke7enA5
	 lIyQy0So37zW8G/wOXccV7qkYZj7IHJ/Xbb5uVyjMEatNi267juqUcSJx0pYH2hfoz
	 nCT5iLMnMJ7fXop9b3GBjaqjq4iQnuJQNXBrT2dxGDRHaXF0mVxLIViLU1CADPJNpL
	 cFmEwozX4nvxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE233A55F9E;
	Thu,  9 Oct 2025 18:26:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251009132309.35872-1-pabeni@redhat.com>
References: <20251009132309.35872-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251009132309.35872-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc1
X-PR-Tracked-Commit-Id: fea8cdf6738a8b25fccbb7b109b440795a0892cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18a7e218cfcdca6666e1f7356533e4c988780b57
Message-Id: <176003439015.230640.14979744765809639103.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 18:26:30 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Oct 2025 15:23:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18a7e218cfcdca6666e1f7356533e4c988780b57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

