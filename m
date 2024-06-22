Return-Path: <netdev+bounces-105882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B89135B3
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2F0283E49
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52138DEC;
	Sat, 22 Jun 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JIR44fpz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59F374CB;
	Sat, 22 Jun 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081852; cv=none; b=aTVVRshq7X7ziEkRB5la5c5VPlnGHIbUcsGJGETVdY0EiAwFRtv+431z3TRX6WHseGmkRnjIz7gWAIB98XtWndK5ngWpZiGqZ2z5NkKrDVGbJOvkxhISVoqg+1iBumK9/o4bsc5q/SE9mpZ25Z5gItSvcLsYKA0G4Vw1ZDgoYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081852; c=relaxed/simple;
	bh=GaqX2mqFW19Q4chlPp9rj1RxKUEKyoOt8XkbUUw+HYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HECO7q68AwveMPImqQc5DcDaAP2JsXgP/3nayxdxQ+nXXI0yNrg9nKzKUoy1DQEk5d9sOIAMh9bnUEg3l+6uylDcxcDq13wR+WjkHpCWRiId6sUGDDVQDF0t4C0sA1lGdYAyYElF/9nZ3FEKmICsNfGNTPOKDUQadhZ64815fOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JIR44fpz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jhVi5FhYxIXR2rmc25MlvFKVYwMuXU0X/Zyy9lMWHUU=; b=JI
	R44fpz2T28QDsR5nmwzTYlUl6J2uYDzGFRDuocYBXVeixZVIBc/3CUK3umZVluhPA7meTYHQe+0nJ
	PtuWiF6FvcB0LjWdK+LLLc5G3FktqefCwsZ12/zW1uwHFxhgXJTMZKxZ+BSPoByh4odIA25+TEAFd
	4VBMN+JJpmaTBnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL5iT-000kJX-95; Sat, 22 Jun 2024 20:44:01 +0200
Date: Sat, 22 Jun 2024 20:44:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <b35cd9c1-6778-4ca7-9961-f7e98a60d20b@lunn.ch>
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621112633.2802655-4-kamilh@axis.com>

On Fri, Jun 21, 2024 at 01:26:32PM +0200, Kamil Horák (2N) wrote:
> There is a group of PHY chips supporting BroadR-Reach link modes in
> a manner allowing for more or less identical register usage as standard
> Clause 22 PHY.
> These chips support standard Ethernet link modes as well, however, the
> circuitry is mutually exclusive and cannot be auto-detected.
> The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
> based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
> (1BR-10 in Broadcom documents).
> 
> Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 8fb2a6ee7e5b..0353ef98f2e1 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -93,6 +93,13 @@ properties:
>        the turn around line low at end of the control phase of the
>        MDIO transaction.
>  
> +  brr-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Request the PHY to operate in BroadR-Reach mode. This means the
> +      PHY will use the BroadR-Reach protocol to communicate with the other
> +      end of the link, including LDS auto-negotiation if applicable.

DT is supposed to describe hardware, not configuration. So i would
have a different description. Say that the coupling to the cable is
that for BroadR-Reach, not standard base-T.

The driver can then imply it needs to configure the hardware to
BroadR-Reach.

	Andrew

