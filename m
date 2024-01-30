Return-Path: <netdev+bounces-67221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE3842643
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA3A1F23FF2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C26BB3D;
	Tue, 30 Jan 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GWXqCLr5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D596A320
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621987; cv=none; b=bbuDTGNk8W45Pk1hkof06U5qZhmSTGnREvUKRqUsQIgPY96y4pZmZhvqYYs21Sy6pxCGiZ9iay59azIJ1WLNI8+IZGOtf+Qr8UNU0hsck2uDD0ne1PGLyjQBZkWoN3MKLV8SBqm5o5+ZTtDz+8OwxqrmsAYxiWNFSDb9qngRa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621987; c=relaxed/simple;
	bh=pvLc4iGHB24whDbHaGXJFHP86XTXjnbuyxR+0fdhjNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYHgbGaGu9ialEw6qwkQhXx9RbTOu++8cDyobiU1xRCTzCitQG8Uow8NHJNGlRwLEsHphSxxeD2FjwlH1NUmeDru76TEFTCzQfgJB/x113el1yU6f4eRO/es2EIusr6adRb7tg89UcQ3NeJRkMds6wI2+jD5KDUJebmGGfzoQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GWXqCLr5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5tcIV29zmJ0EwZRiyJlKoaDAak6UxU6mwYCf+BrgywU=; b=GWXqCLr5m6vbVxQ+w3S6HDAqzs
	wML1JD1Qad//+RuS8gCj2H9BWYUyskE6uHi1O4IN3Th7IH+V76iDK4ubdm+g78sGMQya5dIbrKX56
	QIU6Mi/ohZwZrwZsjvZ53lI/Nwyps27qg1sX0wU8IlvUEjwxyEBS3LHGymsamRKJefCY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUoKs-006Uk9-VU; Tue, 30 Jan 2024 14:39:34 +0100
Date: Tue, 30 Jan 2024 14:39:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: dp83867: Add support for active-low LEDs
Message-ID: <f4b075f4-0dd9-45f1-be96-ad7e91936ce6@lunn.ch>
References: <20240130090043.663865-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130090043.663865-1-alexander.stein@ew.tq-group.com>

On Tue, Jan 30, 2024 at 10:00:43AM +0100, Alexander Stein wrote:
> Add the led_polarity_set callback for setting LED polarity.

Hi Alexander

Please set the Subject to [patch net-next] to indicate which tree this
is for.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Otherwise this looks good.

	  Andrew

