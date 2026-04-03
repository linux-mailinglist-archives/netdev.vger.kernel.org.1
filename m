Return-Path: <netdev+bounces-275273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNMlM2dJ0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5691C398FD8
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171E1306B2DB
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4638A73E;
	Fri,  3 Apr 2026 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQYO++2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED838A711
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257833; cv=none; b=G9gqn0KRjUskAjdecGD2lXhhE+rIcBAX0zRhczLanTBfvf5QbfXK/KYn2qRS1jBqXCsWhLwc2UMkpSlBlw+9u/UsBgSAfVFXmB4ypWwOtIC7LGvC9d0rEDUGj0aC55vSsOTvvjbMDy6Nr87CaZckx4N+jXNB9Ofc5srWDJ8BAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257833; c=relaxed/simple;
	bh=jSrg7F5xaOhot7jDJEG/Jn1j7T2N9zsodc7+QSm4nLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiRuq9Hwld0JLuOhB7Cl7TFr0xmpE1ZzJOTOXB+s2TZAE6PZXAnGtL6QbFJGOC0QobNgTJoHox+hEjhq8nW4TtYvQQ3dVwUyqnF+PxKsiy7L1OS3DuKy2CLcjrFPzBeZ5nm30KQKLa6ocIryrMDFf5Addk+VrIyhnmuSw6bgozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQYO++2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3643C19423;
	Fri,  3 Apr 2026 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257833;
	bh=jSrg7F5xaOhot7jDJEG/Jn1j7T2N9zsodc7+QSm4nLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQYO++2OnTHXSDNLiSSRBQtB7ouInIcRlFFKxh2Xo20dllnZNLmkEmL3p11abFQ5g
	 jKXUxZ+Np/yiavuNaCTUQ/KO21N0tiI09r1cD8fPUcUneLidlIksY9LpJGuD6E1Tx/
	 7160MmxJ37eJED/IiyewruLunt4JxU3UBVND2HEXjTRS9dRnXhIHAy+CaeGQtUltga
	 lNycKtcNl6/ZEcCyeZyoC+w9Q7CJjSfmS4sOTq7F/fZog7NcKeJqRBZXB9vjFC6DKy
	 7LLPZBREDvUxJjps6AlHJQ+dkzT8Phz57MR5HLctzi1E19MJDTwX52AXvRg8c7KFg9
	 cMNsO1S4ALNAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DB63809A14;
	Fri,  3 Apr 2026 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525781428.1484550.15720765341034286626.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:14 +0000
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
In-Reply-To: <20260402070419.2291578-1-sunyiqixm@gmail.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275273-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5691C398FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 15:04:19 +0800 you wrote:
> ipv6_stub->ipv6_dev_find() may return ERR_PTR(-EAFNOSUPPORT) when the
> IPv6 stack is not active (CONFIG_IPV6=m and not loaded), and passing
> this error pointer to dev_hold() will cause a kernel crash with
> null-ptr-deref.
> 
> Instead, silently discard the request. RFC 8335 does not appear to
> define a specific response for the case where an IPv6 interface
> identifier is syntactically valid but the implementation cannot perform
> the lookup at runtime, and silently dropping the request may safer than
> misreporting "No Such Interface".
> 
> [...]

Here is the summary with links:
  - [net] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
    https://git.kernel.org/netdev/net/c/fde29fd93493

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



