Return-Path: <netdev+bounces-245870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8135CD9B10
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 378AE3018367
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6933FE20;
	Tue, 23 Dec 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4p+PDjdA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8F30C61D;
	Tue, 23 Dec 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500770; cv=none; b=LTbqnnq3/c1JkXHF9c6pNsRu/XMz3E/bFiK/R6p56byHiAjLuOexb9Ti+tJTr89abMlN1VTP6/J17CMvKn6+6rsfbaDPmoRwMAGrj4kbzxvpgkGV/E2cOsXUPa4uxyCZ5/UXq/txlXYVEKPes5gqIHytTVms9roRjWCze+VLlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500770; c=relaxed/simple;
	bh=6TTN29y+PWS/l3rr55eYaeynFlLWeN5aD3GULWrG0+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZwjKowe9ATpQVp+vmCx35RQCrGWuSNAYpYxFRa2i7m2XpjJwoLmlfbToEJ2lzGn3T0sTj6IUkW9eDDBUJuqdxb+YE53Ptgys9aH+1HUrAOXCAO3UnION0MTwq1MQu9jdYShoFYuae2eKFUUg6Eh6i1hyboaUzAg+fq+xpWoD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4p+PDjdA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MM9Pj+PXuCZ6pYBf+KPnNr4iahWd8btyo39UXWREDuo=; b=4p+PDjdAX2dWsIgQPmZBfeDGt4
	c5FGae3HbLpfh6kynusQjD+o4CxkkpKbIYIhUNrCdRuf1zQqmJed0iUcb4fJ7MQiAfrfQ8W/ClUXB
	L8A6PmL/GKWFyr1Szs71DwqSCoesmk2Nm6guQmB0vPM5LMhY/hV/zAVznsPdIIb1XxX0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vY3Xo-000JH2-Sb; Tue, 23 Dec 2025 15:39:24 +0100
Date: Tue, 23 Dec 2025 15:39:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: net: micrel: Convert
 micrel-ksz90x1.txt to DT schema
Message-ID: <84bd049b-3c60-47e0-a404-be764758f5b1@lunn.ch>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223133446.22401-3-eichest@gmail.com>

> +      patternProperties:
> +        '^([rt]xd[0-3]|[rt]xc|rxdv|txen)-skew-ps$':
> +          description: |
> +            Skew control of the pad in picoseconds. A value of 0 equals to a
> +            skew of -840ps.
> +            The actual increment on the chip is 120ps ranging from -840ps to
> +            960ps, this mismatch comes from a documentation error before
> +            datasheet revision 1.2 (Feb 2014):

> -  Device Tree Value	Delay	Pad Skew Register Value
> -  -----------------------------------------------------
> -	0   		-840ps		0000
> -	200 		-720ps		0001
> -	400 		-600ps		0010
> -	600 		-480ps		0011
> -	800 		-360ps		0100
> -	1000		-240ps		0101
> -	1200		-120ps		0110
> -	1400		   0ps		0111
> -	1600		 120ps		1000
> -	1800		 240ps		1001
> -	2000		 360ps		1010
> -	2200		 480ps		1011
> -	2400		 600ps		1100
> -	2600		 720ps		1101
> -	2800		 840ps		1110
> -	3000		 960ps		1111

I think this table is more readable? But maybe without the register
value, which is an implementation detail.

	Andrew

