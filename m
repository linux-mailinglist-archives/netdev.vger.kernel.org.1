Return-Path: <netdev+bounces-123438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22ED964DB4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C28B21B82
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF01B86CB;
	Thu, 29 Aug 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI5QLcyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955714A09E;
	Thu, 29 Aug 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956418; cv=none; b=F66HXvmKUnK+TcJS3p6UMhzZgPxrcrXlqP2l3QfRNMlW0Lh83Agn/re7F1LocGuNpdViQiQq+fEzc5A0lAPYXhxHx45FKg7eqUoLijfQYbL2HEK1PahdpqyYQXfKvxyMkoiWJi8eVgxSGVvWLMNtn1kK04i/wf9HzctV/1IwghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956418; c=relaxed/simple;
	bh=ij3zsiEhoAMRcNvDLlCkpX8RdvmsmO9pq+4qFcPR/Rk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lfF9y4PipGv1IybBvG5KScPZtKo+bxKUW3WG/dbBnv/XTD81GJun3C+4NoEPi9byCXcPwZQ+5Hh0TwYaZE22vThH5W8G/QNMvwBV6CQRqzlrff7XXkptuorheQbE2XVmzcOh7WchS1COjKcp97PMTTYsUbIKouByspvMa7T9ss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI5QLcyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E18C4CEC1;
	Thu, 29 Aug 2024 18:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956417;
	bh=ij3zsiEhoAMRcNvDLlCkpX8RdvmsmO9pq+4qFcPR/Rk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oI5QLcyysFSw/qtH7uLjcWmL4p6OotiLBKyOn6jsgB4UdbUXWwtzx4dP1/14SQxF4
	 yx7L1esGBt9vJ/TqXLhaFIZqCmMCmkifzy2RwjsXDKkO+1hb9MAdoUrNZdB2hmY+Jb
	 bkK1VPjLtDe75WihsQwkH8y1nILQlKvJVQOTsK4FDXryKOuGloSIifJN0WoLeEQOFS
	 Km/N4VeCvB/fXV81wEzdi7fwCtSrd+E7m2KkuVDpyITdDZCrOWEkjVu1ZtyJoHICDv
	 Hyy5zbCXxU6peyAV/0xEyggN4Ry9rbgnnSfDZRzUnaoOQURhpl+f2VGDIW1TZrHlf0
	 /9H/OTjCPJQfA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 67CFD3805D82;
	Thu, 29 Aug 2024 18:33:39 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240829130829.39148-1-pabeni@redhat.com>
References: <20240829130829.39148-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240829130829.39148-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc6
X-PR-Tracked-Commit-Id: febccb39255f9df35527b88c953b2e0deae50e53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dd5dd63ba91d7bee9d0fbc2a6dc73e595391b4c
Message-Id: <172495641941.2046318.17359182283541610822.pr-tracker-bot@kernel.org>
Date: Thu, 29 Aug 2024 18:33:39 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Aug 2024 15:08:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dd5dd63ba91d7bee9d0fbc2a6dc73e595391b4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

