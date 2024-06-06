Return-Path: <netdev+bounces-101416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF28FE7AE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5A3287294
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB0A195FCB;
	Thu,  6 Jun 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BEQ2Sg2h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B4FC02;
	Thu,  6 Jun 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680368; cv=none; b=mo3pgwldfb5GXUUe0+B5lOTTp2Tc1HyAChKY+yUxg0hIqVLytqcJ+bMpKzNGQr8KXnDxfey60e2XKB0bS3NlJr0u4LaiEzUuMSFwXAJFq94Q+a0cUbKkXdcKVST90PLGYIINyirS6/edOVoaWTa//jQyqG4YzNEXBwn0gG7jrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680368; c=relaxed/simple;
	bh=Da94MbDvCzudQyDztnqyQOKY9skofvJFvAJNp1KTIcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gieaXsHP8HeHZ2Del1BwTAvXF15KAZ9DkHmDNOgwd3De+Yiig384+w/kuyPFDs5BE5xUSMOPyrW6WXJwdJegZDLMHAR8MEsJRANbWVaqzX/8qzoPv7NIEwZjHRGhrahVz9pSsAXBgOJ1j204dPpwHZrSAfELGYH4Kt+ths2OHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BEQ2Sg2h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QehpudYNwQn/+EF5t8WXc8vQI3VYnM/EWDpwkUDEZHI=; b=BEQ2Sg2hRkMyI04nmbrlG0HbLo
	QeO7iB/STgiK0VKfWXCGl2sd4tRbx5MAgMZ9LWf63lpyYEFkYk4g6YyOsCBRaL6wqcc/iMAGBoUZ0
	+cN1km/L3X73Hqjk5o0FlagS1JwYR7HdhDrOZmTBtipc3cdJhEStoQJjYmllVZH48tYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFD7o-00H1FE-DV; Thu, 06 Jun 2024 15:25:52 +0200
Date: Thu, 6 Jun 2024 15:25:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <22eae086-0f77-4df7-9d70-e7249d67b106@lunn.ch>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
 <20230814112539.70453-2-sriranjani.p@samsung.com>
 <4e745c2a-57bd-45da-8bd2-ee1cb2bab84f@lunn.ch>
 <000201dab7f2$1c8d4580$55a7d080$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201dab7f2$1c8d4580$55a7d080$@samsung.com>

> > > +  fsd-rx-clock-skew:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - items:
> > > +          - description: phandle to the syscon node
> > > +          - description: offset of the control register
> > > +    description:
> > > +      Should be phandle/offset pair. The phandle to the syscon node.
> > 
> > What clock are you skew-ing here? And why?
> 
> As per customer's requirement, we need 2ns delay in fsys block both in TX
> and RX path.

Lots of people get RGMII delays wrong. Please look back at the mailing
list where there is plenty of discussion about this. I don't want to
have to repeat myself yet again...

     Andrew

