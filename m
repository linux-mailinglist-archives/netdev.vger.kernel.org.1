Return-Path: <netdev+bounces-268581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDewNWhDuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:04:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0552A9764
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A59A3055956
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EC3BAD8C;
	Tue, 17 Mar 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMpXUNEz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797113B8BCB;
	Tue, 17 Mar 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748819; cv=none; b=dfuzwi3x8lIEtQXcLdlYOeCYGFT3Y2bSGCEKmSVNPspk9N0OZ/WQ+hZ9eWFvxf9iXOBMeZZZA8+ETz8Ob7QFepeYrXGeLq96aBFjNL4wPLxZ88uWxlRCpjmd+vXdMET2VWjaOgUoUk35FAlOeD14rvWxsVKkUl8RANeswJxzU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748819; c=relaxed/simple;
	bh=ObyeGWjZtHrymyhtE8GDuhc5g0y8cyThbPdP6d9yYY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lu4UHuw8b0zCDrYTBYNDJvpwlmITFiujcQdbQhzQf4DmbWmXqpemFWYiTb5cLaE9MhEsZ8Wf/n8SFTXoUIq74bzcmHkQOcJJWV111ND96kbkFKbbb3MtkNvG0GI0rHYi4oIxaA+pXUMV68XzAsK8kvDYnhesG5OyImdzZ9CZE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMpXUNEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309DCC4CEF7;
	Tue, 17 Mar 2026 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748819;
	bh=ObyeGWjZtHrymyhtE8GDuhc5g0y8cyThbPdP6d9yYY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hMpXUNEzjlOBeJpEzQgy7xrveSW8A+vEoevMJ8D+6cM2PkXe9tMH6KO1nfC5fMZMu
	 PgSrUwsnpo0tH0Ux3XTsCGNfyQsXnBqkJPcVp2rz+TY7uzOPQAXPG0I6A2EgbPCrAM
	 lWKZ+Xqvpk31J94HVCiJrRo4Nx8s8FJsz31MbrfL2+DzxjHigT2XWzmlOT+DCTSLHW
	 y8A9ZDgwmiSo+aeM0qQhbys5X2AxRwYKSxSZ38AlXRpxQsun6kfIdWhOKJHpbfZtSE
	 3vtiia7MLvkdQw5X3AazwL1LMaMekEj4q29aWiyQEYOOltoMMIn2GecfkmIhKFbsfy
	 PYpgsGyM1NUWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B4A3808200;
	Tue, 17 Mar 2026 12:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: add ipv6 RA route to ECMP
 merge
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177374881156.3585799.4575178253875930759.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 12:00:11 +0000
References: <20260313124827.3945-1-fmancera@suse.de>
In-Reply-To: <20260313124827.3945-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net
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
	TAGGED_FROM(0.00)[bounces-268581-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C0552A9764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Mar 2026 13:48:27 +0100 you wrote:
> As commit bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when
> clearing RTF_ADDRCONF") pointed out, RA routes are not elegible for ECMP
> merging.
> 
> Add a test scenario mixing RA and static routes with gateway to check
> that they are not getting merged.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: add ipv6 RA route to ECMP merge test
    https://git.kernel.org/netdev/net-next/c/fdd973148a11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



