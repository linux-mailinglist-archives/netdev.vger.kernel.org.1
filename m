Return-Path: <netdev+bounces-278487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNMVLVdW3mmsqgkAu9opvQ
	(envelope-from <netdev+bounces-278487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:59:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A043FB8B6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F794301B07C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5D2D4B68;
	Tue, 14 Apr 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAyFU21q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0NDQ9Oz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3D3E557E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178771; cv=none; b=SIO2u1VUYLkOkaWxZAyndnlTJ1hopZ0f0hvTO8bCz+k83mqcT1zUfr6aUqAf3/kmjwNRUol0YXdx6Vf7PV8uCqZo3QgaaFblfg30hWSSTOsNk/rzTi+zYG/WxhMbbTrUL+42By/FV/B9tfUeETLl7j8nAU3VO8ZDjClLRp4Ehro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178771; c=relaxed/simple;
	bh=7X9tywzoKKvv/uqlWgu7yQ8seb3SejYWv0mHteKPSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ/Fcpp8WXg0YirFpOx10YlXjt4KeUJ3pY/MwG+C9Cyp8DYLfWpUOY68StowVj5awdcDNlu/JlIi9tznwAhj1iGT3BvCkSZVS5rm+9F7uGIqGjJtF46hxGxn0FOWYbW3P5qXkVLGthx/AVOJ/waFHwVYk9QSWbsf6UNsp80ZPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAyFU21q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0NDQ9Oz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Apr 2026 16:59:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776178768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvDrVUa9oXDqbbeqIPPo36ipSjVASUQcukEGIMRPilk=;
	b=CAyFU21qHkZDsNQ0UIBMFXY/yB1jPvgTlua0QoGNhYT35tFgD3dkKaWGaPKfz7r2wtCmn0
	etcNRWlH4OP9FxOivBIfd/IMZ7wrJVQmEaW4pph1fiOleEwBHzF5krRcJiQokk7uokoIwX
	ZE6Bzi8Jq9cSkTpGZtmpOZlguDgU7JmhDE0Rky11XbXSCI6Az4n1X1edv+q0AJrz7a23VC
	6X0s6hly0Wc1BykeNcqOAsRCyVCzWx5MbsrKu24FcWr0Y52vZz6wC5UhcnaXVwRogwmiun
	AtfQdH9OTaM5pCQrqmVA6y+jNkmrgkt79LZIYH4+AeA/i+Ns7oiwY825wwPwCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776178768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvDrVUa9oXDqbbeqIPPo36ipSjVASUQcukEGIMRPilk=;
	b=u0NDQ9OzGWKqOVHKs82d/YFQBOdAUCLfDCZ9SbepSqGZz2vc/Rb5DSSK8guLjzW+7JEFIS
	9+EPolMwfE9FjlBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>, Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyuqiabc@gmail.com>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net v2 1/1] net: hsr: avoid learning unknown senders for
 local delivery
Message-ID: <20260414145926.0Lwoa8ca@linutronix.de>
References: <cover.1775056603.git.royenheart@outlook.com>
 <b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com>
 <adYwjxLBBaLY52Wb@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adYwjxLBBaLY52Wb@thinkpad>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54A043FB8B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-08 12:40:15 [+0200], Felix Maurer wrote:
> IMHO, the only real way to prevent excessive resource use on our side is
> to put a limit on these resources. In this case, limit the size of the
> node table (bonus: make that limit configurable as Paolo suggested).

I am slowly catching up. There was no follow-up on this one, right?

> Thanks,
>    Felix

Sebastian

