Return-Path: <netdev+bounces-302207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X0OIALOZPmpYIwkAu9opvQ
	(envelope-from <netdev+bounces-302207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C06CE73E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bQDQlJkj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302207-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302207-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E697F3007AFA
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E937B020;
	Fri, 26 Jun 2026 15:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCD37AA83;
	Fri, 26 Jun 2026 15:23:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487417; cv=none; b=RqQ6ucoIIhUEnWRoVAqjsvFWtbIiFoH4ckjANSbeGjx5px/6E0TkhKEXwIPPTxFaaQTaE7LDg9/FOCYqUWP6Q1n+7tbmLWN+2RjovUdssARIdUf6BvXvmNo5hY0Fr/S6mu7vHiHk90+erl3+wMq9FrWjyabeuEZSO55D3cuVOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487417; c=relaxed/simple;
	bh=bmOVwBc7W6hG2k4uI94bIn7gWV6EYU3fzxRLNlMRZq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEjD5lOkrn3KVTU6vfR0RiqU/hhY8m1LPxjNzMEiu3cSXxsA9zO/tb6Oykkx3i5vKTmuE+XwivM7bOYTvgVfTEduFUx8Qomf4whxpjS3SLB4qzUhZwNdZpqWt/VL1IXmnjxUsUUJ8kPrYo4fmm4sxhNj97UPnDbuwZVdHCVsq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQDQlJkj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1A41F000E9;
	Fri, 26 Jun 2026 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782487416;
	bh=bmOVwBc7W6hG2k4uI94bIn7gWV6EYU3fzxRLNlMRZq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQDQlJkjp6johkW7EbQcEFV5PE37jpMgJqZuUtq93ZFNtT39wmWmDmwbtaPL5KByv
	 znz9mfj/t33i/OZloSnl5K8mVR173hmquzqV/NTGefgs2/ZxwnjNyobX+qZCs/yh/p
	 txeYDptuNmRgXfdloDvyRCQJWTROiKO9XyqokBdw5uA8HBYRDWJnJ4Y9VMqd7Ya8Tk
	 bqf33XLb3ujxgvR+g2T/UCdMZheVb8MBZYOn749RZTom6opdsPl3SPWqywTQxVkiIO
	 iqz5Pjkz4wyvrJok+5k0kXopK2wODz9Itw5WSlZVdBqRmxaLcqtwAMX3CspotjX/04
	 Zta7N6BuMqbjw==
Date: Fri, 26 Jun 2026 16:23:32 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, afleming@freescale.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: use of_irq_get()
Message-ID: <20260626152332.GD1310988@horms.kernel.org>
References: <20260624032122.986986-1-rosenp@gmail.com>
 <20260625093630.1173136-1-horms@kernel.org>
 <CAKxU2N__hbPOrPe3JUeTLF6d6+=uN+p5ez78rVg6cnrekkvQPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N__hbPOrPe3JUeTLF6d6+=uN+p5ez78rVg6cnrekkvQPw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-302207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:afleming@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 711C06CE73E

On Thu, Jun 25, 2026 at 05:42:05PM -0700, Rosen Penev wrote:
> On Thu, Jun 25, 2026 at 2:36 AM Simon Horman <horms@kernel.org> wrote:

...

> Meh I'll submit to net-next. This is way too messy to fix for net.

Thanks. Be aware that net-next is currently closed for the merge window.
I expect it will repoen next week.

