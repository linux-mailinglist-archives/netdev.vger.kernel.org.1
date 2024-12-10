Return-Path: <netdev+bounces-150455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A159EA49D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA95C2827AD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3C2AE93;
	Tue, 10 Dec 2024 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0IovEM2j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90F70830;
	Tue, 10 Dec 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796108; cv=none; b=qs3YYaU512pNXMq2aQXzuqBfVBQ1xUw2odcHF1QC4tFyypoxOKMHvdZY1bVErItQ/rKUILqnysAtg9qLV8SQ0/wGYd8h3LECnDgtYjqOz3FOsvSoGJsvXeX1kz9f4/7pBwpVhSiILuLrfMprJ118f44lfY/TEHZoHiYxqyp+JAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796108; c=relaxed/simple;
	bh=+yJX4FKmnL6QyLxcblii4TEjSkV98j/xFW0E6iUByCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9fvbBmocIOhzUKPw06SnGSBHQ++Y100PRZ79meFOLG+toxbMaOA0iElf+2l1DPUBYJySSyjaqz3gfEh1fLELcFVCwh5KGlWhCTd6h3aJ23p4gjH63GsvWzH6xsVlIsOtPD2eKU9hr58WDi+ldfPXjtl8PkCU55B+dRA5WatelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0IovEM2j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cN1bJiZijgUXtucBCQOF/kSi4vfNI8b4zCiXpjiy3yA=; b=0IovEM2jKPSW9vA+0a5z+GHWhc
	uIdx4a51CqPqVnTbw7awUXi7q/Gxpd5EewyBbbzDa4f2cRHj4C+nd+9cuaJKlL+u3Wq8e5RLTlf6k
	QL2muAPS8PmFrE60qRFgzwb8IBbeIReKcd+osT3418k0P5KKudnMC16U+0NNhXbwuxUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpZC-00Fk23-Iw; Tue, 10 Dec 2024 03:01:38 +0100
Date: Tue, 10 Dec 2024 03:01:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 02/11] net: usb: lan78xx: Add error handling
 to lan78xx_init_mac_address
Message-ID: <df577228-87c2-4abc-8f9e-bcdab24b2e94@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-3-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:42PM +0100, Oleksij Rempel wrote:
> Convert `lan78xx_init_mac_address` to return error codes and handle
> failures in register read and write operations. Update `lan78xx_reset`
> to check for errors during MAC address initialization and propagate them
> appropriately.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

