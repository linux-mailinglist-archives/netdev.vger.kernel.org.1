Return-Path: <netdev+bounces-184434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEFA956B0
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 21:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D7F1895E36
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5291EEA5E;
	Mon, 21 Apr 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JYRwM/jE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3627463;
	Mon, 21 Apr 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263258; cv=none; b=mIv1G/zXOXcq8LUx7TTEsMz0Z2qrN+mi+HF8mX2fXgkZ1VPrsMOobWSsEfxDU39Q9u6MXbUWiAV0A1L0mYpnzfoZJHxkK/n2GFkA4EzCJQvRoVXLCHIvZDwdUWRTXDUGRToX2f4W5XphAQLdzhlAvQz3fbEcp+UjdRx6es8IHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263258; c=relaxed/simple;
	bh=FIgFzNnBr++vmjtDk8pCe3cYTsEPiaXPjORFzQs4bws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rhdfod3r75r42uuog+mQjOWBu4DLgSogQsLLSKWDS8eSKTEbo2+61vaRi8PEJ4N2od7jOOJZat236vaqxz5bnNICwPtxhK86cYPC2WvIB884wLQLEzrsCti+VCO81mUi4hjKn5hDO8oFeoQ6g+X1W3lBSi4rLJg//LQftsZvmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JYRwM/jE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RBxdBp38IXRTVJ8jY24aTNAum3SlxGZFX20fKSQ3ODk=; b=JYRwM/jEdQoWgGqz6IdOEGv5e0
	D/tDikDnrG0Zhs6L62dkRU3gpNIyQa5Sqn7jXvKICVVMX2FiKeVl8hrgfKNt3ivSdKTUjvpBpaYUp
	oJPbnMmr3MS/8wX/kBL9F7OafQgHlIjx/ey0huY5PAOPGA41R+mS+/zf0cnLfDxdTQhWqhnW6/7TS
	O2ei9BBeMgvKyeBHj44IIspAKGjekqp4k4aqAVcA18ljtzZbX61rFTzz0QFRpLYeDSdVHnTuqQxLc
	9WUa3/qvqz8TLAiH3FQyEK4Jr3cX1Xeox3El7JzIOjKSa5iWn3BcuuVajsAIBnbyH8inmnyXZS2bc
	xUq6JpPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50644)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u6wh1-0003I5-1f;
	Mon, 21 Apr 2025 20:20:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u6wgw-0006hE-0M;
	Mon, 21 Apr 2025 20:20:30 +0100
Date: Mon, 21 Apr 2025 20:20:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 45819b2358002..2ddc1ce2439a6 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -74,19 +74,21 @@ properties:
>        - rev-rmii
>        - moca
>  
> -      # RX and TX delays are added by the MAC when required
> +      # RX and TX delays are part of the board design (through PCB traces). MAC
> +      # and PHY must not add delays.
>        - rgmii
>  
> -      # RGMII with internal RX and TX delays provided by the PHY,
> -      # the MAC should not add the RX or TX delays in this case
> +      # RGMII with internal RX and TX delays provided by the MAC or PHY. No
> +      # delays are included in the board design; this is the most common case
> +      # in modern designs.
>        - rgmii-id
>  
> -      # RGMII with internal RX delay provided by the PHY, the MAC
> -      # should not add an RX delay in this case
> +      # RGMII with internal RX delay provided by the MAC or PHY. TX delay is
> +      # part of the board design.
>        - rgmii-rxid
>  
> -      # RGMII with internal TX delay provided by the PHY, the MAC
> -      # should not add an TX delay in this case
> +      # RGMII with internal TX delay provided by the MAC or PHY. RX delay is
> +      # part of the board design.
>        - rgmii-txid
>        - rtbi
>        - smii

Sorry, but I don't think this wording improves the situation - in fact,
I think it makes the whole thing way more confusing.

Scenario 1: I'm a network device driver author. I read the above, Okay,
I have a RGMII interface, but I need delays to be added. I'll detect
when RGMII-ID is used, and cause the MAC driver to add the delays, but
still pass PHY_INTERFACE_MODE_RGMII_ID to phylib.

Scenario 2: I'm writing a DT file for a board. Hmm, so if I specify
rgmii because the delays are implemented in the traces, but I need to
fine-tune them. However, the documentation says that delays must not
be added by the MAC or the PHY so how do I adjust them. I know, I'll
use rgmii-id because that allows delays!

I suspect neither of these two are really want you mean, but given
this wording, that's exactly where it leads - which is more
confusion and less proper understanding.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

