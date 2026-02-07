Return-Path: <netdev+bounces-257728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Vmq7GDDChmmiQgQAu9opvQ
	(envelope-from <netdev+bounces-257728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:40:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99350104ED5
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A5F93015D0E
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71A2D7DD1;
	Sat,  7 Feb 2026 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qce4TRwi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9E2D73AE
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439211; cv=none; b=n8sRWoTcR/lvdfeJipj7DcbDe5+Vz2i3FElXRy7/lZWJPCLwVkveyi5CIj/CuPjt2TKzbovReJtTQ2W2TxJwaDpB4/iX5jeKejYJ2LrNAVD8/G9VwtUgpxse84twrcgFbggKtbpepMHKryAaFW3g846W9JpbAqtgZRGRTnjtY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439211; c=relaxed/simple;
	bh=6ZNymhXGUjQZq2msE4gjJ5PnV2qMyjdxgfAllHUhavA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RjDV4W6RXrHtvQxR2rXP2Ld2oGtYWB0QsyGOXthshuA0Uhu9E0hvoayinYfTj2o+1TudxUv64XTpYj0jg9YxMgECO3aw/G9vNbb5l4TK7YCg7Q2lcZ3MADV5PFxjsIkpfxkKIg3kToVrvKblUnj7iGQl31mEeQ9uDP64JWOljfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qce4TRwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C336FC116D0;
	Sat,  7 Feb 2026 04:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439210;
	bh=6ZNymhXGUjQZq2msE4gjJ5PnV2qMyjdxgfAllHUhavA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qce4TRwi4MM/jlX2iLALjBoHwjf0883gSD8RAUf7sZDK8FvYanAy+OAHicanRy/4E
	 qK07zPLyioKln4NZNdNk8MC4rOincAsExFFByphTyEq6WGf9Ss4IgiYOmgW+j8kbzc
	 A+BI4VYVrRg5e7Da85AFLEx5lO4dhOBWXl8a42ywo4xXjLI3BaNnB4D5x5FejBId6D
	 QdWn7KxhKss5wxeAaWGC5CCa6SxM/bq9gTsVEYyied2Tgd/Evrk4uLJrWag3GO+IyU
	 4yVuN5CV8FgWxZliyposFfcQR5MYiSlKbtphLzp7M1oAziV8EVbSf4diKczXLxM6o+
	 gDMlY4h4U6wWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0283809A1A;
	Sat,  7 Feb 2026 04:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: inline tcp_filter()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043920783.1189128.16715600237835460371.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:40:07 +0000
References: <20260205164329.3401481-1-edumazet@google.com>
In-Reply-To: <20260205164329.3401481-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257728-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99350104ED5
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 16:43:29 +0000 you wrote:
> This helper is already (auto)inlined from IPv4 TCP stack.
> 
> Make it an inline function to benefit IPv6 as well.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 30/-49 (-19)
> Function                                     old     new   delta
> tcp_v6_rcv                                  3448    3478     +30
> __pfx_tcp_filter                              16       -     -16
> tcp_filter                                    33       -     -33
> Total: Before=24891904, After=24891885, chg -0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: inline tcp_filter()
    https://git.kernel.org/netdev/net-next/c/a35b6e4863d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



