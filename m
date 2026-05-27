Return-Path: <netdev+bounces-292012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL5wHbs7FmpCjgcAu9opvQ
	(envelope-from <netdev+bounces-292012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:32:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8705DDFA0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9673130AB73A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23930567A;
	Wed, 27 May 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th9ALVXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BC2DECBA;
	Wed, 27 May 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841810; cv=none; b=LyIlUXRZYpkPxe/pc9+GSfWXjyXtJ11l8QWuT9cIG5/e0cH32IB91x3M96h6540llJiQtFBLsDts/CDAl4gdQh7c9/wBFLjEOIE93UY8AdayyNvTmiMhlaPBP/NNFQIF7/8oMD88XXYTBwS2zlN2e8yDIgVYHs5SmpHfsRyGMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841810; c=relaxed/simple;
	bh=gdCJCCCOupd9qma905SUx5vEfYFcSB8S4KM9ImJGyTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WRXVfQVqogM/q9gPGTmAu7W82HaDZyKQuBAaixQs623wKlJVZyf+6xfEyVHOO5ElHiDIF/3JhmaF4JdLc/L0kw774c8JrXtT2LrtOaldGc5lUf5tSpkOlAXm7ESUJ6RUGNyPkeARcdMMl9NNGO+zrws+/Sfw2RmDJSqAX5XcT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th9ALVXU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8FE1F00A3A;
	Wed, 27 May 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841809;
	bh=lpP1bE4YtwF0d8DUZvwmmjLRsm/6r3hmoDSuJiVWVw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Th9ALVXUszd41YSvoHTjI3SsdG/oCx0d1mHAyrXfp5rW/5MWBtBmogArE3/zKee/9
	 wwSTmlqpz7rBfAU41lSyjRQUncG2wXcevTYtf1JGERVRz7ZqNevQ0uS6Sjjx0I47Ql
	 4bvsYAt0vhJdH0RcmCsQqhpWFF1qG9Ynu1HdWKE+MYMp6GCecPxOFyBoAZ9y8MrHHC
	 Cwe0e8AvVObnui8dHc0Gt7ZmMdq/cE6vMCTQDjlfFtSbQV9E3FUsykYogjyQlyYOHD
	 CURxZ2KTqQhKsIKYBOcihAuH2SjuEfVwxINdoFDO2IJg9r019mz4jjXunv48Q5EgC9
	 MeDgRU5ZIzQKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B05380CEED;
	Wed, 27 May 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] llc: Add SPDX id lines to llc header files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984181489.4027067.16835599718279128646.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 00:30:14 +0000
References: <20260523002354.28831-1-tim.bird@sony.com>
In-Reply-To: <20260523002354.28831-1-tim.bird@sony.com>
To: Tim Bird <Tim.Bird@sony.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.kernel.org, horms@kernel.org, acme@redhat.com,
 tim.bird@sony.com, netdev@vger.kernel.org, linux-spdx@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-292012-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sony.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E8705DDFA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 18:23:54 -0600 you wrote:
> Add appropriate SPDX-License-Identifier lines to llc header (.h)
> files, and remove other license text from the files.
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>  include/net/llc_c_ac.h | 8 +-------
>  include/net/llc_c_ev.h | 8 +-------
>  include/net/llc_c_st.h | 8 +-------
>  include/net/llc_conn.h | 8 +-------
>  include/net/llc_if.h   | 8 +-------
>  include/net/llc_pdu.h  | 8 +-------
>  include/net/llc_s_ac.h | 8 +-------
>  include/net/llc_s_ev.h | 8 +-------
>  include/net/llc_s_st.h | 8 +-------
>  include/net/llc_sap.h  | 8 +-------
>  10 files changed, 10 insertions(+), 70 deletions(-)

Here is the summary with links:
  - llc: Add SPDX id lines to llc header files
    https://git.kernel.org/netdev/net-next/c/29fb4a26416d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



