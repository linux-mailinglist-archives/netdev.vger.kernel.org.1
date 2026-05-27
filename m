Return-Path: <netdev+bounces-292053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPbLIeFNFmqxkgcAu9opvQ
	(envelope-from <netdev+bounces-292053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C555DE600
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D28C301571C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB330F7EB;
	Wed, 27 May 2026 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/J6fnbJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56330DD2A;
	Wed, 27 May 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846601; cv=none; b=qdfHtgvQ6S3mliwNx/nj8xAjh65sBzM56j3JXetA7uV0bpLznoBOwTZtDz3Pyv9McAff2G7RQYB4aFa9LZtrsYBSkSqobHabX7W5U9RMf9loNBqQ6EI91vJg90KrO5OO7fsg8wvpp15WiTPMoPzY62P3sJBjNvELxMVwTAl/j8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846601; c=relaxed/simple;
	bh=otpe+9lEnw4qI8g6ZREJHsg1x9eCmYzmWLjkFoSjvwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iM+fomQIvaUh/oXjcNvqDFdkuJoUqKT/nZR1D/mETEjtp8ahfBT27ol1Er3WW/jVWlS3XlLJCH585DioN4yOmZH4SeGVzvn9BRxF7mWHxinrHUNOJW//9p9pa9trJqHTM3w1kx2Y05qHTHlUqJZZtux7EvtMKm9+6gegHlgHOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/J6fnbJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8F81F000E9;
	Wed, 27 May 2026 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846600;
	bh=iU836e323LRcOajOykaTp25SDqaHWb8OLOitpaKAM2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b/J6fnbJ3koUU8FVvMw1glRInYQLZgjRHXmBqPbJb20euXMNCzdgDA1lVB721eM7R
	 RVFcIsM+idAD/8E65Qv6RjtBnC/s+mHI/THsZ9Ui+5H86ktlQQGdpZfebegwzIe1dF
	 agIyLs3FOUqjZs12oYVY/0ap3B6oHhcLcKvs27FzHivkGuUFSOeJng3saFpr6PkuOd
	 yw5Kb+YEudB7Ya0uFEKj6O79Pq2YlIO/q81v1T2jLjCFuzpSSkIXUKWx1scJAxm12L
	 zb8t7hEaLOPXTP6fzy1wIGgNXFXg5ue7OrJePs5aSshjJAss86pDYScexGfFE14WJZ
	 TP3L2J+kpbgCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BB1380CEED;
	Wed, 27 May 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] net: hsr: require valid EOT supervision TLV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984660589.4046339.17294163717293714058.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:50:05 +0000
References: <20260523130420.62144-1-luka.gejak@linux.dev>
In-Reply-To: <20260523130420.62144-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-292053-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9C555DE600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 15:04:20 +0200 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT with
> a length of zero.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] net: hsr: require valid EOT supervision TLV
    https://git.kernel.org/netdev/net-next/c/46d111a3ef3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



