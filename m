Return-Path: <netdev+bounces-242971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8999C9795D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E10B9342762
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8A313535;
	Mon,  1 Dec 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a+Gre20t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A329313520;
	Mon,  1 Dec 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595509; cv=none; b=mAEq/FturKbxPKw4gik90IyQq/sk7/2i5G/lXyAqchurLO1eGjneKZ1V2L4VeobCABYHjPHbC3oI4AUYR6l50AEnb9U/xyNV7Dwn7PYmyI5br11Gw7U5flyX1dfKTDghpIhYdwhDSEoPxQFI1B6aerFyQNrIMlyI8okyQqTJlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595509; c=relaxed/simple;
	bh=f+FCiw6XUJ+ZW0EOn/kr2ROLz/Aj4+Qe16FgN2L2l4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAO8S6+bpSBQvXRG3xoudmivtEx8zJlZMbVr3ext9dQhNDNylelEt/u/NYLeVqfTkH3VGPATZKIdwcP0GYjd5ednpsv3PJ+KMGOkXELsdUupTfM4VQmPf7DZvbBiwvo+RinyTMRekHycWhx8tqmSNfSJipNPZZwrLbzRXxpTfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a+Gre20t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qanFeqiv1sc96LI2Va2y/BpY7wPd+jCatqtnX/HaoAc=; b=a+Gre20tijP9/u4+/PZJ6k8cSC
	vI5SvmnF/kCsxGFLziUjgM7Ddb5ztszyB3J7a+QO0mWfQ1MLtaVBpBXQFg8xNmY6d5VwRpURubwRQ
	TUewBr2rNo7KbqC5mbdKA2V6s9OO99nhytyuJ0MDp8tf9xE2o4g4OZ7irSl1uSehBN0Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQ3ta-00FZfr-JL; Mon, 01 Dec 2025 14:24:50 +0100
Date: Mon, 1 Dec 2025 14:24:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Message-ID: <1fe8ced1-e626-467b-9120-2aeba6b4e089@lunn.ch>
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
 <20251201032346.6699-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201032346.6699-2-parthiban.veerasooran@microchip.com>

On Mon, Dec 01, 2025 at 08:53:45AM +0530, Parthiban Veerasooran wrote:
> Add support for reading Signal Quality Indicator (SQI) and enhanced SQI+
> from OATC14 10Base-T1S PHYs.
> 
> - Introduce MDIO register definitions for DCQ_SQI and DCQ_SQIPLUS.
> - Add `genphy_c45_oatc14_get_sqi_max()` to return the maximum supported
>   SQI/SQI+ level.
> - Add `genphy_c45_oatc14_get_sqi()` to return the current SQI or SQI+
>   value.
> - Update `include/linux/phy.h` to expose the new APIs.
> 
> SQI+ capability is read from the Advanced Diagnostic Features Capability
> register (ADFCAP). If SQI+ is supported, the driver calculates the value
> from the MSBs of the DCQ_SQIPLUS register; otherwise, it falls back to
> basic SQI (0-7 levels). This enables ethtool to report the SQI value for
> OATC14 10Base-T1S PHYs.
> 
> Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features
> Specification ref:
> https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
> 
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

