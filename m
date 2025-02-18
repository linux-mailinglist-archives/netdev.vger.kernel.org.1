Return-Path: <netdev+bounces-167386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE5A3A14F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55301888A95
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9226BD8F;
	Tue, 18 Feb 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2bQybeC3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A726AA94;
	Tue, 18 Feb 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892828; cv=none; b=Hih/UJ6jGYJGCVchYea3v94k131C7ODEZdUgk6s9XRjvMxpVnYFfVkHK4nXrHqmqm80iXJ9DW5MoopNofk5NJv4Ez5fKsDXASVE6zRWARKjojQ1a56Hheu34E7Sow0/bc33hPLIi72G4nppGXrxenevjIGycEaYw4+JHqDUDgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892828; c=relaxed/simple;
	bh=pBZ6DBcpflfPTTSV2qkpelSifShPkMmpmLDJ2Bgc24E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf21TsLxXVUMN7Dafwfc3PtzK+EVVGiCw4gCpnWY0GoLsD0ot6Xd5uXhsbnZT6DbdddzkW22TQ0piD3V7ctxljX4HB/OXbzku2M0BLvB6y+CvD880YsZEBrqK/WZ20tYLrN3/WI9X2iypGEzhvuNFphFqYl3cQWz7F49C6L7XDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2bQybeC3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+SR6bZ23Iqbr9gYinpkbLkkCfOXGYiitlLTZ/pTqB2k=; b=2bQybeC3IMlugSflIXxflyUFQz
	ovuJU1pjz1QG/81pSg5ugxg5hB52YnTM9JviZUPcxWW+02PWxwtJG/2R39OAWS84C02ERiduOm2v/
	WnAjHF/KStEfYdvt4Uiq2cMlCCWvGzA7invLn7XTZUaqt6YqNpW6HooEoKkh5YgbQCgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkPbD-00FKur-Pa; Tue, 18 Feb 2025 16:33:27 +0100
Date: Tue, 18 Feb 2025 16:33:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Pankaj	Dubey' <pankaj.dubey@samsung.com>, ravi.patel@samsung.com
Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <69d1b0fe-d35f-4242-bf80-6c024cf72dd1@lunn.ch>
References: <20250213044624.37334-1-swathi.ks@samsung.com>
 <CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
 <20250213044624.37334-2-swathi.ks@samsung.com>
 <85e0dec0-5b40-427a-9417-cae0ed2aa484@lunn.ch>
 <00b001db7e9f$ca7cfbd0$5f76f370$@samsung.com>
 <ffb13051-ab93-4729-8b98-20e278552673@lunn.ch>
 <011901db80fb$8e968f60$abc3ae20$@samsung.com>
 <18746e2f-4124-4f85-97d2-a040b78b4b34@lunn.ch>
 <015601db81b8$ee7237f0$cb56a7d0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015601db81b8$ee7237f0$cb56a7d0$@samsung.com>

> Hi Andrew, 
> Thanks for the clarification.
> Will post v7 with the following updates:
> 
> 1. Changing phy-mode in dt-binding as shown below:
>   phy-mode:
>     enum:
>       - rgmii
>       - rgmii-id
>       - rgmii-rxid
>       - rgmii-txid
> 	  
> 2. Removing phy-mode from .dtsi and example given in dt-binding

The example can use phy-mode, since the example is the combination of
the .dtsi and the .dts parts of the device tree. And having the
example using 'rgmii-id' will hopefully prevent some people wrongly
using 'rgmii'

> 3. Add phy-mode to .dts file and specify 'rgmii-id' there.

Great. History shows if you get the example and the first user
correct, everybody blindly copies it and gets it right by accident. If
the first user is wrong, everybody blindly copies it, and get is wrong
by not sanity checking what they copy.

	Andrew

