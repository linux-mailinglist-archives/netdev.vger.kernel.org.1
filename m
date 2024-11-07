Return-Path: <netdev+bounces-143080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAC9C10EB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9931C2249E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467282185AF;
	Thu,  7 Nov 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b11a6pBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD47217F38;
	Thu,  7 Nov 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014631; cv=none; b=IfmhKulim3htXtBjIn8lW/kTqCTf/MJ+PsbvlbnGa2g4iq55DI/Fl5NmWB0zyfv+CSLRRSI/BWhb9Fu+zVvON9kWI06qn7GCOu5dKMiEbbLDqX0432nPUrt8GdRC/Mcfj9DMJA+uzZcMLpiS+lr0nlmpVPzk2DwOK2D+YaHlTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014631; c=relaxed/simple;
	bh=lo4kyEKR5iqvJadoiUBYO6kTriOSw1Azyo6gI4YsYnw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H3azJ36qyAH5gZA9631QV3XSakubZMl24SCJnUnZBeM1GwNlc0XLeGBvax/t8icWlhOM3HSBJVMV93ESicNCbuX8LRxus0BgRTBo+y6gHmh4qLdwwdmWqWbsr9L2TAACjRzaegs+QvAb1qvWqvqSC/iR1EcvtDrUNChVQ6vqsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b11a6pBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3614C4CECC;
	Thu,  7 Nov 2024 21:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731014631;
	bh=lo4kyEKR5iqvJadoiUBYO6kTriOSw1Azyo6gI4YsYnw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b11a6pBnf9ueFJGCIrjJMjSad7BA5vuaB7Nq5ZHLtEqLMi5lBin7d+3LsRca/ASmA
	 6q/gP2JHY4OZpoqDwMAQDa6qLC+HFmLcohXDDQpek21fo2S6BP8mVJhREO2lZhG4nA
	 PV7EPSMlUnRIg930RxHbURrwVtpdzN0fuxaX0SIhC/3dRIKMy/KUtrurDBNMCjUIBt
	 eco1k6bPK7e8EOT+4wioSgdx+yj3j16v/zBiyqplIcTt8N7vVVrud2uTpujzrwtK8Y
	 Ze7Fa3Ux08TzJci9SUz7LUSVzVFTlOwwZj4skN8PKatRo2nfKlj2XkG054O2uA5q8s
	 HTV7ec+e+9Vew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D83809A80;
	Thu,  7 Nov 2024 21:24:01 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241107204533.2224043-1-kuba@kernel.org>
References: <20241107204533.2224043-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241107204533.2224043-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc7
X-PR-Tracked-Commit-Id: 71712cf519faeed529549a79559c06c7fc250a15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfc64d9b7e8cac82be6b8629865e137d962578f8
Message-Id: <173101464003.2100977.10337123877056671078.pr-tracker-bot@kernel.org>
Date: Thu, 07 Nov 2024 21:24:00 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Nov 2024 12:45:33 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfc64d9b7e8cac82be6b8629865e137d962578f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

