Return-Path: <netdev+bounces-300741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bp6NMn+RNWoQ0AYAu9opvQ
	(envelope-from <netdev+bounces-300741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:59:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7B6A770C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SKA2X3EW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300741-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300741-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F793048578
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E433AD82;
	Fri, 19 Jun 2026 18:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6662F0673
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 18:59:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895548; cv=none; b=ufQ6xeYQrlV9EDvvjwmj1QY5fmBNye3MGW8LEcv+Fms0I1moOUI8txMmNjudjRJFdObLPvLjq/mVmjtDfC6uMub0k/vunJzv61nuI4gEwV5B8kDLLHNOwben1VLhFYGwRh8AkuHzFBNVJA/Vst+onG9gnCFe8/H2gXM74A97DGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895548; c=relaxed/simple;
	bh=3xoc+MgBbsYploLvsc8b8bH6RypGtVgGv8FJBKJAIxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7s8nwdsy+gFngTun72PC7/jQJXkF4GXAjSZx173x0vo9kpBgbuLpp0Z9qcay1gLCGZmDfZ7z9/PmRjN2e539F8q/ugBb+wl1o32KHOqEBr44T8VaJDbqczlBT5jrjb4T/BnJcyLaKwhuKXRvs4+tXQPWKncf34m9/uG8M5zF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKA2X3EW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6499B1F000E9;
	Fri, 19 Jun 2026 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781895547;
	bh=VigYqZblo65nizyYnycHDfJBDmQN4QsVnu3a3OLTcBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SKA2X3EWsck25o+2f/V+052015pnOe+qyVL3ulj3qIaLuVVLXmshYGdzGd14Nzl4k
	 3HG4oyt3Fz1vDRCC9NGurJI7WmFZnUnXt7T5/nFJmAi3fKusyckSBc2W3R6p/up9UL
	 Wlobxz6tvfRB3PRgYSeZQMi6P9x2TQw5npkzxEViV6r9jrNxmJLvG0xLKY0vP+5WO5
	 ZFzLeoFAtCxkAY4p8MKjIXVBzEyaO1swC/ANBx2qbV3qOWJYDJFAootYJtF/iLRUmV
	 eZMAbsUM41mU7gaiRIDTX+pbOKPf3MIGYIsAFuKvfvtbz3DYubP03NEUbicLetCQ4Q
	 +4M49E5eF5XKA==
Date: Fri, 19 Jun 2026 11:59:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, Willem
 de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, Pin-yen Lin
 <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Joshua Washington <joshwash@google.com>, Danny Gonzalez
 <digonzal@google.com>, David Decotigny <decot@google.com>, Brian Vazquez
 <brianvv@google.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
Message-ID: <20260619115905.051eb340@kernel.org>
In-Reply-To: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300741-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sheenamo@google.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:maxyuan@google.com,m:treapking@google.com,m:hramamurthy@google.com,m:joshwash@google.com,m:digonzal@google.com,m:decot@google.com,m:brianvv@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09F7B6A770C

On Fri, 29 May 2026 13:44:48 -0700 Sheena Mohan wrote:
> Hi everyone,
> 
> We are happy to share that Netdev-CI testing on both IDPF (running on
> Google Bare Metal) and GVE (running on Google Virtual Machines) is now
> up and running.
> This NIPA integration work enables executing kselftests against the
> current proposed net-next kernel branch on real hardware.
> 
> Thanks to Danny, Max, and Pin-yen for their contributions!
> 
> The test results and logs are available in:
> 
> IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/results.json
> GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/results.json

Hi Sheena!

The Google runners do not report device info. The results should
contain a "device" object that identifies external components that
may cause regressions (like device FW version), see:
https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system/#device-information
In practice the main use we currently have for it is to auto-categorize
the results as executing on a real driver rather than netdevsim.

