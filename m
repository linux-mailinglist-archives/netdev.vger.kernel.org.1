Return-Path: <netdev+bounces-302354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2GhvIuc+QGpbeAkAu9opvQ
	(envelope-from <netdev+bounces-302354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C116D2B19
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:21:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Pbc/+RNu";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302354-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302354-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7503007F65
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FA237DEBE;
	Sat, 27 Jun 2026 21:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C82DC334;
	Sat, 27 Jun 2026 21:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595267; cv=none; b=SIZWV4Mz1uE9L+wboFg9errPSUBrf6WFZUTPEWpM/vkg30NBom5HtYlM83nPuHKDYaff0jcE/O1Uasv8Ie6cZW2BzP2KsDut6R+OQZsipXa6sZ7XGPvTuxWCneVBzCHMXHhzV0ZkxMenGH6pZDSydq5Q+pBJLSfhG4eJi3xy6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595267; c=relaxed/simple;
	bh=a0XRv66ZKwYN34WisdMWGQz1ku0D/FSqbFEugYyFpHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoOU394pkjMuYtexBwPO3/e28TVRuL/eFWnS94cKvRLJ1m9d5TmA10AECFCe4qszn6K+I3ZoixfZJqgPqZOWs+A9cl9/lVSqj/KwKzeTJzOWTi3Ph6vF0+ytWMlXetZ6iPp5m/oXA0l3J+j3VaZM9XCgfz00TlMLvSvvQ7/p0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pbc/+RNu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6A1F000E9;
	Sat, 27 Jun 2026 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595266;
	bh=OPcHu+8oNdjc0lF6pPKlxAVPxDNMPVc+ktC36owKY6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pbc/+RNumMh7R+a9YiwcaCCSnrhFPRDLNEHOlS6nCNpMdUsFMC6CcRXmKh/VpUGCl
	 +yM4A8CLM8shY/LrZq7DAQPGNTeSHozxTRDdeL4S77xp3pNMZmnz673pQrgqM5M0bS
	 1ZF5w5lq35iV6JTUG9H/jusyfjVT9cT6tyNO2vln6nKJ5YyT/50BI1ZZ+BPk42ovbI
	 sdYbRzAznFUvI2q060mZ8/Z7Md0YsUgJ4DaUZ9w3F+OPUoZ1AbFmccNXaoODjziHT6
	 fQF6Sy8eXfUUdE8aP/Eq0cVQQb4rd735zFzZJ2ZVGr6Yft+dibWX5dlNmh9s5U/QLZ
	 zsSd9b+JIV3kQ==
Date: Sat, 27 Jun 2026 14:21:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, leitao@debian.org, sashal@kernel.org,
 bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [RFC PATCH net-next] netpoll: hold RCU while walking napi_list
Message-ID: <20260627142105.29f1322c@kernel.org>
In-Reply-To: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
References: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302354-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:sashal@kernel.org,m:bigeasy@linutronix.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12C116D2B19

On Sat, 27 Jun 2026 18:12:28 +0800 Runyu Xiao wrote:
> CONFIG_PROVE_RCU_LIST reports the poll_napi() traversal when the helper
> is exercised directly from netpoll_poll_dev(). The current source has
> important lifetime defenses around NAPI deletion and netpoll device
> close, so this is not presented as a proven use-after-free. The issue is
> that the RCU-list reader contract is implicit at the helper boundary.

Please provide the stack trace from the report, rather than just saying
that you can trigger it.
-- 
pw-bot: rfc

