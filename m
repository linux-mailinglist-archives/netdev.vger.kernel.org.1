Return-Path: <netdev+bounces-228442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0197FBCAF5E
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 23:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB8B3A8901
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 21:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35827A929;
	Thu,  9 Oct 2025 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zGcpMwks"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9B272813;
	Thu,  9 Oct 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046210; cv=none; b=e+DpqZbRb4+t/J2Irp5dlQIy7fademsFCetMuECQe7tTx92Wg7bOKHerZoWFLL2QtgagN5P3XAFdlnlwoH24EJTGpeH949FDu5VMsa76H2zCaAaK0XMoy8qW/dF1NKkJZstTpKCh5nGSIycnAYeuUC+23y9kZ5ZN8GjXnTBtt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046210; c=relaxed/simple;
	bh=gbMwi5Q/YfyiFX0zTtqxier25yUdBnuMUVbW24MeA84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2Pwhfp77256WgzOUoq1NQ4+Ye26S9z6AkIqVu4gXJ0u1OKbXUAxan2n2f4uVj3Dd3gOItKAIRdlULye+Rt1RNmy1TsEUr8FxcCm0/e7YVfP8lj0M5LEZoEdzDMOPKhGWIyQc2BfkZfKzwY2I9xpNIh4GEScVL+0E/t7/RXv+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zGcpMwks; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=18Q60dAN2hudvxDtD9baBPrd5WXXuMY6W/Hc1MxY5T4=; b=zGcpMwksSyyoWHyXLcX36ZowKH
	UK7tKZjxWI93Y5uzvdR7121Kq/nDScg7t6XGiRdlIaT1aLxuSkli81PhhxKV2Mh2K1xGotY5XjL6f
	q9xlR/51xub5KGPbnbklrnUdoLZtikFIKZ8qAPp4N0T4xuW4lqO5iawCXQBhjCH3Wx9c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6yPh-00AYif-03; Thu, 09 Oct 2025 23:43:05 +0200
Date: Thu, 9 Oct 2025 23:43:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Conor Dooley <conor@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <8395a77f-b3ae-4328-9acb-58c6ac00bf9e@lunn.ch>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-8-thomas@wismer.xyz>
 <20251007-stipulate-replace-1be954b0e7d2@spud>
 <20251008135243.22a908ec@pavilion>
 <e14c6932-efc9-4bf2-a07b-6bbb56d7ffbd@lunn.ch>
 <20251009223302.306e036a@pavilion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009223302.306e036a@pavilion>

> When adapting the driver, I also considered an auto-detection mechanism.
> However, it felt safer to rely on the devicetree information than reading
> a silicon revision register, which has a totally different meaning on
> some other device. I have therefore decided to make the driver behaviour
> solely dependent on the devicetree information and to use the silicon
> revision only as a sanity check (as already implemented in the driver).

So if the silicon and the DT disagree, you get -ENODEV or similar?
That is what i would recommend, so that broken DT blobs get found by
the developer.

> Is there any best practice when to use auto-detection with I2C devices?

Not really. There are devices/drivers where the compatible is just
used to indicate where to find the ID register in the hardware,
nothing else. The ID register is then used by the driver to do the
right thing, we trust the silicon to describe itself. But things like
PHY devices have the ID in a well known location, so we actually don't
require a compatible, but if one is given, we use that instead of the
ID found in the silicon. So the exact opposite.

> Regardless of whether the driver queries the silicon revision, the B
> device declaration would look somehow strange to me with a driver having
> one single compatible, i.e. compatible = "ti,tps23881b", "ti,tps23881".
> The first one specifically names the hardware, the fallback is actually
> the name of its predecessor, which is strictly speaking not 100%
> compatible but required to have the driver loaded.

If it is not compatible, a fallback will not actually work, don't list
a fallback.

	Andrew

