Return-Path: <netdev+bounces-292510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCoEIM2aF2qcKwgAu9opvQ
	(envelope-from <netdev+bounces-292510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC85EB8FD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B58305BB41
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0342DF13A;
	Thu, 28 May 2026 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fcf7ulx4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8A2DB780;
	Thu, 28 May 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931823; cv=none; b=Awrz2H+RigaM84tnhFogwOAl73imQPeWmpnHc633H8Qj7zSnBfw32X+exFthtLHJHyLmQPbv9a+8SvY9wKRBuL8uloVGirKYjX36GIUjbfuixp5NyDvndhNLwLc+nWAwuhypDq+Y1oDQTa5Rs63hWFXoWy7Ks6N0zcUiolurI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931823; c=relaxed/simple;
	bh=0fCXW8Uhse/1O5r0kcMFw2l418yqOCKo+aeGu3FfdXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/J/TPUPSKHFAi4VyOQ43sPcZnnRRHBZDB1fkHz2OzGedjy1GtnSjeVXZJYqLq2gGcieIFerdZsXL/pImy48fJNaUolZR0NeAqxHAm9WyIObJ9wVHTdv9rZELTgEgRSslpMvK9V85JgPLpkVJ9p923X+gLGUe1Hh9zNlVK3HjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fcf7ulx4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KXlIrUme6nI5TeSJuUb5HUxvaF4DfiOkDvcubgx5iXM=; b=Fcf7ulx49S3634h4bP50kc9wS1
	UJQ0xQdTbBxYrz3TGVWJuZGZPoSq1NEI7gauP8gur8Qa1xd3PqIBwtw5u5KlVHWNdE6+7/Gue+6oW
	MNQRknas0osuh1ExdTnGQsHGnP150VnGH5Iac4Sy6PMOYMbasQjkZP1Bt9Xs2Zr9U5L4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSPZa-004pzq-VK; Thu, 28 May 2026 03:30:10 +0200
Date: Thu, 28 May 2026 03:30:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/6] net: phy: air_an8801: ensure maximum
 available speed link use
Message-ID: <35d88bd6-49ee-4ad7-848f-3c573c2a7c2d@lunn.ch>
References: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
 <20260526-add-airoha-an8801-support-v5-6-01aea8dee69b@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-add-airoha-an8801-support-v5-6-01aea8dee69b@collabora.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292510-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D8CC85EB8FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:58:11PM +0200, Louis-Alexis Eyraud wrote:
> To ensure that the Airoha AN8801R PHY uses the maximum available link
> speed, an additional register write is needed to configure the function
> mode for either 1G or 100M/10M operation after link detection.
> 
> So, in air_an8801 driver, implement a custom read_status callback, that
> after genphy_read_status determines the link speed, sets the bit 0 of
> the link mode register (REG_LINK_MODE) if the detected speed is 1Gbps,
> or unsets it otherwise.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

