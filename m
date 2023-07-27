Return-Path: <netdev+bounces-22054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75AE765C64
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB5D1C20AB8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56041AA9A;
	Thu, 27 Jul 2023 19:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F917AC1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E905FC433C8;
	Thu, 27 Jul 2023 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690487358;
	bh=UvHScns3KGd/gqfVTpwY4R+Cc42prp4rDYGWAbDSfiU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HIMrSvd3tabqV5aFQS5Qm5RS79lJFbax0HsRMhG5239SjsF1ko4ma1yU6xEpbm66B
	 8+dSxPrM78WEqT3nPzvkUNHSL67M7kbwhFmMPNsD0Ymu2UrgzqUMYvOmq3ZQfbiFpQ
	 CIdfjzhGF8g0Rzcp5dnu/InG8r87n+z4+jsTQg0sjAZtN8kJN7spRhaYmAxan6XSq1
	 ZD2HXM+QCUxhspfylrPHLzZ1Xv2jhUbxp3wb0zYNYw0Ze9XzYjnM37AI/5Nxc/HX10
	 +ImCfZwxNAEKKVO2GMyiFyht7b/u0xBaM6XS4IXwT8iadg4f/04KCoI9bMkFnt21e3
	 /ctAmS9r8QRYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5A3CC41672;
	Thu, 27 Jul 2023 19:49:17 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.5-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230727131250.40515-1-pabeni@redhat.com>
References: <20230727131250.40515-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230727131250.40515-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc4
X-PR-Tracked-Commit-Id: de52e17326c3e9a719c9ead4adb03467b8fae0ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57012c57536f8814dec92e74197ee96c3498d24e
Message-Id: <169048735787.11614.13816300430840436077.pr-tracker-bot@kernel.org>
Date: Thu, 27 Jul 2023 19:49:17 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jul 2023 15:12:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57012c57536f8814dec92e74197ee96c3498d24e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

