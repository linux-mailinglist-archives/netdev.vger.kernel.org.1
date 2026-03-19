Return-Path: <netdev+bounces-269547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJcLMMcpvGn4twIAu9opvQ
	(envelope-from <netdev+bounces-269547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:52:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7322CF294
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DBCB31EDD6E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027C43ED5DF;
	Thu, 19 Mar 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoeUcZsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279B3E9F7C;
	Thu, 19 Mar 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938417; cv=none; b=l7Ute2w4aY1A6GWmNaDvtBUwcGWpm5WoyfV3O+jab4EIeKsXdM0mp74CU3CyxAAmFUYt46784mpadWHW1MmVCC6L5U+44vo6s1kx9/6ssEklKszUNaGyLJ43APg7UnwZ3LQjzi+Z3HbIkNHhj5E4H8pq68cbNGJ8+egAE+GAzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938417; c=relaxed/simple;
	bh=MV5BNbwXvaI0ASYw7Q+3gYMQsNYfca7q3AJDNfPoJwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A4b+eAQQQMGZ0+aItcTRd6F6MGJ77wmCW8K1Kn1diCAsttwVBWgv2e2O/TSTJDhPgmZzbiiJ7Xe9u3c7buj2lC+uEuc3dQOka+rjphmQiKrQjvoCIH/EQMugXW/+b0bwQNzI+/AsgIUnmtkSIOdeYa+v7TP+0nvLID/rziuqh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoeUcZsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C399C19424;
	Thu, 19 Mar 2026 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938417;
	bh=MV5BNbwXvaI0ASYw7Q+3gYMQsNYfca7q3AJDNfPoJwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FoeUcZspymLy3BPQxW5zhI2wPipAdF5nVTRm6kpvVxXUWCQPX5IQZHTHWvR/PqHR6
	 1wSw8jGCwXqxcIACAoUBN68ONf8SnSFinJWt/1hKu0/uHPXOaNB8q4FG3xv+/730oi
	 1w48mjmBSK5USZvdeznaGWbeM59Dij6XJoUckmfem9wBtSWrdTMA3bQ5Fp0+FHHGh5
	 c0DmYMR3mxdkubi9cesvy5F35V7Dn2nFnK6adFsUuRdb3WeepZc1U/aJAmrcQwelP6
	 iCsoVYB7gyeUnRpIxw1Sb21MgnhIZX+/p/IajaUppTQvq9d6JIF4WLZKmI0sL2UnvB
	 kwFGtg2cLzgIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE85380692A;
	Thu, 19 Mar 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] icmp: fix NULL pointer dereference in
 icmp_tag_validation()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177393840804.1701817.18293524741667806586.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 16:40:08 +0000
References: <20260318130558.1050247-4-bestswngs@gmail.com>
In-Reply-To: <20260318130558.1050247-4-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xmei5@asu.edu
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269547-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C7322CF294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 21:06:01 +0800 you wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> icmp_tag_validation() unconditionally dereferences the result of
> rcu_dereference(inet_protos[proto]) without checking for NULL.
> The inet_protos[] array is sparse -- only about 15 of 256 protocol
> numbers have registered handlers. When ip_no_pmtu_disc is set to 3
> (hardened PMTU mode) and the kernel receives an ICMP Fragmentation
> Needed error with a quoted inner IP header containing an unregistered
> protocol number, the NULL dereference causes a kernel panic in
> softirq context.
> 
> [...]

Here is the summary with links:
  - [net] icmp: fix NULL pointer dereference in icmp_tag_validation()
    https://git.kernel.org/netdev/net/c/614aefe56af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



