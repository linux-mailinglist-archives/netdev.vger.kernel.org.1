Return-Path: <netdev+bounces-296996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c9DuKfvcJ2pd3gIAu9opvQ
	(envelope-from <netdev+bounces-296996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:29:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E465E568
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:29:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nNBofypP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296996-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296996-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0014931261AA
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A703F6C32;
	Tue,  9 Jun 2026 09:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31B3E9F7D;
	Tue,  9 Jun 2026 09:20:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996808; cv=none; b=pHhx7z9tilCKmKSE6MdlqKFCsZcJwDI8jf6qwFmn6dTEIGlXFvgzTJkEuYg8+MsIBfVfwD50YNAwNOsMyyeHIIH+2HNfhyH8q6m6dXRZmyEPGdoxJZJ//SXitTyFt+JEx3Ce2EYyz5kj8qc4kaUMrkvnwznvT10jEtk8Op5hQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996808; c=relaxed/simple;
	bh=qZSA9ggaPKM6E6S8XSOJxK6I9nJSCiEit4OFAUMTPko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZTxpJqAVxCN0TxWesLhCuQwL1y9j0zkNDv81eDJiakADYMZajYl4QjInmmBsuQ2SrWW5Q/jhnyRjm7/RwOaB4xz4t3nJJrn9rPr+dGGkVw+Rws+kl1gtzIjN5SYFjdbeK7tjfVZLvSFaxO5CauKEKeF2YIx+gIT07tIzO1ORKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNBofypP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850631F00893;
	Tue,  9 Jun 2026 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996807;
	bh=REqM60JIutvr1UlqjQEL5ZyXW6shAcahCKYRUH+V61g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nNBofypPqEcQ93osXQ7I03cQ3+3uCXmSwNxlY8nJMq6fSY0kMhiZ5IGsMUebjZ3qc
	 gaEK583dbCQh7vx+ddKb1ahPTcyLeYvLrBLbv0hev+UIBlOnLNkMC2ScTrgwAnP7vz
	 KdRjFz/wSHeYTOgvjxsPao1HmZ7ayL/lHCp9PuJmFli2omyut6DoG/lfm50GxlMJ/h
	 6aBV6o7frmT9vQocHgwQX4I26QeqOCnuCRopggf5bkzHBPLE5jU7Ymjnu7xKLoKy4J
	 L3w5f28VMY6pcmJM3vOOQPspOpIbc3j/vD9dxcW3p7ShOSVW+swT4cAAwGB5hV9g6C
	 DCMzCvF5ZRbGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40A3F39302D6;
	Tue,  9 Jun 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8152: handle the return value of usb_reset_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178099680590.1906662.18338551033084703572.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 09:20:05 +0000
References: <20260604092247.27158-450-nic_swsd@realtek.com>
In-Reply-To: <20260604092247.27158-450-nic_swsd@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-296996-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:nic_swsd@realtek.com,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC3E465E568

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 4 Jun 2026 17:22:47 +0800 you wrote:
> If usb_reset_device() returns a negative error code, stop the
> process of probing.
> 
> Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
> ---
>  drivers/net/usb/r8152.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] r8152: handle the return value of usb_reset_device()
    https://git.kernel.org/netdev/net/c/19440600e729

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



