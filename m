Return-Path: <netdev+bounces-298272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m02wEwv6Kmp00QMAu9opvQ
	(envelope-from <netdev+bounces-298272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:10:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93405674539
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="VsTtew/1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298272-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769C235460FA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98824BCAC9;
	Thu, 11 Jun 2026 17:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D614BCADF;
	Thu, 11 Jun 2026 17:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200701; cv=none; b=gg1FH41265oU8fQh8u4arq/CAYCCiEtGGCSuqy55IM1f+n3LFeNTA9a9OaOUSHeWbYdSQ37mHAaOoU1YDDq7Dynl2vOZKVkB9SIAMGF+Paka5Il4dJXYnAfJgmGeNqwKX0uvldULFI39puh5jnDo8kaPjZLzz7Ft7SK3ru4UxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200701; c=relaxed/simple;
	bh=SbCfoXT3sO39K9UJu/jBoWwPE3dZy1Z5QCBZ6cTDriQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8o5gPb/CUMTY6cjuZmvLJ/IfU76dW34rBqNUA3QwwaRI0olhwjjaSwQbvXfYqvwBVO4HN+b+iwURYZ9ujJ+9rv6LIKG2zqVzG1flH/hmnpF13KO1y3hbCSJy3Emk66dqu86PbTtQMDQ3JUoXEidi2g7eBa7Lldt0tGbgRApX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsTtew/1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8621F00893;
	Thu, 11 Jun 2026 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200700;
	bh=Q4hb/jEOmarujMO7ucxZSbYZcGK1M1TjtG2sdKUQk8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VsTtew/1D56T9hY9YrJcud5hCmRiEkVaqXWaepdJDvwsoJnfmxAuSwlmmr/PLujSM
	 klBkOITqjV+CORgqQ0fYnA4Wq3/eaH5NVmzdHTB8O5NpeT02PMWwOiHyUi+j3UyKhW
	 uvHIWYin+eUGZPrr1OLh6YGIfgUQyMs/1+ipxYWxa6ClnAMULebPHwvytV8MA6ca1K
	 04vmBvnfcIu+fCcSDLZ+KlhqoX7FCjLso5DVKQvqPIITdo3SPzLst90DF/r4ajuChV
	 XOJtK66YqQkjgPxQgFtso7mzfNsHiTxU1DG/KiaNuspzVQoYGIEG9f0jf9eQIU96XC
	 8c0/o04o5z8WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199E43930F87;
	Thu, 11 Jun 2026 17:58:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-28
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069763.286318.14177936524394824410.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:17 +0000
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
In-Reply-To: <20260528131839.462344-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298272-lists,netdev=lfdr.de,bluetooth];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93405674539

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 09:18:39 -0400 you wrote:
> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
> 
>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-28
    https://git.kernel.org/bluetooth/bluetooth-next/c/2412591cfe66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



