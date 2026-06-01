Return-Path: <netdev+bounces-293643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEH3IDxSHWpfYwkAu9opvQ
	(envelope-from <netdev+bounces-293643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:34:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FBC61C87C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DD963008526
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534D38F25A;
	Mon,  1 Jun 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xn82i8U0"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C5137750;
	Mon,  1 Jun 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306314; cv=none; b=tYwpANzfyTCRV01EMRLWFpXYryKUd+Mvlew5CF3voXfbYQbuiTFuuip+JWXaArNompBi8DANCSuRGWaZ20DUPEW+yBuRJecMz/anmAS1TRkNhXyw7diVx4edGeYtjXKHfReF/9VX8kUla4YLwOR9XQHCqPkEiioFdK6KxktlbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306314; c=relaxed/simple;
	bh=TF4H+xRgtIHYnukALsh/sfFcWGIHpgbeZ8aBfl5cbR4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xd+/vcRj7qkOLOblBVEbk2iETPEebGW9gDlKTnAaIAePdXzrXLjGBRAdKHnpoVknoILuT7uHoORiH0C6hte7UeEWoenGJVFCTrPSlV9riw81HoYHI7ShUKPd0rFMeHe0O7OrYxNP0p9aK+OxezqoX5rtnxLDCi4udOh98qJfDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xn82i8U0; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB3FEA08DA;
	Mon,  1 Jun 2026 11:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780306310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mmF2Ndi+ZlnCf6k1s/DWNsOrwKBWTAZ7EpTs89KOEws=;
	b=xn82i8U0Uf5XCgmQEmLHWovtTyvtIz+RftZ3tBDoCtoDgtLVBYEPxuL7SWXgTBmtDDZ1mw
	4s5uesglXftigdT8JiJnXX5aDQIJB4ev44b/54PD/msVtf4U7yiFvFiYGmpElkyQvqh8Hf
	cb4UTxmT8zOVVrqgqQN7xD6Ev2rHRTSbeo8QYZoTHgy1tdriaW1HHd71HShZhXONHXB33t
	Xw23xo9VdTtnefzxXih0zXM0Lv/TzHtnGT0ZlQjYCyI+tFGzLGuicl9rxvQVkctIhbEisd
	Z78jk3koZOe+KEmVgda+TpfW5u+Sx4Fo0e/DCIseRA8nDd35Wi+L3Nyl5ScWCA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 11:31:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
In-Reply-To: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
 <20260601084029.815461-3-maxime.chevallier@bootlin.com>
Message-ID: <2823b00cb2aa211d8f4f392a37537351@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06FBC61C87C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.6.2026 10:40, Maxime Chevallier wrote:
> When phy_probe fails, let's clean the phy_ports that were successfully
> added already.
> 
> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c 
> b/drivers/net/phy/phy_device.c
> index 6ccbfacf7d1d..a171cbe2a74a 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
>  	return 0;
> 
>  out:
> +	phy_cleanup_ports(phydev);
> +
>  	sfp_bus_del_upstream(phydev->sfp_bus);
>  	phydev->sfp_bus = NULL;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

