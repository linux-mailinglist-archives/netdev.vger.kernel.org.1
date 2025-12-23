Return-Path: <netdev+bounces-245819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB334CD898C
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5757E301EC65
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C8327208;
	Tue, 23 Dec 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="am6RoUcs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748B3271F2;
	Tue, 23 Dec 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482413; cv=none; b=MSC/py/hCz09EG+g3qVj5XPouJ4xppJrq+gee+IjydW+K2Td0aIM8ub0qsPSM9o9AlBbJUDb6eGeRyiXwCQk/dYHOOOwjgOKOotig3uU5spQe8f7NbHz+C+ZGAo0OwHMBNqmq+KoczeoadKJAkVzj9Qv8BTIVfs8qZr02q10qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482413; c=relaxed/simple;
	bh=fUYnrRXg9Ryh5h4goWFpvGq7fF88SYKrwRa6SrlmhRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiTxy+HV7Mu/4YWHSwYkzmXjMxzE9zYR2PMPyUaD5kloR/sLc1EKpWOYQzMZ9K1AVioyMz85q0IcvOPHCR8H0LITmPAgvpJJcNhS6RdDaKX0Yt9JnE5dfZFLXXpOepd7sEFskK9Ip0EVe5ZqX+A17naMhz++XkdQC2nFX3xr/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=am6RoUcs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HWe0rwm38aY2k+CMrx8ALuuwsrh0NGp+6DZAw8G9l30=; b=am6RoUcs4QP9zIMB7LwWj/tEhJ
	ZgS2l+WG96sZCITT+bt/DZeet8cO7PYI0Zv1mBdyzrrNakfxlP9RZ7bfzlv0ApK9lhD9TYLFe/0i1
	92rsjxcs25FZIxWlfXDTnioESnbGHhJ1xW83Ly1LaK0P67QxP/eVRnGHY6ZXI6D66Q+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXylj-000HTB-3o; Tue, 23 Dec 2025 10:33:27 +0100
Date: Tue, 23 Dec 2025 10:33:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Osose Itua <osose.itua@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com
Subject: Re: [PATCH v2 2/2] dt-bindings: net: adi,adin: document LP
 Termination property
Message-ID: <a30379ee-f746-4923-aaad-4109eaf6f606@lunn.ch>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
 <20251222222210.3651577-3-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222222210.3651577-3-osose.itua@savoirfairelinux.com>

On Mon, Dec 22, 2025 at 05:21:05PM -0500, Osose Itua wrote:
> Add "adi,low-cmode-impedance" boolean property which, when present,
> configures the PHY for the lowest common-mode impedance on the receive
> pair for 100BASE-TX operation.

FYI: The DT Maintainers prefer that binding patches come first in a
patchset.

> diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
> index c425a9f1886d..d3c8c5cc4bb1 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
> @@ -52,6 +52,12 @@ properties:
>      description: Enable 25MHz reference clock output on CLK25_REF pin.
>      type: boolean
>  
> +  adi,low-cmode-impedance:
> +    description: |
> +      Ability to configure for the lowest common-mode impedance on the
> +      receive pair for 100BASE-TX.
> +    type: boolean

You should document that happens if the property is not present. Is
the hardware left alone, so the bootloader might of set it to
something other than reset defaults? Is it forced to the highest
common-mode impedance?

Also, is this an on/off setting? Or are there a range of impedance
values which can be set in the hardware? If it is a range, we might
want to be forward thinking and allow a value in ohms.

	Andrew

