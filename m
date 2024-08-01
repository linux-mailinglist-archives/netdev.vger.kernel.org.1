Return-Path: <netdev+bounces-114963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7FC944CF4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E835C1F200E7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA119F487;
	Thu,  1 Aug 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bqH+0J3a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB516C69C;
	Thu,  1 Aug 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518099; cv=none; b=tzwjBN7NE/gmhj/j2RGxgSFDjGJk3hWRZSjR7JlLbRql7GxITMkItodxOr4jU4WZuU+007hrnYRoffNXvp1pl2JW+lr4pd3mJxytN44ZsDHnAiNb7ZLjI1fP/WvY62v/ZjyM+Ygtk4i//mNoE8SEw1w6b5symQK3g3uwhXPsmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518099; c=relaxed/simple;
	bh=OdXOKkDswjlP+UFeRn2SsByeLLOTwk/n2MQ4Wdycm+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acVO0SuLwRicLGcJyRSrV2xY9g3d8jlFGpPcSk57AqzR4LBsFeRsQvLsM5GhC+fFras66KpfISDhy7WHKaGtFH8yajOztYe3+DZdxBIpBnxyO06XEmwGezmK472WSLx3ZNJGjBbyPxSchcG8mPpMFRsb1RtkoIVmN6ljti6NHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bqH+0J3a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X3EDPtGj4na0Janyf1KgLMMD+IWYat2co2bZNkXChms=; b=bqH+0J3at9ZorWMHecDjQZe8q+
	drrWuMsDMyhW67BQ/R7lv98hlICsWZDzOE1G3DTw/rOPSBGqsWTjuLISX0iHGvYnzIimuBrOqlBZh
	VW9Q+IMyKqpta0PoBYuEoa8+oLvgoX7vPwV51aU6UgXsLabT7t8CaKy8Tuf9UWim4r3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZVdm-003mMD-Pt; Thu, 01 Aug 2024 15:14:46 +0200
Date: Thu, 1 Aug 2024 15:14:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Frank.Sae" <Frank.Sae@motor-comm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
Message-ID: <e9d9c67d-e113-4a10-bd18-0d013fe7ea92@lunn.ch>
References: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
 <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>
 <f18fa949-b217-4373-82c4-7981872446b4@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18fa949-b217-4373-82c4-7981872446b4@motor-comm.com>

On Thu, Aug 01, 2024 at 02:49:12AM -0700, Frank.Sae wrote:
> 
> On 7/27/24 02:25, Krzysztof Kozlowski wrote:
> 
>     On 27/07/2024 11:20, Frank.Sae wrote:
> 
>          The motorcomm phy (yt8821) supports the ability to
>          config the chip mode of serdes.
>          The yt8821 serdes could be set to AUTO_BX2500_SGMII or
>          FORCE_BX2500.
>          In AUTO_BX2500_SGMII mode, SerDes
>          speed is determined by UTP, if UTP link up
>          at 2.5GBASE-T, SerDes will work as
>          2500BASE-X, if UTP link up at
>          1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
>          as SGMII.
>          In FORCE_BX2500, SerDes always works
>          as 2500BASE-X.
> 
>     Very weird wrapping.
> 
>     Please wrap commit message according to Linux coding style / submission
>     process (neither too early nor over the limit):
>     https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 
> 
>         Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>
> 
>     Didn't you copy user-name as you name?
> 
> sorry, not understand your mean.
> 
>         ---
>          .../bindings/net/motorcomm,yt8xxx.yaml          | 17 +++++++++++++++++
>          1 file changed, 17 insertions(+)
> 
>     Also, your threading is completely broken. Use git send-email or b4.
> 
> sorry, not understand your mean of threading broken. the patch used git
> send-email.

Your indentation of replies it also very odd!

> 
>         +      0: AUTO_BX2500_SGMII
>         +      1: FORCE_BX2500
>         +      In AUTO_BX2500_SGMII mode, serdes speed is determined by UTP,
>         +      if UTP link up at 2.5GBASE-T, serdes will work as 2500BASE-X,
>         +      if UTP link up at 1000BASE-T/100BASE-Tx/10BASE-T, serdes will
>         +      work as SGMII.
>         +      In FORCE_BX2500 mode, serdes always works as 2500BASE-X.
> 
> 
>     Explain why this is even needed and why "auto" is not correct in all
>     cases. In commit msg or property description.
> 
> yt8821 phy does not support strapping to config the serdes mode, so config the
> serdes mode by dts instead.

Strapping does not matter. You can set it on probe.

> even if auto 2500base-x serdes mode is default mode after phy hard reset, and
> auto as default must be make sense, but from most our customers's feedback,
> force 2500base-x serdes mode is used in project usually to adapt to mac's serdes
> settings. for customer's convenience and use simplicity, force 2500base-x serdes
> mode selected as default here.
 
If you are using phylink correctly, the customer should never
know. Both the MAC and the PHY enumerate the capabilities and phylink
will tell you what mode to change to.

I still think this property should be removed, default to auto, and
let phylink tell you if something else should be used.

> 
>         +    $ref: /schemas/types.yaml#/definitions/uint8
> 
>     Make it a string, not uint8.
> 
> 
> why do you suggest string, the property value(uint8) will be wrote to phy
> register.

Device tree is not a list of values to poke into registers. It is a
textual description of the hardware. The driver probably needs to
apply conversions to get register values. e.g. delay are in ns,
voltages are in millivolts, but register typically don't use such
units.

	Andrew

