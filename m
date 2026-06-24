Return-Path: <netdev+bounces-301592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HbMVFZWlO2opawgAu9opvQ
	(envelope-from <netdev+bounces-301592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:38:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA246BCFEA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:38:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="l8/hAtVJ";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=EDm9TOMF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301592-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B601301AA56
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B93B6363;
	Wed, 24 Jun 2026 09:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAA3A6F06;
	Wed, 24 Jun 2026 09:32:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293549; cv=none; b=i8MvXLg/5hA2fHTbVtazv0L9zU0TGRUv9A3FD5VVOPp6zKqPvvVZ5NphpsZiEjOe1aMZHvnHyYUyYa+g8n1wvh+3AKariXXVwrb6T9vnj0kNA/IXaPduJRoDYl0SII3l3S/uSA/tR/wOnQlpTR/7E+KmlnFAbxJurE0WkOl4Aa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293549; c=relaxed/simple;
	bh=sMm9upJlaJsbNbTO7Jo3M02LCg88L0kl6E3/iAO3n9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjKllwJGkXr8TfSBAt+BtawNL6oPGF5nTlb+uasExdxYmyvTBdhe+TYr6uIUpyF7wnbwGZAtV3Ky8EokUhWT8/E7DiRxMDIaKEVfpZCwmA3mLCnc8/JRv5LTm3BOGA7PWsR6jJnaZW6t6eC8VmOY+bPi/RzYvf+r2a7PoMqfwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8/hAtVJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDm9TOMF; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 24 Jun 2026 11:32:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782293540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMm9upJlaJsbNbTO7Jo3M02LCg88L0kl6E3/iAO3n9U=;
	b=l8/hAtVJaTldoYHTcaHokyZaSvdPmG4eThHWPjl4rJmLwkHrkD9hl5hww0LZkd+yVyheM+
	PLjxhVOUfuwIhsFRWXE6DwzGxCwYN/e5V5YODq89XR/NlXQxRBD0a/vr420kGrJfflAsY+
	gWN9WOhkoYyDVw+lQcaUfXEYCgJbQqg0STpjIh8oMuB42uOxMr254iRUey7+zmqZjydaOR
	vurYiudtRlvkCm/E5Wbu7+2qIgFJDrOMLPqCCItwh+TZUubQ2U1EP3vOi76ukcqne6RhMW
	X97e3CrtwICX8+FRdx3YATMXNrZMZvU+TwKmHPH5pgIOcFJK48LhDPq+bKkJIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782293540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMm9upJlaJsbNbTO7Jo3M02LCg88L0kl6E3/iAO3n9U=;
	b=EDm9TOMFjOMDYcbqSQ2UeP+xhE99vKDl2Cq3gweAT6k0ntTJAj26J0nxcT0CsM6VpB7PfF
	Giecms/1+WadleAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
Message-ID: <20260624093218.G7t8fj4a@linutronix.de>
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
 <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
 <20260618150440.cLDwgyDM@linutronix.de>
 <3a4ba3da-47ee-4da7-b0da-af500ff1a369@windriver.com>
 <20260618155337._cxJpvd0@linutronix.de>
 <52e2dc9b-45ce-4779-8ca3-b4e022380db6@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <52e2dc9b-45ce-4779-8ca3-b4e022380db6@windriver.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABA246BCFEA

On 2026-06-19 09:15:05 [+0800], Zhou, Yun wrote:
> This is a hardware constraint, not a software design choice.
>=20
=E2=80=A6
> This means request_percpu_irq() is the only valid registration
> method =E2=80=94 a plain request_irq() would fail with -EINVAL because the
> irq descriptor requires IRQ_PER_CPU_DEVID semantics.
=E2=80=A6

> The multi-interrupt approach (like MSI-X NICs) would require the
> hardware to provide multiple distinct interrupt lines per port,
> which this SoC does not have.

I don't question that. There might have been an option route that
interrupt source differently. If it is not the case, then there is not
much you can do. Thank you for the explanation.

> BR,
> Yun

Sebastian

