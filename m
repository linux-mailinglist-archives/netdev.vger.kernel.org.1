Return-Path: <netdev+bounces-256937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPfpCOoFhGn+wwMAu9opvQ
	(envelope-from <netdev+bounces-256937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A5EE24A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00EB83038FC8
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915A2DFA46;
	Thu,  5 Feb 2026 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3moVlF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964302DF156;
	Thu,  5 Feb 2026 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259831; cv=none; b=aVdtuY0rk24JEfBHtDOQVgHhFFnyyd2xfkZiMWILXHLBRDb0KiW+lcTesy4eoe4G8CTOms9ljYO5ejoPaMbPuRbh0lWrxGGZZfOU42tNqqEAN58vvGycWFf4oaCFrO/0a6k1NxoHkkdJlS1H7AahX8I02OdElD30idldyO36nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259831; c=relaxed/simple;
	bh=Yr5O/kTN7gs+BF4zJ7kYPtZFJe+JJH/94kDKNeOwhR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B2oZtLmfT6fiMXLxB1Dh4PMarC8tT2QOGWqEcTIqBjtav6Qm17zs8+z7qb0sP51YtMY3rDTNkukT+UqZS1qO7UfRxkZp4zik5Aw/fHJgXi2VtZuU++M4Em93R+GTWf8P6vKu5zoejZCYCl/j1EXbKmdgPLHpQuiawBjU04Lfsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3moVlF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458D2C19422;
	Thu,  5 Feb 2026 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259831;
	bh=Yr5O/kTN7gs+BF4zJ7kYPtZFJe+JJH/94kDKNeOwhR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m3moVlF6reS7dT5sNptnD3SlXATsLW11rfz0nLN/7UtkDxjDFlMFHZrlzIOrNRYD3
	 8kgnMvaU++R6V9SDM8JM7c6H4l7n7Nr8pyUKBwNS9YlPvqmrlW6e31ef0q5ujP/Itu
	 1OP6iL+auFO85HpWAtrpJ21YEfK9ZlsYS7DKDVuuAxuS86//G5rjF6suqwzb9kvLMp
	 +5z6K6eLJKSRXzmLEDFnqYycANL2z1+xr/DwJe6yw2YB3NegV5fkZwhArtNNcUAwUd
	 S+UO2yLrsxOOb3Bv4RSosCzcNYCuvdCVFdc7oacTfSR7ilEtUhCQRsUl0C7/Kg/K6i
	 hHmLdUs4axrLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852ED3808200;
	Thu,  5 Feb 2026 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177025982907.136386.5748786579112411957.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 02:50:29 +0000
References: <20260203163406.2636463-1-arnd@kernel.org>
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, bcm-kernel-feedback-list@broadcom.com, horms@kernel.org,
 harshavardhana.sa@broadcom.com, bobbyeshleman@meta.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256937-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 907A5EE24A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 17:34:00 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The gcc-16.0.1 snapshot produces a false-positive warning that turns
> into a build failure with CONFIG_WERROR:
> 
> In file included from arch/x86/include/asm/string.h:6,
>                  from net/vmw_vsock/vmci_transport.c:10:
> In function 'vmci_transport_packet_init',
>     inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
> arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> 
> [...]

Here is the summary with links:
  - vmw_vsock: bypass false-positive Wnonnull warning with gcc-16
    https://git.kernel.org/netdev/net-next/c/e25dbf561e03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



