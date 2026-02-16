Return-Path: <netdev+bounces-258922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNJHCu5Ek2kP3AEAu9opvQ
	(envelope-from <netdev+bounces-258922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:25:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808561461D1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133F63028809
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D632A3C0;
	Mon, 16 Feb 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9W+Hhct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwhCZboZ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B1330B23
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258793; cv=none; b=DNiEC7E7bqPR9VpeNQwwsYWdA/1pxrsrFkHjD6GA15qBoBNTQBUj9OD8/dDyx2vtWsVzyb2wRPqcVvzBH8eK7SAprdIKZOWEO8W8nuZ702sgKUHNfnWPafP1v4eNB1cl5rVYzUHJkZ5Et15+ZEbAWUBZFlGw4lTXuMzJvG250uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258793; c=relaxed/simple;
	bh=f4CScdoQc9Du9AAdv3GIpSknPl1HwUyD4MTaWR847Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhDccjV4lQWs0ddqu2+sazdjU/+3tIcmPDpi/z+P+6QioX6KGNT1XsQTImWKphs7YPprfJ6/SZaQSTNf1xTX9MSLwQqywx1a5qF8BwFpuwn35Oeqzw0nGKYs+ppdRajApwjUC+VIkc8Jt3a49/WS9flkR2KrLFmmB0VazmF4VC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9W+Hhct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwhCZboZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Feb 2026 17:19:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771258791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4CScdoQc9Du9AAdv3GIpSknPl1HwUyD4MTaWR847Dc=;
	b=L9W+HhctmzmXp4PiDwGbzmMRsdExGFi17Ez6aXdthVPZ+nK5oIAJq20ixTpmCuG9M/ho2y
	7eQsmA2xRLZh/LTHL4BykLooacnJqAsoH9jFtHqTg9tVcYNExAgSuYnoyMKQ10tSdYi0tJ
	5HWgj7ldjSoD5uqTOALFsGkDtiP5oIHXbLUho/Pmm4J5YyMmDygL3Pc2DxZN3w0MCpxTJd
	/6ZYcVYY/FfVXbxxqBYdJMNbDdi4RWCfd8vGpylOcyKlilmBTMaV5bK8Zeih87zdoySvUp
	PzEe2Na+/1ZhA14fFLbh/qNo+zo8G8VaKov1avk8H3Y/a+RBa8ReaNZQsEAM2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771258791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4CScdoQc9Du9AAdv3GIpSknPl1HwUyD4MTaWR847Dc=;
	b=VwhCZboZfZsUdYtLEE5n0lOFXHrtSvvzdgYCrjpDZajsRh4fruSLKpCnBeOJOavebauokY
	4nZSsxn/QU/yhNAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <20260216161949.hMR3d6iT@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZNBfh81p1zBvbi2@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-258922-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 808561461D1
X-Rspamd-Action: no action

On 2026-02-16 17:10:38 [+0100], Felix Maurer wrote:
> Hi Sebastian,
Hi Felix,

> I had to read quite a bit about PTP and how it's supposed to be handled
> in HSR rings. I've got no experience with PTP in the real world, but
> here we go.

Thank you two. I will re-read the thread tomorrow and get back to both
of you.

Sebastian

