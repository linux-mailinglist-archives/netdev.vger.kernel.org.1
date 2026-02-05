Return-Path: <netdev+bounces-257277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK71AM/XhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:47:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C259F628F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12E7B301287E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF63002A6;
	Thu,  5 Feb 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnwUUeRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335D2FF65F;
	Thu,  5 Feb 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313649; cv=none; b=uwVvlhsjAgpaiLqi9D0ROrgAnbxnqgdSFooxRosRJKeiM28/Cxh+jTEjk3EyawkVOsezp53YPOLvRr8IzyWZ3Y+4XKHClbg11OJGSy19p3ZWsQ9rsynWZ1srw1kNEnJI4JA+dg/cC0cQ0ZtiHRca2lX5n8ft4ZU4fwycdNHf3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313649; c=relaxed/simple;
	bh=xwl0WuTnfOZ/MCKNV/acsDN1ZWbJA58gs2gtWOStIzA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l/utxNheGKHzcNOtikogtwtVjDjjbF0n0JWfMWucf9kvDkgYYQrIqoHR67zJre3/1gvBCDXrMxdKyl7saVc4p5o0rXWv591DKwNUoTavn6vp+JWoHQeF6Klkawye4EIpqPWCTrFKhE1bFBGn7tBsAvW5mrh9KWvYYHY9g7OyLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnwUUeRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B1C4CEF7;
	Thu,  5 Feb 2026 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313649;
	bh=xwl0WuTnfOZ/MCKNV/acsDN1ZWbJA58gs2gtWOStIzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PnwUUeRPyqj/tctHN5yDckIsFllr/4ojtIaMj/+CXn5XCcI82CJPcnmiDeq8rF+jM
	 Pi4KK9Kr1PcnMPBNo/VbDkFkB8cemLkVdHEptGbdd5Ku/wDkju9E1BYbiEw0Wl/9QQ
	 Zd3cb5h3Eg8VUcplC+KakopuFy+BLA18NNuKXfJgbhPUJg23J9pj44eVv9fvbrGJGS
	 ikd6Gxc8r+KOHgbm7bljycQMz4ZFgaMX9b8txDEcskNraY/D30e4iajsLIObwx3kNz
	 zUQIkgb8WXuVu6SA1NQxrhd2qdD88l/h3kycym7HADp3aXnxL0YxMT0RCxt1mHMIrI
	 dGA4ftE7wCItg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 484C33808200;
	Thu,  5 Feb 2026 17:47:28 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc9/final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260205171831.1944818-1-kuba@kernel.org>
References: <20260205171831.1944818-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260205171831.1944818-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc9
X-PR-Tracked-Commit-Id: bbf4a17ad9ffc4e3d7ec13d73ecd59dea149ed25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fdb05de0e2db89d8f56144c60ab784812e8c3b7
Message-Id: <177031364685.509822.7533650509276870343.pr-tracker-bot@kernel.org>
Date: Thu, 05 Feb 2026 17:47:26 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257277-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C259F628F
X-Rspamd-Action: no action

The pull request you sent on Thu,  5 Feb 2026 09:18:31 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fdb05de0e2db89d8f56144c60ab784812e8c3b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

