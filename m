Return-Path: <netdev+bounces-44543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4567D88A3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BF9B210E9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0A3AC0D;
	Thu, 26 Oct 2023 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0sDo1UJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF41D68D
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 18:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 332ADC433C7;
	Thu, 26 Oct 2023 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698346749;
	bh=dHllpklj7kED/297XZYY5LGeedMCBVuegfDjlb0HTuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K0sDo1UJUGDHiFVy9wX61/h0207j34R5zVbvGN9Tvep0qGLADFP7QBDIQ+DLlQtsn
	 UOxqxRPTtso3QuUlHSpoHaYq/93DPIZ28GLv/TCOzWoXlwhwcTsAaWh2RBuQ09fYMv
	 FBlbdL37+6reYbX4LWAtb8FFHlO5785CDvJ82CauYdoX3mdQRPIHySdqTs+nO6x6yy
	 nLibF8EzCceIFBbps+WULgPDKo/SHnx/r4y0SRvShSdGXIL/Nl6A0xcIUtrSLZgHyX
	 URz+/CoxqQR8JF9AY50wVvkcNYMTfiMdPZaR/jm90a/68Desbk1F5LQLN6MZTCbVZV
	 HvFJq8fUHmr+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21314C3959F;
	Thu, 26 Oct 2023 18:59:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231026095510.23688-1-pabeni@redhat.com>
References: <20231026095510.23688-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231026095510.23688-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc8
X-PR-Tracked-Commit-Id: 53798666648af3aa0dd512c2380576627237a800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17cda15cc86e65e9725641daddcd7a63cc9ad01
Message-Id: <169834674912.28071.10248635912400848968.pr-tracker-bot@kernel.org>
Date: Thu, 26 Oct 2023 18:59:09 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Oct 2023 11:55:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17cda15cc86e65e9725641daddcd7a63cc9ad01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

