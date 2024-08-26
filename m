Return-Path: <netdev+bounces-121751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481595E636
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06241F21175
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF177E6;
	Mon, 26 Aug 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mA/+12FW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9C635
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635184; cv=none; b=l5IBSdJ+cE/VFOnuq0JHzfMp8ZT9BVjpecZiEkGTRJWV/rlpofq+rolW1AirH16bSvfp2x6wK6kUd+DbJ01J1x37n7xapT0vO0AtJIAQO3FlP4Sh3jbZeWFSiXsimqcgTn9HffsVRIG01rnQ5sRlIXsjK9QXXaUrOCQP3Whx32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635184; c=relaxed/simple;
	bh=3gnMgKjvR6uSgihcPzYX0I08m/eW012I4564qBqMWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESK7FPSTYv1DVA6FkrsDF1EgSZ8o7ypk2eX4sVHfzYQMeeUnIAohQr3LAGHQrOR3+4nlmJP95mfms0L7IkD5lnQHBiHKZDkaGx9hS4c6tvBZO3UGmOq/jmOHHcTWqtVzfgtdvPTDUMF/wwMlm4PCgfHwC09+rL6yoEp0JbJFQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mA/+12FW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MytP6ozd7DfUW+wN5+UtxpBJOxnUqxCtghpNjpbE+hs=; b=mA/+12FWPXd+6lZ+ov7QBI+U78
	ItaRG+xBCIRErcpStd72xmYs7/Hf2wp9vyTZhwO7PnV40sPL7XLHhR2lWnqT+Nrb0JFW9d76jL8se
	47yE0E89tnC5HUGTiLLsLrbkIm7oGP+2HtkSc5VX1ekSbKXuisNzuoDYALQlj8AA/2QI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOOQ-005f7R-LF; Mon, 26 Aug 2024 03:19:38 +0200
Date: Mon, 26 Aug 2024 03:19:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: add firmware loading
 for aqr105
Message-ID: <f0c50100-f2f2-4d35-97dc-53a15f484c95@lunn.ch>
References: <trinity-c751adf4-fbd2-4741-95a7-c920061d3233-1724521078637@3c-app-gmx-bs42>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-c751adf4-fbd2-4741-95a7-c920061d3233-1724521078637@3c-app-gmx-bs42>

On Sat, Aug 24, 2024 at 07:37:58PM +0200, Hans-Frieder Vogt wrote:
> Re-use the AQR107 probe function to load the firmware on the AQR105 (and to probe
> the HWMON).
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

