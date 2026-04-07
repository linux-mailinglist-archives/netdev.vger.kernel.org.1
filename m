Return-Path: <netdev+bounces-275815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNe8Krhg1GnltQcAu9opvQ
	(envelope-from <netdev+bounces-275815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:41:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 525513A8C27
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88456303FFB3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADFF23E330;
	Tue,  7 Apr 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS50bajs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247C239E7D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526045; cv=none; b=A+ts54EFxwV8MQ9mmxwugMz0Z0nzzpjhL9wADpAvv7KCmAjkVnIV8amlgqJkzYTtWYe0VrQ94Ya0sQ1fX9ElPjXfWfTHIxNf0YPaaMnSrYcdeCWXuTK3XCsgvxTkJy8TFjzVTmMo1MUtGSYLBhzW0KMmqzfFgOZynd/3vUD0e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526045; c=relaxed/simple;
	bh=J7QGwy+oODE1EUBJ6VglJvqE8NIbIiBtOStaJLRlRnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhlkhsecvRMntitCk0KhEMjnNCOksk3T9+xd2eNtfjKq1e6spN2s21csHxkRfbFFw5j6g8oLDVV+X+I58XS5z5nCHq7HBDJ4qg6QjXGLCbtsbzl2DsH2cN7YSGuSgfjU/jPTRVNndWROLeh7OEPTS2YynkgJfAg8Rbc21bG+Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS50bajs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF9FC2BC9E;
	Tue,  7 Apr 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526045;
	bh=J7QGwy+oODE1EUBJ6VglJvqE8NIbIiBtOStaJLRlRnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fS50bajsn83XESC3bjcqZh8iSfNqe8Dq6ufENvY9TJGddf2l8G8eqxSVR0fNV4I/P
	 oG88qdAVQBv7oU3HieKXAaoOsvjHPODuOI/mU+UgdLGDB9SwQerzHN9TL7j4IQbv9l
	 C6SWwh2QQ8LZZChnlMPmqZ9Oixa+66TlQC6/CWPL8Gh/d8I1OMRK8L4Zx86vBPviwT
	 5KQCSdxy4j7RG3yKrm4nM0pnxqDP4IrTOuTxXLzThZQRfKqRlKwTCDu8wwubpdUrar
	 9RFqnh5BG7LtcUnVWEqOUM6yFjrT5zmsQ33Inqy2cIdirImzFAFY150hSE60xyCTqV
	 Dp75eu98+NC5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C9F3809A28;
	Tue,  7 Apr 2026 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] net: advance skb_defer_disable_key check in
 napi_consume_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552602370.3334922.4335754307864094547.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:40:23 +0000
References: <20260402034114.65766-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260402034114.65766-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275815-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 525513A8C27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 11:41:14 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When net.core.skb_defer_max is adjusted to zero, napi_consume_skb()
> shouldn't go into that deeper in skb_attempt_defer_free() because it adds
> an additional pair of local_bh_enable/disable() which is evidently not
> needed. Advancing the check of the static key saves more cycles and
> benefits non defer case.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] net: advance skb_defer_disable_key check in napi_consume_skb
    https://git.kernel.org/netdev/net-next/c/8a4e3ab61d49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



