Return-Path: <netdev+bounces-284660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BC7EIme+mk8QQMAu9opvQ
	(envelope-from <netdev+bounces-284660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:51:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A545F4D5733
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526FA300A3A1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B6271456;
	Wed,  6 May 2026 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBPiF6KT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98176270552
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032262; cv=none; b=K1Pjw8RrQAUemH5oQB3+grSFgeIMXJNUzjZ//2z1gTJz+T0iTy7dRX6v9mbVuH0CgvcMBbFZDm1wiXcasowKHOUmYw0X65ANygXpdouYh/bxc509iYmfVv/2BRukB8jtxvcSxExvhDn6VqB3EyNCZq3ZFpdx4KUKc7kNUzBKGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032262; c=relaxed/simple;
	bh=HdDlmo01ohAOaDJsoBxbdb4KgZBMV2isM8m1POxIjJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qJDKpQNHwWtWFZ8vyXP6dLCQNCI3TpL+/7W42WjeBiLdhQZ/jfcKsz8kRT6bV4d+21anheZ2U8dNgspTVVWP3spdyAQcu2hER0pKC7NAD5fdk9ipTIdIfFCYhJF1yp7u+jsVuXk/ETVvCF3h2m4KLL/x/u3yEU+rLsW9EVEaKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBPiF6KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D3C2BCB4;
	Wed,  6 May 2026 01:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032262;
	bh=HdDlmo01ohAOaDJsoBxbdb4KgZBMV2isM8m1POxIjJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nBPiF6KT1HXgjSUZ4q4XMhmMlG3hg741xtYOj5rr2Rzbt8oDkH9sABExeo3Lp4O+6
	 JMnA7q0liGag1jJyP7VuqkpHqw1faPS8CrMdPfKpustAcrBMpdi17cxblwLxtXjmYm
	 f7ecjRq40NsM4nTbHASP5lHozFiZan7lGMc55X0TVB6G3V3mO/IQoeOUcVeOxB2JMt
	 Yfq2OAifQVK5ZUJL6EMyg6ZHT5rptsXty2D8LGsxegYlEFty/0JP5Dpoakvc3nM2+h
	 J4wm95Z1Skg6BPhUyxTLjXZp1TWA3T8c+O4oDLoMyufTp6OMxb/vdNdYFc73H44rR1
	 ovMlr8z5rQzrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCF33930780;
	Wed,  6 May 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] Fixes for mv88e6xxx for 6320/6321 family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803221230.2344559.11444578417446570210.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 01:50:12 +0000
References: <20260504153227.1390546-1-kabel@kernel.org>
In-Reply-To: <20260504153227.1390546-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: andrew@lunn.ch, olteanv@gmail.com, rmk+kernel@armlinux.org.uk,
 vivien.didelot@gmail.com, tobias@waldekranz.com, netdev@vger.kernel.org,
 fidan.aliyeva.ext@ericsson.com, lev_o@rad.com
X-Rspamd-Queue-Id: A545F4D5733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org,ericsson.com,rad.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284660-lists,netdev=lfdr.de,netdevbpf];
	NEURAL_SPAM(0.00)[0.671];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 17:32:22 +0200 you wrote:
> Five fixes for mv88e6xxx for 6320/6321 family, for net-next, without
> Fixes tags, as per Andrew's request last year, see
> https://lore.kernel.org/netdev/20250313134146.27087-1-kabel@kernel.org/
> 
> Marek Behún (5):
>   net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
>   net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported
>     ports
>   net: dsa: mv88e6xxx: define .pot_clear() for 6321
>   net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
>   net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
    https://git.kernel.org/netdev/net-next/c/d201c2612e5a
  - [net-next,2/5] net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported ports
    https://git.kernel.org/netdev/net-next/c/965871277f60
  - [net-next,3/5] net: dsa: mv88e6xxx: define .pot_clear() for 6321
    https://git.kernel.org/netdev/net-next/c/17826d9708a5
  - [net-next,4/5] net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
    https://git.kernel.org/netdev/net-next/c/e0fdb4157a85
  - [net-next,5/5] net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family
    https://git.kernel.org/netdev/net-next/c/1010deac776a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



