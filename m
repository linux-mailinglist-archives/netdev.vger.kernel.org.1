Return-Path: <netdev+bounces-273771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNm1BhpRzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4137288D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B1F3028013
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81D46AEC2;
	Tue, 31 Mar 2026 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0QomqsF/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9903A5E89
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997782; cv=none; b=K7Oeh8wXmxOz+LHeVLuubIwMIaqEgLR8ATaYTeyMtkqqUiPY+cVVAQTwUA34uP1qP0ObOdjvRS7GrN50hEZYNrjZ/e7ncrXqhBf1QcTaOh6wMgQQTDShouJrl1Nqp7NIXE5n2ZO1zw1L0FzRRibHcWbGgCEHWe7ahQUbgM1VkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997782; c=relaxed/simple;
	bh=I9j2+cE0y0eXodthrKE2zprTaXhLXIhwXMziAGdyQgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALM1LMrhKANw5v/7JQxkcYzB3Ggg0LOSYyM66KFMoYwUWYnwC5VQrHWFc/geOUiVyRLFFTOAO2mjiKaJIeOw7WYsV4D3Yxy4aJqanH+A5PylBt0vSDc3jHRmb6wzPcmlWbTP+Uk4hFsk4veiKpvc2dHcBtZk1hu6NmE405AodbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0QomqsF/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ocpnky6L/aAiS9R5cL8VYa8L7VhF5lBX3QONkQV5/WM=; b=0QomqsF/xPUjgMAUv7O3Qu5KE7
	TMx1RHq13M70hPKo0AcJk85WNASDRgA/S8wOAnBV9R5s7dz9ec0xXlgZPC9ehEFJg5K54n1hU/JnK
	iug8y1LArybGG/qyA054+bRMPN3mx8BrjYNJxXJI+RAXlVbBXMZl7vYgfuxD6n/RO/H0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7i0G-00EFo8-AP; Wed, 01 Apr 2026 00:56:08 +0200
Date: Wed, 1 Apr 2026 00:56:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 52C4137288D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:27:20PM +0200, Nicolai Buchwitz wrote:
> Hi
> 
> Some PHYs (e.g. Broadcom BCM54xx "AutogrEEEn") manage EEE LPI
> autonomously without forwarding LPI signaling to the MAC. This works
> fine when the MAC doesn't support EEE, but conflicts with MACs that
> implement their own LPI control via phylink's mac_enable_tx_lpi /
> mac_disable_tx_lpi.
> 
> When the MAC has lpi_capabilities set, the PHY should use Native EEE
> mode so the MAC can control LPI entry/exit and observe RX LPI
> transitions.
> 
> I'm thinking of a flag on phy_device (similar to mac_managed_pm) that
> phylink sets when the MAC has lpi_capabilities, and that PHY drivers
> check in config_init to disable their autonomous EEE mode:
> 
>   /* set by phylink when MAC manages LPI */
>   phydev->mac_managed_lpi = true;
> 
>   /* in bcm54xx_config_init: */
>   if (phydev->mac_managed_lpi)
>       bcm_phy_modify_exp(phydev, MII_BUF_CNTL0,
>                          AUTOGREEEN_EN, 0);
> 
> This came up while adding EEE support to the Cadence macb driver (used
> on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
> prevented the MAC from tracking LPI state. As a workaround, the
> Raspberry Pi tree currently carries a downstream patch that
> unconditionally disables AutogrEEEn for all BCM54xx PHYs, since both
> genet and macb now support EEE properly. That's obviously not suitable
> for upstream where other MACs paired with BCM54xx may not have LPI
> support.
> 
> Does this seem like a reasonable approach, or is there a better way to
> handle PHY autonomous EEE within phylink?

You should also think about it from the other direction. What happens
with the MAC does not indicate it supports EEE, but the PHY has
autonomous EEE. At some point in the future we are going to want the
PHY drivers to export API calls so that phylink/phylib can implement
ethtool set_eee and get_eee using this autonomous EEE.

Maybe it makes more sense for Broadcom BCM54xx etc, to implement a
.set_eee() call which only accepts eee_enable == False, and when
called so, disables autonomous EEE. .get_eee() can similarly return
that EEE is disabled. When phylink sees the MAC implements EEE it can
calll into the PHY driver to turn off autonomous EEE. And we have a
path to later add support for turning on and fully configuring
autonomous EEE.

     Andrew

