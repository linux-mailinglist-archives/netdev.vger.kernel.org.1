Return-Path: <netdev+bounces-301838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U7DqNv6SPGo2pggAu9opvQ
	(envelope-from <netdev+bounces-301838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68D6C265F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:31:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RTsbmy4d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301838-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301838-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D063071C82
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891EF358372;
	Thu, 25 Jun 2026 02:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C82F691D
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 02:30:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354629; cv=none; b=IxbxDrTPzdEk+GRIaVJxAnelg3v77aK3gknn9q88u7OONETm9NKn9QZx5C1/1cy/hR7/GDl8posFt3BLFAzoT1L8iP3u/02LMB6BX58DMpOOHZclZ9ENAfhOD1w9+qZLMw4/Kgdriqi5+UZ632EJfeoThSgIVglNeddH/aflZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354629; c=relaxed/simple;
	bh=jAdcmBog2oZWQ6heUMhQhcE5xqlA3K3tnmOG+c2W1QU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Al/DaBP1BLzwQa60cUdZ7NAFidsofPPUCuyQy6rAKjIh9aSidRK7e+iT8TRl6VZgq2WeGZ9y0dhxL4TWy5Vwyx3I7fGiiixAMtWiN6gNuWOTt47ezBebjjzPj1IE6SgyFbDruxw+cSVEzZtJaWDFiqvCcT9u8ncxO6RrP9gMeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTsbmy4d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0161F000E9;
	Thu, 25 Jun 2026 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354627;
	bh=bSWHXY2ZnQTCnMh3fpc+zgMT9G6E1MD5nhSfgDrHqzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RTsbmy4d8boQu7LE9XlE7MtOhu1BiTlsabOsJTtjzQgYMXaeIXiMMIBSTWkhnRGpg
	 czdp4F8nQzTy8ZRJ0d9ipTr/MUfvHizpbtR3HWWb3pzkphp7I40BtQ6yPYWRE3oeJI
	 83uhrAUVwCmale9z/vXOT15DAKp/o/2je/6I09d98h+Pw7xjatLPJKa1G2ot5KjvPI
	 cVkI6uHwjuWlao4ViwPhapI0t32D0LpSKd/zSMdEP6xH5avT9JTK0KFsb7vUx0GqDv
	 VB6I0/4wLJVyNguVdjkAwd2PBY4waQbSk1+FuSi4qoPiP53jO8JyWQoeD9Wc9XXZsT
	 5Py16wykebCCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568053AAA6DE;
	Thu, 25 Jun 2026 02:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tcp-ao: fix use-after-free of key in del_async path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235461606.3088510.4275525574137419614.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:30:16 +0000
References: <20260623015208.1191687-1-eilaimemedsnaimel@gmail.com>
In-Reply-To: <20260623015208.1191687-1-eilaimemedsnaimel@gmail.com>
To: HanQuan <eilaimemedsnaimel@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301838-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:eilaimemedsnaimel@gmail.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B68D6C265F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 01:52:08 +0000 you wrote:
> In tcp_ao_delete_key(), the del_async path skips the current_key
> and rnext_key validity checks present in the synchronous path,
> assuming these pointers are always NULL on LISTEN sockets.  However,
> if a key was added with set_current=1/set_rnext=1 while the socket
> was in CLOSE state, current_key and rnext_key will be non-NULL
> after listen() transitions the socket to LISTEN.
> 
> [...]

Here is the summary with links:
  - net/tcp-ao: fix use-after-free of key in del_async path
    https://git.kernel.org/netdev/net/c/5ba9950bc907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



