Return-Path: <netdev+bounces-289285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKpOMSIBDGpcTQUAu9opvQ
	(envelope-from <netdev+bounces-289285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070A577EC4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA457302425B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1337CD5C;
	Tue, 19 May 2026 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="395kkW1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279C37BE7E;
	Tue, 19 May 2026 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171614; cv=none; b=jBAomDpBE96yqbxFJbujd+bcDxYn2AZOSxYNOIO7T3nKOHYxUaZB8m1tGkO6n88rdzy0D+/SZCiOb/WOf7jodogRn5q7yBsR2Xfkih8fMIc5KbEW9z5/wNLc6fwXv4jB7my3HBdZRikArDiAIOlUavttHV9Od5TUVHARJLr7fYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171614; c=relaxed/simple;
	bh=z6H4YotxyqSq1CfYcKMO1007taDdzQQWv3LKGZM1maM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jyle/SgsGRX4tatF8mB1msVSZ5Va57W9+uKyHWzdyGELT55+jsmzK44sNYIQP1b/hNCOxp/FzWWxZrWlDmLUZfhYXOMv3o0SyNLEd39uot6MxSo+YKg+iqRs0gqEvkJuEDVwKsKhwwWJ3N0MS4kdTfnCm+IRE5cmA/V/kZGDG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=395kkW1G; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31401A383E;
	Tue, 19 May 2026 08:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779171606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/mR69zAIjo8yrwpIMgxuHnPe8pPL8L80P3EcXieDedo=;
	b=395kkW1GQ35jR7JnQnBwdsToZLyGw5a/9a3yhWNu9idCu+xi830Q8Xw2vDgyGggDgw/aYZ
	nFRUNt/pZ9zbAk8iP7uzHsQlqFapwJSFTgLyj38a55zVnDxAN/0s8/KehuDBAOhOUGU0q9
	YDytpeAiBJfGKqPCo/eYExSgSXpAklrDOD8RDge4bNZU450d36ytB9BiNk1JdgKdObETvY
	h3Ko0JpSGR/lNpFIaRnxNzOnTS/Thk6AFNy1sgdB6KSHP1m1PT+/iLaIE9l6ivwLDgLT6I
	44hC829xvRVx9yokKTnvABTBPXfl4dVvh5A4gyNGILhKfUE3alMuhSTKgCiokQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 08:20:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phy: honor eee_disabled_modes in
 phy_support_eee()
In-Reply-To: <05a24b73-ff89-41e2-a655-224f1c2dbc31@lunn.ch>
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
 <20260518-devel-phy-support-eee-fix-v2-1-05b52626fa68@tipi-net.de>
 <05a24b73-ff89-41e2-a655-224f1c2dbc31@lunn.ch>
Message-ID: <7245b9c6294300265636ad954c01c248@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289285-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: 6070A577EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

Thanks for your review.

On 19.5.2026 04:19, Andrew Lunn wrote:
> On Mon, May 18, 2026 at 10:23:09AM +0200, Nicolai Buchwitz wrote:
>> phy_support_eee() copies supported_eee into advertising_eee
>> unconditionally, overwriting any filtering applied during phy_probe()
>> based on DT eee-broken-* properties or driver-populated
>> eee_disabled_modes.
> 
> Sorry, i should of questioned this on v1. What PHY are you using which
> masks advertising_eee in probe? It seems like this is wrong, and it
> should be setting >eee_disabled_modes, or maybe eee_supported.c

The masking isn't PHY-specific. phy_probe() applies eee_disabled_modes
to advertising_eee after of_set_phy_eee_broken() picks up the
eee-broken-* properties from the PHY DT node.

The PHYs in my case are BCM54210PE / BCM54213PE on Raspberry Pi
CM4 / 5, and I use eee-broken-* to disable EEE on boards where the
switch doesn't handle LPI well. phy_support_eee() then clobbers that
filtering by overwriting advertising_eee with the unfiltered
supported_eee.

> 
>> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC 
>> support EEE")
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> This patch itself looks O.K.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew

Regards
Nicolai

