Return-Path: <netdev+bounces-121194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE295C19D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B1AB21223
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99025187323;
	Thu, 22 Aug 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esYSQ03W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E98183CC8;
	Thu, 22 Aug 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724370744; cv=none; b=ZGAA+0z1lZHmATLVEOKMARQEXJGa3w5v3Gh/KPPvcwFBBuAjZi9UkbuC2EQnlEk8cawwPJrHQdf01+tcrJ4jCqgI2BQO7CyulmxW9UJEajH56Ei3RcfgpTHxTasljvSnNJtIm8/M8yFOJFv5J/ZmgU8IBjVhhSF8JWO55Mwss6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724370744; c=relaxed/simple;
	bh=gxGU1MHo1J+sZfWdnMIA4NpClQqr2XHGp5qRtK0wyns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KjdRsVBfyozIOH5SgJ5JmY+ia0cpuxn8ZT6ChyxDQ92ySYd6Fxq6fRnR/GU1K3KqmIeaabB7OXk7TKVCZKXIlylwSq15It95xOgFy1z6wiQqYHJPfKVUgjTYV41/iiczNwoj8cg+ot8WL5vX1lCK/KGPE6cTilTkDrDNTlfv++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esYSQ03W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B833C32782;
	Thu, 22 Aug 2024 23:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724370744;
	bh=gxGU1MHo1J+sZfWdnMIA4NpClQqr2XHGp5qRtK0wyns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=esYSQ03WT4yQt5Xy+gVyMotHHWcm8x4mx1Tn/CHORiCL4Up0EVd4l7fxlF8S2yohQ
	 Nbw6dfTcygRZyP+0NAzgMvWiIvHLg+k8F+QFZjadC+RjiZNxVmsiT9h+S+ojDVvWT4
	 C1iZGaEfs+C82XJQttXo7Kyz5cHV9/Wu+ifYkNIIV7k5pEjkrZaLOMBrL9jhNJiTMf
	 V8QCbmKegR3FmHwhk3f7SSVx307Kq6pAOAIG3KUhP0JOWdrosS1OX6XACdnErHDGV5
	 B3/PjRLHKIikh4jkhje2J6x0Kqku6Qp8z7IkQcAtzGOsuJEo6CuA54F1p2svjeVdDM
	 ape/3DzPx4NoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6033809A81;
	Thu, 22 Aug 2024 23:52:24 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240822210125.1542769-1-kuba@kernel.org>
References: <20240822210125.1542769-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240822210125.1542769-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc5
X-PR-Tracked-Commit-Id: 0124fb0ebf3b0ef89892d42147c9387be3105318
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa0743a229366e8c1963f1b72a1c974a9d15f08f
Message-Id: <172437074362.2507685.12571122128822017718.pr-tracker-bot@kernel.org>
Date: Thu, 22 Aug 2024 23:52:23 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Aug 2024 14:01:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa0743a229366e8c1963f1b72a1c974a9d15f08f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

