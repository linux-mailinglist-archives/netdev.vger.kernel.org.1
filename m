Return-Path: <netdev+bounces-296868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDb+D897J2qByAIAu9opvQ
	(envelope-from <netdev+bounces-296868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:34:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20365BDD7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:34:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="nwnbYsC/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296868-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296868-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16953025292
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5682D8DD6;
	Tue,  9 Jun 2026 02:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B209233942
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 02:32:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972362; cv=none; b=iMT026lxhwdIDB43ip6otqslqf0Bzhj79WtvkOgnB23ohfwpogVq1Q53FJ/V0fZh7OW1tD96TdwhzeLd29I5jC3ROoxduJAaM+rOcQbIzNGAN7gQlcOILS/q2KUJAsEya63ptdPPN+1Q/DxCEvcwo5li37u4zZSTHxeQhi3leRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972362; c=relaxed/simple;
	bh=jS2F9Jgzt846e9JgiW+XQlPdCYZNvcDO2LATGN0DKSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOE0qK0NyaBO5MOJ4FUjDUak9Jrv9js8AbFocE7IsmDBRuqtvxJjpoBsneQpPYaiy7Wj5zOo5aTKAhL6AJjiRHsUn6KHxOmbjZxp8FekzU+fluJa/hIBTxiHD/OIpLSydzBKjHUiDIe8JR5WSjSxqfS3ZrulYSZzDiUisegRJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwnbYsC/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9221F00893;
	Tue,  9 Jun 2026 02:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780972361;
	bh=rjTZYyEiFPG9lIFZHtHltObOA2EYCJttfoFzooVqXaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nwnbYsC/rWG3dvWoAVqhz+BuOVBXmNpQQ/+OzNP7IfDXyS3T1x5yW3JznbeyVwXZS
	 gh9XzMMnfhFRb/7ljIf1bwor5DEFkHYBS6haVvyVDWWE1OUjATc+7j5f9WscGEEo4B
	 R67XkpL1W31v2Vpptup7c3e3tVpizlBsR+J+EbyZcPwL64NIf/PDdrLxsieYlm7iFo
	 en86VeOW7jtJt9WLOzfgVVZZxTDstcoZVIhdUjhb0a7hOb41pnBPWNR7VeWww+6b1a
	 ELMJFk6XGDzwP5KaY3bW6hzLAEOfC+Ee2Omv1vyDky+z94lssufFrRA1JLOAQuR+Rh
	 MOkfclrqxbABw==
Date: Mon, 8 Jun 2026 19:32:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH 1/3 net-next v5] ipv4: centralize devconf sysctl
 handling
Message-ID: <20260608193239.5fe7c7d8@kernel.org>
In-Reply-To: <c57b3480-3049-4e1c-8f26-4073a96cfec8@suse.de>
References: <20260607110123.5939-1-fmancera@suse.de>
	<20260608090333.21c94721@kernel.org>
	<c57b3480-3049-4e1c-8f26-4073a96cfec8@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:nicolas.dichtel@6wind.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B20365BDD7

On Mon, 8 Jun 2026 19:41:54 +0200 Fernando Fernandez Mancera wrote:
> On 6/8/26 6:03 PM, Jakub Kicinski wrote:
> > On Sun,  7 Jun 2026 13:01:21 +0200 Fernando Fernandez Mancera wrote:  
> >> The logic for handling IPv4 devconf sysctls is scattered. Notification
> >> and cache flushes are managed in devinet_conf_proc(), while a separate
> >> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
> >> is used for properties that solely require a cache flush.  
> > 
> > Hi Fernando!
> > 
> > Do you have the necessary iproute2 patches pushed out somewhere?
> > I'll pull them in the CI to make sure the test works.
> >   
> 
> Oh sorry, I thought this was using iproute2-next.
> 
> Yes, feel free to find it either here [0] or pick it from [1].
> 
> [0] https://lore.kernel.org/netdev/20260601143242.6729-1-fmancera@suse.de/
> 
> [1] 
> https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fdb064bf64e5df738f5f823a11f315340679d336

Tests pass, thanks!

but ruff check fails with

tools/testing/selftests/net/rtnetlink.py:45: [E722] Do not use bare `except`

There's a specific error cmd()/ip() raises on non-zero return, you can
catch that one.
-- 
pw-bot: cr

