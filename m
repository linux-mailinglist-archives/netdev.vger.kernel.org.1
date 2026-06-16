Return-Path: <netdev+bounces-299676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id edGFFwSYMGpUUwUAu9opvQ
	(envelope-from <netdev+bounces-299676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A807668AEA9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:25:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YD2garaE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299676-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299676-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5528D306B7B8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D723AB88;
	Tue, 16 Jun 2026 00:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF027707;
	Tue, 16 Jun 2026 00:25:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569537; cv=none; b=VdRFxLAsavt0G/4QCOUjESNNjpNoS7Ilsbti56hvUGIzBC+nGXCwEmKBF4Y5uQG1yhy5WafmwhZ3wzODqZ3sg3ZHPvD6NijkU3nNMpyLq+BsuGg7EJtrt9J5eO23SuE0TaaD0MTjgPdMTm69rtyWGz4HUosf3KA5Dda3H9fQ9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569537; c=relaxed/simple;
	bh=CWFSTFYTiBH76MJ3gjOj6t9+K4Ep3BVEdPwrbvarmng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH9VVYKrKTMPV6K6UEZpQnkjUn6WNKkpsxLyvT/j6sNrjwEsJFJRB5zHezzyhwRVqLVyoN55TjVYNTN2Tw0qXPkslziiTkP8LOT6CZXLJzVTnibq2j+sGV8uI3iaXFgYgfLgiGOze3KzBdTAM5ZHEh0vDMaR4TGjvNjzfuHq6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD2garaE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D211F000E9;
	Tue, 16 Jun 2026 00:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569536;
	bh=hH9/51g//fMBZa4WquaIwRZMdG5lN0iHPMy6YWWkEkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YD2garaEL559AP5FR7kdfCzIspY2D6tCIEctRlILjopg10F0/GTT+kDRVQgKPNi4i
	 jOlOMhi15o646GxtKpw9p7pQgqrnlLwIHsb0IMt+9MGV0PBbZzUNCiRmRInpXpfJ2u
	 /Qev49XJSvZwsrO6EVbpH64sHbbEkzDu/NlfrK+nMzqJUuLfKYdFKj6cyaigGrIdax
	 RSPiK5jWhzmxwddBDsu69spWt5R4BnX4+emEvw5PAZXMADovD0nxMIdor0Xkxcy9mV
	 rI5Ic367l98uI0FcSWn7K98eh/GbqGxjvPq3W8SZmWVnQrOLS4Hwxsi+DqaGMbjuaO
	 e3v3HJXZKXDSw==
Date: Mon, 15 Jun 2026 17:25:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luigi Rizzo <lrizzo@google.com>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 willemb@google.com, kuniyu@google.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <20260615172535.080cf94f@kernel.org>
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299676-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,arm.com,google.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A807668AEA9

On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> especially with greedy senders, this has a high chance of happening in
> the softirq handler for tx network interrupts, creating a significant
> performance bottleneck.

What's the use case? I associate swiotlb with debug / testing mostly,
so it'd be useful for people like me to explain why you care.

BTW net-next is closed: https://netdev.bots.linux.dev/net-next.html

