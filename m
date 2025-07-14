Return-Path: <netdev+bounces-206798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F2B04670
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D424A1536
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136CE265296;
	Mon, 14 Jul 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cVmRZpNN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313E261568;
	Mon, 14 Jul 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513931; cv=none; b=YPjs8PpCcKFcLVktuvzjAJ1x+niSJ6ywcIoZQmM8Mx1f9OdQCiNN/smtjQ8xhv6fjMt7NrMKj8C9xMhL4KnyniyfIAwz/Z0hv4BoAPQ8E9mSZ7mui6ZDNKa91FEY6c2LQyXlDT0EUAycSEPXS88nTqfnpFgabXcLVjrZJXiqSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513931; c=relaxed/simple;
	bh=GaWYQMK4/1ABzSjFrcTHi7UFAIxKNq3BuaaN/zUM+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4anc3SopQG8xsbRFCb7MSl2jSZyLPbQNl8Lq5KVIwiwYHPo6YT4v3V8/6nm+IvPWxam0GrvEmrMkAeGdtLjsYLIOAcwCEumu/x84J22z9ejRpQr+Jk6MK2OIMPCsemKMKP5tCAUPAEVAbFXEJPU+8I+vBG59zG+wXTAp8L2SeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cVmRZpNN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wL7y/Nn7lZ/3su+iamM0BGUV0JlXorw1/aqkJA86Ld0=; b=cVmRZpNNmKdhZl30VJDzK5k6/2
	Fdnk5u2nGfc8d3aA9HHImCPqgivZ9aaJohjxs/C4cRZVL16T7kpTiIdAbtogly5w3JH12/azRZVPq
	bxeiItAxABCAAaEXFW/xQgc0HbKRSRx0NXad/uPPhJu6qEPf2/+25uKyFyXzENHezBuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubMvG-001UUB-Dt; Mon, 14 Jul 2025 19:25:02 +0200
Date: Mon, 14 Jul 2025 19:25:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, dinguyen@kernel.org,
	maxime.chevallier@bootlin.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
 Agilex5 dev kit
Message-ID: <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-4-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714152528.311398-4-matthew.gerlach@altera.com>

> +&gmac2 {
> +	status = "okay";
> +	phy-mode = "rgmii";	/* Delays implemented by the IO ring of the Agilex5 SOCFPGA. */

Please could you explain in more details what this means.

The normal meaning for 'rgmii' is that the PCB implements the delay. I
just want to fully understand what this IO ring is, and if it is part
of the PCB.

> +	phy-handle = <&emac2_phy0>;
> +	max-frame-size = <9000>;
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		emac2_phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};

Please add a newline in here to separate the inner node from the
rest.

    Andrew

---
pw-bot: cr

