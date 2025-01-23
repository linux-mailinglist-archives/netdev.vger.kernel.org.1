Return-Path: <netdev+bounces-160605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8083A1A7D5
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B8F3A28C6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2E212D82;
	Thu, 23 Jan 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mCoreyTF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C635280;
	Thu, 23 Jan 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649587; cv=none; b=mOKA0jS2UpqQw8JAaNV392gfQ4/EJW/658yRxeO3jTCmkwfuIrE9GWxLrn6P+x/BvO3mJLHWV7Qzbl14oQIT1yxjoMo/K0QZVqO4oTT+LdxNpnNS8rqRFCm82pr++E40wy968qKkypTFyIWwbAy1vYRq1Clvvj3WCbuneXu/dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649587; c=relaxed/simple;
	bh=1cJHtH7jVV3mpDZfdE6AbqL3CqEDI4JHmhx3L86VYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp5yMUHcnBfuKFv9FN1kEnMjCVuWDldfqFQE5P3d/qQlnzjnJx0Qca47BzhmqO/yHtDfJcQKOY833aXU9se3HVSDzHZZlcLqg3ieMGgp8vPPKdFByWOLgO+IWfPTaO7uVnZ4ljs1ELoCG8KL46I3gD1ulMCRmpwLG0bsBF17Z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mCoreyTF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lkjjikhrl8+AMPFkwYKj/cOxE/3C87gHJSs4QpDquQc=; b=mCoreyTFmLamKcJ3cp3fMNFpcY
	cM7+FfI5Lx0gc1ZQGPmL+ahI72yqKgrHjhGOJvg8xudP9XrlGPSiqYAD+ku6HFXHIEinde1LZnO0V
	1ZB5Ef3PWd58oqYyOgEW+75aci8T/KBgvWIUcX00Oo32JpZM4/2ndZGW6/sYxgH2SNuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tb01v-007IDO-Co; Thu, 23 Jan 2025 17:26:07 +0100
Date: Thu, 23 Jan 2025 17:26:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Milos Reljin <milos_reljin@outlook.com>
Cc: andrei.botila@oss.nxp.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, milos.reljin@rt-rk.com
Subject: Re: [PATCH v2] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID: <bbee969d-7464-497a-a98b-4e6055176fbc@lunn.ch>
References: <AM8P250MB0124B5051DF9B54EC325644CE1E02@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8P250MB0124B5051DF9B54EC325644CE1E02@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>

On Thu, Jan 23, 2025 at 03:43:46PM +0000, Milos Reljin wrote:
> In application note (AN13663) for TJA1120, on page 30, there's a figure
> with average PHY startup timing values following software reset.
> The time it takes for SMI to become operational after software reset
> ranges roughly from 500 us to 1500 us.
> 
> This commit adds 2000 us delay after MDIO write which triggers software
> reset. Without this delay, soft_reset function returns an error and
> prevents successful PHY init.

Is this a fix? Should it be backported to stable? If so:

Fixes: b050f2f15e04 ("phy: nxp-c45: add driver for tja1103")

and it should really indicate the net tree in the Subject: line.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Otherwise the patch looks good. Thanks for the updated commit message.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

