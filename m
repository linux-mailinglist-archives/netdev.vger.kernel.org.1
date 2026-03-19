Return-Path: <netdev+bounces-269652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE8pCO1jvGkLyAIAu9opvQ
	(envelope-from <netdev+bounces-269652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:00:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF102D273D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0D25301D566
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17277363C60;
	Thu, 19 Mar 2026 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0X5MUR+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573F3FE663;
	Thu, 19 Mar 2026 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953992; cv=none; b=hnG36cstA3AXHVp4HNb/p8pDjuPgn16mAQhnIfj5R85Kofbm6M3AAt5UTgGEeI5lZr9xypgCAazsG/f85J/jkVGZs7djCsCCoswLmTTTDHtJFLZ3svEill1/zq1lI5nLEUskvnqZPOZRaBbP/DwS8tqfWAfILMG/em1iZveVtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953992; c=relaxed/simple;
	bh=/Gwn0J+WQ87uDIq7qhXYS8GR+vdx0N4ZYfcLIXrtOKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lamm3iiPTF8m5HkRGMVj64ImTJ86kZ59xmR5YoL3SB/9JYalJZpeljRKyfl/VmQ1pS5SlNXe3hGHpiioKvR/QZQO70YYXe3CS0arovQ5rywhqi1qXtgUn+LqIr3OWOB8ShvGKcJLo3qfYzjjr9q7yMKxITlpDWPJlouJ9MfWUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0X5MUR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F35C19424;
	Thu, 19 Mar 2026 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773953991;
	bh=/Gwn0J+WQ87uDIq7qhXYS8GR+vdx0N4ZYfcLIXrtOKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j0X5MUR+V906J25XhU98tTMggkiRf2qxZ2I/8jiJMU3AsTcj0prRLJEdX3ypBCIMT
	 lFJftNjz3VICj859Dw0V40k0AGeQUNR9UOSbXP5f+E26Z6skuRhwMx9Z3qxv6AsItH
	 V4PI2g88aws3g9qn6n/En0dxtFhsKhbLGGr5dMQmvwkHjSW7Kq502aVGsBk8KR498A
	 2GkBe484WA5eDyEkBYp6Y6Q61B6IXUYbErH8zNqpUTavICtVTW/DXG/TTNrUpDwMZa
	 bz9ElWX4B40xXZ8EDENTJRyGSNDaCM0Uz69BGrPdOwBggmpQ0LbtF8KuUyjL8OrnED
	 g/V5bwmt2NLTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA22039302F6;
	Thu, 19 Mar 2026 20:59:43 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260319172041.4035309-1-kuba@kernel.org>
References: <20260319172041.4035309-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260319172041.4035309-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc5
X-PR-Tracked-Commit-Id: 7ab4a7c5d969642782b8a5b608da0dd02aa9f229
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1d9d8e833781c44ab688708804ce35f20f3cbbd
Message-Id: <177395398233.1799157.12266798296140604162.pr-tracker-bot@kernel.org>
Date: Thu, 19 Mar 2026 20:59:42 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269652-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AF102D273D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 19 Mar 2026 10:20:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1d9d8e833781c44ab688708804ce35f20f3cbbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

