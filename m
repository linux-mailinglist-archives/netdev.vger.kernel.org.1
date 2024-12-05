Return-Path: <netdev+bounces-149411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3509E5893
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F891884131
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135D219A97;
	Thu,  5 Dec 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="adzPbIsD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7398149C64;
	Thu,  5 Dec 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409356; cv=none; b=sre4ElYa5UABRVKIrWT+54zoJ81Pe1kKZMgGWRSgLne6HugiUiw5ogJ4rQ7doxjD770jp6JUwImPBc9cxiybLVzMM+QcCw5oOjVWQbIOzk+3Jw5w0UOcXjvYKZzeDBtsRkvKryI8UyUiPDnuARi2h4cZJCb6Ap7dQmOAIv74cZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409356; c=relaxed/simple;
	bh=PAZGxlGUEOmZxRs5D6wMPERed/sa/ryvKJ7XsU6KiyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmANl+Smjnzcm5TN1Ne1ZezeNXogt5o9CohPu2X+iER07EGihFSfh0DRTWD+ln/Vm99SAiG0JphZODdAJ3zpRI+N0a0pnSlWaj4fVEkNt68Ofb3OPS1jzKttWEZkX1PjisVLX+qW+7a7a64smcZEWqYXKWwyDH5VpZHxZ5t0QKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=adzPbIsD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=akiezOi0AjI2v1AZmbfpW1eWcU7uuOXw1StSELrCSBw=; b=adzPbIsD7Zlz6bScvSSLfQYwQz
	Fq159kqAu3B0ml/1jxYWe35asoT7hNNigSxcE3/v8RKx1HZn8Y3AO4XaUx9W7hmWevouNsYRXpksg
	PREHuCUn21GSJxhSfKDKLRsXJkOGgnr9JZtnHulcCnrsD4c+40g9EhKj6jsjN537RABA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tJCxA-00FKIc-1G; Thu, 05 Dec 2024 15:35:40 +0100
Date: Thu, 5 Dec 2024 15:35:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya.Koppera@microchip.com
Cc: Arun.Ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <05eecef6-f6be-4fcd-9896-df4e04bbde19@lunn.ch>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
 <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
 <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>
 <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
 <CO1PR11MB4771EDCFF242B8D8E5A0A1E0E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4771EDCFF242B8D8E5A0A1E0E2302@CO1PR11MB4771.namprd11.prod.outlook.com>

> > And has Microchip finial decided not to keep reinventing the wheel, and there
> > will never be a new PHY implementation? I ask, because what would its
> > KCONFIG symbol be?
> > 
> 

> For all future Microchip PHYs PTP IP will be same, hence the
> implementation and kconfig symbol is under MICROCHIP_PHYPTP to keep
> it more generic.

So you would be happy for me to NACK all new PHY PTP implementations?

Are you management happy with this statement?

Even if they are, i still think you need a less generic KCONFIG
symbol, i doubt somebody somewhere in Microchip can resist making yet
another PTP implementation.

	Andrew

