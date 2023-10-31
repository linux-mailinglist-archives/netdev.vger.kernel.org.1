Return-Path: <netdev+bounces-45494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0867DD8C0
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 00:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D062817DE
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33327452;
	Tue, 31 Oct 2023 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP9SqeED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62812E76
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 23:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1754EC433C7;
	Tue, 31 Oct 2023 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698793206;
	bh=csBqL7JQp0a0gst2GPRCTL916vz5zXH62YxjMMW+rkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TP9SqeED9myKFJ20Cv8WXE3nSWv1uUtULGS9KkzUyRxgwkSq5SyAHgPT/SP+FM9gA
	 ZenREY8z49nX9iFVLwF7VnOVA5rbzQ/gmAXczn/zJGY/W6wVObiG+7WpzeXt/RtPQE
	 pjKuKBHRq44ZNoUga4a4I2OxHQfCRVRuCA/Qb5edDmckscWrPSYgEOuWbiasLrBZDD
	 EEGMWOxqNr/XOmgVyRs/ZGlxZsFhzT+NbQYQdT+PvaOAq/ql1AJ5/PZkBr3Ln8+fgm
	 KrckVM7bMiMh7Qi3AX8HWvZ2Sg/LGw4Fu1vyb5zf0U556lW5quT3M/S9l/kruj9Ror
	 yxU/ggtDCynYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECFD6E00094;
	Tue, 31 Oct 2023 23:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231028011741.2400327-1-kuba@kernel.org>
References: <20231028011741.2400327-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028011741.2400327-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7
X-PR-Tracked-Commit-Id: f1c73396133cb3d913e2075298005644ee8dfade
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89ed67ef126c4160349c1b96fdb775ea6170ac90
Message-Id: <169879320594.20683.11021135438546525382.pr-tracker-bot@kernel.org>
Date: Tue, 31 Oct 2023 23:00:05 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 18:17:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89ed67ef126c4160349c1b96fdb775ea6170ac90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

