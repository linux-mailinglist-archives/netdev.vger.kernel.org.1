Return-Path: <netdev+bounces-176541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCBA6ABA6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC77C7B3361
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5A1EB5F0;
	Thu, 20 Mar 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFOZXPdK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FB42065;
	Thu, 20 Mar 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490133; cv=none; b=R8IgFpomQxcCFDAcc+MGHhQIqbZqIlw6n9CIadZQXoWW/m7R4nL/JIh/X0HA8Bavbr3VyHqMgP2oJDUYXnMKM8GdaP9diVK9rAyM0WvILRaxbGWpYjMFxYJWuBhK6oKe1j4Ezm6KQh4Ukrb3VQjkxWzHXk0vNwXwr93V1ZkVo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490133; c=relaxed/simple;
	bh=LEvehLr3N22VsKNBnAZgPiAqYilfBHaX2Lh4Py/RWf8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JvGLIGL1vjFkfr49+e4pFKMg39PTxaV45VnlJ2f0fyDapMrOBHsba7O17G/1jbgnwvYzZVSJ/Xl2UohVT5ASqmtdC0BkrGK0x8SqbUOKr+StyGzGTQoiClhrneTu/q+l2fyNZ23ACAFiF3K+/iS4gCH2YGM9B7eAsWFJjcFjoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFOZXPdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED17C4CEDD;
	Thu, 20 Mar 2025 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490133;
	bh=LEvehLr3N22VsKNBnAZgPiAqYilfBHaX2Lh4Py/RWf8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TFOZXPdKAtL5QBXxDLjYxzEvMCsG6EcdlV0GSzK4Q/mCVe+Tjj6x4nH1pd+koEfc7
	 McFoCS0/y8NZvnRuT92u8cHFc7ERwbTqP/N+Fe7whh7z85mAhwt7fMsU1vxGxNGwPS
	 9IQ1LMZ5MmuhivwSw9cttVma4z9qf50lNdHzFajsCzrR8Z206QDGJg1UzJ/u7F3I//
	 +prwhu7mTZUVQtYtfYneJgPvO+H7ZDYcb9dvhlJrk0XEeP0LsFG79cajQraf8zYwr2
	 7KshIw6xVrARV8IwItEN9mOGx889+cmhmmj4WuVtwNva/CYdUXQaJCHs+iyZTEKYwv
	 i5xpIEvaE1Ayw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB50A3806654;
	Thu, 20 Mar 2025 17:02:49 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250320155513.82476-1-pabeni@redhat.com>
References: <20250320155513.82476-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250320155513.82476-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc8
X-PR-Tracked-Commit-Id: feaee98c6c505494e2188e5c644b881f5c81ee59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fc31936081919a8572a3d644f3fbb258038f337
Message-Id: <174249016860.1840953.12043986115967814135.pr-tracker-bot@kernel.org>
Date: Thu, 20 Mar 2025 17:02:48 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 16:55:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fc31936081919a8572a3d644f3fbb258038f337

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

