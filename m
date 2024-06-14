Return-Path: <netdev+bounces-103605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6499908C5D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6EC1F2598A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59B195961;
	Fri, 14 Jun 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="szKBJHBi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DFB19D88D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371143; cv=none; b=F3FdjpDZZcu7ckZerHEAca1ZVvniq81/gb5ZRbwordB1/mWQypKzK36u4CZGO0Uil2/Z0lrEekn5Io/UJl72QxH1hJLPfjyGffcXFMSi6qEiGZGO1LZo+SOCOhcdeh+BtRJo/TAlcXZeL8G3hNOgOmLEH10yUMDv33yrknWUs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371143; c=relaxed/simple;
	bh=m9lSb3QAWikP0J3HhBLcDNBlQ7/QWPKO+rndXKGp9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2AbPAkkIk6J/LYVs29ZMVDk14u3pnrnd5u5SBA56WV0LiTmOvwtuPPZ16aOPpMsvQcR4FSQmGyo0S7TuvnSmlLtKtundqbr9SLtUHX96K2Z12RJsXFeOe260yx7lbhIlYKuX2OQZjhdoysCSnyZvzOOX018qmLLrwa412yZ88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=szKBJHBi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KrOkMNp3+uOLZeamc4MykVL0gGV2BfOa/4BAf7io1E0=; b=szKBJHBiy5P9PO6t0yc8ltTfO/
	53sGmfixa23tCsYCjEhR1WlSn43akXKMipnGtvXndjUWOBs88BpA2C+QgUNO6VeiM6B1XBO+R61Nj
	hAE2XO9kohZlWEqp5kZ2VRLof69pB6AyA3he4WTFav7S6+qn5/m4btZoFRyyiall4D30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sI6pV-00044L-3r; Fri, 14 Jun 2024 15:18:57 +0200
Date: Fri, 14 Jun 2024 15:18:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	horms@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v6 1/3] net: phy: micrel: add Microchip KSZ 9477 to
 the device table
Message-ID: <c4198e44-0f75-4486-88c9-ee6e3d8b0d08@lunn.ch>
References: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240614094642.122464-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614094642.122464-2-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Fri, Jun 14, 2024 at 09:46:40AM +0000, Enguerrand de Ribaucourt wrote:
> PHY_ID_KSZ9477 was supported but not added to the device table passed to
> MODULE_DEVICE_TABLE.
> 
> Fixes: fc3973a1fa09 ("phy: micrel: add Microchip KSZ 9477 Switch PHY support")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

