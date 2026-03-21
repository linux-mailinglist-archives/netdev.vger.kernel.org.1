Return-Path: <netdev+bounces-270144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAFHDFT3vWm+EQMAu9opvQ
	(envelope-from <netdev+bounces-270144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA002E2D04
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32FE63029A9A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F596318139;
	Sat, 21 Mar 2026 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzZ3uF6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDE30ACEE;
	Sat, 21 Mar 2026 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057237; cv=none; b=ii0F03MmsFhvZoW9fX4STks9tb9C/25A/QxMv7KhOTdB8ET8BP4kui2kYZQU0rEHBncR1Ucw98iKts7zYmgIJ4IWsBrpq2bxwli+gITRCIxhs/fcNX5mEk94OK6BxWckUNCOkktESCnfme6CI6fVK9+6T5OgPn/vR5l6W8OMom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057237; c=relaxed/simple;
	bh=Spd1rdLKi0A1cGFiy+F11pEQ75oVtlDDDN+F7hLv3Lo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wt+iBtk0wjdUkzbSzzTfxnLfHGIo4wYVW2k5vDDSCcYycAQhOoS7JbkurH8XdRq6okP5PeR2KiWo6X9hAjPwi/0hijv/K1Qn3U9EEs0qN7K4Ee20n/Brelr71ig8B13+0Hfgd0Db/I7VVaH6+oYr88uA0Mi4RJb9JhSHWvqy4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzZ3uF6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6F4C4CEF7;
	Sat, 21 Mar 2026 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057236;
	bh=Spd1rdLKi0A1cGFiy+F11pEQ75oVtlDDDN+F7hLv3Lo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bzZ3uF6VjVZ1jlO9U4uE6T549BtAABXFBoHSnKvo4Fa7o4/mFqPQ8WxFXIBuMYAsX
	 1Hq84tysC2PUo8OSvumKt20gTOLnBt10P+KXd/A2UR1mSEmDJtUiiQcNkY9gVIqIKX
	 A1JVRMbK/AfM8m074putUpvvH6bxHRqpso/jtRWkUPx8jZxGXxS6rb6jus3oo70+rP
	 H3BzU5FWE8z9DP0OmSzF9aWA5ZWeTYO6KEknz1WVG0/95HMNArwPTEw3L3JOUcaLeg
	 /UrMchBSiFAIIdbTT+ogmd0DohS9Cq704qXwRWnQI6UgEHgli/4cWC8Tco4/SPHkNA
	 /Qk/yIOtNfvfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD93808200;
	Sat, 21 Mar 2026 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mxl862xx: don't read out-of-bounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405722648.2718727.11800442368567709611.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:26 +0000
References: 
 <83356ad9c9a4470dd49b6b3d661c2a8dd85cc6a1.1773803190.git.daniel@makrotopia.org>
In-Reply-To: 
 <83356ad9c9a4470dd49b6b3d661c2a8dd85cc6a1.1773803190.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270144-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDA002E2D04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 03:07:52 +0000 you wrote:
> The write loop in mxl862xx_api_wrap() computes the word count as
> (size + 1) / 2, rounding up for odd-sized structs.
> 
> On the last iteration of an odd-sized buffer it reads a full __le16
> from data[i], accessing one byte past the end of the caller's struct.
> KASAN catches this as a stack-out-of-bounds read during probe (e.g.
> from mxl862xx_bridge_config_fwd() because of the odd length of
> sizeof(struct mxl862xx_bridge_config) == 49).
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mxl862xx: don't read out-of-bounds
    https://git.kernel.org/netdev/net-next/c/6b5f49176a08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



