Return-Path: <netdev+bounces-147784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A846D9DBC74
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 20:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C2281F0C
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D291C4608;
	Thu, 28 Nov 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAPT4ztj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BF1C4603;
	Thu, 28 Nov 2024 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821588; cv=none; b=T9JPgELmD41HzbZis5CdgH8vGNNPBjWVBwFqp/QO5fvbOeUt9ZhVrtp1/0R9IP58yI+Wo9KI0Nc0EVc49wHywzI6jC/Ftda/NMllfq2hf72cQvsczg2yRzOKNcfbG+g56lYXmbvo7kg4ceuCbjHaN2I+qDYRYHRcwr6WNSb0qtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821588; c=relaxed/simple;
	bh=0j9ucpnBKJDef/9ZNNllQJgNnEMRgnfJHvUic/Cl1hs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oxywJjZKVGZp3adcXs/CuEki61I3fYAnVzmVZtE3teBc+sluqApMWdzgEd3CxVclC3VCacmSE3hClRTd9Dns9fXBG9B/+7yY7Zt8sif5z9uOVZGWJKfwXwl2ybA/qoMFGLQ3ioLO6m8fS0Bb7l8yTEgOnCnjBOLzySaCeiA5ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAPT4ztj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3C6C4AF09;
	Thu, 28 Nov 2024 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821587;
	bh=0j9ucpnBKJDef/9ZNNllQJgNnEMRgnfJHvUic/Cl1hs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GAPT4ztjE4FE6r4BJS7ss1EgOL7Z6KrhrE3z+T2ROfas3MGh9Hx/cwqS3LFyeiQOp
	 aQB/Eyr/TZ7j53CEY9ImK98jTU4okWWYbR1mhOIE9zJZMm6aCh+lSAy4d21nm5wMwn
	 K33nnjovG7fedjuSVz1eeA4moByHS0bgftvaLmBscukP2A9e/oxsy4PlRsVRc5glei
	 RaClhXo9pstsVSXVWhmZRxfVX0Pqbeg2jWn3rvpet0TiASAmF7j/U+6Loj6KJe2QOc
	 e60UqC4MUNgcltlpnht2ELeh1vA40YPH08d5Pk8IzcgYfBh90UxHAIIgrqPCEHG/R9
	 RJcwqQvNQqTkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2C32D380A944;
	Thu, 28 Nov 2024 19:20:02 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc1 - attempt II
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241128172801.157135-1-pabeni@redhat.com>
References: <20241128172801.157135-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241128172801.157135-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc1
X-PR-Tracked-Commit-Id: f6d7695b5ae22092fa2cc42529bb7462f7e0c4ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
Message-Id: <173282160082.1826869.11344770905252332008.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:20:00 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sashal@kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 18:28:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65ae975e97d5aab3ee9dc5ec701b12090572ed43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

