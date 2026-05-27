Return-Path: <netdev+bounces-292031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAUzK5pEFmqUkAcAu9opvQ
	(envelope-from <netdev+bounces-292031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:10:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7ED5DE27E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2A553034540
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07D303CAE;
	Wed, 27 May 2026 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCcCIgZ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5333207DF7;
	Wed, 27 May 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844207; cv=none; b=cHG48mrXULeiOaWBjZE7pugP1Ykm/az5G9XeV0O4b7NVFzJs+ICMfbWh6sIbexeuf+ELyphL8kOVIsxBcY7uW8F/9Q8HD78qex9ljPtiHNA7j6PmcmjdSFcMBgxtRzJEIUDZ1+MjNe4atR26eEcrA0zHLfZqPwerWQp0EV08cZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844207; c=relaxed/simple;
	bh=6AFLMnzMNqkNdMyS0BI6HKWC8cUWcF6B5j7CA9J5gxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qWG6iNK2ntHmdOwlL71QV+DPl1AcT2wZ6a31Fl3/RgodrRUYw+7FtQZYVX1rElGgrwTo887xI1FqrZbs4Mi5hI46dVuehPLkeK0QAQp098wQmzzX/hlpqEIfdKvi51GGxqZqhDgNFbQf6Opxtloia5S1aZ8DY87HiCamsAxOhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCcCIgZ1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A01F000E9;
	Wed, 27 May 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844206;
	bh=7szisFQcjEmOnwzS4zMx5Ii/YMyBEoA8gjRBq3neaLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jCcCIgZ1vdGA5fFUzDZGOCM6FGZz8ZbtPYK3crM50NbADimOUF/2928IwYE26CpvB
	 S4qd1j5klGTBXBwk/bxI3VpecLgaFuiykT/WAtrmVcOjA4IxWQMbQzi+IF1cAifrJL
	 XciRUQpJoaThVETPZnPEt5YmpAN1WJZd+ZC5wM3aidGUY5ZIutStvlO7TPc4kREqxp
	 48quHhEX5/XZFE0WeQ2jAOGjZJT9HNO2aOlSO5h0btDEPEcDo3tJB1uRfxca0+nH+E
	 K1kaH8OdcqeaqxAiYGQOSBxRd/9hkpLVUIFKSuwO/jHqIdrgeC6Y1q3givW0OXPLg1
	 xRHEHhkjOW85g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E6380CEED;
	Wed, 27 May 2026 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: netc: fix unmet Kconfig dependencies
 for
 NET_DSA_NETC_SWITCH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984421189.4036929.10087209171562712797.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:10:11 +0000
References: <20260524070310.2429819-1-wei.fang@nxp.com>
In-Reply-To: <20260524070310.2429819-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 olteanv@gmail.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292031-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E7ED5DE27E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 May 2026 15:03:10 +0800 you wrote:
> NET_DSA_NETC_SWITCH selects NXP_NTMP, NXP_NETC_LIB and FSL_ENETC_MDIO,
> but these symbols depend on NET_VENDOR_FREESCALE which may not be
> enabled. This results in Kconfig warnings and linker errors like:
> 
>   undefined reference to `ntmp_bpt_update_entry'
>   undefined reference to `ntmp_fdbt_search_port_entry'
>   undefined reference to `ntmp_free_cbdr'
>   undefined reference to `enetc_hw_alloc'
>   ...
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: netc: fix unmet Kconfig dependencies for NET_DSA_NETC_SWITCH
    https://git.kernel.org/netdev/net-next/c/10006ad04b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



