Return-Path: <netdev+bounces-296190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kuz7BIcXJWoCDgIAu9opvQ
	(envelope-from <netdev+bounces-296190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 09:02:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A864EFBE
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 09:02:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=aoGvoJc4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296190-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296190-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B413F3013268
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0901DE8AE;
	Sun,  7 Jun 2026 07:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCD18FC80
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 07:02:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815737; cv=none; b=OJ6TCNZZ47GWWTSkWWxVbb8MDR/lTedXVKBQ33piqjUj2MhvOG2i9cJHM484z7RLFuEpqhBYIFXOzqCt55eABxjwXoZdvyw7ZoB+bPH3d4uSKn3DoVEmpFaxt+53QQ8Sb/b01o4x9UAQP4xUSFbCwfPjvuHPmjbUo3MqAm9udSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815737; c=relaxed/simple;
	bh=HXcVk+J/jC94lJ4r/0go5TopyLFmG8Dt8FnFs9J7yDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXKV1XUYXCTbJega1L06NR2sSKODyKfvrVFRXdstnuFLhx93yVFpkDRxK8fC7ZbbRiu5urUrEdrDp+TycG81WH3Qk+I2Uy4c4rIApZUFwOsOEE7tBGyJcfziqqgloipjWaUmcWH4z4X/ooeFuOWHyQjXkUSRp9LKf+uc0DZJXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aoGvoJc4; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OzshWX62bv6H2iTVYR0A3I8MxYDmhGZ4N9sOLl3B9Ac=; b=aoGvoJc4XZP196V/2MZ3KhxMzS
	JSYyi7HgNSKyO8+Z+wopCzzeGHfMlcZYOt25fkEQM8FH7H+tTc5clwpcQOMxIWdcL+v0NPA1VTuPj
	X/ytJutlxNC3DmgMZpzB6woHMpsKYMfopdE9a8idK+d9WFUGchAWxQ4lJlL1+kZBK61I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wW7WN-006RO9-B5; Sun, 07 Jun 2026 09:02:11 +0200
Date: Sun, 7 Jun 2026 09:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1 01/10] cxgb4: Add T7 register definitions and
 core structures
Message-ID: <e45bc138-f551-496f-9d86-74a48ccdf90a@lunn.ch>
References: <20260607035220.528439-1-bharat@chelsio.com>
 <20260607035220.528439-2-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607035220.528439-2-bharat@chelsio.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296190-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F6A864EFBE

> +/**
> + * t4_os_lock_init - initialize spinlock
> + * @lock: the spinlock
> + */
> +static inline void t4_os_lock_init(spinlock_t *lock)
> +{
> +	spin_lock_init(lock);
> +}

What is the point of this wrapper function. It does nothing.

     Andrew

