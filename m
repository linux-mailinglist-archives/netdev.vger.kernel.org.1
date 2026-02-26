Return-Path: <netdev+bounces-261171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLKRDLXAn2lOdgQAu9opvQ
	(envelope-from <netdev+bounces-261171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:40:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD731A0A14
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BCFA305364E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B63876CD;
	Thu, 26 Feb 2026 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc4BcOcm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5723876C3
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077200; cv=none; b=Q9S8F2FyVSTWJvVpJm60ML+1C92dDQgoEgpK8n5IXISe21YsMIdpwCJSBe64BHpjDmqBD8bhZogrBgYIkYVjUoZhmtW1cWJOIkVodUWJGHWF6Ja7KYODqCJgzoMncfq3i+Jdwn3MGeSCEtkWAv1d3I09yBRSfIvDqm7aCECKh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077200; c=relaxed/simple;
	bh=Y7oXXIopA0Ah1mNVdAxGUupx5yX6wl8SdgLgl0J+zTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M6shPdUTy98DNl8NoRCxVnE8b0ZycvSa7NAiXGG0zvLAlsX+mGAllzfK1b6jlpsFSuKF3OVyH1apNU5v8ZPs68mmzydBtUFwbmglZ5QBqKiYiY+ccB3xxfvUI2HbUS2etlpqLhHOn5acCz0hHJ21gyXuVCQU/wOo814x6wSFe/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc4BcOcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F38C116C6;
	Thu, 26 Feb 2026 03:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772077200;
	bh=Y7oXXIopA0Ah1mNVdAxGUupx5yX6wl8SdgLgl0J+zTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uc4BcOcmoXDXxjVclXdYj+eqCONhUWBbsf0aSEv/5ui5MBcVKPsDAiyCMgBeyGl5a
	 FbXKOs3db9Ohx+U7cHH32uEM67OpDxfBmyj4wdIpy9YDcZc0o9glNGc/p8XhLYkgIt
	 bL+cyMj5fA+sPpWTySrSN9Akz07CCFP+euLzjjwhVa8YdJzhFZZ5jxPf4Fa7vkd1Ap
	 IIAWEcz0YDXAEsmqJrUz0j1gIdDrYThFS6THjl8NoV5swEiq95uo3+nS0aMykjxf/I
	 pF6uuE2vDIzE7t5N5mLOnEjVx9mySVlJmWaWMMXgZI2YnLyTc6fdjuKnil60St25jc
	 sn93q9NHjAS0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD98380A94B;
	Thu, 26 Feb 2026 03:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v20 net] net: pppoe: avoid zero-length arrays in struct
 pppoe_hdr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207720504.1025014.10601666751150279207.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:40:05 +0000
References: <20260224155030.106918-1-ericwouds@gmail.com>
In-Reply-To: <20260224155030.106918-1-ericwouds@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: mostrows@earthlink.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, fw@strlen.de, razor@blackwall.org, kees@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,strlen.de,blackwall.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261171-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CD731A0A14
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 16:50:30 +0100 you wrote:
> Jakub Kicinski suggested following patch:
> 
> W=1 C=1 GCC build gives us:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
> ../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
> ../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
> 153:29: warning: array of flexible structures
> 
> [...]

Here is the summary with links:
  - [v20,net] net: pppoe: avoid zero-length arrays in struct pppoe_hdr
    https://git.kernel.org/netdev/net-next/c/7717fbb14028

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



