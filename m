Return-Path: <netdev+bounces-277868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tIw9Bs/k22kkIgkAu9opvQ
	(envelope-from <netdev+bounces-277868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7D3E565F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5554D300AC23
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAED2FFF8F;
	Sun, 12 Apr 2026 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUzsozt3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDF220F49
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018634; cv=none; b=NYDnyeVkhZ9fXnHDqSc8/4w2fBApwxqQOnzdK+Bw6az4Ob1aqX8V/gO8CjGO3k33kyiumiEnaiy6fuO03iv7u/8pe+E/kJRaTGQIvNdript8qpkkfi/mPTOWCSwaSu+gmWRfFaajesfzYwzZFINgOGHYb4BWqOqoGpAREp8pP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018634; c=relaxed/simple;
	bh=Rn09doMwThVuGmJttHrEWCY7Ffm82LLEd6qDoY9fTD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rbzquDyxxrK/3Zxk1rHLEqXadCLwKcV1cn30yWtO782QAb1Lqgx0Ytlc0cn2fMGDkvcuTWOPVfSd+CDb6npc3IRV4kv8OmExUO4Owi9Ir2NSClTmFVzT0uN0Y9wdQvS+LOojr7qOmZVBFhs/2CfmDccRJN54mNyfiyegATLoK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUzsozt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56582C19424;
	Sun, 12 Apr 2026 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018634;
	bh=Rn09doMwThVuGmJttHrEWCY7Ffm82LLEd6qDoY9fTD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUzsozt3RW2IZ3ZMM220xBEBobXzs9NyXQKkz9bfKzMKKVEO0ugU+nPlLdXeXDHxg
	 2ouEEP/+p/DBYL4jDrIBOHdGtphxrEesXPKocip8LK3TTpmYwrg2ce4JoGKGZbMkCO
	 bemdwb0XwbXt0sSDnMGiko8grIXmoLeofFXkxZkj6iMs82VeSie4z3iwr5WuOZIE2/
	 9aNwqykuNG+qYid3qOGKTr4te63fBTqyKAtZlNyNS6bfgNejBc0+J3vb625pMS97bb
	 F6CZeDI1+aEMx9FGrmbRLJ48GbWeWjAw6AEkgvHqEeDpy9dN7ckh4va3IZNa/TXdxQ
	 48MfX+uy4vj4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D023809A8C;
	Sun, 12 Apr 2026 18:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfc: llcp: add missing return after LLCP_CLOSED
 checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601860655.3367410.12963803976017127062.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:30:06 +0000
References: <20260408081006.3723-1-qjx1298677004@gmail.com>
In-Reply-To: <20260408081006.3723-1-qjx1298677004@gmail.com>
To: Junxi Qian <qjx1298677004@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-277868-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78D7D3E565F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 16:10:06 +0800 you wrote:
> In nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc(), when the socket
> state is LLCP_CLOSED, the code correctly calls release_sock() and
> nfc_llcp_sock_put() but fails to return. Execution falls through to
> the remainder of the function, which calls release_sock() and
> nfc_llcp_sock_put() again. This results in a double release_sock()
> and a refcount underflow via double nfc_llcp_sock_put(), leading to
> a use-after-free.
> 
> [...]

Here is the summary with links:
  - [net] nfc: llcp: add missing return after LLCP_CLOSED checks
    https://git.kernel.org/netdev/net/c/2b5dd4632966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



