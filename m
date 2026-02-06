Return-Path: <netdev+bounces-257414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hWRAITtZhWm7AQQAu9opvQ
	(envelope-from <netdev+bounces-257414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:00:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E67F97C8
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D58E300D9D3
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068B27FD74;
	Fri,  6 Feb 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW0GVluk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD291221FCF;
	Fri,  6 Feb 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346807; cv=none; b=r9B7B/K/hnHclMhHqMuhw7Rus+kSrAqZftVN+f/MJWjpPjqqHdXkl+P0EXzng2Vt39Vg2SmXBJZwKhWjyhivvd2ZE14V7857c6kIVUSk1E829iJDpvHkajhKOoAj7FrNPgZiusSEgxVpEHGGoroSddLUQoX1Ot5eUDrZK6lo53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346807; c=relaxed/simple;
	bh=yyPBPdqWtCWB66G2cOZg4eEm2C8BEy+CRs5V1N8afJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p8l4+RAL0QwhkgB1B1IfhrUB5o9fjCMq9xeAEU9kZDXOtIgmfQtX4wgRg1ZiWRb1sqG62sbv5veaom2m1iuYEuK1PIr7aMeGUw0oIvC6n2TIdNkvFk3JDJT4G/zhKIl665z/kf3oO6uNdT2UhZM1/FJCqCg7nppnstOcYYIZMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW0GVluk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A8FC4CEF7;
	Fri,  6 Feb 2026 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770346807;
	bh=yyPBPdqWtCWB66G2cOZg4eEm2C8BEy+CRs5V1N8afJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EW0GVlukO5NDSkf/iPNKdP+Oti/JOH7mWs0g2SecD7fA9DitRd0pbGdNERFUkB8Ld
	 bJRGIOYIuBKAQFkQEytP6ovO2K6kdYwO4i3NKZHuKG2BhAZnnUSBkjRAqakjDwXgOP
	 m5725PmlRt39D1gamIbFPKA+a0t6cWb8li07mcxDOh9U0gqyzvHSSY9B51PwERDCpT
	 8Ze0jd4Yjy7TN2hpDDX6TGCW8/6W84u0Dh37Go5Fo1wlgydiGuN0IPhOmOcOugOhIN
	 UgDFodgLB010jNmk2aMwttVa/9qN5prTXRMjDBMoJq3kHZN1oww3rwMGzgC9O/aIEr
	 6udGTsXr4r9Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482263808200;
	Fri,  6 Feb 2026 03:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfc: hci: shdlc: Stop timers and work before freeing
 context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177034680483.662298.10040199384768030642.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 03:00:04 +0000
References: <20260203113158.2008723-1-Victoria.Votokina@kaspersky.com>
In-Reply-To: <20260203113158.2008723-1-Victoria.Votokina@kaspersky.com>
To: Votokina Victoria <Victoria.Votokina@kaspersky.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tglx@kernel.org, mingo@kernel.org,
 eric.lapuyade@linux.intel.com, sameo@linux.intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257414-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7E67F97C8
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Feb 2026 14:31:57 +0300 you wrote:
> llc_shdlc_deinit() purges SHDLC skb queues and frees the llc_shdlc
> structure while its timers and state machine work may still be active.
> 
> Timer callbacks can schedule sm_work, and sm_work accesses SHDLC state
> and the skb queues. If teardown happens in parallel with a queued/running
> work item, it can lead to UAF and other shutdown races.
> 
> [...]

Here is the summary with links:
  - nfc: hci: shdlc: Stop timers and work before freeing context
    https://git.kernel.org/netdev/net/c/c9efde1e537b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



