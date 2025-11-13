Return-Path: <netdev+bounces-238431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F089C58C5C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9933F3A609C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506835770B;
	Thu, 13 Nov 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RFl8jFEW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504D3559EE;
	Thu, 13 Nov 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050536; cv=none; b=k49uOaDQuguJJ16p4eyKZcQsIcl81Z8cARv9fm0iGr9cnWnNWb0OwMsm8ajINWAKnU1F4ECdpIknx3u5zm6xNKT6gVOpupwotc8MB1FfzOtspU6boTvnUdaBhr7L6KWNWSJdtshJOzUTMz9dYXlHIIw9U83NmH1xLns8WdqoHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050536; c=relaxed/simple;
	bh=zch5XTqmqwnqBMfus+pEfLGmlWoIhGTvKQwot44PA08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeGiGRC49uYhl6L55k0vemChERKBNlE72js+YYNiNaGYcWyx93T++ceSWlp/94M2lMU+20Znl7nwO4aJz3cjyUNvctexDQ8IS+CbGicVMl4TKxTGANlsTIpzvLp9W8f7G7/UHsceD82yMPenRNZLaJzz92ukEzmEPonWv1pO57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RFl8jFEW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d1qG2EOOPA2rU/81jZpVYjHAuGn8lV28KM97X2B3IAQ=; b=RFl8jFEWbUqFBQhFWlez5KnQL2
	BmAq7H9ktc1BVFJUqNs9yl8UFNn+x9ocZRbgOCKlTe2GEA2bFfIKEWZAWzKGidxJ+BP4LYcc9OgHI
	u1ktH/M4LvxP5YBftL/bqZveqHHCaiy4gOLYcnAH7p4nGK1WsVZ8kHrGX28+atAM0ZI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJZyl-00DtMx-HK; Thu, 13 Nov 2025 17:15:23 +0100
Date: Thu, 13 Nov 2025 17:15:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Message-ID: <f6acd8db-4512-4f5d-a8cc-0cc522573db5@lunn.ch>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
 <20251113115206.140339-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113115206.140339-2-parthiban.veerasooran@microchip.com>

> +/**
> + * genphy_c45_oatc14_get_sqi - Get Signal Quality Indicator (SQI) from an OATC14
> +			       10Base-T1S PHY
> + * @phydev: pointer to the PHY device structure
> + *
> + * Reads the SQI or SQI+ value from an OATC14-compatible 10Base-T1S PHY. If SQI+
> + * capability is supported, the function returns the extended SQI+ value;
> + * otherwise, it returns the basic SQI value.
> + *
> + * Return:
> + * * Positive SQI/SQI+ value on success
> + * * 0 if SQI update is not available

I thought 0 represented a very bad link? How is the call supposed to
know the difference between a bad link, and no new value, try again
later?

I had a very quick look at the standard. All that update seems to
indicate is that value has been updated since the last poll of that
bit. There is no indication you cannot read the 'old' SQI value if
there has not been an update. So i think you should always return an
SQI value, if it is if 'old'. 

> +	/* Read SQI capability */
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_ADFCAP);
> +	if (ret < 0)
> +		return ret;

I wounder if this should be cached somewhere. You don't expect it to
change.

	Andrew

