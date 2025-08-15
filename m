Return-Path: <netdev+bounces-214154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A05B285FF
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C11AA855C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903F2882CC;
	Fri, 15 Aug 2025 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ykjmhjZF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0421317714;
	Fri, 15 Aug 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283781; cv=none; b=po6UrKqU+YJJz3Z0jatRqL/2uC6WRnxYE2Lmt5au9ukfkS4ljCMPECIlzz0o8COYWBAfpfrDUuYF/6ID+Qs8ddBM9m4VCgnQIRNjqVafL/8y+v7GmCpi8scIhq68LDDhVe2jJlH/YKW2zXH5V69Jfhes0zKOrLACwScgYjzGKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283781; c=relaxed/simple;
	bh=b/i+po+8/sV24lvo2g/QG1HgwE9bX25ATZUwg6dBnpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3r7zVs01oXy459n9gulZmMfGj0+92rfekdy8O7rUhIy002+Fxy983UHb9j416BHavtYWyuw83JRpmswtJcomcPpB4PAq1McNtDQ3xKJco6Dt0hBKn2inWckh40yHjTKHSPWha0RhLhVJg2ihJNfomyQVDkUPk2xUyw49MZOsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ykjmhjZF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1PlEMtUUWsb2dchVb0gw1B5xKWMiUdAV11zCeHtQwZ0=; b=ykjmhjZFazc8fArusi/DDEiVqK
	/BBu7eARMFrwumSTf43pgb5XkErvzEYhpzACpjeSbPxNyxUYQAyAor+rWNBfgQLiHsNlfUFOaNzgp
	rHdZV7KxNwZkHBTRk1BhMg3i2Hh4CNY0f7PEMK2USMwiSOD5wrGzxANwlkc+UXZImBTM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzUd-004qzR-85; Fri, 15 Aug 2025 20:49:35 +0200
Date: Fri, 15 Aug 2025 20:49:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
Message-ID: <507730df-a882-4d75-af8a-a0c0b1124b78@lunn.ch>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815135911.1383385-2-svarbanov@suse.de>

On Fri, Aug 15, 2025 at 04:59:07PM +0300, Stanimir Varbanov wrote:
> In case of rx queue reset and 64bit capable hardware, set the upper
> 32bits of DMA ring buffer address.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

