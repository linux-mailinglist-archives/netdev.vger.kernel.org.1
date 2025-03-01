Return-Path: <netdev+bounces-170949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F9A4AC7F
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DDF17138A
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8C1DE3A3;
	Sat,  1 Mar 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SZqIo3Xr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA035976
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842136; cv=none; b=Ufwz3ISsbQ4U9eE4yEFKJphA9Dk1RUGudaTa8hjBwd0zOhwj3EqDMEUmVp0gcxsmY/fipfEj63VJAq4RtQQrVPirvKr72EtIgW0tIgeCroAXMIUsBKSSDT3HPP0YWII9HY1YrEQ8ObF15ClIMWvKGHD/akQvomyjvV9916t6lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842136; c=relaxed/simple;
	bh=2KgDhait4VOyxn0K/Pb/xtbbcRtfybSnzOMuUpV1qRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps5o8/iSE9ywNp+TD2bG3rzGCnWcZxHsWytg841k7YlQLNKbZggQ6P/JzezW2w6+hKnXX5iUeghPb2t1u3i9TEwxuajr9gpfXn9A/1NoWH7YK22T3NTtMMUlWWJfretDuosPzaQKGdBcHEvI12wMfW47PJTtcH5Fv2BbUj4AX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SZqIo3Xr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=04Av02GWIrKnQFrIEX9q1ez63PubUFTQ9f9hPd/0h/4=; b=SZqIo3XrzrCFZqV5rqSkEpYS0l
	1CahZqGALnxEJQS2XiSzTq14jMMpfLaVMSv/qFmGjmkzMW5yjLUwA6d1uISL4s/M57mcD1xeb9aUj
	elqP0tzssi96dBXOHEDZc4CCdWaW0FncLuH6t794K9sX58NmUYnPwV+YZc/ruqPJFn2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1toOYf-001Hla-5s; Sat, 01 Mar 2025 16:15:17 +0100
Date: Sat, 1 Mar 2025 16:15:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [QUERY] : STMMAC Clocks
Message-ID: <e54bf5af-b2ab-496d-9146-41f88bc4b5f2@lunn.ch>
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
 <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
 <Z8LkPQ-w_jyXriFp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8LkPQ-w_jyXriFp@shell.armlinux.org.uk>

> However, I think that we should push to standardise on the Synopsys
> named clock names where they exist (essentially optional) and then
> allow platform specific clocks where they're buried out of view in
> the way I describe above.

Interestingly snps,dwc-qos-ethernet.txt has a pretty good description:

- clock-names: May contain any/all of the following depending on the IP
  configuration, in any order:
  - "tx"
    The EQOS transmit path clock. The HW signal name is clk_tx_i.
    In some configurations (e.g. GMII/RGMII), this clock also drives the PHY TX
    path. In other configurations, other clocks (such as tx_125, rmii) may
    drive the PHY TX path.
  - "rx"
    The EQOS receive path clock. The HW signal name is clk_rx_i.
    In some configurations (e.g. GMII/RGMII), this clock is derived from the
    PHY's RX clock output. In other configurations, other clocks (such as
    rx_125, rmii) may drive the EQOS RX path.
    In cases where the PHY clock is directly fed into the EQOS receive path
    without intervening logic, the DT need not represent this clock, since it
    is assumed to be fully under the control of the PHY device/driver. In
    cases where SoC integration adds additional logic to this path, such as a
    SW-controlled clock gate, this clock should be represented in DT.
  - "slave_bus"
    The CPU/slave-bus (CSR) interface clock. This applies to any bus type;
    APB, AHB, AXI, etc. The HW signal name is hclk_i (AHB) or clk_csr_i (other
    buses).
  - "master_bus"
    The master bus interface clock. Only required in configurations that use a
    separate clock for the master and slave bus interfaces. The HW signal name
    is hclk_i (AHB) or aclk_i (AXI).
  - "ptp_ref"
    The PTP reference clock. The HW signal name is clk_ptp_ref_i.
  - "phy_ref_clk"
    This clock is deprecated and should not be used by new compatible values.
    It is equivalent to "tx".
  - "apb_pclk"
    This clock is deprecated and should not be used by new compatible values.
    It is equivalent to "slave_bus".

But snps,dwmac.yaml only has:

 clock-names:
    minItems: 1
    maxItems: 8
    additionalItems: true
    contains:
      enum:
        - stmmaceth
        - pclk
        - ptp_ref

Could you improve the description in snps,dwmac.yaml, based on what
you seen in the data book?

	Andrew

