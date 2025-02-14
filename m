Return-Path: <netdev+bounces-166492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C236FA362BE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F720188FE9E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD326738D;
	Fri, 14 Feb 2025 16:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D570831;
	Fri, 14 Feb 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549366; cv=none; b=TEOvX4nW0lym4PGP3CDG/N2k0R40uGu+FyGtbhG6LWa7VNZNQ+OoeBM6lReN/AwW1VXIb/W80WxOE/c+K25RatUTHCr4zW6vgDPh3YI/uyv83NUySFKPsBQ+rGHpAd8u63XY0LnM4Jhm6QUSx60jT8oswS2h+RJqTHKOgm5q+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549366; c=relaxed/simple;
	bh=XvfaTAUytr9K0t1F7rHIR0kQJhJKplPtZaVtQLmMrM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqTUHPl5AJoCY+PpfP3zPwKUHADpYMIS74hOJh4UvwZBhksMu+22kDG4+Rjj8rID8Zad051/oMZeLFyeSUeg74VxpiZXXwZQ4hSndlZ6euKiMi1FMbMugrVc/YsP5qL09KW1FdeaWgw9JEI0h8eSIeihCGuqWgRPxAKjUOiI4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de4a8b4f86so3191958a12.2;
        Fri, 14 Feb 2025 08:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739549363; x=1740154163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF5FufNPsiom+i34fThs/hUtAnyWEdYBJTAnC8Bz9ik=;
        b=dmPjI6e1tjg7FR5MFZ5oGl7aS0LrCF8qGLAq7PvMREUcfMhWE8r2rKpMiTNOcv3TBr
         wR0ja2pxIcsTaQqruY+v3xvxCs2h3EZBuWdAlhYLsiqKXYuHKv4hNxXN6Kl8YDtEQLsG
         UAifeiJWsXAZ7lsw4cPSRhuoP5t4PBVH2q2N3Vkz2rOuyO1/2wAe+GpEh1l8ZXkbSSuy
         /ldFKPL/pmtjb3z0mZjLC93vetbg9i2t3hwUyUwZj+4/BwJDGQQ+27+nCBShT1EIkleG
         qn7mouvBM72HG+9Oetq6h3UO8zHBUV+FUYiPnbcstmnbkVmUmbFskccE+Z1Z/yft/Al+
         a0OA==
X-Forwarded-Encrypted: i=1; AJvYcCVeKKRfHnM/GQnLMHvbO/xZGR+JuPPvHlqaz6/mNJm4SbHqqg8fwX5fyvKRJ217eAiaA3RMYO+HNhpgLCc=@vger.kernel.org, AJvYcCW2KYadxojFaPLqlcAPcAbn6JPHpwCWyTwEASbW5IF0jlhxU9xBaSHvtroqYuEhGo+UJ/6IdP0R@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3HTyCWm+agN8XQ9D0q2jBG7LWj/kZMX+BptF8ccspUuNB4Wx
	VJxUsuMhzTjZ9vWTa9ezfehL6/x+ZCodMqnmTBhhA+bZNXyigHqCziAxnw==
X-Gm-Gg: ASbGncsMOaAc37KJPCFCFF2Xr7WTJ+WYOY78AStE0OWoHw2iOFuYj4ZSb2iMvxKfNFI
	sKZqL5Zr1NzR8wrps6bNu1GbGSbKhr7oj8zHa50M5udrW5Px9fHevcCKqcwy+UK3e7prqNmSkLi
	F2kScp73tH+3l+G5DkFiADEbLttU36RYr681JSd0MeI0Pv8frFknjBk32OeK3bj55K1D8CWoem8
	FyNdIKCufuAAxEu/KOTVQNUBQdhYxv3ianC1bBVDDqiVeIrztDk5zE6ftZkloR4w8koN5nninOH
	K9NuWQ==
X-Google-Smtp-Source: AGHT+IFvmEPPfznVRo+H6qDRmrc/GS0dcen0jjnB7DIo3iaqoZEyzMgj9gc8pj+yIVY8o82BeznEJw==
X-Received: by 2002:a17:907:7f06:b0:ab7:d5e3:cbac with SMTP id a640c23a62f3a-ab7f34aeb1amr1192297066b.54.1739549362472;
        Fri, 14 Feb 2025 08:09:22 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323226asm370036566b.8.2025.02.14.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:09:22 -0800 (PST)
Date: Fri, 14 Feb 2025 08:09:19 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove redundant variable declaration in
 __dev_change_flags()
Message-ID: <20250214-bald-mammoth-of-opportunity-48a0bb@leitao>
References: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
 <1d7e3018-9c82-4a00-8e10-3451b4a19a0d@lunn.ch>
 <20250214-civet-of-regular-refinement-23b247@leitao>
 <943abc29-d5af-4064-8853-5f3c365bf6d6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943abc29-d5af-4064-8853-5f3c365bf6d6@lunn.ch>

On Fri, Feb 14, 2025 at 04:02:10PM +0100, Andrew Lunn wrote:
> > But I agree with you, if you needed to look at it, it means the message
> > is NOT good enough. I will update it.
> 
> Thanks.
> 
> > 
> > > > Fixes: 991fb3f74c142e ("dev: always advertise rx_flags changes via netlink")
> > > 
> > > I suppose there is also a danger here this code has at some point in
> > > the past has been refactored, such that the outer old_flags was used
> > > at some point? Backporting this patch could then break something?  Did
> > > you check for this? Again, a comment in the commit message that you
> > > have checked this is safe to backport would be nice.
> > 
> > I haven't look at this, and I don't think this should be backported,
> > thus, that is why I sent to net-next and didn't cc: stable.
> > 
> > That said, I don't think this should be backported, since it is not
> > a big deal. Shouldn't I add the Fixes: in such case?
> 
> The danger of adding a Fixes: is that the ML bot will see the Fixes:
> tag and might select it for backporting, even if we did not explicitly
> queue it up for back porting. So i suggest dropping the tag.

Makes sense. I will drop the Fixes: tag and send a v2 to net-next.

Thanks Andrew,
--breno

