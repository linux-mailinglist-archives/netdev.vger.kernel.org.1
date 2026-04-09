Return-Path: <netdev+bounces-276791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAX3CsgR12khKwgAu9opvQ
	(envelope-from <netdev+bounces-276791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:41:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A53C5983
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 035B13028F6A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854436C580;
	Thu,  9 Apr 2026 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTxe88yp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D236828D;
	Thu,  9 Apr 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702448; cv=none; b=grV+liYU9ZWKmKgac2/fHWVYF+aXrL7iw1d+MeyIp6LdfSkSGa1HAVtU64FdEHxTJVPpnavgXhUqA4XJJqnTUmtLa61eL4qVZV+O+0AEGCy+lgEqfkrWY4SZwTLGLGwpA8n1PndDnotr4SK4qgelBj9VrKKCy4F45ZYAt1aUwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702448; c=relaxed/simple;
	bh=HhqT4a7t4eXQmKLvX6hqb15K6NPEpstkWuQleu6eoCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L0FxueP2YLdMb8v3VSq0K2kvpqon1rtp29cakoZQB6xqtGck/D/Z0NYzeMpFYyrwtSX17n9I/fXUXkS02HfV2Nr/ssgaRRc26k8LPcJVxKaSJJRSiWL17i4kD5Lh3rsa8qRZBS28OSHDp+jBuLx0gAoOSRdRaCuSgBZbp86HTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTxe88yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49812C2BC9E;
	Thu,  9 Apr 2026 02:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702446;
	bh=HhqT4a7t4eXQmKLvX6hqb15K6NPEpstkWuQleu6eoCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZTxe88ypm061McFvWbUQa+RbLqtbpzWqaVNAvxOlotRqj3Y6o53UgrY5JnpXPG9ax
	 IHMz/hqBBEgg6iTWPN/CrdAe+nLtde52UdBSQs3KfGOUjiWlaqD2c3rqmJeBeZ3Ikl
	 X0iEEE9/i9+fw/Z/2cTd/bDlADMUeM/8M5F/TD+KNGJxKXBPhccoqTZHfThFmIDecl
	 W80w8daWfcIkfbh9myApg8rUp2L1pCefjBpBdX062upM1+WgDIqOiOBsaWJDCmcqw/
	 FCic3FdgHOXc6d7gaP2gQiFbS7B850aKGQR/v8/3mbjqSUYjYxryOblRiuZUV1NcNp
	 MENIVUANHMAKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EAD3930793;
	Thu,  9 Apr 2026 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: bcmasp: Switch to page pool for RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570242254.964658.10910304956594603004.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:40:22 +0000
References: <20260408001813.635679-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260408001813.635679-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
 arnd@arndb.de, markus@blochl.de, hkallweit1@gmail.com, fmancera@suse.de,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 nb@tipi-net.de
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276791-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,arndb.de,blochl.de,gmail.com,suse.de,tipi-net.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0A53C5983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 17:18:13 -0700 you wrote:
> This shows an improvement of 1.9% in reducing the CPU cycles and data
> cache misses.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: bcmasp: Switch to page pool for RX path
    https://git.kernel.org/netdev/net-next/c/686a7587bd0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



