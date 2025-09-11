Return-Path: <netdev+bounces-222351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7604B53F3A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6965D3AA851
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821E2343C7;
	Thu, 11 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ1QSFS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5E199BC;
	Thu, 11 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634611; cv=none; b=ncIMVB53Gz2GS4RiV990opNYkt5j7IZkGfRy8pvmjuNd4/1cOkSmBy63LNlhKXeIcrOpiDd7oQVbDxN+H3+oQIH1L4mZZBjrx8AbSIEupheTOuhr4BGd3VPuq9qWN69+aPUB1l5g5STZtbCTeBK6A9kgx41uxYuQ/8SjuvqKHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634611; c=relaxed/simple;
	bh=QKIx7fZK8zw1ZQePuU1g94DQ2X7z2ZTh+XIeZvk0UM0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hhQfc6ULiaiOLZXt0O1icDRCisZFk8huFcuqoHhTAhyaNtHv2PDAL3DfBgqcuuU1QD2nX+aloSviAlYCS/n5ErZksEt5OlIJIPIT6/pa/bAxpyJznbezBNss3okkvI0s1vS1cviY2LNMyL0MsPcN52xOHGSjqAD35/wNP+pBtRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ1QSFS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3294C4CEF0;
	Thu, 11 Sep 2025 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634610;
	bh=QKIx7fZK8zw1ZQePuU1g94DQ2X7z2ZTh+XIeZvk0UM0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JQ1QSFS6RKEQ01TESP1k6caAM9JSd9RQD3kXW5vWAp6AuPxwVd1/27pnBDrPnZ0OC
	 UE4OE4jYLRBrKz5ea7OrcAg1x74LHsnORyCCWY/LbBK6799lfQIK6DXija394YBtmK
	 rsvVrw8D4Nbx3I+jjC8ELhZ9s/EMCfVUTlbaVnKqsQicQhyzghuWQ4TYdTcJHlyAYx
	 hxJA0OGQIJlxEa5OGVUWCKpDMt3nPUVNIfnWL0EV8C4RCiaer0WAPtMYl9y5lp2mtX
	 WQi5ZK5vMF1mghrwRryAJV3c4w48IlJJd+UNCFDHEcT7Yf0+8ZiV2SMh9TYTc+NGoS
	 xej68HboxQ/6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFB4A383BF6C;
	Thu, 11 Sep 2025 23:50:14 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250911131034.47905-1-pabeni@redhat.com>
References: <20250911131034.47905-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250911131034.47905-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6
X-PR-Tracked-Commit-Id: 62e1de1d3352d4c64ebc0335a01186f421cbe6e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63a796558bc22ec699e4193d5c75534757ddf2e6
Message-Id: <175763461328.2348576.9957004045210482039.pr-tracker-bot@kernel.org>
Date: Thu, 11 Sep 2025 23:50:13 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Sep 2025 15:10:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63a796558bc22ec699e4193d5c75534757ddf2e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

