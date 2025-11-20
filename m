Return-Path: <netdev+bounces-240493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10105C758C6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C792A2C13A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693636E56C;
	Thu, 20 Nov 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsLAC9l5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365236E55D;
	Thu, 20 Nov 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658311; cv=none; b=ZIJSjU6DgaReZo0EL1ED4kF99E6dAr7leHefw39LaaE6Ega5rM5+UcOx+uMlIVO0qy4uEQi6SErR2PwXnXbyra7UiUUKfEqBeBL8LXT9/XBTPUMC84PC8SA82GqNSzQ96lwA8y1+DpX+820bq8cBo3T9LL3f0uL5pJdItibQYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658311; c=relaxed/simple;
	bh=iy2DxuhkWszpQxJcvNpt22K+b940k13QyvZL3o6XXNM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bj4mAsDU10iSo3oI4F8XUTQFfLt30jZdmpyc3fR12JIkWdAesLYkHRm+7I2+pccbrJboNuSgJTJKmsCZRFeExQcH2mWIl7EiSxGcDRoOLKlFh/5Nfj82itwtIZxVAj80MsWtvFDIdlfm3D+sop6c9tAl4V8SGjqN1gA4vG0COGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsLAC9l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81B0C4CEF1;
	Thu, 20 Nov 2025 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658310;
	bh=iy2DxuhkWszpQxJcvNpt22K+b940k13QyvZL3o6XXNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OsLAC9l5WNEVCpvPgGF586UKvbsHZ3LIaNvBMbKe4IQhb5IF27fP04yTKgtolxbTg
	 6Cs2PnwN/oBoqkabnWI+y8Vcp2RXPxqUrqLCo8oPMAOx4JEdidrm/ruGBdDDekdG/h
	 Vx9smAdnGptxwTdDoU2/nytSSyXrkSNz1t09/KC7UzkC+lDQJjXollq4sn34vYPzHQ
	 OhbSmAcNrSfHDsf1gynJoo3AFwKjIDnnBnEreEgclMbxHQdjNYs+n5oSVuZF1RzmK0
	 PIEabahq0eVW5zHU3ji+p+BTnRRT9ClO6w0dfOjZ+xTN9D2vl0o4nlUqbIAZ5xG0EN
	 jM+9ORlUcwJBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3438B3A40FD8;
	Thu, 20 Nov 2025 17:04:37 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251120164717.3974032-1-kuba@kernel.org>
References: <20251120164717.3974032-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251120164717.3974032-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc7
X-PR-Tracked-Commit-Id: 002541ef650b742a198e4be363881439bb9d86b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e621c9a337555c914cf1664605edfaa6f839774
Message-Id: <176365827571.1713338.1774300708063257238.pr-tracker-bot@kernel.org>
Date: Thu, 20 Nov 2025 17:04:35 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Nov 2025 08:47:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e621c9a337555c914cf1664605edfaa6f839774

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

