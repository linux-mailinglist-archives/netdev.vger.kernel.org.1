Return-Path: <netdev+bounces-234650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FAC25255
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75E03B760D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A1343D72;
	Fri, 31 Oct 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NNabkInW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C43271E9;
	Fri, 31 Oct 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915707; cv=none; b=tnwR8tx3l1YpwV68eIgBygTV7MhZfSgZy4+HFRP95CK/54+/FRjyRK5bcG/92FFVML83fbQGh62YXFIo+aifleRP/W8rClMq/c8KSPdDi88jddlt28iH6VhmgctwLDt4owMqZyygmsaIv7FAZpXULKfb4BajriQiACvr/8FcvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915707; c=relaxed/simple;
	bh=Fpa7qr/fv+SUhi3F6Axnu75C/Us8931ECYR+k+bdT6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSj2UoWRYFkTKYgr3lK+A4mqWAk6UiN1Q+4vLlqea3fJ4NV6/P5Fbqr5rVI754zm6d02koLY+iGJgim7ZdF5Dmp/4Mx97xF8mJjUxPDDxDkXUESk5bSQsQhz7h10Ghbr2oDtkwO/oLyvMWkb+m7NSuqx1v/FoBUY75TTU4zEwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NNabkInW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qTaTyhUjf/2nEG3SlpAKJXiXxBK13JFXAX85CB9hmng=; b=NNabkInW1GPZRoJ+ZqbKd0e0dZ
	m+pALH4KYgwoFs9VKsE6IeDAehBGwqr44F/ZnMG9Oek6vPmSP+Yhqymrhwm44yg5P6luiE7wQ5F1w
	wtH0cjkqKB3ejjrmX6RSSu/UXlInuzX+0vvwBZcaK+TbSfW8JKoIoMWYuoz3VD+KA9tM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEokw-00CbHN-4K; Fri, 31 Oct 2025 14:01:26 +0100
Date: Fri, 31 Oct 2025 14:01:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ethernet-phy: clarify when compatible
 must specify PHY ID
Message-ID: <f08d956b-4392-41c0-93d7-d7dd105c016c@lunn.ch>
References: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>

On Fri, Oct 31, 2025 at 09:15:06AM +0100, Buday Csaba wrote:
> Change PHY ID description in ethernet-phy.yaml to clarify that a
> PHY ID is required (may -> must) when the PHY requires special
> initialization sequence.
> 
> Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
> Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2ec2d9fda..6f5599902 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -35,9 +35,10 @@ properties:
>          description: PHYs that implement IEEE802.3 clause 45
>        - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
>          description:
> -          If the PHY reports an incorrect ID (or none at all) then the
> -          compatible list may contain an entry with the correct PHY ID
> -          in the above form.
> +          If the PHY reports an incorrect ID (or none at all), or the PHY
> +          requires a specific initialization sequence (like a particular
> +          order of clocks, resets, power supplies), then the compatible list
> +          must contain an entry with the correct PHY ID in the above form.

That is good start, but how about:

          PHYs contain identification registers. These will be read to
          identify the PHY. If the PHY reports an incorrect ID, or the
          PHY requires a specific initialization sequence (like a
          particular order of clocks, resets, power supplies), in
          order to be able to read the ID registers, then the
          compatible list must contain an entry with the correct PHY
          ID in the above form.

The first two sentences make it clear we ideally use the ID registers.
Then we say what happens if cannot work.

The "(or none at all)" is exactly the case you are trying to clarify,
it does not respond due to missing reset, clocks etc. We don't need to
say it twice, so i removed it.

    Andrew

