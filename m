Return-Path: <netdev+bounces-258195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NOJIhMNjGnffQAAu9opvQ
	(envelope-from <netdev+bounces-258195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:01:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D7C12148C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0BA306F01A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9E306480;
	Wed, 11 Feb 2026 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjE8O+em"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F52E0B77
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786027; cv=none; b=RUJpmQRC5GQsC7P9G53C6Th1GoZk6da3oB1i/K9tgghu7CITVR6xvOUJosalwFcrdkO5wLOpwAwv9RS+R5v8tdxSpiyPOEcclVG1E+Ty2YkzcBejtk5A1PgjOIsDCz5WwK62390oz1IDSi4vTP7zcis//ki4aSNG9vG+/wrOaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786027; c=relaxed/simple;
	bh=6WuNqvyejPz3jfiXz0vEIkcvhfIQAqauwyqkW5GuxD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M50DmjPHhpCO+KHhB8gJ+V8miIiLqlt3NCxCFH+w9JebL18hsE/Eo4m5MK2Iw+oUY4XiCC6L0zvlp1k7Jmcm57SP3wGfc9dMZ1nRrs/75j8vA3fWbJ+FfCfRIFdqmgyVGw5RcvAHTnKF9+Cgbp80U6+8wa7DODIvv4TQ+tDCmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjE8O+em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70671C4CEF7;
	Wed, 11 Feb 2026 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770786027;
	bh=6WuNqvyejPz3jfiXz0vEIkcvhfIQAqauwyqkW5GuxD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZjE8O+emTzN6JNqi1jtZzCKWdHLmR+woiGsN1AZpY1Thn6RlMC2C04xW5K0Y8BKmt
	 xdwH+QNrvVUwxrPVDrWwP6W7pUpF6p0T0+vqdy5jAvWxMFILkvE141psMmUhjvhFvH
	 E9g+1Msbe7XjjKio1WvKekw6f/PFeL2FqKY3NYGLPnKhlBNLeY+bMQ54dQSwsda/oO
	 cIWTV9mni1YGthvQnGW0SdkB800vpIWTIoCu6rd5Y7xTNYm+BgNXvCLezSIKTb3g/U
	 RXN8r4mC4RCnD5MC6M7U0f8skNF5tzNUvPtad9CSZEUe1TzpXk2OKmwuI1P5bbldyj
	 ccn+IrFeUAztg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22CB380AA50;
	Wed, 11 Feb 2026 05:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] xfrm: reduce struct sec_path size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078602232.5556.16093817625787227064.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 05:00:22 +0000
References: 
 <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
In-Reply-To: 
 <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, fw@strlen.de
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
	TAGGED_FROM(0.00)[bounces-258195-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0D7C12148C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Feb 2026 18:14:36 +0100 you wrote:
> The mentioned struct has an hole and uses unnecessary wide type to
> store MAC length and indexes of very small arrays.
> 
> It's also embedded into the skb_extensions, and the latter, due
> to recent CAN changes, may exceeds the 192 bytes mark (3 cachelines
> on x86_64 arch) on some reasonable configurations.
> 
> [...]

Here is the summary with links:
  - [net-next] xfrm: reduce struct sec_path size
    https://git.kernel.org/netdev/net-next/c/dc010e1b4bb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



