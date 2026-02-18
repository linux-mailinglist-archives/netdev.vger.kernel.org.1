Return-Path: <netdev+bounces-259185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEgqDkEUlWlYKwIAu9opvQ
	(envelope-from <netdev+bounces-259185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948FB1527FE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6A3305C8F0
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B12DB7BE;
	Wed, 18 Feb 2026 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9+/YYVZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA40284665
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377627; cv=none; b=bPGfmB6hVEd/Osr08r5FyUVpuIpg+/wCPgogzBDwUYR6cRolVsvk+jIt2KBSH/QFb8jcX+T1hfC/KDliyEi66Xe6MkmkzccU6hwMKFw5+g2DwaxJsQMtocVaJ1ffbR28o6jqDreQ/my4TT5HHX1o4+Yglhsw3OuknHquRHELGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377627; c=relaxed/simple;
	bh=gVu7MW9IUBRi+EpHfPFbYF0RmEKN8DD+vcfIRsqbu0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CS7+r9dn6A2oOPEPomYlN265L2xiW6+XUm1BwhIgS7brH6tJ0qO16rYsZAhHM4CAchZ91S9dZlbbKRbyJI6mGSwLHHJZg4OXtJe7UwIzYR5R0/SImA2WKl7AEJElj6z23XcfP0MHIakYNwB4HdYoVgA46EUllH6zpJowW30EB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9+/YYVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064FC4CEF7;
	Wed, 18 Feb 2026 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377626;
	bh=gVu7MW9IUBRi+EpHfPFbYF0RmEKN8DD+vcfIRsqbu0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q9+/YYVZBpnIxOI/QALK6chnjes5BJ6OX1zmRtbMY/x1IocQtdxvDW9F2MjHaD6uZ
	 a7xXnDg2n2FyiAHA3YoaA2bxjbKx0tJLkpi5k9OVeqIhan8h/XccFeYl5E6w3j/RsP
	 BxP2bEJxOfyc9r3db7VRYjLjjCXTDzi8935JFXR7boC+LSu7kLSiH3O/GEwMrhS9XM
	 Xf43KL7cjdfp6rfG3FxVrTzQSsNxn6Dwta8Sr/r/TK9/d7cwLJ1+pF317bGHXGwaaG
	 +N1sqDB/qe8suH9ohKz2pCkdlAP+DAQo5VNZFlFfpgoKIcFGM5/2158yTAtm6HAB5k
	 uGZN6Fn22AH7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22C03806667;
	Wed, 18 Feb 2026 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137761857.765825.5185653389299397165.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:18 +0000
References: <20260214172543.5783-1-fmancera@suse.de>
In-Reply-To: <20260214172543.5783-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, fgont@si6networks.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259185-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 948FB1527FE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Feb 2026 18:25:43 +0100 you wrote:
> This is a recommendation from RFC 8981 and it was intended to be changed
> by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> but it only changed the sysctl documentation.
> 
> Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: addrconf: reduce default temp_valid_lft to 2 days
    https://git.kernel.org/netdev/net/c/9e371b0ba7f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



