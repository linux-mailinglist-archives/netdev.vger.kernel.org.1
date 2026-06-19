Return-Path: <netdev+bounces-300564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EI3pEj+XNGoEcQYAu9opvQ
	(envelope-from <netdev+bounces-300564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D96A382C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:11:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BLhe4oUw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300564-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1B9A30364D3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBECB2E06EF;
	Fri, 19 Jun 2026 01:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50F2DA75C;
	Fri, 19 Jun 2026 01:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831423; cv=none; b=s7N14w8MWU/KpTZ27YO6TJ2h0Zemcx+Q/lKko0ahM1fFeRyzo3HAijQPZxOnyWDnnN+K00Drlf5CFa2Zmz8ik1pFi5GSE/Elx5Pv6OX4pJtx8d8S9+ijtqUzebV1+lk6g0yMkEm5T+z6vVd5MnwTNOBSvVEWnORDM9Qg077o18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831423; c=relaxed/simple;
	bh=Vf1NiBRDppA/fXo5Cy79yBJ0vmOuujHsaBkIIbOe6ZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o27gRV1K+v3Saktu+60lNLeGuhhq2RZObn67XO6D15NmNSUvdUJZfLeSrtE4I6qfTh7do7lHsfPcygToNlD989l/9vqp4SxscPE8rDrSjsDC2cGVq1RBTys1hJSRq76qmTYWGrvyLmKBrq3nLI0PYikH2i8Y0q8Tox3sWeZjWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLhe4oUw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA1C1F000E9;
	Fri, 19 Jun 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831422;
	bh=cHNhTPpb2DnmLt3wBo29xmKCPVcx2ByRO36SGXERP00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BLhe4oUww6MhlcL+ZEJL9sWsmVrCiA8tRJPlr5PEaP5KxEQ1iC2+wP1kPnIFXWfrZ
	 neCCqgvPD7FZ5rMepcwM8isW2oCCZdtaDCXk86Uz4ZElFyCo5e7cfRche1kIhTDs/9
	 +CTUMVHo7ooWwWlU5n9S3bpe7tq/1moMSOtTaYFqbeW9Vs1QdYdh/xXHBi55+URHdI
	 RcxNnqQtpVZbjiQ/U2ai9x0XIETp4LDOMaeKTMQjhicAORTswRJIYwkp4KxQMwc6QX
	 XuwrmQntuKWP3FOH4va1HOLPOdXCIW+0F38M7NFX/0KC6uRPuA8RkDhb4KFbUpd+6z
	 29XEysEqO0DvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 29D473A78A7C;
	Fri, 19 Jun 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: pch_gbe: handle TX skb allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183141588.3148637.5386692499986905665.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:10:15 +0000
References: <20260615125043.3537046-1-ruoyuw560@gmail.com>
In-Reply-To: <20260615125043.3537046-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 masa-korg@dsn.okisemi.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300564-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:masa-korg@dsn.okisemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C8D96A382C

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 20:50:42 +0800 you wrote:
> pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
> then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
> fails, skb_reserve() dereferences NULL.
> 
> Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
> fails. On failure, let pch_gbe_alloc_tx_buffers() clean the partially
> allocated TX ring before returning the error. While bringing the device
> up, release the RX buffer pool through a shared cleanup helper before
> unwinding the IRQ setup.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: pch_gbe: handle TX skb allocation failure
    https://git.kernel.org/netdev/net/c/a0aa6bf985aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



