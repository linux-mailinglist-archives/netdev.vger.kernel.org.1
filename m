Return-Path: <netdev+bounces-235524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58DC31ECC
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA218C48AB
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD1272E41;
	Tue,  4 Nov 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nv1G8DYe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125827703C;
	Tue,  4 Nov 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271320; cv=none; b=RE/4Sf09ItWFO2PF3zNtxwPMbdwXBwK0xwbWzKlqpCFzfbzBTDv0AByEBERK9M5tRK8+nMtt+aPjmG6fdfjWPdkp4xF/8BHa03LvHbw87SPkOscEzUuXSQdanG/G2gF6aN3DcF5T3Qc/WvxGYG77UZkC+i6Zpxc5KeKN35MAQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271320; c=relaxed/simple;
	bh=aGe2A7SGNdDP4G3wTqnlP3T3ycTJTZT/CZpnlJsLvas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHDl1/UEM7ZTV4Lb1DnaXXVNIem3nY0tnuUUUwzlyYhaIzOHUTzPM5SReN7bShC7TGUfrr3xnL54UvWnhNHZavPEthhiZsnxb78bbUd5PN4rzDR13JHPSaqvpYHTsQGM54ukwiQqIPrP9rGGyCvq22dClv1pFHCpP1JiuVO+n/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Nv1G8DYe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9XnubeHy0V4MovqTn+FEeVR8KioBS8pCCfGpqCEoueI=; b=Nv1G8DYeqfz/RRbWTipfRhdlYb
	4+psaPvs1R3Dc/LAiIo4VXGJMfZ1ZT795B4MCvMLxH0+KcFoDLXJDUYrg+5RzUMRa48cJoADoNHjt
	TG/pZYOFULBhog+m+sUKT3LKctlenNbxvP2vhBHLXQEKpgl7ak/mtJE9SZ7R+TneP2L0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGJGo-00Cu5O-GA; Tue, 04 Nov 2025 16:48:30 +0100
Date: Tue, 4 Nov 2025 16:48:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1s:: add cable
 diagnostic support for LAN867x Rev.D0
Message-ID: <3344ecef-3b45-42f7-b501-475413efbafe@lunn.ch>
References: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
 <20251104102013.63967-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104102013.63967-3-parthiban.veerasooran@microchip.com>

> +		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
> +		.cable_test_get_status =
> +					genphy_c45_oatc14_cable_test_get_status,

netdev prefers lines at < 80, but up to 100 are accepted when they
make sense. Please keep this on one lines.

	Andre

