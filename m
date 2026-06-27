Return-Path: <netdev+bounces-302290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E3j0JBAsP2q/PgkAu9opvQ
	(envelope-from <netdev+bounces-302290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:49:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0496D0BBA
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:49:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OaS4COb9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302290-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B06302FA96
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4C223702;
	Sat, 27 Jun 2026 01:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4F3C2D;
	Sat, 27 Jun 2026 01:48:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524939; cv=none; b=Z3CZ2wHiDDaHqWVRoaliDceuxVccgNv118xRcfRulYh0hu0n3T9ZUgW2VuOxvz3pFOtEqry31dQGZHvTV4VyTTXerQH88atR83euqwOHUJXtjyggF3wKEU98F4wpr4kvpySFfXLMxSNOnfvK2sp+OdbsTHF2oOu+R+WvWboeTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524939; c=relaxed/simple;
	bh=tY+lEB1fVZf6CWjOO86JALvtnSr8NyG046MrlCmuTqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQJKYLHPE2TPTnjunSw13T1IghqCl3E6G3WMNX0nG1/QWZoHU5t77H6atLTeUoewfYv/LNQxZ2CspNY6Qf08pe5l9KpWckvf0gwIqRnCXA0N1CwBPa4SYiOSuP/VakTbNGts8FL8h6t0Ho26dPxsy12DbXfYrsxIXxPcQiR2A1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaS4COb9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0D11F000E9;
	Sat, 27 Jun 2026 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782524937;
	bh=qGuvAgmfPhtioQ+ccOiVR0g2fE1Chcr4teyYLHHEAjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OaS4COb9c2t10ErVf8Tloketd8CgUu2/Y3/SqXTbI3O0dTQVjM6lE6i1+nARWiduR
	 iadyrQumdNWzqc+o+TibehYZbLftw3+wB17uPWCfAc74OTk7kPbyrnXUzomw782r1z
	 V7E+ICyFOpInt2rBUfMqgsMOzToS3sUdQBcDQCZgja1Gts8j8/dplhRGJuphWAqeeb
	 d5yNfstggVSQeRnRyQsOmfZRon057ciZdvMMETHWyzkumpa6onSqWB1UOLqSxLSjVe
	 LJ8tUrb0peIBnIRRG6ZhV3HJiIXC+PvjmVr4Z4urZ+dYTPUwzaDG7pANGFL3I1yCjp
	 IXE0v3inrWBtg==
Date: Fri, 26 Jun 2026 18:48:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] netdevsim: fix use-after-free in nsim_create and
 __nsim_dev_port_del
Message-ID: <20260626184856.4b7f5228@kernel.org>
In-Reply-To: <20260623144447.255326-1-hrushirajg23@gmail.com>
References: <20260623144447.255326-1-hrushirajg23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hrushirajg23@gmail.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6c25f4750230faf70be9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA0496D0BBA

On Tue, 23 Jun 2026 20:14:47 +0530 Hrushiraj Gandhi wrote:
> Fix both paths by calling debugfs_remove_recursive() on the port's
> ddir before every free_netdev() call. The subsequent
> nsim_dev_port_debugfs_exit() calls become harmless no-ops since ddir is
> set to NULL.

Looks like the wrong fix. All features clean up after themselves with
the exception of ethtool. Save the ethtool ddir and remove just that
one. This will align with how the other features behave.
-- 
pw-bot: cr

