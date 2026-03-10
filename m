Return-Path: <netdev+bounces-266134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPRUNSkcsGnufwIAu9opvQ
	(envelope-from <netdev+bounces-266134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:27:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295E2503A5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D25BB31E9B3B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DE3DD52F;
	Tue, 10 Mar 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWyTRUX0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E53CBE82;
	Tue, 10 Mar 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146409; cv=none; b=SH9obdYFxEu/mK3vcwCuDtVL6dD5r2n21Q19SIxOXDTzCBK7ejhw+ULmw8MkWTaGlMjdcxbW3ev2HHxNH5JoZ4JlHPpHyENUAmN15wwlmfRfZ+sX3JeJWKf4u1VriSBne2nlUI3QsQ6jNYZ38BZxr+fmKb1spqbGwAO2njqGXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146409; c=relaxed/simple;
	bh=IK6RJArbLIh4dHU4kWnimKMjcvtkiiNjPOSaY4dgevA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=THaG912HS45yGMyaKz/S4pTdZeZ4tFrp+kamRtZT4YhlXnlF9LwU1DuqqdLkVH3+S7GLBYtqlvS7dW7dJ4yiMpKraNKvwfKyCnPPNIwaUjr33OIFsyEWLHuDoY5C2En5uVQ2p+niPEHsqaaoc32eVameiWnGfkFp2aU+hDB+cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWyTRUX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC78C19423;
	Tue, 10 Mar 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773146409;
	bh=IK6RJArbLIh4dHU4kWnimKMjcvtkiiNjPOSaY4dgevA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TWyTRUX0DNGEZfH5XTV+/AVjjv7xiVGJDynNG0IXcjP/maHWoxquAsSfPoTo1jwkK
	 g+6icFTeZBvc0hLOFiZQBCpVobowprHg+3iXqqYGV5hUsSX0RgFGTig22dmAxC9VcE
	 lrTv4/X851eBQPwIXcwC7nwSnUW7xYsJEhLkwJpnxNTVtw/uAMJPmMcrRIl7u3lloh
	 +udXIgeNAYOgCIPxI2wCYpaWdWx3t9A/DL4t9ZPB2qlSEFbnU8uSSyaVNJ6skE7HpC
	 BTF5eGC+soHVky+7wrq/QHvrhC0MB85NafzBpRUj38xr230onNr38d2bdqhFRhi1xh
	 UWKG4Athi8QoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF3D3808200;
	Tue, 10 Mar 2026 12:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: add xmit recursion limit to tunnel xmit
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177314640530.2269130.10013467728563826261.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 12:40:05 +0000
References: <20260306160133.3852900-2-bestswngs@gmail.com>
In-Reply-To: <20260306160133.3852900-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xmei5@asu.edu
X-Rspamd-Queue-Id: 5295E2503A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266134-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  7 Mar 2026 00:01:34 +0800 you wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> Tunnel xmit functions (iptunnel_xmit, ip6tunnel_xmit) lack their own
> recursion limit. When a bond device in broadcast mode has GRE tap
> interfaces as slaves, and those GRE tunnels route back through the
> bond, multicast/broadcast traffic triggers infinite recursion between
> bond_xmit_broadcast() and ip_tunnel_xmit()/ip6_tnl_xmit(), causing
> kernel stack overflow.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: add xmit recursion limit to tunnel xmit functions
    https://git.kernel.org/netdev/net/c/6f1a9140ecda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



