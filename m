Return-Path: <netdev+bounces-262068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLv4HChkomnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:42:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB161C02E5
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03437311E76C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B6F2D2381;
	Sat, 28 Feb 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCH8xZXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080D228CB8;
	Sat, 28 Feb 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250021; cv=none; b=qBB+FvoGkAbxUk32CCtE7WDR1ymAV10nF3yogP6PqFwFhC7xmZ5VJ2E3sV+LxNJ/LHj3W0a76HL2rlJi+OJ2Vw4GIP3+wdhrDtP5XHRACtVxDr2Wo56/w4MUN99c7aEDQJ71pIq709868Db6j8pRi7pxyIn5VYu4hoAuKkQI1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250021; c=relaxed/simple;
	bh=rfQcLuUk0+dDhH/ajuJc8UjMuiLK9/BXDYJx7XTSxCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y6mdIgC/1dJZuqcZe3s+uy4gMIglSFJl1gv9TXPgJ1V5t1kQypxaOjMba8r8WeDnUljQoTr9oOSel+r5ysKsccmYiRDqKd2AE4MXaQgfoIuVwB0ltNLciqVlUv+YaDSYHFlKAO7dn+TjRPlLVthMfvAl4neICW/+Dq+oX1YkPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCH8xZXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5ACC116D0;
	Sat, 28 Feb 2026 03:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772250021;
	bh=rfQcLuUk0+dDhH/ajuJc8UjMuiLK9/BXDYJx7XTSxCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kCH8xZXMbgmHn/te+cPW7BH4S+aEn2RyLihe6y9QfP9OGABp905ZumNUXw7CB60oS
	 xrtmvC5G7mpEE2LkHocspDoYBqPjTJ9l/aGIL5dlvqJPRrDZw+rX95xGCCU86D2+jm
	 aUFfn+8mNiHkHWWlblwvElZlXKmiBVKDLxnUPjnC8Bi+lqY5j4V4TgK8c6fSsZ+gZI
	 dkBfe3DbLR5uhOqWlbbN3M49KgLR0NIptnHVbTfhU8f/en1OAZ86N2UfWJUuVOAcvN
	 7C2NGlWBWKqzOwg8QsiaSDtHStHKro9dsZYE4QN/ychaUhSxeVMhoR4abwuYQDJz42
	 J6CuTJ97/0iQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F7F39EF96C;
	Sat, 28 Feb 2026 03:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/handshake: Fixed grammar mistake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177225002428.2855218.306398645905286064.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:40:24 +0000
References: <20260227001151.41610-1-leon.j.kral@protonmail.com>
In-Reply-To: <20260227001151.41610-1-leon.j.kral@protonmail.com>
To: Leon Kral <leon.j.kral@protonmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262068-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDB161C02E5
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 00:07:47 +0000 you wrote:
> The word "a" was used instead of "an" which is grammatically incorrect.
> Fixed by changing from "a" to "an". This improves readability of the
> documentation.
> 
> Signed-off-by: Leon Kral <leon.j.kral@protonmail.com>
> ---
>  Documentation/networking/tls-handshake.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v2] net/handshake: Fixed grammar mistake
    https://git.kernel.org/netdev/net-next/c/57cc8ab3e9f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



