Return-Path: <netdev+bounces-142834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45E9C0717
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7220282391
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C820EA49;
	Thu,  7 Nov 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qoPZCD8f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7581E1048;
	Thu,  7 Nov 2024 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985557; cv=none; b=qMxSB26wMCRWpkn+wsWmlVF0wUpIR0hSwU1Fo0WdYM8KB5uop63OphiLenLKJJPCSTBLfU108vkfZMJS7EezFPC9Zxnn8+PfgxhyT3Qlk72Tbt2WD0NQW8BqyWDfyJDG2M71T0D0NcMug80W0trtxE4DjL01mTiZ1mu9y5fbnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985557; c=relaxed/simple;
	bh=30P4jNopQuStNnLTtJAXBWFkFvii1xYHKPCCcFEL/Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We0WCtIQDmiYOpyGp473EeFlNCbxxSjOiWiPpNROcynHE0Lwc5aqGQ3//VfgN+c0CdLGgfw1YDiOAsUQAoEGsf9SwkCD9FMhHQHYLXh75StInpiu0w5Y/Qbm6t4GfmHfRBJsq+UlZfGwUJlAhZrP0AYYVSdSow6fWfvNK+4fzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qoPZCD8f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1o0PT+VvYeF2Yc1hTEqEhN6nNmR8jwyG9x4O7dGE/Wk=; b=qo
	PZCD8fmKsuqe8MM0+5HAxgA1V6sLxp1dxWT6dgRzFLKJ+Uj612/2my5BcrbEkzNKu2cGnhqk12oGB
	/a4BAt4NCaZn7xVX092i/qM2JCfjxaohRr5xqBfTcg7hjl+yJ2+6TiiQ3PRLlum+gfT49bcro6kXI
	u2un0pipZbINs5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t92PO-00CSlH-Qe; Thu, 07 Nov 2024 14:18:46 +0100
Date: Thu, 7 Nov 2024 14:18:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
Message-ID: <9455e2f6-b41d-476e-bda9-fc01958e48d5@lunn.ch>
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <f3c6b67f-5c15-43e2-832e-28392fbe52ec@lunn.ch>
 <21a00f02-7f2f-46da-a67f-be3e64019303@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21a00f02-7f2f-46da-a67f-be3e64019303@gmail.com>

On Thu, Nov 07, 2024 at 06:31:26PM +0800, Joey Lu wrote:
> Dear Andrew,
> 
> Thank you for your reply.
> 
> Andrew Lunn 於 11/7/2024 2:13 AM 寫道:
> > > +  phy-mode:
> > > +    enum:
> > > +      - rmii
> > > +      - rgmii-id
> > The phy-mode deepened on the board design. All four rgmii values are
> > valid.
> I will add them.
> > > +
> > > +  tx_delay:
> > > +    maxItems: 1
> > > +    description:
> > > +      Control transmit clock path delay in nanoseconds.
> > > +
> > > +  rx_delay:
> > > +    maxItems: 1
> > > +    description:
> > > +      Control receive clock path delay in nanoseconds.
> > If you absolutely really need these, keep them, but i suggest you drop
> > them. They just cause confusion, when ideally we want the PHY to be
> > adding RGMII delays, not the MAC.
> > 
> > If you do need them, then they should be in pS.
> 
> I will fix it.
> 
> We have customers who use a fixed link instead of a PHY, so these properties
> may be necessary.

That is a legitimate use case which can require the MAC to add delays,
but i generally try to get the switch on the other end to add the
delays, just to keep with the uniform setup.

Also, please take a look at ethernet-controller.yaml, these should be
called rx-internal-delay-ps & tx-internal-delay-ps.

	Andrew

