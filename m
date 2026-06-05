Return-Path: <netdev+bounces-295575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QEZHAn4rImq2TQEAu9opvQ
	(envelope-from <netdev+bounces-295575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA1364487C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:50:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WpY4yLmk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295575-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4700300C3A8
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D834E761;
	Fri,  5 Jun 2026 01:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F433557D;
	Fri,  5 Jun 2026 01:50:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624214; cv=none; b=AS/yM0XxsJOtWR6y6H+65zYX+2i5vq06y8iRZ/wsspB1PUhJIe6w9ordGj5N1nkCkeLiugJXzThdjCQdEb/0cO/MDlnsGSPsh7IFMUEu2dPBei8kyo/ScBGEznMP9d1QwtJ29objNqTr6k8K6prMePTw5FUFdjid5kVFmZjoE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624214; c=relaxed/simple;
	bh=uILYhWaXsIqkSmfjHAXT2LKi09l2xBmY1Td7iK2bp9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ROVClE0NmFU6R3ZYdM08+snoN7gkryg2ArEu52uzTF19EPt7fdGffIQzmQKHvLWrAdSC59sYRER6bTGwRj/uk9KJNy7eznJlt6YuFbxQXK1q+Z2aGPUH5lzGCBF4b9hzlHntig9sbRbcW3W45vEsOOc6zFo0uGAc+4/Iwzm8D+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpY4yLmk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3321F00898;
	Fri,  5 Jun 2026 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624209;
	bh=npzZuIrahPpXIMyh0d4mEOB5RFINgqbaV8Faq6AJrpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WpY4yLmk4RsKOjfVYkoANaDLaYamqMfyJAvycgatxMVG9QKMUoSNqtmhz+JmYfYZQ
	 ZBWksaRZoWSiZ7lN5fWdMS5jcOYzTVXX6zHHIlaySJG7MHV++pdMceNPWAP9l3FLLO
	 phXgIRD5hlfzYRfl+hbW5uOU25k6Ft7LMO3VVz8iHW47lpIz6eMNEjYJXSWZViyvi8
	 MtA2MofdHE7jceiNqZRMw2B0qV67kumnZ4zAp+c0v6KxBuUEKVpCXJXAUMaJnHzrh5
	 7UDXWFNClErL/zF0tQIqnFHIg2/BpF5Hgvxbzh3GobOPO+VBHRqzwFmH4YCQSKyCtd
	 w8pBUy8yDTApg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5EE573930A8B;
	Fri,  5 Jun 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/dns_resolver: use kasprintf + kmemdup_nul
 to
 simplify dns_query
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062421007.3099818.3448654067097447224.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:50:10 +0000
References: <20260602071343.962830-2-thorsten.blum@linux.dev>
In-Reply-To: <20260602071343.962830-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, brauner@kernel.org, tim.bird@sony.com,
 amir73il@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,sony.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295575-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:tim.bird@sony.com,m:amir73il@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFA1364487C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 09:13:41 +0200 you wrote:
> Use kasprintf() for descriptions with a query type and kmemdup_nul()
> otherwise to simplify dns_query().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Reverse xmas tree (Jakub)
> - v1: https://lore.kernel.org/lkml/20260528222030.1655010-2-thorsten.blum@linux.dev/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/dns_resolver: use kasprintf + kmemdup_nul to simplify dns_query
    https://git.kernel.org/netdev/net-next/c/6ce66868d1a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



