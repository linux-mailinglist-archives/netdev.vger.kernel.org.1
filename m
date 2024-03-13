Return-Path: <netdev+bounces-79595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807AB87A082
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 02:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6071C2293F
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 01:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22A8AD4E;
	Wed, 13 Mar 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmypOpUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DED8F4E;
	Wed, 13 Mar 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292205; cv=none; b=hwwzmaNRoH88gAXGXa9WNR3e72/qZf3KBh9uP4d08ptEcPUaHdnPDoRaOdgKAU3RwpVo1UkmZlWbBzMkSwkoTN0Ftn+m6KFPiMysBfxu7iBbAeonZTH4Rquac3xQklvgirSF0GJlvKw4ETEWYFJ9plqqpsQfajNemNqPjmTC2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292205; c=relaxed/simple;
	bh=wBZ687/sRdHhE9MP9hwax4N13s5f99Ly25yw3MhMu48=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EyoHRJndIExeNrj+bEKBc/6sruRtdOYdfBb6hRKBN70Vwd5f1ThX+/RXD8/bmUksF3JWO+g83gUbnOk6Cr1gmJ1ZqVGSvDgBhFeibxAOkokVxR050sQmiPZlRuHFBDHB6oJ0/EKoQmx3hVVtEZjwaxsNEVOyn1XiN4SaESA4pCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmypOpUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 530FCC433C7;
	Wed, 13 Mar 2024 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710292205;
	bh=wBZ687/sRdHhE9MP9hwax4N13s5f99Ly25yw3MhMu48=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dmypOpUys70ARygh8hrydwGgE1Kk9u/DQjLWfGr1Ed67wtRPgkkjoYwC7tAW5hgsP
	 VBEFbpBRfLdnMtwxM1AtyPfnxOWrEslYsy7ulgyXVNeCzhjhgctYVOzn1TOZenxTNj
	 ZMFp/GeARJyH0tPw69/M7eDqjXcQXw2zwMSpwbfyToLB80qRjMfPs5/my2RkaiQGjV
	 4zpaYA6R8iIvEfW/xXfQ+1os+4cJLopYAFJ+vV3cEi6y/va7fKkA03XOlx3U9fLvF3
	 EjV/OMINgOWdejgi0muEdeky0KELLKvEEtL+J//UANRhRfC2rYU1IZa8kdHi1XwaMY
	 /EJEbigirSmUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28641D84BC7;
	Wed, 13 Mar 2024 01:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240312042504.1835743-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.9
X-PR-Tracked-Commit-Id: ed1f164038b50c5864aa85389f3ffd456f050cca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9187210eee7d87eea37b45ea93454a88681894a4
Message-Id: <171029220513.17951.9200663377546911143.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 01:10:05 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 21:25:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9187210eee7d87eea37b45ea93454a88681894a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

