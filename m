Return-Path: <netdev+bounces-280881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGFIBz2U6mnQ0wIAu9opvQ
	(envelope-from <netdev+bounces-280881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:50:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E91457FC2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC4E130131E0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB7361DBF;
	Thu, 23 Apr 2026 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4JSeUjv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49023D7CE;
	Thu, 23 Apr 2026 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981050; cv=none; b=UJ/X4gr4m/pU7k9urtrj3QmTp+min5Dkr8E8/ZdrBjE6xULY+CBKfM9qM1Z2mbg8ny2lmDyQgxzkXLW3Jd7kfYmpyRJCKaSiq5wLqaig13ojbWfhQ+CDpLxjSJuq8YlsK5h4f+L+s0AsRBfk9kbvjrSeU5Ib00CnALPrrCYc5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981050; c=relaxed/simple;
	bh=XYuKr+eaOJj0h6C00DY+gStx8tqVxxnWPOfaL0ideFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4FMsOoQUvbR408104n2lgwOku3TF1LV7EQU0W1cWNvHo1p8UzwjbJQe3zDioDecDi2Wh8PBHy0meAXz/Y5f2PQIXla22ahtJYbv/CDYDrR1aEimrDjlMBSuhCU+ql06CeCyB87geoa4N03FgRZcW6aFVLIOjwHY075VeI8irck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4JSeUjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CDFC2BCAF;
	Thu, 23 Apr 2026 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776981049;
	bh=XYuKr+eaOJj0h6C00DY+gStx8tqVxxnWPOfaL0ideFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n4JSeUjvAxQOaOZKSOuAOEhyZUagMglFLYbT7kJx+29PPFnKsb6tTP1EOg4u1H7EP
	 yXkBPNp/8ZRIzUs7Qq/yhSpolzWadXLwcKXGNfIWnCOwjUdV3ZxkOLvkTTf5/0h1/W
	 L4xCJ1j14PM0D5r6qPNc8SCRQBUfzES5Eu8ycMnjQNSWCAu1qwDDPuj8Rri1M2KRj7
	 Fu1IPdk+fYvXmeT+uvaY2yBNPueADw/Rstab0UUu5UDhpU1SS5YzwkYudvf54eOhQy
	 oRf93hINIew46E78/SdaylGufTbWb1lUXCC4vIqIfDOGMROxcla3p+Aj3lo/jRsERh
	 CdSaDpnAtFYSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DDE380A94F;
	Thu, 23 Apr 2026 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177698101049.775674.1567171164890583654.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 21:50:10 +0000
References: <20260423200909.3049438-1-dhowells@redhat.com>
In-Reply-To: <20260423200909.3049438-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, anderson@allelesecurity.com, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-280881-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80E91457FC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 21:09:05 +0100 you wrote:
> Here are some fixes for rxrpc, as found by Sashiko[1]:
> 
>  (1) Fix rxrpc_input_call_event() to only unshare DATA packets.
> 
>  (2) Fix re-decryption of RESPONSE packets where a partially decrypted
>      skbuff gets requeued if there was a failure due to ENOMEM.
> 
> [...]

Here is the summary with links:
  - [net,1/3] rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
    https://git.kernel.org/netdev/net/c/55b2984c96c3
  - [net,2/3] rxrpc: Fix re-decryption of RESPONSE packets
    https://git.kernel.org/netdev/net/c/0422e7a4883f
  - [net,3/3] rxrpc: Fix error handling in rxgk_extract_token()
    https://git.kernel.org/netdev/net/c/3476c8bb960f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



