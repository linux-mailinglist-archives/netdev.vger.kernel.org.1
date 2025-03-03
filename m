Return-Path: <netdev+bounces-171302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39D4A4C6F4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BF91719C4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2322356AF;
	Mon,  3 Mar 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w3Y+gMNg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96023537A;
	Mon,  3 Mar 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018573; cv=none; b=g55Luqd07yCP1aJvfsxK1hAbiVQfFp7qoxVBEgu43JT1MA5iqijjE9mElMhGAnabYEVk0tEr+RVihyGHZEbD0+zAS054VKPCGBRY2JvAuCf+XLlM45kMXFZcmegahXOoSxIHwiFzuppAH+/ocTB2zX5YDYdJqS6erTKeQmWwaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018573; c=relaxed/simple;
	bh=PXYD7enaEEC2B+4t1Mddyq/cp/vGAdtV6nK5/i0Potg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWtxPRXDrCXtybkNRQ1N01BL1XX9Y0VcKxe4LzjKbYfSeSr70jUDE6mAhQTCNX/3TpauzR5YSqXLOaaZT65V5z9TdrzsGIcKheICWBFyJwqBFYDWzj25wH8Dk/eEyqKWrWCBd4Wo9L/hIe7UBHwf04oo1TnR9/E4LJ8lSOcXMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w3Y+gMNg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zednl9Xz9rjKPfU1f0ZWLrff0ZoIoDCzDmBtTmsQLeg=; b=w3Y+gMNgxLZ+HNORcoDYauNgZC
	bfgL9wey9gp6zKeFmdwOWOpPH/mTpzp3tmNh7PAlEot1LPRccePV+JbmEgjBGV/gt8tjyshUQryTD
	UFb6Yhrpsuy1C2yZ//1JbBTWorF+6hqk+FAubL57p74UDtp8gfrPWFTn8Mtp5FeID+us=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp8SP-001rE4-NS; Mon, 03 Mar 2025 17:15:53 +0100
Date: Mon, 3 Mar 2025 17:15:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, rmk+kernel@armlinux.org.uk,
	javier.carrasco.cruz@gmail.com, john@phrozen.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add
 internal-PHY-to-PHY CPU link example
Message-ID: <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Mon, Mar 03, 2025 at 11:24:35PM +0800, Ziyang Huang wrote:
> Current example use external PHY. With the previous patch, internal PHY
> is also supported.
> 
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/qca8k.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> index 167398ab253a..a71dc38d6bab 100644
> --- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> @@ -185,8 +185,10 @@ examples:
>                  };
>  
>                  port@4 {
> +                    /* PHY-to-PHY CPU link */
>                      reg = <4>;
> -                    label = "lan4";
> +                    ethernet = <&gmac2>;
> +                    phy-mode = "gmii";
>                      phy-handle = <&external_phy_port4>;
>                  };
>  
> @@ -266,8 +268,9 @@ examples:
>                  };
>  
>                  port@4 {
> +                    /* PHY-to-PHY CPU link */
>                      reg = <4>;
> -                    label = "lan4";
> +                    ethernet = <&gmac2>;
>                      phy-mode = "internal";
>                      phy-handle = <&internal_phy_port4>;
>                  };

Adding some more context:

                port@4 {
                    reg = <4>;
                    label = "lan4";
                    phy-mode = "internal";
                    phy-handle = <&internal_phy_port4>;
                };

                port@5 {
                    reg = <5>;
                    label = "wan";
                    phy-mode = "internal";
                    phy-handle = <&internal_phy_port5>;
                };

                port@6 {
                    reg = <0>;
                    ethernet = <&gmac1>;
                    phy-mode = "sgmii";

                    qca,sgmii-rxclk-falling-edge;

                    fixed-link {
                        speed = <1000>;
                        full-duplex;
                    };
                };
            };

The previous patch still causes it to look at port 0 and then port 6
first. Only if they are not CPU ports will it look at other ports. So
this example does not work, port 6 will be the CPU port, even with the
properties you added.

When you fix this, i also think it would be good to extend:

> +                    /* PHY-to-PHY CPU link */

with the work internal.

This also seems an odd architecture to me. If this is SoC internal,
why not do a MAC to MAC link? What benefit do you get from having the
PHYs?


    Andrew

---
pw-bot: cr

