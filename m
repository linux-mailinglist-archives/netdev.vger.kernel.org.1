Return-Path: <netdev+bounces-258216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOrdMWU5jGlZjgAAu9opvQ
	(envelope-from <netdev+bounces-258216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:10:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6B122161
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8090F303012B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB82834EF1B;
	Wed, 11 Feb 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOVpxfMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F322264C7;
	Wed, 11 Feb 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797410; cv=none; b=sUmrXWIjWux4J+QkmVBfJ1RLdWE2WDb4hloK3J7IqTPdYPvzViLSw2ACd9SxvYawKqlWxsYv74ikZi0F6cBwMgCuXxCbiEmwj5STXwloAsSIHwJFMTRKlJs+3GMLZwrhkPLh3uRXnsSCMV6+RGJNbrvF7NKRvxijDFQ2gb9crpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797410; c=relaxed/simple;
	bh=G82nyiOockjch7tzPX2TQu1nelLRdi8g1wC/tcZhusM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MtOhTGCtvUt0ut/e5mIduRupKwiW+xazG1dAbKqpw7DWj9FsXl6VL0mPwiMxmIQlk+wDOAx3np5gVK1252c46ugHzJjbt+wTEdhX7lR+6QPfuiaeJOk0tX6qyGY+h3b0UWDxY8HEL+rXDyXUVTWAaL65KFi86cvPwSE6qeRJo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOVpxfMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C61C4CEF7;
	Wed, 11 Feb 2026 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770797410;
	bh=G82nyiOockjch7tzPX2TQu1nelLRdi8g1wC/tcZhusM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOVpxfMwTC8c5dZPIv2Mo2QnlKXewS8KpovejBna1SRNzHyL8FUBiZpxu/rWf/x2p
	 hDKjBJGIcQqzEOWgTmvTK7/kus5OJoeF6NYGTTQE0bMIhi7pHsjuQN7z5dm2zmwV6c
	 G6cY3gbNOQd2c71k8HSRaPBmDIUgV5Knt/QRRGfc6PPkk6VMr/hKCKm9Ykszz3xJzM
	 FxqcoTki30h+2JSbiksgtgIqNgPyAD/fYhiLC0ig6eihbHKITtglTEL6glxagygwEq
	 mnnAVbSXE3StgKDA8oe4jNLaMRGYLLK4e+hggRN2WmNUlQ0Y6h5azS05kBia5CpCsX
	 pqfiH1fYjZYSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8531139E4DBF;
	Wed, 11 Feb 2026 08:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: renesas: rswitch: fix forwarding offload
 statemachine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177079740533.67100.2512796446047987823.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 08:10:05 +0000
References: 
 <20260206-fix-offloading-statemachine-v3-1-07bfba07d03e@renesas.com>
In-Reply-To: 
 <20260206-fix-offloading-statemachine-v3-1-07bfba07d03e@renesas.com>
To: Michael Dege <michael.dege@renesas.com>
Cc: yoshihiro.shimoda.uh@renesas.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nikita.yoush@cogentembedded.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258216-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3A6B122161
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 06 Feb 2026 14:41:53 +0100 you wrote:
> A change of the port state of one port, caused the state of another
> port to change. This behvior was unintended.
> 
> Fixes: b7502b1043de ("net: renesas: rswitch: add offloading for L2 switching")
> 
> Signed-off-by: Michael Dege <michael.dege@renesas.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: renesas: rswitch: fix forwarding offload statemachine
    https://git.kernel.org/netdev/net/c/e9a5073a98d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



