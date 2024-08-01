Return-Path: <netdev+bounces-115087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0EB945117
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD59A28815F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67C1B32AA;
	Thu,  1 Aug 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA6zWTom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E851AED45;
	Thu,  1 Aug 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531109; cv=none; b=LWtPOR0L48e7FHCRyrNOPEuLaIRKLsp2CHqqCgzxplD/fCu+bluAQuJTa06f0/tJtP+Xq15CYacEIF29PHNP4GH9LfD+qgNQUHkn5Q59Slj5MKdHkMN7GyVxYPyC0226YVRyRvEY0RI3f6IOVBzo/yPztqSCqwMGqcFdzSlhUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531109; c=relaxed/simple;
	bh=N08uFIg8IJ5XUPcOAI/3cQ9YR4LdtJX1tOqnKsc7ig8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bi3ql+/SCgGEOei/uljCGmASGQ9qd3a9nJr/leP4hS9IR+kuFREHXgENIqMAsqQ8WEg8eJHgjaCfBw8Oid1lftLWeLexKhW4gPH738fo/PpeIfvEPu9TkvCop0941ng60yM5AKD7tLitRWOV3O7iRSZW8zkeYVgTb0JiMLe+gU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA6zWTom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2376C32786;
	Thu,  1 Aug 2024 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722531108;
	bh=N08uFIg8IJ5XUPcOAI/3cQ9YR4LdtJX1tOqnKsc7ig8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iA6zWTomCc6lCY+A/5DoCHQL+bugrGRV/tbVIGN0AeIVKHzlyMCdIYInOpup+IcG/
	 8EFPLLn6zxrBVclxl2rGDE3YBCjzp/O2pGCsw67QaKOw7ifv3ZEYV+UHMa8CDz7+LD
	 TLVlW6YDhLeBVTCrL+xVz829ly4qMMfbrpMvWoIkjvMyJlqxuz84vxC30yjJR5k3aO
	 PrIvK30X1BEWu2lj0sJwU1S9bV9TPiUxDTf9S+XD6Y2cDiCGsU4kB1yKzeymtn+pl9
	 9NPQG/NjEr5lD5IAJ2uT3H1zJhMz6uzyoZbXKTxyeRMYRAcNRS891UeCRwe5zU61qP
	 Jb60nWlVEzKyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7E45C3274E;
	Thu,  1 Aug 2024 16:51:48 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240801131917.34494-1-pabeni@redhat.com>
References: <20240801131917.34494-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240801131917.34494-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc2
X-PR-Tracked-Commit-Id: 25010bfdf8bbedc64c5c04d18f846412f5367d26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 183d46ff422ef9f3d755b6808ef3faa6d009ba3a
Message-Id: <172253110874.24083.10454676813839813262.pr-tracker-bot@kernel.org>
Date: Thu, 01 Aug 2024 16:51:48 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  1 Aug 2024 15:19:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/183d46ff422ef9f3d755b6808ef3faa6d009ba3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

