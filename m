Return-Path: <netdev+bounces-277234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBZcFz1x2Gk5dQgAu9opvQ
	(envelope-from <netdev+bounces-277234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B23D1E30
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AEE4301F3F3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF5328B7A;
	Fri, 10 Apr 2026 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+PL5e+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D932692C;
	Fri, 10 Apr 2026 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792441; cv=none; b=PDVH4xE91LgjacQMhRX1fEjoN5xJ6Z9/N3rWg6oMM/ZbRQf+kowwrt447zHtIoc/KHpExmzoWZ0tl80lG5QFQlGY1XoZQ8/glm+SwceVO8mroDViylIwi72E7WeS4cGa2u7jt9mHU5TyFJoSaG4AFOtqBzNWbL7E1QKQLgP8Qds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792441; c=relaxed/simple;
	bh=47XOPo0Emw0+KM/NUPQa56Op6psTg3p+6Rwhf22g+Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cm34zreyRDdEGEhXayyWzOwfrx+U+3/M3hn8+/CS68jKPgDgDJ+HQb8LdgRrw0ibpdYhwfibq08FukXlS+xtKXbyEVoGWtxRFtdoAZ1pSLwrrliV4TajrnAXm8XkRf77T0/Qne4YHZB0Qa5cp7ybaiZfBOaIN4XF1ujMpG5t3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+PL5e+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D10C19424;
	Fri, 10 Apr 2026 03:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792440;
	bh=47XOPo0Emw0+KM/NUPQa56Op6psTg3p+6Rwhf22g+Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+PL5e+wk7L9UJjKREsfhqdg4gtPFrYi5PWgPJ0Zh2q6gmDaITyYDm2wDZ2VJC47e
	 ZQ9af45kBEGA6vIv/8BUMMpR6nJ8vEvx2KgiDE/3gB/dDDG6j4cubwdVfpwz1KqfCL
	 WK+OWTgSAa0zjY45QK50nxVb9cNmekIvZCNwPk1Qnz6OqvX7P0pm1N8kOt3FqEedgZ
	 VOzOzbfmXyEQiM4xGsQTv38oPOYooF2k+uXwl5uFHxT0qklWYakzmOgDI6z1kY/Dh3
	 e2xgX/GlYU6q/Ka+b/uupbxmZXpgEDZP647wgcrsqsD75BIdRxB0Or3eNDB+XL5scg
	 1fl06f2G9ftfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE3C3809A22;
	Fri, 10 Apr 2026 03:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Use wake instead of start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241604.1854480.10464243149429133196.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:16 +0000
References: <20260408002415.2963915-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260408002415.2963915-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, dg573847474@gmail.com,
 edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com,
 kernel-team@meta.com, kuba@kernel.org, lee@trager.us,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277234-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,intel.com,meta.com,trager.us,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: F19B23D1E30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 17:24:15 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> fbnic_up() calls netif_tx_start_all_queues(), which only clears
> __QUEUE_STATE_DRV_XOFF.  If qdisc backlog has accumulated on any TX
> queue before the reconfiguration (e.g. ring resize via ethtool -G),
> start does not call __netif_schedule() to kick the qdisc, so the
> pending backlog is never drained and the queue stalls.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Use wake instead of start
    https://git.kernel.org/netdev/net/c/12ff2a4aee6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



