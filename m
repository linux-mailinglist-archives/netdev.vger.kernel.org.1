Return-Path: <netdev+bounces-161716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBDA238BA
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 03:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F9B1889BCA
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEB7146A66;
	Fri, 31 Jan 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdhkxc8q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5892146D53;
	Fri, 31 Jan 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288798; cv=none; b=rUVLZzN41nvSFysWwCgXpxDvxHVb6oddqsq3tG5xettVxAA4/JiJZwdsF/1HAS1SihpimqnGzrdxLyPZTcUqbmhAkyN2nwD6G88B/eUlOKfAKKhWGn6sfhObDxcde0WlL49VCtz2GGEMySz7IJJeHaaN/kLgrxLX0nuu2bD1vEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288798; c=relaxed/simple;
	bh=nZP8+UgRDh02YWo+NQ+Z4kLeb849AbaMK8ntcRyMdi8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iVedbnR9QrjszGhfIct3nlUs0fEyssEFVg9k85IYCxomUh6MfjA+SrPnlswqyMh/+7Up9iUn+IMKtFgHPy8DY6fv0ZXhxJucHWsv57j9x2iKRBPrOlHNDvqA4yFyDJ+iBZr9Jqvoi+uHP+O0MEHsht9TxWeMzdkGSdzkFKA8a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdhkxc8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98097C4CEE0;
	Fri, 31 Jan 2025 01:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738288798;
	bh=nZP8+UgRDh02YWo+NQ+Z4kLeb849AbaMK8ntcRyMdi8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vdhkxc8q6fsC18U+y4PFovvm4Wh6nXEnDkA40bf79EFzdu1t4JhOgS1HDB0iuE+ck
	 ZZoIXwW183Po/Ge/7mfUBEmrMuw2lUUgN/aObX+56iV4gqEa328yFBxuk2Lz8GuB9m
	 LkUoTG44hjA5AlWktjiDRYlUgtd2mM2uRfsA2LSNJ/CatnfRXFIG29qARj46OXPMLG
	 YBKcKC2UvcdX9a5mf27aN3NPACS5wbgHEsdkd/Oka9NGgLmpXf5GnsZnWBYwqwb7Qd
	 MgbdWSXeUNFdBlbiYziBzJsYNG+QRBD1abFqgH3vMChaalCXMPaCzk7pqNQTzF24Hp
	 FyKCUqnEQOazQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340A0380AA66;
	Fri, 31 Jan 2025 02:00:26 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250130190806.3217841-1-kuba@kernel.org>
References: <20250130190806.3217841-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250130190806.3217841-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc1
X-PR-Tracked-Commit-Id: dfffaccffc53642b532c9942ade3535f25a8a8fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2933b2befe25309f4c5cfbea0ca80909735fd76
Message-Id: <173828882487.1145982.2538240306108037907.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 02:00:24 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 11:08:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2933b2befe25309f4c5cfbea0ca80909735fd76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

