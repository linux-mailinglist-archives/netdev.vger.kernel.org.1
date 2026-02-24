Return-Path: <netdev+bounces-260514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME99CJKenWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD49187386
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5C7E3008630
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FBD39A7F9;
	Tue, 24 Feb 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJOqkwpQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F739389473;
	Tue, 24 Feb 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937399; cv=none; b=AxYublxmsPHxUbFVs/G7ocVmPidk40222N1klGVuIu8ItwlcNERwUJCRFvPx8/3efLp3xm1SZ8ZBaTCSECbcIL4yq0lITLY7HLokQGHTLKtRc/zJ8M5l/gWEXCqFnzZBTPblvikUC89yxq0QAn6NI8K9MrBQ72vLoy/Lti0wYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937399; c=relaxed/simple;
	bh=fiBYcVViEOVxt3UilGPojzDx8ijJs99SKMjsoBGwWKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XA9xa7BoJDuk/p6A+dQQVrT+gAbVARLoH2gcl/1mwN9XbLQK6KMBukv+mDAsquKyoYe0XabYqf71hg6ZPpMnUZkbD23OdNguWq3TviP2DTyEwH05RrKBj9rltQRXWWsi4kd2UdFH7VeCZ5QIIS9SalJCR528bNn+ihvwkMxiWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJOqkwpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C78AC116D0;
	Tue, 24 Feb 2026 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771937399;
	bh=fiBYcVViEOVxt3UilGPojzDx8ijJs99SKMjsoBGwWKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hJOqkwpQ6pT6LnWAZCQL5QrQvXifMtftnw9qjQXVv/svmQGIEm76Nt3Wq2oPcdscl
	 XYQp0pPgYoKiOnkF8RFqSuuz5J5BnTAINiZwYAAE5qBpLuTWX2lAOFb12XVyoYSxZ8
	 G26tV05StddpBtusEK+I2kCg5+6FFOAiZz4J2iveKWugr1zsTqxsz3kLkf9+IVQ7Y7
	 BI6aGDRy6NElbKVz3aCMCKWv79kTtfwAg16P1OsXgD8GOuYj8FjtHZy2+DacogAlrj
	 ENPoJEUQCMh/k6QzyxYuhktCtFyyIoQhGRc8Mx2XJvjvTcAX+/l+fBnHjCRF+Cwdz9
	 2PJGJJ4SOWQwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D743808200;
	Tue, 24 Feb 2026 12:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: l2tp_eth: Replace deprecated strcpy with
 strscpy in l2tp_eth_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193740480.3556455.11942601380923015598.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 12:50:04 +0000
References: <20260223074137.321862-1-thorsten.blum@linux.dev>
In-Reply-To: <20260223074137.321862-1-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-260514-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AD49187386
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 08:41:34 +0100 you wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  Use the two-argument version of strscpy()
> to copy 'cfg->ifname'.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net: l2tp_eth: Replace deprecated strcpy with strscpy in l2tp_eth_create
    https://git.kernel.org/netdev/net-next/c/e5a80f5e67ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



