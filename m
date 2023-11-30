Return-Path: <netdev+bounces-52728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EBD7FFF90
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881AB1C20BF8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 23:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F895954A;
	Thu, 30 Nov 2023 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtsBl10N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAE5953B
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AE9FC433C7;
	Thu, 30 Nov 2023 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701387583;
	bh=06C2Lx7+yfSbvlgL1dhTE1txCo//HLv4ilk8l0a5G8A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WtsBl10NAqC04N7oDNxRnrktq49Uh3lc3GeevKRO9mXuWb+O5ZavBpHtAsyDmRPc5
	 LkqiZSjf6LLWwEJ+VldjvppX8oGJ3WxrAPSnGZORWC6Vtlo7yHZbgWbpI4QNRaPTxo
	 dlSjI6sTW9jsQc8l6rnyiU8gns2ZhXtF4/jF+fiEUvgN9gnrcHHx1mcgd0uBQBW6T6
	 ArP0gQwZ3aTGaX6+S+106Ktu/ru+5BZs6siVpZ4g1bkeYKN9GipgufZqWh7c1sc8E3
	 hrWokSQ96CG2BhFclTGun8nUALXX748g8X+wMSYh2xEK1l5VGk3cnJamwma2cTv2N1
	 n03unuwxM/WBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59805C64459;
	Thu, 30 Nov 2023 23:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231130125638.726279-1-pabeni@redhat.com>
References: <20231130125638.726279-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130125638.726279-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc4
X-PR-Tracked-Commit-Id: 777f245eec8152926b411e3d4f4545310f52cbed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6172a5180fcc65170bfa2d49e55427567860f2a7
Message-Id: <170138758335.26468.17756075344747602504.pr-tracker-bot@kernel.org>
Date: Thu, 30 Nov 2023 23:39:43 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Nov 2023 13:56:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6172a5180fcc65170bfa2d49e55427567860f2a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

