Return-Path: <netdev+bounces-228716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D503BD3004
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26EE189E421
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5D26561D;
	Mon, 13 Oct 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs6dms55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4A22A7E5;
	Mon, 13 Oct 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358912; cv=none; b=JqCDq1IpmU8Vv+I4aSbhxe2GRh+bP+WV8ETv15XLtfRI51Gwqlfk/bKEXlFO99L1mjnIsKJwbnYvlAuetZ7ItZlNJ/5YoC/EV+cjiJv1KHfM8iFryqsog4QA0H4EG7EKqkaSY8b/qbez5BFTvZgdbV+n8X45p6I/RGe6G8fE9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358912; c=relaxed/simple;
	bh=J7z2lg6KO9CfV5PrQzpW29+4wNZgsDdQxb+OUBTCSKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz9LfMJ2ciOKnugXN1Cjr+EXRH4r0jMkGv3FJIwa3gjGlUpWn/9pvU4jewtL3qyy8ZAO3nqiKWuZM1+X/WlHbLGfpQC3Xn+S8KgQFdjG82uLzoViCclg+JLBgfuZPsPIZ/dBA4HvPbmoLPGTdpYP3qhOtCcuqpVzcEdnvLpG8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs6dms55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC9C4CEE7;
	Mon, 13 Oct 2025 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358911;
	bh=J7z2lg6KO9CfV5PrQzpW29+4wNZgsDdQxb+OUBTCSKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zs6dms55P2YpofhTi+/MHBPFOsSQVtEGACA3/xMdq0hTsUl/GGd1SyRQPLM0l8Vkg
	 tfw4q/4cEIkHHnUsTd47dd3tv+pwTwQ457SY6cqwr3tSLx2IBTGyjOEcd87v2VAc+o
	 gOiJRbiwdSVKoAbf4qfKHVVPjpT2wpdeAN0E+KN2V781jJpp84xMN+ThrW4w+7hV5k
	 RiFOmOdBXme24Vjuf7pFEG6Zj9hCf6nDA0ZfIXMdhxue2T9cqNtS/jXDHxDHTwmRSA
	 TLwNVnL20NNSpB8ESQYfVsKWxnfO2qBvD3VkLuiOuYA/BZwtMTuE/yYiQxRnXvSqhU
	 HUlhPFWaSoeoA==
Date: Mon, 13 Oct 2025 13:35:07 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: rtl8150: Fix frame padding
Message-ID: <aOzx-4PtIMAk-8Nl@horms.kernel.org>
References: <20251012220042.4ca776b1.michal.pecio@gmail.com>
 <aOzNH0OQZYJYS1IT@horms.kernel.org>
 <20251013125043.0ae574e7.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013125043.0ae574e7.michal.pecio@gmail.com>

On Mon, Oct 13, 2025 at 12:50:43PM +0200, Michal Pecio wrote:
> On Mon, 13 Oct 2025 10:57:51 +0100, Simon Horman wrote:
> > Hi Michal,
> > 
> > I think this should also increment a dropped counter.
> > As this driver already uses dev->netdev->stats [*]
> > I think that would be:
> > 
> > 		dev->netdev->stats.tx_dropped++;
> >
> > [*] I specifically mention this, for the record because,
> >     new users are discouraged. But this driver is an existing user
> >     so I think we are ok.
> 
> Thanks, makes sense, will do.
> 
> I will only drop "dev->" because it's superfluous - we already have
> 'netdev' here, which was used to obtain 'dev' in the first place.

Sounds good, sorry for missing that detail.

