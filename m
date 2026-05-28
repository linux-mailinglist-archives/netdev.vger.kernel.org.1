Return-Path: <netdev+bounces-292704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zeWGJ+ZNGGpMiwgAu9opvQ
	(envelope-from <netdev+bounces-292704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFE5F381A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C8F3041A0D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC92D978C;
	Thu, 28 May 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KSo4J3xP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C4262D0B;
	Thu, 28 May 2026 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977153; cv=none; b=exYLaSd841dx9G60wv8DmfQXLLDAlB76HRdspgEwLw+3C4iNv/0RbFYvpbGnBZ/K9QHyH3wO3Gui3UmngGrsWvVeIc0iTwKQ//HQgOdNJy4ucRpYeYRooyh4BJ+mHdNphTRHYz8u//KheA+MiEUeVUFk23xYJAQBiKpUu92KWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977153; c=relaxed/simple;
	bh=2B+LiktD1pa0YGhkxFn2PP8pHb5/sG7H1Di7+KweH+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkAWARCuusOO9Gsj2Uj8J+g0mQy1G73xZirGnGWR1uGRLZaeGw6DcTjG4sNjin5XzO17iZdj19rXiTNrMY64cb4MqLH4qT1UFtl0FHMWyxViDo31I+7ORhhRTawwGUOP8yhJ0kVrFtTDdbbs/ydMihB+zF/EclcVZOotK8h0r1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KSo4J3xP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iKxZKPqxsH5uo4pqIkZVW6G4qdRbJWxX6X8Pa63Xnvo=; b=KSo4J3xP9z2BKQp2YtD8YreOy7
	JeSCicIOC7tMqDe2DyJ3gZuNqZ+BYMq7UwyFX1esBs4k+0kK0zYAYY/CvIi+v9yk6nIIZnpLJvaHo
	ubs6YYSQlYKT8rFh1GgejQPf1VML8a4GuDCXZGIBDFf3OYYn12/cSaMYmzMqTXOA7Uk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSbMc-004uKm-0g; Thu, 28 May 2026 16:05:34 +0200
Date: Thu, 28 May 2026 16:05:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Regus, Ciprian" <Ciprian.Regus@analog.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Message-ID: <91ff1b03-d5db-473a-9292-335022a646c5@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
 <0aaa9a58-fac1-4de7-90f0-443db37228c8@lunn.ch>
 <72c3a9a8040e4b8990f217d4072872de@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c3a9a8040e4b8990f217d4072872de@analog.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292704-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 27CFE5F381A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Does the standard say anything about this? It seems like something
> > which could be moved into the core.
> 
> The comment is a mistake on my part, as it doesn't clearly describe why we
> have to pad the skb. It's a case of a MAC device which doesn't pad a frame to
> a minimum size when the host wants to transmit less than 64 bytes. I'll update
> it in v3 to say:
> 
> /* The MAC doesn't automatically pad the frame to a 64 byte minimum size in
>  * case the host sent a shorter skb, so we have to do it in the driver. The FCS
>  * will be added by the MAC.
>  */

Just an FYI: the 64 bytes includes the FCS. So if the MAC is adding
the FCS, you should pad to 60, not 64.

> As for what the OA TC6 standard says, this is the relevant section
> (7.3 - Data Transaction Protocol for Ethernet Frames)
> 
> "Ethernet frames are typically transferred from the SPI host to the MAC-PHY without
> any padding or frame check sequence (FCS). The MAC will automatically pad the Ethernet
> frame to the minimum frame size of 64 bytes and append a computed FCS. However, the
> Ethernet specification allows for the SPI host to optionally perform the frame padding and
> FCS computation prior to transfer to the MAC-PHY. Similarly, the MAC-PHY will typically
> strip the FCS from received Ethernet frames prior to transfer to the SPI host. However,
> the Ethernet specification allows the option for the Ethernet frame to be transferred to the
> MAC client with the FCS.
> 
> The IEEE Ethernet standard [2] defines the behavior of the MAC and therefore is beyond
> the scope of this specification. As a result, support for allowing the SPI host to perform frame
> padding and FCS computation, or passing the FCS to the SPI host is optional. When supported,
> the method for configuring the MAC-PHY to enable these modes of frame transfer is
> implementation specific."
> 
> As I understand, from the TC6 standard point of view, the padding and FCS offload is optional.
> So, I think this shouldn't go into the core. 

Thanks for the quotes from the standard. I personally think this was a
bad decision by the authors of the standard, leaving it ambiguous.

In the end, putting it in the driver seems like a good first
approach. Maybe as we get more devices following the standard, we see
it is common to need padding, and we move it into the core controlled
by a quirk. But that can come later.

   Andrew

