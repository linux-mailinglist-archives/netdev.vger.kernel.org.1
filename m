Return-Path: <netdev+bounces-262030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLPoAx1Fomnd1QQAu9opvQ
	(envelope-from <netdev+bounces-262030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBAC1BFBC2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD85C3034666
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E85C2E9EA4;
	Sat, 28 Feb 2026 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhqxQuwj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82C2DECC5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242202; cv=none; b=H7dkeu9NgJOsQB4b4hp+4Zx2igEKB1AuJxFhtAritsUmhnEeYHfHmTaq8ESB4Z2QT+wZnN3X3drPqYABqs2o+lOEgPWIbv87d4BHS1tTVQ7KROhyOws/wljXpUsbiPxwKru+kNkhlbgH1q7zUvY4qCS1p6gcoXBO5qqTk0p1bpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242202; c=relaxed/simple;
	bh=BtEUHDKkcH2bLX5ebjsI2w+T1Cwvf0zXNM+Vb34H/KQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J2r02GIOQUZXmZIugR25320ZOyNB/f/D4L1oOFLURRnY+SeVFExhEy6LFq5xwJYQoAEATJK4Vz13VkfJCO8DKhtYULpA/u+KleHwQQaSO8tQBANCfC52OzA8lf9e4msyyyfTdtLTX32ozoLfCPOJM92oAFKTizV7TwrJXwHgBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhqxQuwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C296FC116C6;
	Sat, 28 Feb 2026 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242201;
	bh=BtEUHDKkcH2bLX5ebjsI2w+T1Cwvf0zXNM+Vb34H/KQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GhqxQuwjHbL2+5rMs772nvk6TDEKPdnDxq0L/zPj4guQX8O57Fqql49HNMyJBp1TN
	 ErWNrId4DyxeqlYJ4G4kp3e+icu4PkkYakRXnvdszT+1sbJ9mhcnV6WMv30nZ7q3ow
	 SPs8cQeGGveHeinuvbL/5LTLzcMdxtKMi7V6fBcBxQeDiFWC5oIujGQ3huKZYRrU27
	 LEgFtNzvzsE+2idO0+vZJ9KUSFoDtyv2OueJIJ0esAha2Irmuwclhh3ahBwE/oLbHw
	 Wu8VhhNQxTix48fk0/9hRA6EovBHUBGyTDnYuNoq46cSpEc5d9LE0KV8NMKLXKNkw4
	 QmwUY9ujlJWXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0C139EF96A;
	Sat, 28 Feb 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: annotate data-races around isk->inet_num
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224220505.2830622.16544036216262878564.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:30:05 +0000
References: <20260225203545.1512417-1-edumazet@google.com>
In-Reply-To: <20260225203545.1512417-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262030-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5CBAC1BFBC2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 20:35:45 +0000 you wrote:
> UDP/TCP lookups are using RCU, thus isk->inet_num accesses
> should use READ_ONCE() and WRITE_ONCE() where needed.
> 
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/inet6_hashtables.h | 2 +-
>  include/net/inet_hashtables.h  | 2 +-
>  include/net/ip.h               | 2 +-
>  net/ipv4/inet_hashtables.c     | 8 ++++----
>  net/ipv4/tcp_diag.c            | 2 +-
>  net/ipv6/inet6_hashtables.c    | 3 ++-
>  6 files changed, 10 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net] inet: annotate data-races around isk->inet_num
    https://git.kernel.org/netdev/net/c/29252397bcc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



