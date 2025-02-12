Return-Path: <netdev+bounces-165348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6072A31B9B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF03A2234
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A578F20;
	Wed, 12 Feb 2025 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T78s9wxx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DA1CA9C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325356; cv=none; b=IcU8+uKltEnhcPR0kNQl5Of8glsK4d7eEHpRmi4J7UPjHBqKNEVxXZGhn9qacUKNEMNI/zd2I+1TSVTENzB0NPLAlt1WI9Q3tOwfghdQbNsuiI4bsIyEt1SMX1P1GVBb6MKnvwPGCfjnwhJJj8U8anzexGgAsxCfF8WKYbCXGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325356; c=relaxed/simple;
	bh=fr9uGeNlPMogedH7gEnJG5stucHnhfd0XOyeciZyaho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtYB/DFkS/VDL6B8DehJ6fu6whMTvFNKjn2ov9h8Gc6gHil7sxTnKr5up1B/EeZXzrBA2zLSkBaxjlCu5bpAOI+HARtI2vLNKyNP4xBbnwu4PD9hdxxvo0cBVY/QrWwaAVd3NaOlI36bZ8xa+YV3ZOqXgcBL21NIG1EGpbKmlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T78s9wxx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qCGRB4p/MQQC8FMGsIGRTtftv/wNCvhKKE4ch53Rs7I=; b=T78s9wxxQs4Kfiuz6rxKR3zjyu
	1TX/B7Z0rhTg+WE3atDKM3w07sDCgYN7K5K1ZrO48pVh8/D5aDZYfm4xztRu+hgc9HEo8OCPcRAGt
	YyDBtJ3F7teyGBTL9aWGzz+hwV58W4LTf7m/H85vOTRXJvaD6eq08HCGvDR0KLY67xKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ti1yd-00DFC3-3P; Wed, 12 Feb 2025 02:55:47 +0100
Date: Wed, 12 Feb 2025 02:55:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/7] tsnep: Select speed for loopback
Message-ID: <8b0e2b6e-fc26-4557-966d-48a985c6ccba@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-6-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209190827.29128-6-gerhard@engleder-embedded.com>

On Sun, Feb 09, 2025 at 08:08:25PM +0100, Gerhard Engleder wrote:
> Use 100 Mbps only if the PHY is configured to this speed. Otherwise use
> always the maximum speed of 1000 Mbps.
> 
> Also remove explicit setting of carrier on and link mode after loopback.
> This is not needed anymore, because phy_loopback() with selected speed
> signals the link and the speed to the MAC.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

