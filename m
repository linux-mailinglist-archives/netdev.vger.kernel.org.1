Return-Path: <netdev+bounces-258674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCFOMdqJj2nURQEAu9opvQ
	(envelope-from <netdev+bounces-258674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:30:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372B1396C8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 607BA301137D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4183298CAB;
	Fri, 13 Feb 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hREUNQsc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5228B4FA;
	Fri, 13 Feb 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014615; cv=none; b=iElWDnrwhccSUS/fqfBSKuh6fqs2Mo51NoqrAZn3w1jPei/JAWUXsrxd/FyWO4wyO/hm7dK9m60qRsdCYbEjo3QLP8qO2OYbOCy/RtnPWz6dprh2YEE4yf4avSKuAFtP4762VdCwc4QtEe2Qr/ooccNweB41T4h2tLjV+mgtlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014615; c=relaxed/simple;
	bh=2/isel9TG5hf1Ig8H/Rx6ciqOFzxs1NCkfMSRvAjrTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F9tfNqly6diJoDVvfsjWYMe93hL81L6FD5/qV3RxpmGNb9kBpdzOS+X7MD6/nwNFurs7pIcWYSFZhpDWoIsJb0CtAunxbGkJd2z5qjYJzWgfIrvUYHvvHLlqYbmRLfzNb2Z+topkKttacveNoLW2498Prs81Qi7EgzWdMttriFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hREUNQsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDB0C116C6;
	Fri, 13 Feb 2026 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014615;
	bh=2/isel9TG5hf1Ig8H/Rx6ciqOFzxs1NCkfMSRvAjrTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hREUNQscSu5cIXsrKkEVEogyw8k10cQY6JWcsNQFgFfrPSjvsaZu2rBN3bVVczxbz
	 smY86ci0mdZzA4VEHNTPmCmTZz3O8mfeeXLEBeXTmBbt0NfLikye1bOLbYMuk2QOgd
	 Lu0cDe30Fb7ImItMKnGCKRXxrP1isBuVwf2OTAy01zfb4QdRjeRJzL0BqsTnjNQlzf
	 wNxYcFKvK/balFXqmj8Wui1DtUEL0olcPxUgv2o2NH9w6CQ4fEP0sdQhYETI+oal8E
	 GQNvCMqDgwBMkwd81UIgO1S38fOP7UyjiQa+UYrip05s+C6qZUDJ5bgWZCk1bR1hbN
	 MvgCDZCW9XB9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2E63811A44;
	Fri, 13 Feb 2026 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netconsole: Increase port listening
 timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101460883.2548179.10870319755406955975.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:30:08 +0000
References: <20260210005939.3230550-1-treapking@google.com>
In-Reply-To: <20260210005939.3230550-1-treapking@google.com>
To: Pin-yen Lin <treapking@google.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-258674-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6372B1396C8
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Feb 2026 16:59:36 -0800 you wrote:
> wait_for_port() can wait up to 2 seconds with the sleep and the polling
> in wait_local_port_listen() combined. So, in netcons_basic.sh, the socat
> process could die before the test writes to the netconsole.
> 
> Increase the timeout to 3 seconds to make netcons_basic.sh pass
> consistently.
> 
> [...]

Here is the summary with links:
  - [net] selftests: netconsole: Increase port listening timeout
    https://git.kernel.org/netdev/net/c/a68a9bd086c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



