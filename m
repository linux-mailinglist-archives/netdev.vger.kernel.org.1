Return-Path: <netdev+bounces-257730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGGiGEXChmmiQgQAu9opvQ
	(envelope-from <netdev+bounces-257730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:40:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE77104EE3
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 360623020879
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F072E229F;
	Sat,  7 Feb 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+DEZmzA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85912DC32A
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439214; cv=none; b=vF+pSNmjYSkxX84GlSv9q+BvpnKzKTHImI+mQT1adQ46XPDGmcksyOvBArJRPAJIvYOyIvdmRzDAtCkTXpbPo8cQhIM8+3VNNtnrDK72aAhwXl0sQU2AfY2UgwIPWB7SLUHM65iWCoGHfadMR6QUh1CS88O7GRzt+DdFMj9XOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439214; c=relaxed/simple;
	bh=v3pzHLinNeUIreFbgj6SMS5VHn3aBJx2qfGChvlWMys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cPHj9gEED8cCvYf8EXpZRGSKRJRZt57KfwrC0L4lq6h5M3T6GiLeZBXyW1zxwAy5RN6PueaC8dbXhh4I8a6aTuoOQfuMZfYx5oGr05HIzh3GSbRwlxCGqTFQty5J/jxSyYIaSoghdx4T1NdrE31T+6Q/V9DtQOoHgPK0691TalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+DEZmzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4911DC116D0;
	Sat,  7 Feb 2026 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439213;
	bh=v3pzHLinNeUIreFbgj6SMS5VHn3aBJx2qfGChvlWMys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j+DEZmzANhNRUeMH7lF5vCitYhRHnWt8Ear7BM0S1W+OQuwoWXGfjwqbeObGc3a4I
	 d2aIeAPXm1bNrRNZgFdPo3GzSsl+vfRaXbiCAQRrrtuFnPBRbKMwfQly3DYDcLGxui
	 7YqC/FAzkxrWeawqlYA40/krT8CaP8/nQszI0lcUZBhJJA2R33izbHKE6ENYK5sMdA
	 1K6Q9W5Ypu5GM2GvZ4n+mENKvCFNB7cNH/Qld0BS+yPe/BaPuP01SzlM/vt+VhVQoY
	 v5SN4TVSe9+TMGD2R1WTTl6YUtlCaGm1byzXsZqu7/yNigIr/6YUgqYLPMrRm7Tnf4
	 u4k4zJoJK3rhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851E93809A1A;
	Sat,  7 Feb 2026 04:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ti: icssg: Remove dedicated workqueue
 for
 ndo_set_rx_mode callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043921032.1189128.16023595822783523466.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:40:10 +0000
References: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
In-Reply-To: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, danishanwar@ti.com, rogerq@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, m-malladi@ti.com,
 jacob.e.keller@intel.com, vadim.fedorenko@linux.dev, h-mittal1@ti.com,
 horms@kernel.org, byungchul@sk.com, elfring@users.sourceforge.net,
 linux-arm-kernel@lists.infradead.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-257730-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBE77104EE3
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Feb 2026 14:25:09 +0800 you wrote:
> Currently, both the icssg-prueth and icssg-prueth-sr1 drivers create
> a dedicated 'emac->cmd_wq' workqueue.
> 
> In the icssg-prueth-sr1 driver, this workqueue is not utilized at all.
> 
> In the icssg-prueth driver, the workqueue is only used to execute the
> actual processing of ndo_set_rx_mode. However, creating a dedicated
> workqueue for such a simple use case is unnecessary. To simplify the
> code, switch to using the system default workqueue instead.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ti: icssg: Remove dedicated workqueue for ndo_set_rx_mode callback
    https://git.kernel.org/netdev/net-next/c/b6e2db0ed9b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



