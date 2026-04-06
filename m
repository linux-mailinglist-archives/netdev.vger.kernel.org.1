Return-Path: <netdev+bounces-275698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKO6Gdr702k8owcAu9opvQ
	(envelope-from <netdev+bounces-275698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA8F3A6402
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119493009B06
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621C38F636;
	Mon,  6 Apr 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="t5AhVQcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F638C43E;
	Mon,  6 Apr 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500192; cv=none; b=rDnwYusS2fKXVFgVE+dA14QcHR77fFYpW4w1aOuj800VaOrxaCSW6d8SmgrTNn1b9nlIX0dYrc9fF4DzSMSjJEZ11c+pG9qxJGUmv0FIYh3JaN8FUA4An16Hs++2nQOWls3JZCM81acCCLNM8lRoZMbWwaHwwCTgHFuDLufP08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500192; c=relaxed/simple;
	bh=1FsQQzvn0jCYwDQ9OY5NDoR1XnzzljGSEivuWJI4ugU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OpKKRJXc8qVrCTCrmwWK4Df4LdDLFURHz/+rue8j2VxwpLOOfnbrhoIsNNOpJz65z8xRyKoRVPcV3eOvXJmSIgFcIosXdDyO0gzTeXxyxXthjvYJBUAXZIMekk51N4AXTOOjwFAFjK34t3SNj1zv70Kg7bU0uWyUnH3e04P0rMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=t5AhVQcJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FBFEA5889;
	Mon,  6 Apr 2026 20:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775500182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XNAoPmqAN02jd6z5OC5FpXvslNmeUiMwHsaPe5dtZN8=;
	b=t5AhVQcJVQ8fcHQPcrrBrsh4JueYmSr3+2xeu17RLAdmhPa+Nekzpz4exBm+LLzj+PqO3I
	o8jL8FBK+2OTerm4m5lp8T8mofenjfM1vqrsx9k7ga25/wRl3tDut31z9x1VLS4ItP7wa0
	7EP+UcCw4/OpgxSUCwVNuiAgN3tLXhQr8pyh4dp23kHzo64Da+UWOFVdmwcStwsXH5fKPa
	2buoNs0sv5UMJjex7uFt8MU/vfIIxrmaqO3hXXA6jJcmZmCC/o5Eguung3U8bvb8fblFF/
	Hg9odyxPfcPqUNvtgcWXMabr6CBRyjYTbIPxLqlF9NP0XjLa3xDDmA0rokUj0A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 20:29:38 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
In-Reply-To: <adPo-o9DtxIZGDvg@shell.armlinux.org.uk>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
 <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
 <5298959c-12de-4992-a896-3d1371cba111@lunn.ch>
 <cdef227e-9dfe-4860-aca3-5ce1f60cb838@broadcom.com>
 <adPo-o9DtxIZGDvg@shell.armlinux.org.uk>
Message-ID: <faf651039d98fb9c1ffb40dbd98bb16b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	TAGGED_FROM(0.00)[bounces-275698-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	NEURAL_SPAM(0.00)[0.235];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,i.mx:url]
X-Rspamd-Queue-Id: 0BA8F3A6402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6.4.2026 19:10, Russell King (Oracle) wrote:
> On Mon, Apr 06, 2026 at 09:43:55AM -0700, Florian Fainelli wrote:
>> That is almost a guarantee given, there will be a broken MAC
> 
> Well, it already exists. modern i.MX platforms use stmmac, and some
> bright spark wired lpi_intr_o together with the main stmmac interrupt
> which causes interrupt storms when the receive path exits LPI. This
> makes stmmac LPI unusable on this platform.
> 
> So, if i.MX is paired with a PHY that can do its own EEE, then we
> have this exact scenaro.

For DT-based platforms (like the broken i.MX), this could be addressed
similar to what we already have with eee-broken-* properties. For
platforms without DT it's getting more complicated and I can't see a
way without ethtool.

Maybe we need something similar to ethtool --set-hwtimestamp-cfg and
make the EEE provider selectable at runtime? Something like
ethtool --set-eee eth0 mode mac|phy. I have the feeling we will need
this sooner rather than later, given the overall quality of EEE
implementations out there...

Nicolai

