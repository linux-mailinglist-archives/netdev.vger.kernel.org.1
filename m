Return-Path: <netdev+bounces-93583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB388BC56F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6971B281EB2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA393C463;
	Mon,  6 May 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q8bLEqz8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EFF6FB2;
	Mon,  6 May 2024 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958934; cv=none; b=mxjd73iBkweHzutcx5v4ND/nM0kdP8EsIHp0KUDQl3h2Q1sjh3zUxSoHVr82rqXKCi8u6Wmc2Fu1sjQGLjaJ7tyN3Z5yBAxHeTQdG1x62DHk6rKc0u915kFZCcdd1dRQBoo+9TDBqQ2RELjyCnyePtGP0/jyEuyz3yPWoPsTwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958934; c=relaxed/simple;
	bh=MBmDyn3o3vnEjJuULueAN14Iyp0I7VYXDlzhpDUe35E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTZRFLO1AGUYPh032ltXf8vILAbWro6coGW0eefuFJni7Bhb8fJoF9ccAk7NZHawrXJiC0mwpF87UWxd834+Vf0J42HH9wK6dkoAJxbRYZ+3Mqcg2VtY1J4zK2jpF8cmaAdyBQ3t9g5R/PsWd5O2VDZj8k/unybFA432YKXtNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q8bLEqz8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4lEoVVeC36+PEGRwrbvZuuCU2i1qxfqOELKXfHvEA7Q=; b=q8bLEqz8Y4KHwIrCW5ESEnbrap
	KvUJ50SPYgs8SgFdowHd+2GdUjabMFSSpzaUPgSqCNgIa1ytH7pqgu8tJ+sQhZRIvPiwtNox4Wtp1
	KmFCMHsA7eX7nQgaR6qAvnthu5lxaD35nEDNdm/FXMBsAe2oMNh5HX7ePYlpwlslHazA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s3n9d-00Eiyk-Dt; Mon, 06 May 2024 03:28:33 +0200
Date: Mon, 6 May 2024 03:28:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjSwXghk/lsT6Ndo@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjSwXghk/lsT6Ndo@HYD-DK-UNGSW21.microchip.com>

> One quick question.
> some of the options (ex. WAKE_PHY, WAKE_MAGIC etc) support on PHY and other
> options (ex. WAKE_UCAST, WAKE_MAGICSECURE etc) on MAC of Ethernet device.
> 
> Suppose, user configure the combination (i.e. wol gu) option,
> Is PHY flag should hold combination option or only PHY supported option ?

I don't think it actually matters. The user is going to end up
invoking the PHY set wol. The PHY will setup what it can. On resume
you are going to call the PHYs set wol function again. It should do
the same as it did the first time. So if the PHY ignored WAKE_UCAST
and WAKE_MAGICSECURE the first time, it should also ignore them the
second time.

> Ok. I will change.
> May be in phy_init_hw( ) function is better place to re-config the WOL

You should first answer Russell question. It could be a totally
different scheme might come of of the discussion with Russell.

	  Andrew

