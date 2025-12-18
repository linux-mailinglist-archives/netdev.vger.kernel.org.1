Return-Path: <netdev+bounces-245443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CECCD9CE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25FC3081D42
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183862E9EA1;
	Thu, 18 Dec 2025 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJXgNefC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A12D7D30;
	Thu, 18 Dec 2025 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090644; cv=none; b=MBJVYLRD45h31RKQEw2WWTFJdQR5hlEhph8vi32qk9KJPdURyLyn8ky2fq9qrtVBtiMwg0MBSoGqGVDYo2LjMTPP8n1zIlG/FxJ/g8eCK6q5P/lZXmUmIdxuL3Wy4y6gI+bzFg0R2mlkemO4yBUqXU6BKH3fXzCAqjAC11Thw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090644; c=relaxed/simple;
	bh=zg1sBMnpte1guIIpHqW4Rpr4Rmt0OU2qBklgs+RANFg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lZz4odFBr3FX/Bc/ElTnRqwvkpfb+gTNbgJBTV6p+iYYeJ5yPtt2tWrOmMkJK3QNpo8sO844k7Wl53euSooK89RNMczyIU8eFRj8wFayliue6+4DzQShRfrIsLKn2kZAAvzTQrUy1CqiReYZRZFHWrUOAj2/PuXxVLxE6yw/FQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJXgNefC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9EEC4CEFB;
	Thu, 18 Dec 2025 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090643;
	bh=zg1sBMnpte1guIIpHqW4Rpr4Rmt0OU2qBklgs+RANFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GJXgNefCfAzU1ZZCZ+5nRAD/nblRWcvf3SyPe7EhTXukwiJC9D4o0hbjq+lsiJuq+
	 kN2ZO2ZpcWcUCaUXKP/eKG+iQgCcpzvDnYlEOgf9UofhStaY1As/6olmukxRYvhTo7
	 KpX82J+c8PibrXhWk98DpBazFsAAOlpo+yHBwnWJDRbDcGT5bYGIp6qTTSRgZsvsEl
	 ZD2D9xRB9wttes9gb8wExPPdVKgpnni6LuyAxJwxSAGrmZcOM5Wo+ldcIW8qeN1zZY
	 0o0d/8byMiJ8bRwfO4toWp0qIMECh0iarA2h9ubpnSwp+Nqf0XcdEMG9w9sSngTebz
	 BELwY7VaZ52jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A7C380AA41;
	Thu, 18 Dec 2025 20:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251218174841.265968-1-pabeni@redhat.com>
References: <20251218174841.265968-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251218174841.265968-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc2
X-PR-Tracked-Commit-Id: 21a88f5d9ce0c328486073b75d082d85a1e98a8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b8e9264f55a9c320f398e337d215e68cca50131
Message-Id: <176609045240.3123986.14744749704822531851.pr-tracker-bot@kernel.org>
Date: Thu, 18 Dec 2025 20:40:52 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Dec 2025 18:48:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b8e9264f55a9c320f398e337d215e68cca50131

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

