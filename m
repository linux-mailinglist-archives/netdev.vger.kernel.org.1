Return-Path: <netdev+bounces-264110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAjfIhLWqGnpxgAAu9opvQ
	(envelope-from <netdev+bounces-264110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AAB209AAE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A45130A624A
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484B23C4E9;
	Thu,  5 Mar 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0oBMT18"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688D23B62C;
	Thu,  5 Mar 2026 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672463; cv=none; b=EJjkfepHCNbQruTUUeaQip3OIQR0bpBVOKe9cj6Yzcb1+rjL3ZyjfhxzKbqTHL7Aw9VhVt3vzfKMcykn1HYxDD60vP7OvtwXkqVSddgyaNDSHXC5dhXXYznk5akTToHBwPoqwzSzsEVIx/TBjYdp0RAzPzD34BdiY6F7MiaLQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672463; c=relaxed/simple;
	bh=ucdMLCE5H7DIbLIO04qV28R/XBQzuD0cy8A2lw9cL88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rD+8XxLbaviZECJd2VVEUf+KPNq0YFnJnlDdHPvyLN7S9Q3MQ/TEhQ/bDBnGJuvKjLaj2Ziz240uFtB+aRX/EInw/AqxtlKYOXkE1o+YZIs2xgFIGSjR+67yzahl5d5QE7IOVzanfEEXecjHOqvf6kei6uZ4Lb9SeqLC1JvA8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0oBMT18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D710C4CEF7;
	Thu,  5 Mar 2026 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672463;
	bh=ucdMLCE5H7DIbLIO04qV28R/XBQzuD0cy8A2lw9cL88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N0oBMT18Z5DarRxZt0tYnUZlkMSifQfSSl3nwWboXys3+T+VBxzb1fXIP4N0oY5RF
	 GAlNGWdpJAO9HoJFzcfvyA8fzSe1W9nyaKS2UE86PquLT33Zw+lZyM0orWcabIS5/B
	 Q8LA4JIINJzGpdIEdY55K2224YAU2sod4b8A3LMMZ9c2buo9aPlMbcCwOtWe9ph6f8
	 /bYPe+44KRx7GBqu5CJwFLh1qCu7Jq5epT/kca+oJ8KzNL+PTZjheIlZneR7pCmgCU
	 O/2TsrHCMTuW6jeomoEFQJkSzXpnRoUBZMCc9LMluAdKdGaVR8GQTC5z8B5RlSEzaP
	 WWe8HPvBUb5Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1B3808200;
	Thu,  5 Mar 2026 01:01:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mxl862xx: rename MDIO op arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267246404.2463633.3384474012777758672.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:01:04 +0000
References: 
 <e1f4cb3bcffc7df9af0f2c9b673b14c7e1201c9a.1772507674.git.daniel@makrotopia.org>
In-Reply-To: 
 <e1f4cb3bcffc7df9af0f2c9b673b14c7e1201c9a.1772507674.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: E8AAB209AAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264110-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Mar 2026 03:17:43 +0000 you wrote:
> The use of the 'port' argument name for functions implementing the MDIO
> bus operations is misleading as the port address isn't equal to the
> PHY address.
> 
> Rename the MDIO operation argument name to match the prototypes of
> mdiobus_write, mdiobus_read, mdiobus_c45_read and mdiobus_c45_write.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mxl862xx: rename MDIO op arguments
    https://git.kernel.org/netdev/net-next/c/aefa52a28a36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



