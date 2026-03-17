Return-Path: <netdev+bounces-268594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBEhIE5MuWnG/QEAu9opvQ
	(envelope-from <netdev+bounces-268594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:42:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11972AA0CF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D632303F7F0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406BC3C1996;
	Tue, 17 Mar 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/ZcJhsB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999D3C13E3;
	Tue, 17 Mar 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751213; cv=none; b=DLbOuAlgIeIX6pd6R1kSBqspBF4rLdUOOsNypj/XMKu7M83fXBOzGLP2T2TrEc3CUu4yQr+KtdZU8PoerD1Lim0GOr3Sd4M4aynxzGDGh1/dOeSuCKEZO9jFs48a6InvZikQjaeVtmr8V+gXDBKJBhtEr+scKXmtXuVeDIXRo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751213; c=relaxed/simple;
	bh=f9aCgqHc9Z9hg9SrBPxyGVP85yvakfMAePswxE1Hw3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQz4WBeLkaoiES5z7mnTDRrftSdmTUqQciCKHRynai/p65GYf5qKEah2exh/2bTar9SLKY8LQj0ZLkBsw+s5azGCxeckD4/QD/CSbRGC4NwkdMXEVnTAcM8tK+O9DdM92R5e8ubkl8XSrjslBXxxHfbODTjReFOHY2lppgIrfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/ZcJhsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4D2C4CEF7;
	Tue, 17 Mar 2026 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773751212;
	bh=f9aCgqHc9Z9hg9SrBPxyGVP85yvakfMAePswxE1Hw3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L/ZcJhsBey9Q0LnENoBjq4x1RHPgt/AiAL7UyV8IdcXyvV+OXfkhAVE2WJokDfibL
	 7TDLqTutmTdxFsapZEuZ4vNJ+wJaAUnQUUiwhA6K3UgaHFq5lPEoytP5gbsiysQDM3
	 J+gnJHmaX9mj/flcaDdMwOlUYrpLcSvuP6on761GaKVfqeQtwKgrAgFrWSadqG6ObV
	 e21Lm+y1hGn7HqfjOgFkECVOtenoHE1zPbYaTcxFVBkZBpO5i8N+mZ+rnRszflTxIh
	 aMrEMvhGkbBCGkd6PP06NBcYlO6HWAkJbcx5sKJciqQCo9gKrrqVKGHy9ElowqgtS7
	 qkDkGAqVFXTzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE9D3808200;
	Tue, 17 Mar 2026 12:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: aqc111: Do not perform PM inside suspend
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177375120504.3601019.8300848005217374464.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 12:40:05 +0000
References: <20260313141643.1181386-1-zlatistiv@gmail.com>
In-Reply-To: <20260313141643.1181386-1-zlatistiv@gmail.com>
To: Nikola Z. Ivanov <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, enelsonmoore@gmail.com, kees@kernel.org,
 oneukum@suse.com, n.zhandarovich@fintech.ru, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dbezrukov@marvell.com,
 irusskikh@marvell.com, syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268594-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.com,fintech.ru,vger.kernel.org,marvell.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,48dc1e8dfc92faf1124c];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E11972AA0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Mar 2026 16:16:43 +0200 you wrote:
> syzbot reports "task hung in rpm_resume"
> 
> This is caused by aqc111_suspend calling
> the PM variant of its write_cmd routine.
> 
> The simplified call trace looks like this:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: aqc111: Do not perform PM inside suspend callback
    https://git.kernel.org/netdev/net/c/069c8f5aebe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



