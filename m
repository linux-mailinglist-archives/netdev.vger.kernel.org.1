Return-Path: <netdev+bounces-114301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF5942142
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EA3B2515A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A9418CC0A;
	Tue, 30 Jul 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuxualcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F91AA3C1;
	Tue, 30 Jul 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369817; cv=none; b=V6MHWE2+J/pcbX6MGTkte+cVGf0/k4crpOP52hVxjmwzCTx3D6a5g7Aom+cluWxUX1v2DeF7WAZsO2Ph0pc9lpG9Gpl+I5aUR8ADoqWxhvFDiI483xLx212uRuAd1lZN2vUXqTXrSYjmieEz2ch9KVfe+3u4HwjfK+N1/JBaJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369817; c=relaxed/simple;
	bh=ioCjriq9osqMbAs8+EODo48zUlg3xS+R9XDTxWKShkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOulZKqhc5dDtg7RTs2rlmFJyp/IxVWHj3SIK68sZRdLHOCQEReTLEE3k5GmsLLKy+hVjhpYf0F17HbR0tpQj1iuipvv9o0cksCudd1sQaPJVnWbYnaYQVscZH8Yufe6appaxqlO1WoeVcCahY0ptFaiVsg1heZ/rnjKcxxbkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuxualcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07519C4AF0B;
	Tue, 30 Jul 2024 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722369817;
	bh=ioCjriq9osqMbAs8+EODo48zUlg3xS+R9XDTxWKShkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuxualcNOych3A4yWU5cC100YYKH0ZeP2O6ecJ6E7SdoTqmSAR4goUieQ4axHS4Sm
	 25X41wCdbhg4c0vRdGG4MzgTwqQqXL/IA3FLE8DIFHXqoyUGu1cpgJMjIgJ8zMhmTV
	 XBykMsqVmjGMn+evEkltJbJkdCHBPnRO31XXRRlftLgVQ132Y/3XCqZ44Mah2L5ePX
	 AF7v/SRgM2uRQz1shDNW3BIazLQ28VJJvZSiCBpYI+ifgGdNFZrzI+d5pHw4OH6Iq4
	 /0+mNUxDsvMP9Fehd426LT/8NV8zshFdNu1LhT16CaNG2y1CSfyWdW2A6qa0s6/hqS
	 cl8ZWVHu7tWUw==
Date: Tue, 30 Jul 2024 14:03:35 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
	andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530: Add
 airoha,en7581-switch
Message-ID: <20240730200335.GA2059838-robh@kernel.org>
References: <cover.1722325265.git.lorenzo@kernel.org>
 <63f5d56a0d8c81d70f720c9ad2ca3861c7ce85e8.1722325265.git.lorenzo@kernel.org>
 <3d0e39a3-02e9-42b4-ad49-7c1778bfa874@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d0e39a3-02e9-42b4-ad49-7c1778bfa874@arinc9.com>

On Tue, Jul 30, 2024 at 11:57:36AM +0300, Arınç ÜNAL wrote:
> On 30/07/2024 10:46, Lorenzo Bianconi wrote:
> > Add documentation for the built-in switch which can be found in the
> > Airoha EN7581 SoC.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml     | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > index 7e405ad96eb2..aa89bc89eb45 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > @@ -92,6 +92,10 @@ properties:
> >             Built-in switch of the MT7988 SoC
> >           const: mediatek,mt7988-switch
> > +      - description:
> > +          Built-in switch of the Airoha EN7581 SoC
> > +        const: airoha,en7581-switch
> > +
> >     reg:
> >       maxItems: 1
> > @@ -284,7 +288,10 @@ allOf:
> >     - if:
> >         properties:
> >           compatible:
> > -          const: mediatek,mt7988-switch
> > +          contains:
> > +            enum:
> > +              - mediatek,mt7988-switch
> > +              - airoha,en7581-switch
> 
> The compatible string won't be more than one item. So this would be a
> better description:
> 
> compatible:
>   oneOf:
>     - const: mediatek,mt7988-switch
>     - const: airoha,en7581-switch

enum, not oneOf+const

