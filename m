Return-Path: <netdev+bounces-302356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ChWJOIQ/QGqBeAkAu9opvQ
	(envelope-from <netdev+bounces-302356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:24:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5FE6D2B3A
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:24:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Phyikz3p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302356-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1B53007F5D
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49A349CD6;
	Sat, 27 Jun 2026 21:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7F2DC334
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 21:24:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595458; cv=none; b=S9WznqcRTpWaJHxjRJLnp8v4VW2GcZvK06oSVsZ3Ayg+/4ym6mPpE1QHPM2w4JOGquCaT6qYlZI1SwcgQqmQPPNb6T1dfwFsVrzWqkhE1j4+NuGdeUR/RJq7X1mg7GIfD2LWGSbyovCVcGvX9ia8hF/z70pSvS2ZeiRZCgFAQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595458; c=relaxed/simple;
	bh=JRMHnmhfG3B6xuyQWjwZEprewEM6W3SPcwx8IxbuaCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT4kK8+4a+jfhHcCyNnlaNh79sCeDqTXh+lwtjFjfD+LyAjcjfW0xvUzLKCiZTnGbAlkM7gDQGzblWT3EDrhaM0zgxu5BIG98rePjLTYo9YWQ+t1Eh9CtavgPVuSbfOPx+xlvg2AkTlf/oyidwqBqH9T/SWRvMvbhF0an63zLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phyikz3p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D787F1F000E9;
	Sat, 27 Jun 2026 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595457;
	bh=JRMHnmhfG3B6xuyQWjwZEprewEM6W3SPcwx8IxbuaCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Phyikz3pA74Q5lyDEZnuLRPA8xnBvrPk6KRxU27hLtNKfgClveMG409o6/nZ2419t
	 mTHRO4klxzICVLG47FpZTarp7mQXx+Y8l0zzBJQ6NJu8Sj/ngvlAVQjqxHif1f3q4e
	 7R4CnL1TdI4ApuIeZmfq/Cb/8kacH6S42aR3TWCmhvPTaY0rzezcySxx1TBy/90lku
	 vrHFlTj7KZu6dJyyU5byNDnjyz8hsAAQI+lYj9qJiC9B5oF73LfFkS4cVAdmTeuH5+
	 ziGG4lQ6bIc3c371OyB47P3OLLdyTZHILxHZrytFDt05Uq9G28Wemk8naU9oCT6Lbz
	 uY6y7zdD5NWNw==
Date: Sat, 27 Jun 2026 14:24:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: atharva-potdar <atharvapotdar07@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Francois Romieu <romieu@fr.zoreil.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] r8169: migrate Rx path to page_pool
Message-ID: <20260627142416.249bb17d@kernel.org>
In-Reply-To: <20260627035241.59689-1-atharvapotdar07@gmail.com>
References: <20260627035241.59689-1-atharvapotdar07@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302356-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,fr.zoreil.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:romieu@fr.zoreil.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D5FE6D2B3A

On Sat, 27 Jun 2026 09:22:41 +0530 atharva-potdar wrote:
> Signed-off-by: atharva-potdar <atharvapotdar07@gmail.com>

net-next is closed see the process documentation

Please also spell our name in a more usual way.

