Return-Path: <netdev+bounces-292509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA32LYWaF2qcKwgAu9opvQ
	(envelope-from <netdev+bounces-292509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759F5EB8E4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F23A3049FED
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F727E076;
	Thu, 28 May 2026 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c6HvHKpv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71E233923;
	Thu, 28 May 2026 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931778; cv=none; b=u9diGnlGz43uTfbexJaE7M7YMfGkGObuBDjEg5DToecXmmxQl7dSjK2PR3la8U9Wy9ghT4CM7Wjh0XCKn9k5oPQof5vsL8XHK5pA8/98fO1ls9XCGsV6Vf3aIAziwqfoOEYBfncwsfAoa7ZmGjik7osPhCZeVgpE5Sn3C8ykbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931778; c=relaxed/simple;
	bh=amDpNotis3yqirZEjH7r/atGsV0+bKPKYG2ewZAOu0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2ARR+wXvnz6X2T/nAZTibmGgr5Nqacs3ZbZqV+dae+7xtiQf+XSdAZL2wSy6qxmgCHXhtaRK4m7SqEG5EFo+uuAwmjbL1SL7w/Vcy6qs+lQxinwqown5DPEtG4JEveAva2Oq3FGOriUN4MMeZlkD+DMEEDEuP8xGx+2TWbUNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c6HvHKpv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FXsePR+h/9s6oQ0vf99Byt+KAKcUxCsDa2eRWuUa1dw=; b=c6HvHKpvDTNVqu8NLCMNHlPf6z
	/2UD71RSAH/TF8qZepSoEaQxkHa7BMa0kaFk4wvbBxGAPkLNbKdroOb8TQY8RiApWOe4rM+/spa+E
	0H+Cu2CVaFR0Qxrwoi/Ak82OmFgUaPMb0DY+R0KPNA8ZXWPSPH04VMYQrxosKYdijm3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSPYm-004pyX-9w; Thu, 28 May 2026 03:29:20 +0200
Date: Thu, 28 May 2026 03:29:20 +0200
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
Subject: Re: [PATCH net-next v5 5/6] net: phy: Introduce Airoha AN8801R
 Gigabit Ethernet PHY driver
Message-ID: <28727381-e56e-4d42-9f54-e7905fb2dff0@lunn.ch>
References: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
 <20260526-add-airoha-an8801-support-v5-5-01aea8dee69b@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-add-airoha-an8801-support-v5-5-01aea8dee69b@collabora.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292509-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1759F5EB8E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:58:10PM +0200, Louis-Alexis Eyraud wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Introduce a driver for the Airoha AN8801R Series Gigabit Ethernet
> PHY; this currently supports setting up PHY LEDs, 10/100M, 1000M
> speeds, and Wake on LAN and PHY interrupts.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

