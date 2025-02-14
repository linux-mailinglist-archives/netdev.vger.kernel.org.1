Return-Path: <netdev+bounces-166444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45BA3603A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B56F3A4AB9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611426562C;
	Fri, 14 Feb 2025 14:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7322E405;
	Fri, 14 Feb 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542884; cv=none; b=MxLretYeRwng2f4CTHVRqKCcaCwLJPgA+eTwxVTAybobwuBtApYjcs6axXiXhBHj9DCx9JINxBV+mlxAKN12OTgUiDqjYqPMQMToGKYyIpt3l7MaseBKpDl5/AL+JVDf2PqvBFAaAD8M+p8yAvOY/KSFZK/sjbWcqI12a7jvRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542884; c=relaxed/simple;
	bh=9wV9zi80MssyHyqbbHH1wH1qfVJUKm2q/f3vCe7E9Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSny2brjkydhHYGyQbXot4y0vnweTmSA0Hps7ZC2clqC61TQENY1BFWOvZlwMZTVOE7ez6zat8jdVzvGmoYhGImVLW04peAxqAkowDpFNNH18uf8vvh86aJulLJK7c62x7g9EQCim1BLYuqlKeDSMq5m9O/hTd2oPB6I7JVfULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38de1a5f039so1967601f8f.2;
        Fri, 14 Feb 2025 06:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542881; x=1740147681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkDdfiIFPazb3iy+mY6xvBl2fOoIl9woklaAYbdfG1Q=;
        b=w6/M8at4QKkTWjgFZCrm7sOyoNW1FKFI8BESZT5xqsxkKTw3oGKd72gAazCGjX/o1C
         PvuqLT8Y2fFC/D9gnWX36lLTDIyPuVb4b4IpOYNtxeuthiBxXciR2kwKzYjbrb3mGoqi
         Txzko7gQD0ZeccTrfGBPzDPtNKvHYwntXAlSE2S3P7OrWE2vHzUBLzxPV3bbLzcCqncY
         4E8XHtN6ivETVt74aDj8YepG2O/D4ZNs2DozdhYhykFfCE/4Vngu0v2tnUQnzqq0BA0M
         5LP51D5XLkMXf+8OQgt5VTwQp4ABHyOIOTSPqIh8Zv/2HNnWAB3IBGWRYPv5GcNYVEd/
         af9g==
X-Forwarded-Encrypted: i=1; AJvYcCVUISSXBhV1ZFICsgC0hc/C9vmCktMBNGDjvJPgVwyNiQlA6kBmhWoJIy49ynhd9njvnVD5g3Qd@vger.kernel.org, AJvYcCVvaaMFHPiAUy5AFe9ttnbGsTGdz9A1rQv4jzimPZuO43cS7rbu2h0opNbHoFRUTCyc/xu7VMf9h8lerdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICX/pFsTiatEi2l40LX/vJD6V7qGpgWu4Hoy3cnm9EK+HLbam
	hk5+6pU5l8dScTCWbfvurASYvXACmjHalzqGWx/JzQKuBRIrjliJ
X-Gm-Gg: ASbGnctyGqtaL5uFCLB5xLfa4+SuoRAo9xO5+cF8Wy5qkquSN1rT7J4VeCa6EmkoQLp
	l+HQNvviBvbYGLCj5bKF8rnc7ZVEmi9WeJoEGseW/NRQ47igi1EyaBWlrO+Al3bFZu3YpJkgA3R
	vXAR4Xq+NbveddQGwOzDyTFZ9lBIFFWb+7GGMpfRgX5CgB/HtUK5meji/3+MYs68ZddaOeb9JeY
	RFbU/hVJY6B/AaPLo0lwSGobGxnpKAgqSMJF2K0gkSFy+tsQ/kdzDZk3zWcyOk8YEkd4zaQgd9f
	zJOuaA==
X-Google-Smtp-Source: AGHT+IHtccw1sGugux0/bYnAs/0O/y2/oHiUDYrlR5xGQIWl2sGQETYSdDp50oO4Ozv44JAO4cZ8Rg==
X-Received: by 2002:a5d:5f45:0:b0:38f:30c7:eae4 with SMTP id ffacd0b85a97d-38f30c7ed71mr2435755f8f.52.1739542880928;
        Fri, 14 Feb 2025 06:21:20 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339cbafsm349880966b.136.2025.02.14.06.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:21:20 -0800 (PST)
Date: Fri, 14 Feb 2025 06:21:18 -0800
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
Message-ID: <20250214-civet-of-regular-refinement-23b247@leitao>
References: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
 <1d7e3018-9c82-4a00-8e10-3451b4a19a0d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7e3018-9c82-4a00-8e10-3451b4a19a0d@lunn.ch>

hello Andew,

On Fri, Feb 14, 2025 at 02:33:45PM +0100, Andrew Lunn wrote:
> On Fri, Feb 14, 2025 at 04:47:49AM -0800, Breno Leitao wrote:
> > The old_flags variable is declared twice in __dev_change_flags(),
> > causing a shadow variable warning. This patch fixes the issue by
> > removing the redundant declaration, reusing the existing old_flags
> > variable instead.
> > 
> > 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> > 	9225 |                 unsigned int old_flags = dev->flags;
> > 	|                              ^
> > 	net/core/dev.c:9185:15: note: previous declaration is here
> > 	9185 |         unsigned int old_flags = dev->flags;
> > 	|                      ^
> > 	1 warning generated.
> > 
> > This change has no functional impact on the code, as the inner variable
> > does not affect the outer one. The fix simply eliminates the unnecessary
> > declaration and resolves the warning.
> 
> I'm not a compiler person... but there might be some subtlety here:
> 
> 
> int __dev_change_flags(struct net_device *dev, unsigned int flags,
> 		       struct netlink_ext_ack *extack)
> {
> 	unsigned int old_flags = dev->flags;
> 	int ret;
> 
> This old_flags gets the value of flags at the time of entry into the
> function.
> 
> ...
> 
> 	if ((old_flags ^ flags) & IFF_UP) {
> 		if (old_flags & IFF_UP)
> 			__dev_close(dev);
> 		else
> 			ret = __dev_open(dev, extack);
> 	}
> 
> If you dig down into __dev_close(dev) you find
> 
> 		dev->flags &= ~IFF_UP;
> 
> then
> 
> ...
> 
> 	if ((flags ^ dev->gflags) & IFF_PROMISC) {
> 		int inc = (flags & IFF_PROMISC) ? 1 : -1;
> 		unsigned int old_flags = dev->flags;
> 
> This inner old_flags now has the IFF_UP removed, and so is different
> to the outer old_flags.
> 
> The outer old_flags is not used after this point, so in the end it
> might not matter, but that fact i felt i needed to look deeper at the
> code suggests the commit message needs expanding to include more
> analyses.

Right, I have analyzed this when creating this fix. I was wondering if
I need to rename the inner old_flags or just reuse it, and I added it in
the commit message:

 > This change has no functional impact on the code, as the inner variable
 > does not affect the outer one.

But I agree with you, if you needed to look at it, it means the message
is NOT good enough. I will update it.

> > Fixes: 991fb3f74c142e ("dev: always advertise rx_flags changes via netlink")
> 
> I suppose there is also a danger here this code has at some point in
> the past has been refactored, such that the outer old_flags was used
> at some point? Backporting this patch could then break something?  Did
> you check for this? Again, a comment in the commit message that you
> have checked this is safe to backport would be nice.

I haven't look at this, and I don't think this should be backported,
thus, that is why I sent to net-next and didn't cc: stable.

That said, I don't think this should be backported, since it is not
a big deal. Shouldn't I add the Fixes: in such case?

Thanks for the review,
--breno

