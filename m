Return-Path: <netdev+bounces-252617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLOPLJ/fcmntqwAAu9opvQ
	(envelope-from <netdev+bounces-252617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:40:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494476FBE5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C41F3016C9E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F12374167;
	Fri, 23 Jan 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOQ8wUOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A235D5F8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136021; cv=none; b=e2WR8XYiR7OXXzmPm86TX9lCHaf4GWJORMMLirYWaP5mqOoSMvCpaieLW+ziciM9daStfr3TznuknS7YRdpmgepmn2l+j3QxwkVVBRiEDhtu5vQA0ojbAEt44OngfjVjP3UE9JXapX1H3LyqaG2JOGIfwroKEY4WXUbkaYaBtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136021; c=relaxed/simple;
	bh=hTXoQYwo8ykC+hBl9sW76f7x9Tjxs5euxwG7O+468RM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HgPlDd7m2psLm0v/WKqsYAn2PlFoPgZZnOgALW6YQdiMWZiXjiDO/8zkT/HFuxAeRH9TNf5B+GGpGnRyM3jj7WnAuUXVZ4ElHHq8Q9WUp4Sj/y+yGGBifb8OGEYOIw9kcB3wBODcX6/DwcJO2vi6b39Sfxef8GA00hjwiYhfBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOQ8wUOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1DC16AAE;
	Fri, 23 Jan 2026 02:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769136019;
	bh=hTXoQYwo8ykC+hBl9sW76f7x9Tjxs5euxwG7O+468RM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BOQ8wUOaWUg3MgLjP8TGuPGmH04dGgnz4ifyrjZSNwQ0SAzKg3hj1cTmg2EqzoNYd
	 hWcudsn4TVchOL5tuDcMb2oDv1MsRRNWV5zo+AmLTNDsQxETlgTxaZTAmCt519ZTpu
	 PuwwNJVe0JayQzqrXxTHbAIBHTdlTUUCotOZaLxRM20WWSJS03QO+W4gFr1CtdPekE
	 PFUXmoEnHDFSln2BFy+UYKiByIpbsG5eGk8V6rSbxAjqh6S/1ER0DMDIvbHAsblvpJ
	 shkGHZyS4R1xmoO2tupISbrtB8IWFMvIu6OQTE9GODzkRDIIuniYtkeS/QpFoS9TE8
	 UxJg/fqTmBnvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AE33808200;
	Fri, 23 Jan 2026 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: remove tcp_rate.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176913601584.2368645.14555144176625626997.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 02:40:15 +0000
References: <20260121095923.3134639-1-edumazet@google.com>
In-Reply-To: <20260121095923.3134639-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-252617-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 494476FBE5
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 09:59:21 +0000 you wrote:
> Move tcp_rate_gen() to tcp_input.c and tcp_rate_check_app_limited()
> to tcp.c for better code generation.
> 
> tcp_rate.c was interesting from code maintenance perspective
> but was adding cpu costs.
> 
> Eric Dumazet (2):
>   tcp: move tcp_rate_gen to tcp_input.c
>   tcp: move tcp_rate_check_app_limited() to tcp.c
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: move tcp_rate_gen to tcp_input.c
    https://git.kernel.org/netdev/net-next/c/b814bdcecd79
  - [net-next,2/2] tcp: move tcp_rate_check_app_limited() to tcp.c
    https://git.kernel.org/netdev/net-next/c/bc1f0b1c98f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



