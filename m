Return-Path: <netdev+bounces-156885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82577A0835F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A609A3A7F8D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5388D205AA4;
	Thu,  9 Jan 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ96rqBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D01FCFF7;
	Thu,  9 Jan 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736464846; cv=none; b=SS0Z7jnLLnh2ODv1gdaM4HIqdJLZAqv4xrUvyHxFpXt31wtz5S+AxoJR5KZ8eiewoDHW0ehKQ7K5ODBu/LlnODYfp+1uoQxalF2zY/J4FwOXKVyRgH0XllM7R/qDbLynI6ke15vVEqgFGy0Yc6JvpwfYxGPDxX5rPOYw8HrbJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736464846; c=relaxed/simple;
	bh=DEgfqbU/jsY3ku2DNiqBd1YR8lIkFTsUg02q7kBihwo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aeCZ6HYdWOc+QZQzb90xVQ5Qix6MmhDzXIBC5230TKa94XQLhYQkxz3MhXas+JHCRNSVYB641YPvsUxbq31Lf/WWU7rs0tSmEOpz+++kGtJfooqH6l3wr8mnINGzkgRcFjP0jwVlbGVRCStpnQ5Pke7Pc8Fg2Qg7fduS11fP8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ96rqBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01683C4CED2;
	Thu,  9 Jan 2025 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736464846;
	bh=DEgfqbU/jsY3ku2DNiqBd1YR8lIkFTsUg02q7kBihwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rJ96rqBgHtm/SP2In2vM9JB3hOopKSSG43FWfSO21E4gZ8+DT/cM5c7YCNrA+UKZJ
	 zAerX8aiDb3pwpqImf1u5pJviKVE2EIaiBNmxdP2x5+9W8w7Mju3/PLQOFCKo7SWtd
	 HvEEJuJzSrUJPvooP9y/WfTzv15+YVpx7TKwjzaudtaykhv5gcBiuVD+8x8o/6KJE5
	 J+F1W04gqvWVbJxmOOl7acoGmpRzfyOYmB2rZNNgFmXaz0K6vTVENCfOjRXy4gi7cg
	 dMcBa02b58+M3ETjzTGtWlCV89POo/9xrs3Mukqy3vv8Om+Y/qgHQ/ybN1nc1ZPqbF
	 1jOsr3Kh6nfiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB154380A97F;
	Thu,  9 Jan 2025 23:21:08 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250109182953.2752717-1-kuba@kernel.org>
References: <20250109182953.2752717-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250109182953.2752717-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc7
X-PR-Tracked-Commit-Id: b5cf67a8f716afbd7f8416edfe898c2df460811a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c77cd47cee041bc1664b8e5fcd23036e5aab8e2a
Message-Id: <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
Date: Thu, 09 Jan 2025 23:21:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Jan 2025 10:29:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c77cd47cee041bc1664b8e5fcd23036e5aab8e2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

