Return-Path: <netdev+bounces-248579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A9D0BD46
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC77301AD30
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A728366557;
	Fri,  9 Jan 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r9CsqDao"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08C365A1A;
	Fri,  9 Jan 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983301; cv=none; b=KttA4Z3TtlP9pfvq97ZmfVpcq5lOvFnaBqQpvODJWgFKPNN1XDsm2KW5c/jzxhN8YHEP8GliSWfjf6kdUqB283/wRc8W6A5XeWf/ntzSd7dmGNisIkKivrTmD1tagDZ+s4SBVs9EPVj+ezyyBS1nBBESpjwn0q3CsBb3MDqC5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983301; c=relaxed/simple;
	bh=RnYQ3jKO2W4FwB6NaVCWDHAv/WgbVuSK5HvRF1E6bs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sabpYRmls95g4bl8UIbIOvIFi0ZmaWKL6JBAYPs/fiuFlWHFMle1R4zZxw+42Y5InNF7lI1lvB6tAYrzk3Xk6UR9D8sWB3N+Apwa7qv7dU0mh+Gk8QyZ5dxw9YWbOR8j5EhcsDjibVo9kLUTIcRcSwv8yLnoNHYTGfJAYTbM+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r9CsqDao; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AoU/pYR/8Cjf2D5K13/a9aFfWsyhDLaSPlVF5yOnY/g=; b=r9CsqDaoUY730tg3SWrg8c7dpA
	n/bCi+XeY9OOvMvpx3OVeAcCe8afkdzHtULOeScAtoUSD3v716IwgcQOxmljCavQStYwlAW5P/Zmb
	b1LO4V8xOGVNaOG8FjizxFDVdOHs+fQ0wkwrNdwfVaAvHFSPjsfLLPxJLPZzT+ZfIOME=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veHDG-0029Zc-9h; Fri, 09 Jan 2026 19:27:54 +0100
Date: Fri, 9 Jan 2026 19:27:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
Message-ID: <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109080859.1285-1-lizhi2@eswincomputing.com>

>    rx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    enum: [0, 20, 60, 100, 200, 400, 800, 1600, 2400]
>  
>    tx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    enum: [0, 20, 60, 100, 200, 400, 800, 1600, 2400]

You need to add some text to the Changelog to indicate why this is
safe to do, and will not cause any regressions for DT blobs already in
use. Backwards compatibility is very important and needs to be
addressed.

> +  eswin,rx-clk-invert:
> +    description:
> +      Invert the receive clock sampling polarity at the MAC input.
> +      This property may be used to compensate for SoC-specific
> +      receive clock to data skew and help ensure correct RX data
> +      sampling at high speed.
> +    type: boolean

This does not make too much sense to me. The RGMII standard indicates
sampling happens on both edges of the clock. The rising edge is for
the lower 4 bits, the falling edge for the upper 4 bits. Flipping the
polarity would only swap the nibbles around.

	Andrew

