Return-Path: <netdev+bounces-306628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tXM0KkMfUWp2/gIAu9opvQ
	(envelope-from <netdev+bounces-306628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:35:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272273C9B4
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:35:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=f31374gC;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306628-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306628-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7776530066BF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1932368D5B;
	Fri, 10 Jul 2026 16:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5C26F293;
	Fri, 10 Jul 2026 16:35:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701310; cv=none; b=n6SIK0QYDpk7Ri+9vFNLSyARLE2rBU/4kk6/mMQjQhNv9ngm7RZn04AiTQy0vXNs9boZCL7KgDIazDc+vpM6bOhZErlYyaJu76wnalxlYZ9RGXIVb3lyQdCGHWfVvP3ubobKjXKK0mqbe/0WCX3RORyeLrZqaaE0ZUz73kHw/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701310; c=relaxed/simple;
	bh=QRl5+SWRonZygH8EGrKKbgj5UpBB1S6mijDUwycD9vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrM7CJBvvvjMLv0Fn56RmGra9SdeHGDUHPKdUiTlh4iqLirtRUO0QSXr8C2QaceqZPTQ+RDXpLKt56CqVZ5yuOyVnHy+tesFBAfD4qdSY/+MWMNveX4OewTmNOY5rqs0Memfh/gKmtv66Pj/AO37yU82+t2sLGFm+VnOyecOC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f31374gC; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mKoA++2FvpRfbjJH0g7fyztWo+KTteketPfqtWfa26U=; b=f31374gCPEiuOGhG/A6F8DXIz0
	z2Jzji9FI6+p8VuCbTHThMZlUrQcMYPVmc4AtoOcHeLZUSJXPjdHZ4wT6GBUkNSqY6l9ymWgcQ+30
	zlk5RJq2tqF+lXPhZsQE8a/PRUa45+ltdYlq2oRObwkWDIFNsoC+IL2GzdYNB2hlO+UU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEBf-00BfWs-LQ; Fri, 10 Jul 2026 18:34:51 +0200
Date: Fri, 10 Jul 2026 18:34:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
	tung.quang.nguyen@est.tech, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
Message-ID: <3ec7b01a-270a-4b57-af9e-bdbf85313da2@lunn.ch>
References: <20260709211649.15623-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709211649.15623-1-blbllhy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:tung.quang.nguyen@est.tech,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306628-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2272273C9B4

On Thu, Jul 09, 2026 at 05:16:49PM -0400, Cen Zhang (Microsoft) wrote:
> Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
> MTU values but only enforce a minimum bound, not a maximum.

I don't know the tipc code at all..

Can this be piped through netif_set_mtu()? It will call
dev_validate_mtu() which will validate the MTU against dev->min_mtu
and dev->max_mtu.

    Andrew

