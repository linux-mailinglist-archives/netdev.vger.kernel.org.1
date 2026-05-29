Return-Path: <netdev+bounces-293260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGcKGHb1GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18E608763
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 913233020FF6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D113FCB29;
	Fri, 29 May 2026 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1ZXxl6D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A23FA5CB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086026; cv=none; b=pZtnTvs6CypKRxnbNEyhVBNZ3ssL3yG5K4/WZxVqKcEMVe3xTcT7TekB+BgflBYG0VYHY5FUGozKDjMuB7cVnszIALmhMkfYPZ2303eg5Vc9LVlmCe/h4SkLNhZITQfRYzgc1c95A/8bmKfO/7tvwVVgor1R5tWI8Ip6738Blr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086026; c=relaxed/simple;
	bh=elsPppkRlj4J4vnqZa+mmO3dbZhr/CFx2gBxBZXpBG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hlsCBAXBu2jhFU27HnAHbURSEgf3HsweR1PevnMS2JphdP6aWVi0ItKy1zrwioCKM2PVOLJ102B6iXsqAmydxVrgKzM3Ef/hXNkSjzxToAenCbDJFGCjSbBTN7ZuNp1XYXL2dmVlpdLoC4gcgZIm2+QwYwI6WmOo+YTaT99lJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1ZXxl6D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD771F00893;
	Fri, 29 May 2026 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780086025;
	bh=KW2ZUzyp2sBn92BqmkHlD3wZ16lKrSJfpfH6rnW3c6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z1ZXxl6D/qM0ByOzoTFdEMShlRcK/OGkRozrJTYBWUzNfpdtEdDm+7SUgxL7Rr4Q0
	 jhRnwshDdSOaL36VWhhDeCajvktelksKASyjsQmscD172jqg76rX6sfHuGZbyYO9No
	 z4E60txFCOty9APTrevDT/fkI7nVX8MTnsToFDlzOx/BjiI6PqwpBzThIrf5jmHJaO
	 nrulJKqPUt7hx1eUwsGfwX1AOBvCiIgl5nv6OdLprvdn5F83XPa4rZ9djvXWawL2sK
	 FMDlcHZtwnej8HwKc4W9TX3TYILXq4B7zMyZWR3L4axV4DmM8oGQzQgYM5FXWruxEb
	 alYX3ARZxTmtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197D039301A0;
	Fri, 29 May 2026 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope
 addresses"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008602864.1951456.15617120657680768690.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 20:20:28 +0000
References: <20260529112357.5079-1-fmancera@suse.de>
In-Reply-To: <20260529112357.5079-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
 sbrivio@redhat.com, linux@cmadams.net
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293260-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B18E608763
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 13:23:57 +0200 you wrote:
> Chris Adams reported that preserving insertion order for same-scope
> addresses is causing SSH connections to be dropped after stopping a VM
> while running NetworkManager.
> 
> NetworkManager caches the IPv6 address configuration, when a RA arrives,
> it determines the list of addresses to configure and checks if the
> addresses are already in the right order in the kernel. If they aren't,
> NetworkManager removes and re-adds them to achieve the desired order.
> 
> [...]

Here is the summary with links:
  - [net,v2] Revert "ipv6: preserve insertion order for same-scope addresses"
    https://git.kernel.org/netdev/net/c/072aa0f5c3d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



