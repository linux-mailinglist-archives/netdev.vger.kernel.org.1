Return-Path: <netdev+bounces-273355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMyyMCMAy2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 359733622E4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 986D83031CE2
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078A3E9F89;
	Mon, 30 Mar 2026 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XANtZDRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB16398905
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910674; cv=none; b=uFe3BunLi3NpIrNxjR4K96fzTutDdItaUfUqtRsedHn8+uOM2gEogkTYtxDbbW5ADW3+GzFajwa9+TKVPoAS3OEz5kbEKFvu0lSGyn/0zsFiCPUfSxw0ZofyOsC32P7CDmbUy6QRW2DTIufqM/kQLI8YAnugg2JXcY12Xaw2etw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910674; c=relaxed/simple;
	bh=FK94apVjZaOnfYTmPI7R1bdtgdB0ZM8hbaTCdcBtudc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XcRSlrODAfmrZczHBtNRC0rVdtaPv3VZ93FuV2DU9ZVJukVQNVziQL2BbGf4IvpPDVi2wg+cfaoRUJL3LZ3v4LVgp7AnbSyisspoobwCcK5cDGOuBFf28frTt+xUcwZZjQ2nX4eDs7Vb+gzjkfb33CRHBxGt4FviC8K2ZoBbgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XANtZDRR; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 606D7A56EE;
	Tue, 31 Mar 2026 00:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774910658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lhZ5rVZacFjVXe7U2doDE8Y/G4RSG9wxup7HJOd79vY=;
	b=XANtZDRR2H5NuQoJziHqflh7BAH5o4GG81TMTcpdxJ99ttYtgtfZrZmYIoTBVuZbUjUf67
	PKkg3w7e0Tm2nBj74eJOUTXhnGqmCUgV8b3b2lbUgvrfEakHZV6uWyBf+53X9cySrfIdH+
	VQgskhnk7LfChUQxX15fDzZqD4NjaG0IuNtPSv+O1MimIzQrNLh34XDOIEcXAsQ5ijjJVj
	/W1f5NSEHxmO6L0jHYKOP1JCroove1rS++ASwm45eKsTVnr4UBG0EwYd/syEA7cXmNNZeh
	r4hXvtpOjl1TrNpyVLSieLhTfQKLrWUdUAKpNj9dFRcb70jU9DTeZtmClgq8hA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2026 00:44:15 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli
 <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 bcm-kernel-feedback-list@broadcom.com, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: bcm84881: add BCM84891/BCM84892
 support
In-Reply-To: <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
Message-ID: <c54db52f82956f5dbeed3a425fb87ad0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273355-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,google.com,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.576];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 359733622E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24.3.2026 20:06, Daniel Wagner wrote:
> The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
> BCM84881, sharing the register map and most callbacks. They add USXGMII
> as a host interface mode.
> 
> bcm8489x_config_init() is separate from bcm84881_config_init(): it
> allows only USXGMII (the only host mode available on the tested
> hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
> tested platform. Does not recur on ifdown/ifup, cable events, or
> link-partner advertisement changes, so config_init is sufficient.
> 
> For USXGMII, read_status() skips the 0x4011 host-mode register: it
> returns the same value regardless of negotiated copper speed (USXGMII
> symbol replication). Speed comes from phy_resolve_aneg_linkmode() via
> standard C45 AN resolution.
> 
> Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
> running OpenWrt, where the MDIO controller driver is currently
> OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.
> 
> Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>
> ---
> Changes in v2:
> - Separate bcm8489x_config_init() that allows only USXGMII. v1 also
>   allowed USXGMII for BCM84881 (which doesn't support it), and put
>   SGMII/2500BASEX/10GBASER in the 8489x possible_interfaces which I
>   can't substantiate on this hardware. (Russell)
> - LPOWER clear moved from config_aneg to config_init. Characterized on
>   hardware: boot-time only, does not recur on ifdown/ifup, cable
>   events, or link-partner advertisement changes. (Russell)
> - Dropped LED support; will figure out the PHY LED framework approach
>   for bicolor speed-mapped LEDs as a follow-up. (Russell, Andrew)
> - PHY_ID_MATCH_MODEL(). (Russell, Andrew)
> - is_bcm8489x() helper removed; the interface mode now suffices as a
>   discriminator in read_status since only the 8489x config_init allows
>   USXGMII.
> 
> v1: 
> https://lore.kernel.org/netdev/20260324152503.1522071-2-wagner.daniel.t@gmail.com/
> 

> [...]

Checked the patch against the public datasheet and everything resolves.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

