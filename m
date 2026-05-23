Return-Path: <netdev+bounces-290980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG14Njj1EGr9fwYAu9opvQ
	(envelope-from <netdev+bounces-290980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD35BC078
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DEE130179E0
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC131E32CF;
	Sat, 23 May 2026 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQPaIpQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57441D9A66;
	Sat, 23 May 2026 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496203; cv=none; b=d4M5mx9PfkdmCwiwSpeN5VtY/jTnZ/GVDKO16QScOPY8W/++OU+PpPzKt3Q/8cglZbmVrCOv39znxcapy/WUEf3v3YUY/AovFibZ+gbA2A7MCGdLquF/zYzYGXi8qH9A3XiZc3Fz33IklyrKhiZA3K9LnuvJnbRf/dhTagbQ7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496203; c=relaxed/simple;
	bh=RUeae9J3CvYI2yHeKr4blx3wYaw/zDcw8YPUdJdQzH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aEFeInnAb78IiEmmiORBG2yZrXOv027eIisDC+oj5XB1CTrZwiJHstNqFhpuPrURWG1T+Cp1i2NwQ1jc3jWAjdckKz8EiuWtCX8wSAu/xWK1qDtnWZjJlxh2P/IrW46lJQ89hUaxUtYJKQfd6MBAdgLZB3RjORag/jIJq4K5zqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQPaIpQi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB561F000E9;
	Sat, 23 May 2026 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496201;
	bh=v0TA6DHL5VyiCPnG/LRNQe+vuPDHhPpx2aotbl+ON7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PQPaIpQibhjB3SfNBM/hvSYf88UMt/i2JyvVXfJEPbi5sgEhP1zAUVMTKpCqpskCr
	 Ki/9ujClZjnxEfGqgCZVFZiacr+aWOclGmIQgJFT8I9l6rVurZJVetjg/NlYbPZAxk
	 /x+pavV4qFxZMlghHBrDtd6UxcwXVrYPPtvZMVCRPS8g/fBcckGfyxEXR2Eb9uRBLe
	 SCbbHKqv3yhoH2oXs5Xb6Og8MNJvi+1udVgY44lQw6rJbNYfVfRGPswEruK8DN4nfd
	 VHcpSNN61CKLgiPolzOoicWnZ7Z4v/vrsWTx1ctz00xYGIDGExja5Mg81LWJZhL9EC
	 m6WZMkYl3a6mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19918393100F;
	Sat, 23 May 2026 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] netlink: fixes for cross-namespace nsid
 reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949620964.1423514.6539424966524103680.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:30:09 +0000
References: <20260520172317.175168-1-i.maximets@ovn.org>
In-Reply-To: <20260520172317.175168-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kuniyu@google.com,
 kees@kernel.org, amorenoz@redhat.com, jbenc@redhat.com,
 nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, matteo.perin@canonical.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290980-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,canonical.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4AFD35BC078
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 19:22:34 +0200 you wrote:
> While working on some new features for OVS and OVN we discovered that
> self-referential NSIDs get unintentionally allocated in the system as
> well as unexpectedly reported for local events on all-nsid listeners.
> 
> More details in the patches.  They change user-visible behavior, but
> the current behavior is arguably a bug, as it makes it hard to use
> all-nsid sockets without a decent amount of extra unrelated work of
> tracking when new NSIDs are allocated for your local namespace.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net: netlink: fix sending unassigned nsid after assigned one
    https://git.kernel.org/netdev/net/c/70f8592ee905
  - [net,v2,2/4] net: netlink: don't set nsid on local notifications
    https://git.kernel.org/netdev/net/c/88b126b39f97
  - [net,v2,3/4] tools: ynl: support listening on all nsids
    (no matching commit)
  - [net,v2,4/4] selftests: net: add a test case for nsid in all nsid notifications
    https://git.kernel.org/netdev/net/c/2e43b6424890

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



