Return-Path: <netdev+bounces-107686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E535391BF1E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68974B23209
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C4158DD2;
	Fri, 28 Jun 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mZ4atJA2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD7155C88;
	Fri, 28 Jun 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579819; cv=none; b=sJHCcyV475ksbxanfCs9hjC9xV2JDVC5Upk2XtXACuTCK+9iAmXzASjvwrrBOakuFUM6YDSBTJmsuX6ioi03TB9bqtvs7ol7MGkfkTPDWWc17HU8D7+TPWgNDKX+cWT9FgC3Pb3HCl0s/6R7ix+VPypXrCZTeKo/Fk4fhQkuUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579819; c=relaxed/simple;
	bh=WxBr0rSr2Oj5lFd/V5f2z2g/Y1b3owlQaVz68AcreBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX0HRmKYc4aLlnAHha3cx4ANL43cbzCcIFMAEWorZh9BrbzAwQyPGSr8dpawbRzj4YFJ9592jbdkAwcRwMJYSAVKlLRrqHL5u7f+ARpIMKNqApIRgelDSdzqcIK44wrtjUAMSlmuAFUWfXm2Ys4hWZwXnkF3MuuijeOEcSE5RyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mZ4atJA2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9otMkeMdAgkNNBSByYFZ3WjG0J5NuzixzkYCbswttpA=; b=mZ4atJA2zwGWgI4BmHXCCpePhf
	I9cdzxkqOpvLZmEDU/QtUSmnRw0WBgks7oeYFlCgpo5CmKdgK+8lLsmoxC5mW6GxaaInm2K0/xSPk
	VkHUFFeIGy3nEd0GjYjiuwumaRfW41EQwcehO4NNuZZUD47V0s+7AYQthkxhJxZ7Zitk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNBGB-001HWK-IB; Fri, 28 Jun 2024 15:03:27 +0200
Date: Fri, 28 Jun 2024 15:03:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan.S@microchip.com
Cc: linux-usb@vger.kernel.org, davem@davemloft.net,
	Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Message-ID: <2aa4fba0-c5bd-47e9-97a7-3f73048282cb@lunn.ch>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
 <6eec7a37-13d0-4451-9b32-4b031c942aa1@lunn.ch>
 <06a180e5c21761c53c18dd208c9ea756570dd142.camel@microchip.com>
 <d72dd190-39d1-49ca-aeb2-9c0bc1357b68@lunn.ch>
 <369cd82f60db7a9d6fd67a467e3c45b68348155b.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369cd82f60db7a9d6fd67a467e3c45b68348155b.camel@microchip.com>

> Although, there is no specific errata available for adding fixup
> specific to lan78xx USB dongle, we have added the fixup for handing
> specific configurations to ensure the PHY operates correctly with the
> MAC. In this case while transmitting from MAC to PHY the device does
> not add the delay locally at its TX input pins. It expects the TXC
> delay to be provided by on-chip MAC. Since the delay calculated in this
> case is specific to the lan78xx USB dongle it is not possible to use
> this fixup for interfacing with generic MAC.

Have you tried PHY_INTERFACE_MODE_RGMII_TXID when connecting to the
PHY? The four PHY_INTERFACE_MODE_RGMII_* values are the official way
to ask the PHY to insert delays, or not. If that is all you are doing,
i don't think you need these fixups at all.

> > Please give me a details explanation why this fixup will not be
> > applied to other instances of this PHY in the system.
> 
> As stated above, the TXC delay calculated for the PHY is specific to
> the lan78xx on-chip MAC. This delay ensures that both the phy and MAC
> clock delay timing is met. Any other MACs connected will need a
> different delay values to be synchronized with MAC and hence these
> instances will get failed.

You did not answer my question. Show me the code path which prevents
this being applied to other PHYs. Is there a comparison to netdev
somewhere when applying the fixup? Give me the file:line number.

	  Andrew

