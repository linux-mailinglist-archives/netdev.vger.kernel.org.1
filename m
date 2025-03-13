Return-Path: <netdev+bounces-174726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12066A60086
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE517AF570
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F41F5428;
	Thu, 13 Mar 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddkjb5Ak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCA1F540F;
	Thu, 13 Mar 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892649; cv=none; b=XvsfkTsAYygT2snk4izTOJBhBl1zS77c87KvNc5LAg81hJPe/Zsg8iSg8G366GwsXnJlBEus50/4vkEnddPyF0TYMEs1161+bSa01XJoEwJ+GOt62uuhnq3xaceAV0oRKs2TEyIJ5o4Qzn9CQMCkfXi1/z7xltvPqkhAf5JkA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892649; c=relaxed/simple;
	bh=05I0OWR9UPXeuCVTee7H6uMfXhu4xD+VW3g5h6Zf7Do=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=froV2am5gOe7KBSfVSnFrHtofWlKW90sQ0925finAc0AsKHv6p1/hbqmWu3VuRmTB4gOB4YN09K8umU1CwF3AhuMbahsvn1/6MZFKeglAZ/03AJa5H84PthCj4J8QzWQ3tV+Dw/i0uDsGgo731lALsyPmcgKLthGixLeNUb3iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddkjb5Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE3EC4CEDD;
	Thu, 13 Mar 2025 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741892649;
	bh=05I0OWR9UPXeuCVTee7H6uMfXhu4xD+VW3g5h6Zf7Do=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ddkjb5AkDkZTEuw8RmPbnWa/Y2hdCQTDh3N5OywnqhdZhOwXT4U1Zj62PC6iRwsyX
	 OhIAjG245r8N0Rto/FfBJKpFcHDORcak+NgVmg60lKf0K9lzqysXqnWnnFWMPa+t39
	 1UdQqrZl4YaZ8ER/Gkh4um+5p5y9Ij1BeS7A9BLmvhYbSVusHhDQtTZhM7DZWDD4gz
	 dozyyfMAH4E/Tr1NzmsD7pn+zlZqCMXCTJHtAr3a8OUAHTe/+vp4+ojy1+3Ayc5aHG
	 UGocI9uO2TUH2FUOS/HdnG9rQ+qfqGeA95de80i53usMDPQs0IlPkaLzUuzwGe4HOb
	 eAQd1gWH/oYzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF63806651;
	Thu, 13 Mar 2025 19:04:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250313154206.43726-1-pabeni@redhat.com>
References: <20250313154206.43726-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250313154206.43726-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc7
X-PR-Tracked-Commit-Id: 2409fa66e29a2c09f26ad320735fbdfbb74420da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4003c9e78778e93188a09d6043a74f7154449d43
Message-Id: <174189268352.1632354.3352768815368148665.pr-tracker-bot@kernel.org>
Date: Thu, 13 Mar 2025 19:04:43 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Mar 2025 16:42:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4003c9e78778e93188a09d6043a74f7154449d43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

