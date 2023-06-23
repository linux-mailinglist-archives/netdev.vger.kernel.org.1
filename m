Return-Path: <netdev+bounces-13230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48A973AE1F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FCA1C20C81
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 01:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0722376;
	Fri, 23 Jun 2023 01:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DB363
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FB0C433CC;
	Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687482214;
	bh=Vri/YbzS0NKveeCPqaZTZuYXIFhP96iw9gWfzmr/GQk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ww5OWBeBUTWFoyhRRPsiB0k9KWlBcMlRq2QSGHSweba6dZUrse9QM3u22OYpzZSSR
	 F0euVGxl0ARsBhKkd3TYSCME3eLzZRPfxeWFIW3kEeErqdkRZtQdG9SeV9fgmAeKDS
	 8oXm2WkFTv67n72I4xV98q6W6EfUK+5MtPizk7GaoCqbhVUnYNHb+GW5FgGykl6BgW
	 isRw8B7hD2qTRM27C5pgYXaHgW+qUru1gVqRctSgMtfp++YIEPyglNK4EuyXlP3hwo
	 mA/hDXkVr5dYKj6WeicydLeNS9NdPnfqGGadBtVunLJf0ZuMX0Yrgj1Vxndga75MkQ
	 ve7okybUhzLsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73334C691F0;
	Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.4-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230622151656.54164-1-pabeni@redhat.com>
References: <20230622151656.54164-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230622151656.54164-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc8
X-PR-Tracked-Commit-Id: 2ba7e7ebb6a71407cbe25cd349c9b05d40520bf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb
Message-Id: <168748221446.12146.913932329704204041.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jun 2023 01:03:34 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Jun 2023 17:16:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.4-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

