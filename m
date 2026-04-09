Return-Path: <netdev+bounces-276769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPCKBykG12mdKggAu9opvQ
	(envelope-from <netdev+bounces-276769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:51:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED23C5588
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1CE300BCA6
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0706B358D37;
	Thu,  9 Apr 2026 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay24gmnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F6232367;
	Thu,  9 Apr 2026 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699475; cv=none; b=TYchLKMiiKt0DuNMcRWusNTzsmaIM/2+gquPitgaktnq/90N7cd/ClMUOuG3pMux+PBZy13Sm3PnrTmwk6YaTB78RVXW8VmiY2IXJsAXvR03Lern/OSv/SWPktpfQoepbkj6M04QsNgAxvWikSyfjkMPshh3b5xCGGWkr/cXcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699475; c=relaxed/simple;
	bh=4bkcelQmN5Muntzw+d4/wQqgKbOlDu71rhjNDY1lmqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gZklGOwUr7MMu7kBX4UbZ/3ZIfqWqlV148V9P21b6Q+FNDmJwRjpplWuiymd9CsDCwXyj+lJ7uJmSe9+4l3lhB/3SIRffWIvRGzUrznx0hOGy88+wZfLtdEuhvPM2BTfaTgpC/L4EyUm6ptUwlx0E6cIgNfTphSdoSMlPI7QvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay24gmnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8451AC19421;
	Thu,  9 Apr 2026 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775699475;
	bh=4bkcelQmN5Muntzw+d4/wQqgKbOlDu71rhjNDY1lmqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ay24gmncRkMp8Vh04QVcpamsrCfwBjdBAvf5/P6rrDyp4DWSZiNH4gTjtkxuHYQAq
	 604n+WEd7PjzqjuLvJYtHoIkjoE9tTPPM8SypaHtmx/Gl1GMmV8zSrxhlwqpsFkPMi
	 oiQ+LTusby4JR37/Lr5DiQKov7fyv065kVeQ+yyBJaIiCX7cf8JOkF49O6gD7EOP1/
	 sRItnDUFZ6WFOO3MVr1QGEyua09ulja89fFzjbbTSJdgI0IM5HZCxKlDVTlu/0fnDv
	 4UPKl9yi2P3GTIM7OfMsv7sh+DPSgMgVafzCDltLqoyzu1FtwfCyoDwBQYLwRtXnzF
	 Fotz1EoaMG6DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F153930793;
	Thu,  9 Apr 2026 01:50:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 00/21] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177569945153.949482.7195276358640737512.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 01:50:51 +0000
References: <20260408121252.2249051-1-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-276769-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78ED23C5588
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 13:12:28 +0100 you wrote:
> Here are some fixes for rxrpc:
> 
>  (1) Fix key quota calculation.
> 
>  (2) Fix a memory leak.
> 
>  (3) Fix rxrpc_new_client_call_for_sendmsg() to substitute NULL for an
>      empty key.
> 
> [...]

Here is the summary with links:
  - [net,v5,01/21] rxrpc: Fix key quota calculation for multitoken keys
    https://git.kernel.org/netdev/net/c/bdbfead6d389
  - [net,v5,02/21] rxrpc: Fix key parsing memleak
    https://git.kernel.org/netdev/net/c/b555912b9b21
  - [net,v5,03/21] rxrpc: Fix anonymous key handling
    https://git.kernel.org/netdev/net/c/6a59d84b4fc2
  - [net,v5,04/21] rxrpc: Fix call removal to use RCU safe deletion
    https://git.kernel.org/netdev/net/c/146d4ab94cf1
  - [net,v5,05/21] rxrpc: Fix RxGK token loading to check bounds
    https://git.kernel.org/netdev/net/c/d179a868dd75
  - [net,v5,06/21] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
    https://git.kernel.org/netdev/net/c/b33f5741bb18
  - [net,v5,07/21] rxrpc: Fix rack timer warning to report unexpected mode
    https://git.kernel.org/netdev/net/c/65b3ffe0972e
  - [net,v5,08/21] rxrpc: Fix key reference count leak from call->key
    https://git.kernel.org/netdev/net/c/d666540d217e
  - [net,v5,09/21] rxrpc: Fix to request an ack if window is limited
    https://git.kernel.org/netdev/net/c/0cd3e3f3f2ec
  - [net,v5,10/21] rxrpc: Only put the call ref if one was acquired
    https://git.kernel.org/netdev/net/c/6331f1b24a3e
  - [net,v5,11/21] rxrpc: reject undecryptable rxkad response tickets
    https://git.kernel.org/netdev/net/c/fe4447cd9562
  - [net,v5,12/21] rxrpc: fix RESPONSE authenticator parser OOB read
    https://git.kernel.org/netdev/net/c/3e3138007887
  - [net,v5,13/21] rxrpc: fix oversized RESPONSE authenticator length check
    https://git.kernel.org/netdev/net/c/a2567217ade9
  - [net,v5,14/21] rxrpc: fix reference count leak in rxrpc_server_keyring()
    https://git.kernel.org/netdev/net/c/f125846ee79f
  - [net,v5,15/21] rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)
    https://git.kernel.org/netdev/net/c/2afd86ccbb20
  - [net,v5,16/21] rxrpc: Fix missing error checks for rxkad encryption/decryption failure
    https://git.kernel.org/netdev/net/c/f93af41b9f5f
  - [net,v5,17/21] rxrpc: Fix integer overflow in rxgk_verify_response()
    https://git.kernel.org/netdev/net/c/699e52180f42
  - [net,v5,18/21] rxrpc: Fix leak of rxgk context in rxgk_verify_response()
    https://git.kernel.org/netdev/net/c/7e1876caa836
  - [net,v5,19/21] rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()
    https://git.kernel.org/netdev/net/c/f564af387c8c
  - [net,v5,20/21] rxrpc: only handle RESPONSE during service challenge
    https://git.kernel.org/netdev/net/c/c43ffdcfdbb5
  - [net,v5,21/21] rxrpc: proc: size address buffers for %pISpc output
    https://git.kernel.org/netdev/net/c/a44ce6aa2efb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



