Return-Path: <netdev+bounces-290146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGl2DR5ODmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:13:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9627359D341
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B55319CD56
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926139A7E7;
	Thu, 21 May 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhKWr+l+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A05368D71;
	Thu, 21 May 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321606; cv=none; b=peDTr+xI9IkufeNM/Qlt3pAI/tqpzzc41VpHHGPzLeh+9k5tVizFYZCgk5aDEx9wHt9qH+b1LD3iAHBuFgwug7EcKYd9TRF840OeI1Blkt9b1WTpJKyOajCAhkp8qPIlWfNalgWqZz7yUneoEcNrLC6oT0vBfG6wrTG12eRJZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321606; c=relaxed/simple;
	bh=+GNiDaCiiEIC3nOannu7nbff6M03NoAEcaFNRD8DyC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aO3P4qr8KBLmzze6gdVGRJepU7hsyNj99DQwaYHlQtK3Ex2Kr0LOgB4uARf1hQCLmvpmkqNbPOaQ6WOnD88t2soEHVuACUN++oVt+YqKk3BvILr72y7VKX90xt8vm1ASM6X79Qm6DrayejLcDTLAaziJKQwmAw+O7vddZOMKDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhKWr+l+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6586F1F000E9;
	Thu, 21 May 2026 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321605;
	bh=uGNtUi+Sqv3W4eXSQTy1SbbAkyQJYxXQ6mkDBlAPRdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bhKWr+l+veBSsSEBSFGOMeIdzuR69FEt68ITovQZAwQ3h+S8CdsaIwU+DE1YxutIw
	 PDB1DCPYI+Q34zIDhSt7U4+7e9CkeGX9XfE8QtTC9DC+QaBxFXIkDPh+skFL5UgkUo
	 Hohnhh+2B8IiBZ5WwhG1Ax5imhySAYvSWmIYnbu20eGK9eVRWvQCvj5ub057MfOFhH
	 5ykRI5edZNzoy0bfH4QxG2q5FVnhtNLcjcbCeZzm04rpWIbXfa+HKcIP86END15ZK/
	 4hyYU+T+27hPsF7eigh/oBERtVfzMnkeB5+MKVK0t8aYbX9R65jzJc6YjQOkYU0L8K
	 Nfqyfc72WskBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A963930C25;
	Thu, 21 May 2026 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] rxrpc: Better fix for DATA/RESPONSE decrypt vs
 splice()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932161541.3801238.11650632767864736181.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:00:15 +0000
References: <20260515230516.2718212-1-dhowells@redhat.com>
In-Reply-To: <20260515230516.2718212-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com, marc.dionne@auristor.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290146-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9627359D341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 May 2026 00:05:12 +0100 you wrote:
> Here are two patches containing better fixes for the in-place decryption of
> DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
> packets and sent to an AF_RXRPC server [CVE-2026-43500], plus a patch to
> precheck the length of rxgk-secured DATA packets.
> 
> Of the main patches, one patch fixes DATA decryption by having recvmsg
> unconditionally extract the data into a flat bounce buffer and, if need be,
> decrypt it there.  It doesn't seem to cause a performance problem to do
> this even on unencrypted packets; for encrypted packets it makes sure the
> content is correctly aligned for crypto which seems to get a small
> performance gain.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
    https://git.kernel.org/netdev/net/c/2b50aceafe66
  - [net,v4,2/3] rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
    https://git.kernel.org/netdev/net/c/d2bc90cf6c75
  - [net,v4,3/3] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
    https://git.kernel.org/netdev/net/c/8bfab4b6ffc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



