Return-Path: <netdev+bounces-250590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF1D37AF8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA1031461D3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDBE34677D;
	Fri, 16 Jan 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3mvC97IN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3C2C21F4;
	Fri, 16 Jan 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585855; cv=none; b=dk22HzT1kBi1UWb4WILKbC2SFMkY9YwPlYBwE8cA9giO3EIJFSBpvPD7gNDz3KazkbrRv89mB2IxiijpMA2XrF6KuxmaVFdA9Lpo9zEj9a2NH0HFUOCJVusjKLSTsGbqW4DDaxEVcN1ie2v4vDqbC7STjn6yzIP+RiuAbjfoVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585855; c=relaxed/simple;
	bh=5SpgsjoIKRYn0rW9Mv2HD+hI9j2YH5rKZ34L7l1DLJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBQsf7Wxql/NliITpXOiI0KXmwFMLzS9F6Frit3LjteNVHigWK+WSY4sUeFjaQvemmSERUiI2Y3TwcyOsYWMREpitN243AAlL8WCkU8I7Eb+omb3JuF4IFngG3SfBF4rcp1rBQfsKKnQ1atf3i+yW0rEGpGMS9iY2d4PbGnE+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3mvC97IN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lXn8WREm1ikX1NgAMR5lcnRlZLOX/Na1hyGAcAzr8AA=; b=3mvC97INayYq0Tmyyi5lofQxVD
	s7aIVzAmP8ZkQw4JsZ0LgGcq7LRI8IVVzYZo3UsbZP2CaYJV86zErcvhFHWDIoSvqpvJrUhtGnpPJ
	d8NFblhPfHsV9zTTVhtLQ47kbRgZDjXFoFelFPuzfOmoWjPpi5umHBRN26AOjqiidsIo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgny9-0036L5-C4; Fri, 16 Jan 2026 18:50:45 +0100
Date: Fri, 16 Jan 2026 18:50:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: micrel: Convert
 micrel-ksz90x1.txt to DT schema
Message-ID: <70ebc8fe-eff6-4f29-accf-7ade18c24721@lunn.ch>
References: <20260116130948.79558-1-eichest@gmail.com>
 <20260116130948.79558-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116130948.79558-3-eichest@gmail.com>

On Fri, Jan 16, 2026 at 02:09:12PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the micrel-ksz90x1.txt to DT schema. Create a separate YAML file
> for this PHY series. The old naming of ksz90x1 would be misleading in
> this case, so rename it to gigabit, as it contains ksz9xx1 and lan8xxx
> gigabit PHYs.

Thanks for adding the table mapping skew to real skew.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

