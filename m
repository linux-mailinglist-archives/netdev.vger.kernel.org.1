Return-Path: <netdev+bounces-306594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id irkTMAUEUWrr9wIAu9opvQ
	(envelope-from <netdev+bounces-306594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012173BCFB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UvvorHlY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306594-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306594-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C732303850C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7134D385;
	Fri, 10 Jul 2026 14:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EE349CE2;
	Fri, 10 Jul 2026 14:30:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693829; cv=none; b=h/IH8pqGoj8nkoVunsAf/BJaguD1Bb0jtK6Bi9pHBSaSv2vdZTyrYEokXXCDlwuj5trTowmi27DapU6OPt+7lNFGlUFmHRQj3ble+XHJ3A9pGlPg5H0AryeO4zm9cf94usZ6G9qJyQFhFLghWRX25jxMHUZaxU04wF8nUqQxQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693829; c=relaxed/simple;
	bh=Y2Qk60/aBHEqmikQ8DRFc6QOS+mAIxRRTuaylW09lJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qsEn+gLlVMZogUMnu/aP0HbxX7nEb2ETjuqjqShvyMaBIWHMmjsbrO3rja4beqi4e45wXX0Co5XjTUuq/ULGLKQMX6a2im7raIluk8eIqiICy5N8lbouj+SlEEQr9T+hGxTP1QscXkBuIFA8q88yTvbhpCjg+FThDpdM1xvlyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvvorHlY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0A81F000E9;
	Fri, 10 Jul 2026 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693828;
	bh=4decS/j5Z05u+cHo9JLWnSsA42kMyfwxEZmjd8WNFNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UvvorHlYTocPstFEzsTrz5XF4J8+PGPJQ6srmagQ/TmoNkdCR5aYWTm1cezEqT70m
	 tGXxz8sR+EtAG+AL9AdRY8ppAOh0SP/Xa9KQfmE1CiX8uea53VY4HDDzZM+r8E7DLg
	 tDGWu5m4VxJ0uc63G/a7KcbdQtxgtnCnnxoU1JBbUzSxxung103lJb58c9PAoD7sGf
	 xLbx4AjwJ9ZXteqKoJeFd+glADl5VT6aPhCrx8m8uoEVKtF4uQIwaq7A+evUMw9Nhz
	 Oly/7K2bg/n8ivayzCK13+r/v1dM0CSt6cEKeUTMyBcpPecc3Zl1AAxDNlI9tRHFRP
	 mv+5uygHoevYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391F3924F97;
	Fri, 10 Jul 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/iucv: take a reference on the socket found in
 afiucv_hs_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369380615.710487.10375995602211210819.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 14:30:06 +0000
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
In-Reply-To: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, twinkler@linux.ibm.com, wintera@linux.ibm.com,
 nagamani@linux.ibm.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306594-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:twinkler@linux.ibm.com,m:wintera@linux.ibm.com,m:nagamani@linux.ibm.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1012173BCFB

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 05 Jul 2026 22:24:36 -0500 you wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> afiucv_hs_rcv() looks up the destination socket under iucv_sk_list.lock,
> drops the lock, and then passes the socket to the afiucv_hs_callback_*()
> handlers without holding a reference. AF_IUCV sockets are not
> RCU-protected and are freed synchronously by iucv_sock_kill() ->
> sock_put(), so a concurrent close can free the socket in the window
> between read_unlock() and the handler, which then dereferences freed
> memory (for example sk->sk_data_ready() in afiucv_hs_callback_syn()).
> 
> [...]

Here is the summary with links:
  - [net] net/iucv: take a reference on the socket found in afiucv_hs_rcv()
    https://git.kernel.org/netdev/net/c/4fa349156043

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



