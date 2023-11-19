Return-Path: <netdev+bounces-49035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A37F0763
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69861C203DA
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14EF14009;
	Sun, 19 Nov 2023 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3GZN/Kj6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA083128;
	Sun, 19 Nov 2023 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NxAx9i/mT0ieuvpN0I81e9ihNgtBEyUhPumkp+2OoDA=; b=3GZN/Kj64dPIRCV6DXAM6TWSIO
	v2c9K54yv/AWiXQTjquHsfhqhfC3G0XjXLe1F7iToGaB6jV9iHcOu7H4VlqOyD/e+mLfGWPzLlCSM
	U6OO768MECXWfFbpMN9H2uG47xCishW2V+PJcHiXH04/5fYbUQpCF1ICNB9G9UlMZXuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4kQA-000ZUg-MX; Sun, 19 Nov 2023 17:13:18 +0100
Date: Sun, 19 Nov 2023 17:13:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Laight <David.Laight@aculab.com>
Cc: =?iso-8859-1?Q?'Bj=F8rn?= Mork' <bjorn@mork.no>,
	Oliver Neukum <oneukum@suse.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>
Subject: Re: question on random MAC in usbnet
Message-ID: <20891d0a-6ec0-4865-bf61-406f29f2ac6a@lunn.ch>
References: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com>
 <87zfzeexy8.fsf@miraculix.mork.no>
 <64dfec9e75a744cf8e7f50807140ba9a@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64dfec9e75a744cf8e7f50807140ba9a@AcuMS.aculab.com>

> So you might want to save the MAC on device removal and
> re-use it on the next insert.

That gets interesting when you have multiple USB-Ethernet dongles.

I have a machine with 20 of them, which i use for functional testing
of Ethernet switches. Luckily for me, they all have a vendor assigned
MAC address.

> 
> [1] We ended up putting the USB interface inside a 'bond'
> in order to stop the interface everything was using
> randomly disappearing due to common-mode noise on the
> USB data lines causing a disconnect.

Maybe you should of just thrown the hardware away since it seems
broken.

	Andrew

