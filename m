Return-Path: <netdev+bounces-305501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O93zJfwVTWpYuwEAu9opvQ
	(envelope-from <netdev+bounces-305501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3E71D01E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=f1yfOviH;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305501-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305501-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C2C31AB740
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D7429825;
	Tue,  7 Jul 2026 14:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5080425CC6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434769; cv=none; b=tuY71WW8iJzNEBGEg+tFD8oE6G1RbEbZeB6N8BsxVtNWYX9js4Fq7MnUOkvwFPetxdhHGe8wzcHglHNDZ3rDWtDYVxVNbBl5qbwWm3GbxWik315QvbS7Ipy6R4AxNnBaSYn1QODU6/hANfS2F2fgEdVVqOKXQrlD2hyViA+N7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434769; c=relaxed/simple;
	bh=R+h+d1pBH7j+suspTHLN7nSmJ1rrO7a8PG4g0rBbZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8ajO45/sSLfnQRoxz4KfqQs9KFnnfQrnksONah2C2m90uV3BIMVHEM1+YaNhWmnwtYFF3Br6mT4WRzxkYEq+LYM/lVOHYZvD7qP14nMVeIHoj2ORSFbw+LPBu5jG3Z7DFcjum46NbyaQUvInMChd+vZlN7XJv/TRS8cJ2p8p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=f1yfOviH; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 399A760194;
	Tue,  7 Jul 2026 16:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783434765;
	bh=1jdaldTNEf92jtFvTk6vxq/9JGpSlITwrFemYyFuldE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1yfOviHmXbFuKPOQPXZaIzLWnHoZMDD9HJm0fDUSyvyZE4F9UxSgaPhD47dKXhah
	 ws7auEx2rQau+ZJHDMYqdTyDnaG3X8KwvpJzmL23VLcmq5O2UAxlwV6tEcKGcPUdPJ
	 3SdC+B4ZlHxmE4RUxTrwvzfJ1LwsjcErOQAS0bQ5T9R0dUCocvnuaRtLoHmuykMa1A
	 KPBSmtfVWKFsKroPXUZsfuOmjB59S3zH1LM4CGZzA00/S2lrk2op0+7/2yczcXaDrK
	 gfYw7M5JrZo+jHSVjjyGsWdutfXEeaVfpTAtoHlsRPafj1q+6KoMto6Jb+Hhjdl/g4
	 H7WIOvXptrOHA==
Date: Tue, 7 Jul 2026 16:32:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] gtp: parse extension headers before reading inner
 protocol
Message-ID: <ak0OCusCIcf0DH7y@chamomile>
References: <20260703093708.18141-1-running910@gmail.com>
 <akefPJ5cCrsZcpRw@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akefPJ5cCrsZcpRw@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:running910@gmail.com,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305501-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:from_mime,netfilter.org:email,netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8C3E71D01E

On Fri, Jul 03, 2026 at 01:38:39PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Jul 03, 2026 at 05:37:08PM +0800, Zhixing Chen wrote:
> > GTPv1-U packets may carry a chain of extension headers before the inner
> > IP packet. The receive path already parses and skips these extension
> > headers, but it currently reads the inner protocol before doing so.
> > 
> > As a result, the first extension header byte is interpreted as the inner
> > IP version. Packets with extension headers are then dropped before PDP
> > lookup.
> > 
> > Parse the extension header chain before calling gtp_inner_proto(), so the
> > inner protocol is read from the actual inner IP header.
> > 
> > Fixes: c75fc0b9e5be ("gtp: identify tunnel via GTP device + GTP version + TEID + family")
> > Signed-off-by: Zhixing Chen <running910@gmail.com>
> 
> Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Patch is not good, it needs to refetch gtp header after
pskb_may_pull().

