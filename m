Return-Path: <netdev+bounces-250309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B4D2856E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CAC304A938
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC43115B8;
	Thu, 15 Jan 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSbUY/IQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6525F798;
	Thu, 15 Jan 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507989; cv=none; b=WASzDsYnZid+lxqbqmgMgfOcl4H18CXZsrYVTkkj7a2KEuZ2ufFGnQF8iHWWuQ7I11e1K2F95KI+JrTaADLdvSuwdC8mZoIkZamwXIyKefMhJB2EObwv8POeth09vVRSl3I7oX4bm190HjPt/SZPRIeQcipXesoB3PMOT/noHVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507989; c=relaxed/simple;
	bh=4jxQhUIMakX7LOYYIDcyfu7e9B+6f2utjwvwxxVxfIY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p1aB24TERmnjtkKoS+KSOlSPWlvFV+aFWlyZFMAqG1a/Oi9TrJwzUs70kMFvKhUvOZOtdKYHHHtzLT9rsG/CGOkcny5oxDwRKi1rUmSx6dRoqfX9AeYMrAX2UU+eGUZkh0PXrKbXuQqwhZCeBWIZ/p6+yhQHM0ksi0v4sk3W87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSbUY/IQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E932C116D0;
	Thu, 15 Jan 2026 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507989;
	bh=4jxQhUIMakX7LOYYIDcyfu7e9B+6f2utjwvwxxVxfIY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XSbUY/IQSfnQ0c7Tf8eXk/eGxiAcZTyrWdOWBZxORUkOQyOMehQnWobax6HJgb7L5
	 K7P+lqsPeuu8GoHg8sVp/qJtijl3fs/Y7X6VbAEfhsxxIxqI30RMTAmolWARtcSVI/
	 vDAUeOSOeXWsT0Hb4tiYvu6NHDqGM8AMiNZGV0EhgkBD7OgLZdOY1siFPtc7RAvaLL
	 JOCoTRyA126Vai2ZBaZ6MY/ELQY8e8eQuy54c/hyevv7QQzaS8M/NpjDnxkzuG7jcH
	 hP0iyZx3HPtIN+AQOzoQ1xyN3970d65x7LHBhXGukZxmRKf0q4pqp0jSHahhYDhcsa
	 5h1yafdIOm4RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79257380A97F;
	Thu, 15 Jan 2026 20:09:42 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260115142011.254549-1-pabeni@redhat.com>
References: <20260115142011.254549-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260115142011.254549-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc6
X-PR-Tracked-Commit-Id: 851822aec1a3359ecb7a4767d7f4a32336043c2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e995c573b63453a904f3157813dc8cde4a6aba4
Message-Id: <176850778098.4151234.876791464014057859.pr-tracker-bot@kernel.org>
Date: Thu, 15 Jan 2026 20:09:40 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Jan 2026 15:20:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e995c573b63453a904f3157813dc8cde4a6aba4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

