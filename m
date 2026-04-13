Return-Path: <netdev+bounces-278209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBGjD9Jn3WnsdgkAu9opvQ
	(envelope-from <netdev+bounces-278209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:01:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DC3F3B04
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C02A305E1F7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8538CFEF;
	Mon, 13 Apr 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0RBCEYI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACB18050
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117638; cv=none; b=P3qjU0zZ7ONMjbfxxkEwal7GJSxX44Q4aglWeRCKSVgGOisS3lXHCUr6yL+M77vvnrT5tcCrCkKauEm6IEXTOgRzhJsh+wo8VotaQ0BXO41K+6eh/Nb8xGYoBdHB1zJ8dcqqmYDjdqXqNzFo9QXroSPSOhUipy2yqNPLmmDH1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117638; c=relaxed/simple;
	bh=tLt4MrLSUuyC46ZPh6Lc6VBJjwvbru1bIpP/5h9L/yw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Su/TfW4dnRmjegk4Pz1PiTI9CLdIusA1GYB+vtqeZCOiKawdn1osZqoPR2UU82k7o+KJsxIKbUhsR7YskAnOFPP87CYHnlmkJfFUv3dRdBeZlrRV6keiznYNH3wf9IzT630uXqkB8fkFpUHKogNuOB4F4g0JxdgP8N83YBrsonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0RBCEYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B06FC2BCAF;
	Mon, 13 Apr 2026 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776117638;
	bh=tLt4MrLSUuyC46ZPh6Lc6VBJjwvbru1bIpP/5h9L/yw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S0RBCEYIx9NUrdM0xJSW1Km/E8zIxavKc3c/ikbebwI4VTs/qucZll2NqvUKaTdBA
	 k21kXxJn3TxqrIE0nU0xmGYO5VBw+iJm1UWI+kuFVxFc5hCo5Iq8EiphFp14sHRiR9
	 ssWUZsl3Wf/Ga3d+X9Ji43SjWYk51Z3QKihrretQ1UYd0J4alaLtKlhAlduKa8lDSb
	 SvKHGewED7UG/NmGK2tvvHxIUkE/5+anFiSGSLHgRl/+X5RBGYaAKz26mJcO3dHLp4
	 J3dBglkgiQBRSHKiGqmcYKI1FQYrpIS58ylqLYW/eTTcpdKSHkqcXetp8qOf1bQdWw
	 3VdfuMw9QhrOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D0C3809A0C;
	Mon, 13 Apr 2026 22:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177611760954.563263.9933342148326899367.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 22:00:09 +0000
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, cfsworks@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278209-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A9DC3F3B04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 14:07:51 +0100 you wrote:
> Enable receive process stopped and receive buffer unavailable
> interrupts, so that the statistic counters can be updated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Since we are seeing receive buffer exhaustion on several platforms,
> let's enable the interrupts so the statistics we publish via ethtool -S
> actually work to aid diagnosis. I've been in two minds about whether
> to send this patch, but given the problems with stmmac at the moment,
> I think it should be merged.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: enable RPS and RBU interrupts
    https://git.kernel.org/netdev/net-next/c/1b9707e6f1a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



