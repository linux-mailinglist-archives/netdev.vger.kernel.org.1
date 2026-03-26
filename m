Return-Path: <netdev+bounces-272169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBjZMMluxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:37:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0E3393CA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 609BC30E105C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA17423A78;
	Thu, 26 Mar 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eINTcyHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFFA423144;
	Thu, 26 Mar 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546261; cv=none; b=Ydeobf5WPU86JG86nfkE2/IV7vCagGNG7QGQQlYfMwIBNfQJFnpCU+3fLVEAOlQvsMLhSB1EcawwMJj9EgHT1L73eY16JxMsYO3mAXvfon2jq20l9amOJxlRgCz1PYeqBVwCN1xtQ73jikeRgHUV6/SyKJ2wpY9/sEfLqAB+YV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546261; c=relaxed/simple;
	bh=f3uQZ3KbpPjHvy59gBnkif0pO9fMKfnmmYRZRQlLEok=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IAnN7UvJki6r9japxdYNicAg+KCj1XHS+UCJFRiFP4IdU50571NmXR0X/LaTresl6onyFXjbg25+Hq4GrR3xd3Sy1Ua1l+gnwTycJw4uyuCmbFeiylDLVcBiP2AFnC3kDsjEkFxOzrInTEubpL10EGyXDg0u+V4b2rPmDWah9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eINTcyHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AF4C19423;
	Thu, 26 Mar 2026 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546260;
	bh=f3uQZ3KbpPjHvy59gBnkif0pO9fMKfnmmYRZRQlLEok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eINTcyHxXFMKoTQmksNhECs8CyDSherl6x7YYZdrWkV4AwuyEOo/yB1JLjpKrHnUk
	 sz3YHxaKRTbLvKvOM/TsE9GfFdtyW6vEQhdS7pN9TyHkA45ieHW80xZgJIFm+Dez9u
	 IgRQbYIKwbSb8NrxB3RhCe8RY4SeXX+iQrSkdOb4lJ2a41/TRLeBR68lFORaDIbchL
	 VcrnrJqZcZULu9M24O08cNPkh8zdGjAiimkL9PHwG1tKMo6/Ex7vUf3Ted0pZY4qb8
	 h4PGnfXcSh0t2g5HaTyvqOPEjg7BwMayZSPGTwnXkFwrF6owaoauGFGwN3kLMrkgoR
	 rPslcZEUOk6zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F1839F2037;
	Thu, 26 Mar 2026 17:30:47 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260326163029.350902-1-pabeni@redhat.com>
References: <20260326163029.350902-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260326163029.350902-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc6
X-PR-Tracked-Commit-Id: db472c34a74770f39318ddb1efa986c0a8d5d86a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 453a4a5f97f0c95b7df458e6afb98d4ab057d90b
Message-Id: <177454624641.3098378.14236139068355746366.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 17:30:46 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272169-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59F0E3393CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 26 Mar 2026 17:30:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/453a4a5f97f0c95b7df458e6afb98d4ab057d90b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

