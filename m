Return-Path: <netdev+bounces-173985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78466A5CC3D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CB63A31C1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3425FA2F;
	Tue, 11 Mar 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSfE7xhD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F01925AF;
	Tue, 11 Mar 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714426; cv=none; b=EJ1cTzFnjktTkHSgipzz+8X3C2RMLZLmYAQ4qmeeX8eZDR4BPrbbaDUfD8QLqhPzFniKU/wKcfRPfyhIGZNMXFiIKbuuJx4Z2xUKPZRNknZ+FD3X+yDQqex5EWmmKac7YAPyR/FhrsQseoHuIen52tZn2Bhu5rsygPXnlsRIHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714426; c=relaxed/simple;
	bh=MltOihUXzgv+EEBgM5uJkF4euy92dMq6NOYuBiqedKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNe6G1lLrjYsGq/oG5eLwB7OouDCVHmzSeN3RgyYaezp60rquDiqG2vCAhgn/x69YH0DHXjErM7CMY5B2TSxnmpM3rJuTbxSbZERo6B2xbbC3BYNMnu1jNW/FIVPfx3xwmaT+/s4r/8Z04ddEnfiVu2tAxDBLhBUdr8KYHf3yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSfE7xhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A89C4CEE9;
	Tue, 11 Mar 2025 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741714425;
	bh=MltOihUXzgv+EEBgM5uJkF4euy92dMq6NOYuBiqedKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSfE7xhDQ5slphlIJ3b6YsRdjT7deCO5YH9nFXoQff5CotLov5/c1oTKg+fwldIDs
	 pz2TfTJ78V89pacdPueLsNWNWakRwHL8oroawm5npDcsC4t9yLkTLdmA+L6xq9XqR/
	 gFKE6iDftPCNms4pGceW8h6/9AX8wkNRwIOt1CT7ruoIfqHjz1KDrRpkYea0zT/WeI
	 GwsTMSAoqOZiEVb8KuobW/gWbTD5V9uI90bDkhVxCwlRZ2KYWmszP51ZYGQKc9Vko1
	 IPjSR56YiQWeLlYYsIOVTFy2tjjvp44xaEQSzH0hnzUsNBNhA9zK7WERx8wiWXFNad
	 oEXlbZhCE+zjQ==
Date: Tue, 11 Mar 2025 12:33:44 -0500
From: Rob Herring <robh@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: ethernet-phy: add
 property mac-series-termination-ohms
Message-ID: <20250311173344.GA3802548-robh@kernel.org>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
 <20250307-dp83822-mac-impedance-v1-1-bdd85a759b45@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-dp83822-mac-impedance-v1-1-bdd85a759b45@liebherr.com>

On Fri, Mar 07, 2025 at 11:30:01AM +0100, Dimitri Fedrau wrote:
> Add property mac-series-termination-ohms in the device tree bindings for
> selecting the resistance value of the builtin series termination resistors
> of the PHY. Changing the resistance to an appropriate value can reduce
> signal reflections and therefore improve signal quality.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 824bbe4333b7ed95cc39737d3c334a20aa890f01..4a710315a83ccf15bfc210ae432ae988cf31e04c 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -238,6 +238,11 @@ properties:
>        peak-to-peak specified in ANSI X3.263. When omitted, the PHYs default
>        will be left as is.
>  
> +  mac-series-termination-ohms:

A property of the MAC (or associated with it) should be in the MAC's 
node. Also, sounds like either either end could have a property. We 
already have similar properties in other cases: 'termination-ohms' for 
example. That appears to be for series term as well given a value of 
120ohms. 

Rob

