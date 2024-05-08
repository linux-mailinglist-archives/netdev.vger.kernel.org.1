Return-Path: <netdev+bounces-94703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814148C0446
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D21D286837
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2DB12CDBC;
	Wed,  8 May 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kmCe2E/P"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D112C497
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192750; cv=none; b=Ttgowr2B/4mBv1m2cnsj7R7x3KlqMyCdQfkES1ByK0rOqCePPMP+RNUHvN7giiG5y7RXeC7q57KENHiDueD+VSjd/mnCgQ6qhXuNBQuOzNGjUa+9xoowX9Spz0ISV2Ol6KjOX4Lh58Vm4T6+zmTJk6jRZDKXNzZ52nF9tE7Qn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192750; c=relaxed/simple;
	bh=KAyCRYQwtgIx1Iisdj4+gJv/Ujxzpd4m3fB4RXTDlEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNBHbZQRdizatSVCn29lRQC243I53sPRCydgxARdYZvzxCdvJcaJm7gEKsA7vQMStkFGQCY6A2Qq5k8P96StGT9EcylpJGsPgiKhK9RXQODTSK5VHFzEsmthROP+XSQb/5zHvbfOUAdSlzbCk5jUlR5lUUv9F2TPW/tbtZgqT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kmCe2E/P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=11PFKAzjXy1ks6X/e65WnG6F0ZqBufIUsPq7HBb2zNw=; b=km
	Ce2E/PcuCk3Ot3Ijhc5Am2eTg3ALnRCo9En6RNBKArRF72mgoDpt2kztuP4AZK+v0g7OtBkqBXxZk
	9guZQOp2WsgtTVCgxM3DVIYeRJZRwADexUZeX61Hufy6xoGx14dQN8XJfkO04vHdjtvtmj3fWefem
	EF7fat99aDYNCS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4lz5-00EywS-H3; Wed, 08 May 2024 20:25:43 +0200
Date: Wed, 8 May 2024 20:25:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
Message-ID: <12394ae6-6a2d-4575-9ba1-1b39ca983264@lunn.ch>
References: <1f28bc3c-3489-4fc7-b5de-20824631e5df@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f28bc3c-3489-4fc7-b5de-20824631e5df@gmx.net>

> > +    writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD);
> 
> similarly here:
> 
> writel((MDIO_PHY_ID_C45 | i), regs + TN40_REG_MDIO_CMD);

This one i don't agree with. It happens to work, but there is no
reason to think the hardware has been designed around how Linux
combines the different parts of a C45 address into one word, using the
top bit to indicate it is actually a C45 address, not a C22.

I would much prefer a TN40_ define is added for this bit.

> > +    writel(((device & 0x1F) | ((port & 0x1F) << 5)),
> 
> and also here, similarly:
> 
> writel((device & MDIO_PHY_ID_DEVAD) | ((port << 5) & MDIO_PHY_ID_PRTAD),

Similarly here, this happens to work, but that is just because the
hardware matches a software construct Linux uses. It would be better
to add TN40_ macros to describe the hardware.

   Andrew

