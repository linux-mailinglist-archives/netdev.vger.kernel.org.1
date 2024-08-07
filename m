Return-Path: <netdev+bounces-116465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C694A828
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4CC281BE4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6721E6747;
	Wed,  7 Aug 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bn9v3zEq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B71C579A
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035541; cv=none; b=O0dRdFGf7DrWtltae5TLyXyEyHToeHC3gqrgWnpTbDb/L1y8cAHkI70rPdfEfts/p2gXOSUk8+gKTNiyvZJdcjz2V3QOJNqrtvO2/ZiD91ucP0KJOU6DmiZVIVNlJ1g9HUFVxpaWMRt37fyZUkh6cHKqOeHsyBa3yJLuZIMBZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035541; c=relaxed/simple;
	bh=DK5cWL/KqLXUk++8jZBNtKO2ex2GLezTyAluO66Tp3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjlmLzYuD6+TwOb91x4y6cjlsgkKax+kgktq2gs/XceA4yZSYfO+yvte1UVYat6nX/yxkZacpVaT1OSc+OfGHf+WoiyV/I5LClnFQpsZkuYveS1sErRmpJc6Ib6P20pDh7rrvcvbrCGuYspufWsMqf7PwJUH/n2FoOo7WxNjv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bn9v3zEq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=MHAEn2K/oYC2/Qg1ValvHBCEafHwfqv3I4V/YKEikFA=; b=Bn
	9v3zEqvYLmzxPped0G9Jd3964pg3jPNyK2+vEtkE45ijFl9VxVF1k0LnUoecTr2JvtqoDxodWJKSc
	LBfsS3VfnHQPKaAiN9UYhNh9KnrnDWiLvP3DvEvZJv/Q3p2IUW5m0h5Y2gfYOA16VA1Zfo5u300/s
	YwQI5Xx6RJuyvoE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbgFc-004CXW-Vg; Wed, 07 Aug 2024 14:58:48 +0200
Date: Wed, 7 Aug 2024 14:58:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
Message-ID: <c98c7d2b-d159-4306-bd26-2999be45e1d0@lunn.ch>
References: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
 <1e537389-7f4b-4918-9353-09f0e16af9f8@intel.com>
 <4CF76B28-E242-47B2-B62C-4CB8EBE44E92@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4CF76B28-E242-47B2-B62C-4CB8EBE44E92@net-swift.com>

On Wed, Aug 07, 2024 at 01:42:06PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2024年8月6日 19:13，Przemek Kitszel <przemyslaw.kitszel@intel.com> 写道：
> > 
> > On 8/6/24 10:25, Mengyuan Lou wrote:
> >> When use rgmmi to attach to external phy, set
> >> PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> >> And it is does matter to internal phy.
> > 
> > 107│  * @PHY_INTERFACE_MODE_RGMII: Reduced gigabit media-independent interface
> > 108│  * @PHY_INTERFACE_MODE_RGMII_ID: RGMII with Internal RX+TX delay
> > 109│  * @PHY_INTERFACE_MODE_RGMII_RXID: RGMII with Internal RX delay
> > 110│  * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal RX delay
> > 
> > Your change effectively disables Internal Tx delay, but your commit
> > message does not tell about that. It also does not tell about why,
> > nor what is wrong in current behavior.
> > 
> 
> I will add it, when wangxun em Nics are used as a Mac to attach to external phy.
> We should disable tx delay.

Why should you disable TX delay?

What is providing that delay? Something needs to add a 2ns delay. Does
the PCB have an extra long clock line?

    Andrew

