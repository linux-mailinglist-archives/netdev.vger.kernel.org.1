Return-Path: <netdev+bounces-107411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1191AE45
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74CF1F22ED1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6491AB91A;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjUurzRG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AF1AB901;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509664; cv=none; b=M+9vAGIHnX1Sxpvhm+B6+ezgab2YXrcFzA6ZFJP4HP8Oi4eLYQk6CmfwYdwB9dAF5b1Byqz8luEhR2MJSAjoFr/QIj1rEG9VXKHQypR+lIrjYRu38+4p16Ccdh2OObUNFAIbr+S212Th0B1psbwiKYPCBmbqkH/bkCzyFo8dVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509664; c=relaxed/simple;
	bh=8BhtxZsedOdrl072Sb0DvndBmeRWeyyS0YJUP/4C4/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kBWL82UuOMzoM3n5g1y3unT0PPQ494wXlICQFdzcjQgNlkOX96OrD4c5UPDgWiY5v6HhY/+8XYojZ1JgTt0Y9D1DMzca2LgZ/HHzblu+j0aMgeFveMnTyQKS8wKmw4CrWJT66p/YLtmLeBJECKe7JwaMT95EbOIZhmSzrTC4P6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjUurzRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EB03C4AF09;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719509664;
	bh=8BhtxZsedOdrl072Sb0DvndBmeRWeyyS0YJUP/4C4/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bjUurzRGkmlPMMYj1jolv7aVoh9rGDawMhdCW0qxtqtNhqzUADCIiM+gdaXkkCIRD
	 NwXKJrUd57L0LymD+QjHadrMUET4UmC46JnKwvV9SJy+m6HtznxI1sEqzhDhcCgeqO
	 nvH2jSut1OQdGPOrwLHmYXUQ9DoltCTJH3s82skMLP2R4YRlQgJhIM3zDlfL8NR4UQ
	 qyaS8btG2sl8DQb062MbJC/0Je3fn4cN3ychsR7DRY3AFZFRz+Fu1oLoZLi2rIqNYW
	 ZGkCZ/Qbu7XOeemiWEJw5Z7E6gAFavmWA7L+4nR9f0VfNB0KyxZmILuJnb1rveQLli
	 gLAJinyTv/e3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7754BC433E9;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240627140837.42758-1-pabeni@redhat.com>
References: <20240627140837.42758-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240627140837.42758-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc6
X-PR-Tracked-Commit-Id: b62cb6a7e83622783100182d9b70e9c70393cfbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd19d4a492af77b1e8fb0439781a3048d1d1f554
Message-Id: <171950966448.28398.1863633279919800857.pr-tracker-bot@kernel.org>
Date: Thu, 27 Jun 2024 17:34:24 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 16:08:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd19d4a492af77b1e8fb0439781a3048d1d1f554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

