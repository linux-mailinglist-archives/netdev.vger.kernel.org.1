Return-Path: <netdev+bounces-292011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICWSD4o7FmpCjgcAu9opvQ
	(envelope-from <netdev+bounces-292011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:32:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF665DDF86
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EFA930958CB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859DA2FD7BE;
	Wed, 27 May 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyW5fEZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FD2F7F15;
	Wed, 27 May 2026 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841809; cv=none; b=oswGibaRAXbJkLqn4Kb7Nt2eNBKnno1pgzxNabwRM1t+2+HDLdRmCFUU5hXJB3OldaxVOBQjw9oq03nZqcZTpiN/8sBzM1dJIG4i1kpZf09B5pQX0ClOBNRgJ+AesRP02/LDNuW1NhWaPiGhmN3o8xMWzoW9K2L7bJztbEmIYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841809; c=relaxed/simple;
	bh=LKEviJ9/gM6EymZvbmagw1BMrhKUVgeQv6Ho1ABrnoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOc+UNFcpyiTBvl4TVJIenFKZy84vZ/l4rhgfvUcTSrN1ucG6E4/b8DYVSGRlxpyp8cJ9r0Gej4qe/gNYyiH0+WN3uxSUXOovNGeHVJbhWAcp1Sc0MB/j5aIrZozBSRnlYgRj1rtsJH/dDrDwtVOFeYlLNxzrkL5BVXOvVhupZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyW5fEZs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE01F000E9;
	Wed, 27 May 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841807;
	bh=XRrv3oyQqtsV9DayAxa9xAJljanELXzEWRLBdG9TRJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oyW5fEZsH4Gr74ugvoTtqGxITtw+bwmfil0RU9lZwttpoPA5bp0zn2DNBF03yNa6l
	 ddJjjTGamnyEp5P7QI16jUabTErfUjK4vUWWzWmrBZoNNuHIrxyMhMj1awi4byWggz
	 RdldB48UcUf6dHXvnewme6KZscoGUQW9YRHM/lvF540FoOWER7F1J60nXJAxaTsDzy
	 jbW7dw+dSeIsriRFJR0TI76yLJ+7w3DeJ4Cn+by8YcuBuHsL5Q9/pxeHZ2bK79tqlP
	 /xYOvtjPaIGfT/vkFzrxHHkl8QPm/R3LNDHvuFQy7PN+mjXmpjszhh0Jvv58t21roc
	 AnxcKcgxWV6Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC0380CEED;
	Wed, 27 May 2026 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] llc: Add SPDX id lines to some llc source files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984181345.4027067.9275875594847282349.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 00:30:13 +0000
References: <20260522225508.24006-1-tim.bird@sony.com>
In-Reply-To: <20260522225508.24006-1-tim.bird@sony.com>
To: Tim Bird <Tim.Bird@sony.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.kernel.org, horms@kernel.org, acme@redhat.com,
 jjschlst@gmail.com, tim.bird@sony.com, netdev@vger.kernel.org,
 linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.kernel.org,redhat.com,gmail.com,sony.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292011-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sony.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CAF665DDF86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 16:55:08 -0600 you wrote:
> Most of the lls source files are missing SPDX-License-Identifier
> lines.  Add appropriate IDs to these files, and remove other license
> info from the header.  In once case, leave the existing id line
> and just remove the license reference text.
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> 
> [...]

Here is the summary with links:
  - llc: Add SPDX id lines to some llc source files
    https://git.kernel.org/netdev/net-next/c/0b13c6a618d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



