Return-Path: <netdev+bounces-248250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC06D05B6A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C540F3007650
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59C3002CF;
	Thu,  8 Jan 2026 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haw1Omnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB732882B7;
	Thu,  8 Jan 2026 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898999; cv=none; b=eRsmNB5l0BsP6JYp1m6G9zKWE5r6J07VlU024IR7ACoLH//z4LiC9CTRXb5eO0Cwj/CcoLK97hUTxtdfhuoyd1Su3GBWPb3pUSUEUxPbKjyGTAF8o7Etd35+/iaxzHau9hjFP22VEriNxKk+WabIFLMEsKuA9+DwEFJHGx/0fxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898999; c=relaxed/simple;
	bh=5G5yA+zmkZFfw0l93jNAkCzJLDYHn2wnBOHiHSz+A4o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gvaZW9XlXWirb1FkIY3++xuiToFf0qWF5qJNDg0Adl1bMBrstHp18E18A8AGt2LOdTrw/4EOT/IbpthyogAARdMvSekn1HGMXALuHm4Ilng3JI6AzDzq8HVwK2fqN/QhcNWNWHSzxMIi/4WJuA6LrzOHl4c//ODcqL9kikWGJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haw1Omnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFA0C116C6;
	Thu,  8 Jan 2026 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767898999;
	bh=5G5yA+zmkZFfw0l93jNAkCzJLDYHn2wnBOHiHSz+A4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=haw1OmndqS44ua5ZvT8NRgu2cRLZuH+SKhtdzsRbh2u0v/HEUt8K6w4jpGp2MswRr
	 VJiSS7QELfXehvewlyXdxLKN/mP4NIX5X7lhougoabNygeU7eSOLOivpDNdfRSTQaI
	 eYM3uN8vOejldVMOnS3lpcRLMCz9jeZAoqpxWJcT40HHlpUOwRV9nK9JSGSvJw4FvR
	 6UCrlEwhAPet39e1y+qy6vdcSX6szC8rAOcHAYFfzNKnIfhUMZRw3saJ12RjZFE6Hp
	 C/omfaVkGyNl1IGVDmemfpINM6vjSgQVq0gQxCVyMD3QhwjgKpMb8kPDIeMycO9rFJ
	 N4Xp4XdBu0lDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F42263AA9429;
	Thu,  8 Jan 2026 18:59:56 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260108173013.2849487-1-kuba@kernel.org>
References: <20260108173013.2849487-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260108173013.2849487-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc5
X-PR-Tracked-Commit-Id: c92510f5e3f82ba11c95991824a41e59a9c5ed81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2a3b12b305c7bb72467b2a56d19a4587b6007f9
Message-Id: <176789879567.3767999.3449910281586819392.pr-tracker-bot@kernel.org>
Date: Thu, 08 Jan 2026 18:59:55 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 Jan 2026 09:30:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2a3b12b305c7bb72467b2a56d19a4587b6007f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

