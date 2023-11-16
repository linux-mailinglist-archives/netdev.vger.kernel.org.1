Return-Path: <netdev+bounces-48327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090C7EE10E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6A41F247E1
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905F30650;
	Thu, 16 Nov 2023 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPhzmF6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1AE30645
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D317DC433C7;
	Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700140018;
	bh=5qk9VczzTb12p9ri5AV/VUJSsCmoyaMwsBOWcCucr/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uPhzmF6CXBEuGNtidr4fVrGvoDC6uML8UpNFIC243BWx1bQUdGXGojASFHgLNoHVS
	 F3o6NQ4+y5ToLCsFN/oEqSpk5CjbMDVESUDdN16TbR1o2oLnCA9Otr7bEQUi2gWlsi
	 Sbjs/UwW0dikRO9+Fxf9fy/9O972Dy4QIkiQ+rZltVhSXb05t13JHUI5orcZ9pPp88
	 WihdHV7xNft+s1i8zWfdDHysdnRHSGAQuHPATGFEA2H9moWwayv70nMOPf1+Jm3sjo
	 J6Rl0ko2fe5RaKl4FjVTG5u4bNukhxUHTmKpWu3M1IuZ4xXJS/kW6zSznJrDA+pfSL
	 mNpNpyTgNDX3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE2D2E1F660;
	Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231116122140.28033-1-pabeni@redhat.com>
References: <20231116122140.28033-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231116122140.28033-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc2
X-PR-Tracked-Commit-Id: cff088d924df871296412e6b819823f42d1bb9a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7475e51b87969e01a6812eac713a1c8310372e8a
Message-Id: <170014001877.19711.5713646184426687588.pr-tracker-bot@kernel.org>
Date: Thu, 16 Nov 2023 13:06:58 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Nov 2023 13:21:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7475e51b87969e01a6812eac713a1c8310372e8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

