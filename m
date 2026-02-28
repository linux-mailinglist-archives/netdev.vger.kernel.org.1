Return-Path: <netdev+bounces-262197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP7cCWNao2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:13:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC271C8DBF
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE1293127BE5
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310CA3CCA17;
	Sat, 28 Feb 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsgc3ANF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B934D397;
	Sat, 28 Feb 2026 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304623; cv=none; b=Um5ODsSej2VZum9kI4A58DyxbOXwQm8wNl6segioKdWwW2nYWldptc8W2d5xuJ/TldOeCCGt7l0mmSv//hn16C4gyLB4QE1fSehjACtzP9IqXzXiAd4ICxKl5UXWOnjGVTv5b71eHai9f9yErVvk4nslvWWh6JVRm9ZThvazpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304623; c=relaxed/simple;
	bh=o3s/gDoFG8EfQUCWNgD0fRtJQ/l0yMR9mBKUz+jAEBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e2JBKo+8QFmNNLYh3qDubNhjFI82QbDDnISmC9UprysAwXRITo6koxlGb8WPyNqe677mO6JNPdXD1GFcXl+sM9RBWgwxr3nWntPnwHrfUzFPhqs4W/cNtTsO91fhhOyksSjSB9o4uGRvFM1ULSnwfpxLMOI0Mh09LEJHd3x+pEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsgc3ANF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A691FC116D0;
	Sat, 28 Feb 2026 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772304622;
	bh=o3s/gDoFG8EfQUCWNgD0fRtJQ/l0yMR9mBKUz+jAEBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dsgc3ANFfEuFH9PnWEg7SGC3bR37/Uanrsz9mNzcAlArC5J1u0wTalsJ4AdWLltjZ
	 Pu1u/7O2EEDKDV7/3iWBQJ3TaT1qdTq9p4tQjESxLiov5rX1qqFu0/bNwTVBk6PMlv
	 Qcw8qUqMsRw5dAJlr7oeKWMxiSMFLej1TlJ9hxiGwwcwozd0zwPb+4k6v/wbaXqit4
	 Cnpk+Qoo5n4SFuIx6XDx9Q717d4Po1fvwVqR3jrKioZ5tWxz4zViAXOgcYqmGgP8bM
	 zMu0x8deh39PTnNaS8vZXKJ5Cg1nihm+OIPIGHFXvb22SX51lriw75ZJtuUFCPQIpC
	 8rRlv3unUEZVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D9939F2022;
	Sat, 28 Feb 2026 18:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 00/13] NPC HW block support for cn20k
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177230462579.3039668.12557877812546604763.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 18:50:25 +0000
References: <20260224080009.4147301-1-rkannoth@marvell.com>
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262197-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AC271C8DBF
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 13:29:56 +0530 you wrote:
> This patchset adds comprehensive support for the CN20K NPC
> architecture. CN20K introduces significant changes in MCAM layout,
> parser design, KPM/KPU mapping, index management, virtual index handling,
> and dynamic rule installation. The patches update the AF, PF/VF, and
> common layers to correctly support these new capabilities while
> preserving compatibility with previous silicon variants.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/13] octeontx2-af: npc: cn20k: Index management
    https://git.kernel.org/netdev/net-next/c/1396771b0b77
  - [net-next,v9,02/13] octeontx2-af: npc: cn20k: KPM profile changes
    https://git.kernel.org/netdev/net-next/c/5868682b68dd
  - [net-next,v9,03/13] octeontx2-af: npc: cn20k: Add default profile
    https://git.kernel.org/netdev/net-next/c/a2df2f95eac0
  - [net-next,v9,04/13] octeontx2-af: npc: cn20k: MKEX profile support
    https://git.kernel.org/netdev/net-next/c/ef992a0f12e8
  - [net-next,v9,05/13] octeontx2-af: npc: cn20k: Allocate default MCAM indexes
    https://git.kernel.org/netdev/net-next/c/09d3b7a1403f
  - [net-next,v9,06/13] octeontx2-af: npc: cn20k: Use common APIs
    https://git.kernel.org/netdev/net-next/c/6d1e70282f76
  - [net-next,v9,07/13] octeontx2-af: npc: cn20k: Prepare for new SoC
    https://git.kernel.org/netdev/net-next/c/de3f88b465c8
  - [net-next,v9,08/13] octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
    https://git.kernel.org/netdev/net-next/c/4e527f1e5c15
  - [net-next,v9,09/13] octeontx2-af: npc: cn20k: virtual index support
    https://git.kernel.org/netdev/net-next/c/645c6e3c1999
  - [net-next,v9,10/13] octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
    https://git.kernel.org/netdev/net-next/c/9000cada7aa9
  - [net-next,v9,11/13] octeontx2-pf: cn20k: Add TC rules support
    https://git.kernel.org/netdev/net-next/c/0d12d26701b0
  - [net-next,v9,12/13] octeontx2-af: npc: cn20k: add debugfs support
    https://git.kernel.org/netdev/net-next/c/528530dff56b
  - [net-next,v9,13/13] octeontx2-af: npc: Use common structures
    https://git.kernel.org/netdev/net-next/c/2e8aeb7ff0b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



