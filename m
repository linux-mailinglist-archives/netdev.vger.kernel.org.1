Return-Path: <netdev+bounces-258532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPYRBGqKjmmrCwEAu9opvQ
	(envelope-from <netdev+bounces-258532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 853DA132644
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C021D308453D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9B23BD1B;
	Fri, 13 Feb 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEI3WzB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF923AB9D
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770949218; cv=none; b=fg2PDoI1Dcd6RsmesIUDIBIMPmdC/Q+C8UloYNuDUzmGsgo9dYIHbHiagplWjBbvq4Mkz+qk0SdmOnNEVXfevNzAk8CFufp3coNFAfdboZOaYSRbDawulfbwn/Zba6vIsBeuvV/vhBVsZNUTWLm/o5/tcNy/hLF7+6NO81UHz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770949218; c=relaxed/simple;
	bh=WIKJ2LP+y8vitZiGH7ZU2GldWWA6i4qo9q921Hh0bvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3matx4cxFVM2Ca8+Kf+VqSFihFoiSFTXPKUBImSvTZoWd/btW7JgfL4T0o3Ppbib+3MveyhHe34RiqR7f8jwcV+zE1lbZsQj+MxNZmlNWyhMjGP6HOTs0Jtszuo4PtjPQeNe/38x/GRDN9FfwVVf4tTkhaPWedrJa/2oAX6Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEI3WzB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B02C4CEF7;
	Fri, 13 Feb 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770949218;
	bh=WIKJ2LP+y8vitZiGH7ZU2GldWWA6i4qo9q921Hh0bvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uEI3WzB7XLd1fcclPXGMhJQXLNyyAfu6B3xTvI7VwrXlSlRUsWJPokjvkdzdG8UYw
	 kzvu6N87NPpQYNvhlm/kRwvFhANKWeSUEKLw/iu+3XBMZeH3eNi+QUbuIvdryycnCg
	 iq6LRbditbjSN5FnOzV/VpWRbeHXl66fQd1Oed50qYaUZvG24DVbSffZoHpi0sLCzq
	 QKlf0ST6szdISZsVFN1LUmTjuHrv83ArbpR00P4GByf4qqh8cdliV2giM96w226Agg
	 2F+2RcLljxZVAW4TvgPIOrYeSPVLBcXzroJNckKXc8VcKLD8QgRVcnk8+uQSsunPQ9
	 tLWDLdst8BRpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85266393108D;
	Fri, 13 Feb 2026 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] myri10ge: replace comma with semicolon to fix
 regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177094921207.1813136.14656090554617621428.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:20:12 +0000
References: <20260212055028.3248491-1-nichen@iscas.ac.cn>
In-Reply-To: <20260212055028.3248491-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, arnd@arndb.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258532-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 853DA132644
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Feb 2026 13:50:28 +0800 you wrote:
> This fixes a regression introduced by commit fd24173439c0
> ("myri10ge: avoid uninitialized variable use"), where a comma was
> mistakenly used instead of a semicolon.
> 
> Fixes: fd24173439c0 ("myri10ge: avoid uninitialized variable use")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2] myri10ge: replace comma with semicolon to fix regression
    https://git.kernel.org/netdev/net/c/7c375811b511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



