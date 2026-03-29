Return-Path: <netdev+bounces-273022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OkMEWOcyWmqzwUAu9opvQ
	(envelope-from <netdev+bounces-273022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:40:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF81B354316
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53F163009F1E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA952382281;
	Sun, 29 Mar 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFIW3eit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580137AA79;
	Sun, 29 Mar 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820442; cv=none; b=b89W4NeN6ZFqjRNRgvuDBBf/AK4b6jWHHB5Fkd37KyGuGyfPMguNKtTEqLPbUMNl5ts5HErsJYVFrxQFm6rKLb3cta76k4gEAKudkxtwxk2sWpmWkkAlO27TexP6ablZ4iwZE/Bp3wQZAJPVoBO2gSqbghqLbQbgUOzIb2LjKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820442; c=relaxed/simple;
	bh=hmCRlyG0bAv29oQ0zT8IF5KWMcwWQa7Oj6fZIK+K8FE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nRLnp6dGt+f/xZ/A7TV2mD2mhq70kD/mrEbBfj9dNbK9SPxFo2m8rcx+LdUqTiuJsYodztABo0MchD/RVcCAUtn02orx57BjSVjaUzhejqkKy4ou5SISjGr7oe6vk4oHytmOlKGowZz9oH4EMqlQy94VjIK/1lnSJlFSj4X3nsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFIW3eit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78258C116C6;
	Sun, 29 Mar 2026 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774820442;
	bh=hmCRlyG0bAv29oQ0zT8IF5KWMcwWQa7Oj6fZIK+K8FE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JFIW3eit3Al+gKwsouuexsxYcJA0ZA6RMQNRr7/OTssRgQuKYYxgZoPVZGneCU5me
	 d09YBaY87ZjxQ6vCQ10cz4IQOiGNAV8TxePuoC+qm5ywMeBUCDFwkazhll9X/CpG1U
	 u9dCzawuQDAAPZF97IjsZ2ZqALBoRAAC67GGqfW5fQVQvqTGTfSKNicV0Y8VkCA3Eu
	 ClLSw1oa2zRoyUVrGUF2fq8dDstwX1W3wJ6wBpHpZNb2FCdUo6LBHaqQGuHR5RBaBa
	 EgYt7qeZzCBbrJ/NxEu/clQTwEQq6YarVNgsURA+4FuIFz/0OXW/eO08Ddko/gwK63
	 /0j4mS62xwgXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE083930012;
	Sun, 29 Mar 2026 21:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: hsr: subsystem cleanups and
 modernization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177482042679.472023.17711197467583379324.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 21:40:26 +0000
References: <20260326174600.136232-1-luka.gejak@linux.dev>
In-Reply-To: <20260326174600.136232-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 fmaurer@redhat.com, liuhangbin@gmail.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273022-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: AF81B354316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 18:45:58 +0100 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Changes in v2:
>  - dropped trivial cleanup-only patches per netdev clean-up policy
>  - added AI attribution for cover-letter/commit-message wording only
>  - dropped fallthrough/BIT conversion patches per review
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: hsr: constify hsr_ops and prp_ops protocol operation structures
    https://git.kernel.org/netdev/net-next/c/3e09b370f830
  - [net-next,v2,2/2] net: hsr: use __func__ instead of hardcoded function name
    https://git.kernel.org/netdev/net-next/c/137ac69c15fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



