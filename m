Return-Path: <netdev+bounces-292276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i/jRFtrlFmpVvwcAu9opvQ
	(envelope-from <netdev+bounces-292276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:38:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED06D5E449D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65BFF300381A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332353EDAB2;
	Wed, 27 May 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5Pm5lqyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C03EF0A9;
	Wed, 27 May 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885528; cv=none; b=BOc0vHohQ60SzIoUy+3OrT2D0PjPGXkYnb0OldVO35ax7L5KuCEmdS0B2WJjW0zs4bn67tUprJ0Gl0LNvNLqKeHV+qt4kr1cpbd5apxAzZUoWeqw85B3sKP8s60qd0C85h6HClGnp08h5u7Rmrhq+LkQeExxhD+hMPGx2mwXbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885528; c=relaxed/simple;
	bh=Z7/26Dde4Pzl59FBZsDoSgiS3P/J41S/Ax6I8PeqB3M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QfcdLvqBbRZFlokxBt5VvggNFpvpbTh9g2gYWmFidHKHvtp5zKghUR3oAx1xqlkOdEUC68BYm14kPAY/yzamAfo5sOW3VyygtV2BFSfvidAAkzjDS+iRPnWbdE7TC5hdtorvyK492ZRs4W3CJX9NRr6JATb4Uw/Fz7ygEO8KCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5Pm5lqyW; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DFBAA0334;
	Wed, 27 May 2026 14:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779885521; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DXcGw4XFpeDLFMHotGZqawI+h7zq2pTwOpnT9F8RuW8=;
	b=5Pm5lqyWG3DQBhpu6A46MitXJgpNER8lGzvHMAjP9t9SKkW8wXBZ/40h1/nhOIDBt8SQIa
	3AylR72HxQVSvX+iUt7iaHUUYgPyXDRmO0p9vHil2VzUpb8XDg1iaVoQkNi+eZODGbNESc
	rPj3tm+sXclSB4JcemrpTW4looCW4c4IzQ70nCUWjaLt/wz5GfjVWO2z6Gpo8KGbCOK3eX
	RrRgSU5Ay/5ZqSw2HpcvR6YHfzZN/mkojOEYapmnvlYufRIVNqrlOYLrDUsMDqRe/t91xI
	79olPAOtksgnh3RX1AkHlXsIsJSHcW/uw6utMZ8EG5l4YIaaYEiGws9JUmLJow==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 14:38:38 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thangaraj Samynathan <thangaraj.s@microchip.com>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
In-Reply-To: <e66d0929-6fa1-415c-80fe-d2635bf74e19@lunn.ch>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-3-thangaraj.s@microchip.com>
 <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
 <b24c34f91726681ef5797af10b3d1e9a@tipi-net.de>
 <10b311c5feef2ab18f1e94a6c935a79b@tipi-net.de>
 <e66d0929-6fa1-415c-80fe-d2635bf74e19@lunn.ch>
Message-ID: <c0c65d225270c91323bdc7f790d9356b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292276-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Queue-Id: ED06D5E449D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27.5.2026 14:20, Andrew Lunn wrote:
> [...]

>> ksz_common is exactly that: it puts RMII in lpi_interfaces on purpose
>> and uses a dummy mac_enable_tx_lpi() (the comment there explains the 
>> HW
>> handles LPI itself once EEE is negotiated):

> [...]

> 
> and this is a 3rd variant, were you have an MAC/PHY pair which is
> tightly integrated. I doubt that RMII is actually being used, and the
> phy_interface_t should actually by "internal".

So, if we treat this as a special case, patch it and track LPI
internally ...

> 
>> So clearing RMII in phylink would break EEE there.
> 
> Agreed. So maybe it is too late to do this in the core, at least not
> without having to change some drivers.

... we could clear the bits in phylink when RMII is used? Arguably this
patch is the first occurrence of such a construct, but who knows what
the future will bring... Better be explicit in the framework than
rework it later?

> 	Andrew

Nicolai

