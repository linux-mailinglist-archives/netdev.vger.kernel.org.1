Return-Path: <netdev+bounces-207096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A86B05AE8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700B53A896E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD32E2F00;
	Tue, 15 Jul 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LxVtsJyk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CF145355;
	Tue, 15 Jul 2025 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584970; cv=none; b=HJ/PMNQvyLJkbxCUdzdjz9skkv6sn708K0q6BB3WCTs3IMfAS9Mpme1bKumQni2hmgdLy4TkvtUDv/Mx74z2iTv7jKEvjAJqruQtthNZ4ZOOuy9dVsPprc101BiH1JtwPfGB6Oymebxig+eEEPvQu8eNC4A5k9ZH6b1LKh/dAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584970; c=relaxed/simple;
	bh=eoF/UePDKZmut/JhG6GaJN6c2Lua9uujSd7gKNYVqD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1d1XCklEFtMyf2O7jJD7286cLMOK8wlCw1l67MW3IypFmtVRiDcKbhV8PujGfhlEef5QwzTAfbq76LZEIjRyrx0WpRtVoATF4XMoPPMYBIqBcEOcqPLysJUkOONT+rlMbNPT8OV9vISEFNt646Wm5+j0ncPQ6TbUluAYp7uWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LxVtsJyk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=16c8+dR6HK0YJK9HdtebFuRBOksx/FzCYGCA1VXItEE=; b=LxVtsJyka2iWGcioJGwDwlizsr
	L4EoRNpGscSylpareAM6ksRdtJVRFOsui0skpA2/emISSuak68BrHCOwSX67AqvNVMsbZRfVt0T1x
	1GK7n791vGtFiKvcyV7KK6VVRcHhKCBcOhznASGSpV5vB2jBFhfT7ss8ERvpNv/FdH60=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubfPJ-001a2l-Pl; Tue, 15 Jul 2025 15:09:17 +0200
Date: Tue, 15 Jul 2025 15:09:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com,
	jszhang@kernel.org, jan.petrous@oss.nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	boon.khai.ng@altera.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <e734f2fd-b96f-4981-9f00-a94f3fd03213@lunn.ch>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
 <c212c50e-52ae-4330-8e67-792e83ab29e4@lunn.ch>
 <7ccc507d.34b1.1980d6a26c0.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccc507d.34b1.1980d6a26c0.Coremail.lizhi2@eswincomputing.com>

> > > +	dwc_priv->dly_param_1000m[0] = EIC7700_DELAY_VALUE0;
> > > +	dwc_priv->dly_param_1000m[1] = EIC7700_DELAY_VALUE1;
> > > +	dwc_priv->dly_param_1000m[2] = EIC7700_DELAY_VALUE0;
> > > +	dwc_priv->dly_param_100m[0] = EIC7700_DELAY_VALUE0;
> > > +	dwc_priv->dly_param_100m[1] = EIC7700_DELAY_VALUE1;
> > > +	dwc_priv->dly_param_100m[2] = EIC7700_DELAY_VALUE0;
> > > +	dwc_priv->dly_param_10m[0] = 0x0;
> > > +	dwc_priv->dly_param_10m[1] = 0x0;
> > > +	dwc_priv->dly_param_10m[2] = 0x0;
> > 
> > What are the three different values for?
> > 
> 
> Let me clarify the purpose of the three elements in each dly_param_* array:
>   dly_param_[x][0]: Delay configuration for TXD signals
>   dly_param_[x][1]: Delay configuration for control signals (e.g., TX_EN, RX_DV, RX_CLK)
>   dly_param_[x][2]: Delay configuration for RXD signals

Maybe add a #define or an enum for the index.

Do these delays represent the RGMII 2ns delay?

> > {
> > > +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> > > +				  &dwc_priv->dly_param_1000m[1]);
> > > +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> > > +				  &dwc_priv->dly_param_100m[1]);
> > > +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> > > +				  &dwc_priv->dly_param_10m[1]);
> > > +	} else {
> > > +		dev_dbg(&pdev->dev, " use default dly\n");
> > 
> > What is the default? It should be 0ps. So there is no point printing
> > this message.
> > 
> 
> The default value is EIC7700_DELAY_VALUE1

But what does EIC7700_DELAY_VALUE1 mean? It should mean 0ps? But i'm
not sure it does.

	Andrew

