Return-Path: <netdev+bounces-298410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lQ0HEMZPK2rf6QMAu9opvQ
	(envelope-from <netdev+bounces-298410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:16:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A7675E52
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TU4WZbZh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298410-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3984A329C6B4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E5232395;
	Fri, 12 Jun 2026 00:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF61E5724;
	Fri, 12 Jun 2026 00:16:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223361; cv=none; b=NzpZD4rnNgZNJkwJt3gfGPX/UT4COX78itvU5+8RyRDNBSN88A1niY0CSY4jNCCbvmZY8V9/DgBt15ELy1h5CQWJWOn9jjQtQiMsGAAFOikuzoWpeafruAGwG4paWbLNQF00dngZ1cB7BjaQgjQkGOXTom3DQ1HqExGJLv5ISko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223361; c=relaxed/simple;
	bh=trPl9E/NPOcIiL9fnNtUJ6Qojjjrc0W8ccKb6LqsizI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifu+TUbHt6If5+rK/tglNLHsWCCu9fn7FpJEVcj6MkhhsrMBh27RHbacbhDwCcUp9Z6JJIBgm66yEh/JMjLCVHUNhJU7HejZu+alIsROLRh9EXhqCWWpGe6j7tYKiF7SxsehR+iRRWPObDL8763356Y2qd1g7yBw285gJ1ZA5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU4WZbZh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BC1F000E9;
	Fri, 12 Jun 2026 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223360;
	bh=knIMGB9uT3vqgP2ooIIsZTSTNdIsZh95XjgznEq18uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TU4WZbZhjKH5pttXmE+QJ1fkcv2E53JkUtMgctLXcR1vayDfw8Vt2HaIXXGpwyNZv
	 oeS+gR98y0txB1vAPRNcOqw1LsKMjZyVTIOJsKiQLn4SgmVXU0ec92WgE4Fa2+xgWg
	 ogBwDxaaBSmwSJBZ9A0pMs/P90FgBbohygF65qkhnk7wChZctHxo+h1tdpNMG19Tta
	 Po6FB1BNyYHmDX8v5+KbctQsEn7g/hCDeiJu8gVsm6Ep/8V6LgOswpDtfWNgZsgnoU
	 YpBZdLuZKWTlgKXmI+VbAAhHbjcVbMdHsSqSTIWwHA4C4mR6OP2zY9dGmPoPn7dPwM
	 1YaLl9oEu+itQ==
Date: Thu, 11 Jun 2026 17:15:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-06-10
Message-ID: <20260611171559.5219cce9@kernel.org>
In-Reply-To: <20260610180050.419401-1-luiz.dentz@gmail.com>
References: <20260610180050.419401-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298410-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:davem@davemloft.net,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 402A7675E52

On Wed, 10 Jun 2026 14:00:50 -0400 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - hci_core: Fix UAF in hci_unregister_dev()
>  - hci_event: fix simultaneous discovery stuck in FINDING
>  - hci: validate codec capability element length
>  - eir: Fix stack OOB write when prepending the Flags AD
>  - L2CAP: Fix UAF in channel timeout by holding conn ref
>  - btusb: fix use-after-free on registration failure
>  - btusb: fix use-after-free on marvell probe failure
>  - btusb: fix wakeup source leak on probe failure
>  - btusb: fix wakeup irq devres lifetime
>  - btmtk: fix URB leak in alloc_mtk_intr_urb error path
>  - vhci: validate devcoredump state before side effects

Missed the PR :( Sorry about that :(
*iif* you're still rebasing the tree - could you mend the fixes tag?

Commit: 13d7c52acbb8 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
	Fixes tag: Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
	Has these problem(s):
		- Target SHA1 does not exist

