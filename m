Return-Path: <netdev+bounces-276258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BQyGwnI1WnA9wcAu9opvQ
	(envelope-from <netdev+bounces-276258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:14:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64823B6845
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4263018AEC
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82125283FF5;
	Wed,  8 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6OzQN77"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95A223339
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617836; cv=none; b=UtASI0b/Sq07q9LJPgeFjC8Scbhb7CkV5/HtYYRMgPaXYMoytgbSIcDYe8kRHRFV+4xdq+FnnyJkMEaUupFu8HLu3OK6+5UxXBtmIieOiNbblBQ3KD2bk+jcVSF5WYvjEshpK4hjQf7wG4T5r9z/kxUsA0yZVyZZrHlTEEtXyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617836; c=relaxed/simple;
	bh=ie1E5fb415nv7EKjQbCmTdAI0JVIcsVP65r5OO1WdPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJoelL7Ft3+erQ/jJCKVz5eVGtL+kvoHKB+PFhgrdfVYg40uKJ7USZqUAZGDHWsMZ4nzRrE9yuykLywh2isL2KJCSbYoL/82J+JpSt9x823XzQ8YF4UrOR4Z3yB/eRM5LtVp4Z2mjA6ANM/YXniKyi9SkGsB86dvOgQSHdnDQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6OzQN77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB6CC116C6;
	Wed,  8 Apr 2026 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775617836;
	bh=ie1E5fb415nv7EKjQbCmTdAI0JVIcsVP65r5OO1WdPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6OzQN77K2MQ0SQhGwPk7cazMAb5hkyZ1ou85kv8sQv8M1zIfMs9mjKPox1m86RMm
	 wiEPFg8ov3fA72PNdx3J2wX9oPkiAFF3co4GemFYgc4RHFiu3LEmdQB7YlDlSKo45O
	 0NWRPYh24m6HSE2x3blxF6Tm3lYtYVkUMbkzZ6HvnazsDcPkZG/FA+CZA+4V5tNIHo
	 HgFMRFz8fsZgPwgw2BTkL9fbUWKy8xE9nolnM1OGFpW54hZLt7GmMja52SvTbtQe0x
	 BTdNRVtur+mcADrmMCkce3DTUwjUIPK2NL1pcqQAtOEPmRuemVq/ilUxNTEjnZcLCw
	 fAHimp9vTwXRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA23809A29;
	Wed,  8 Apr 2026 03:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: pull gso packet headers in core stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561781329.51568.12566138936967070024.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 03:10:13 +0000
References: <20260403221540.3297753-1-edumazet@google.com>
In-Reply-To: <20260403221540.3297753-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, joe@dama.to, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276258-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,dama.to,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C64823B6845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 22:15:38 +0000 you wrote:
> Most ndo_start_xmit() methods expects headers of gso packets
> to be already in skb->head.
> 
> net/core/tso.c users are particularly at risk, because tso_build_hdr()
> does a memcpy(hdr, skb->data, hdr_len);
> 
> qdisc_pkt_len_segs_init() already does a dissection of gso packets.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: qdisc_pkt_len_segs_init() cleanup
    https://git.kernel.org/netdev/net-next/c/30e02ec3b4b6
  - [net-next,2/2] net: pull headers in qdisc_pkt_len_segs_init()
    https://git.kernel.org/netdev/net-next/c/7fb4c1967011

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



