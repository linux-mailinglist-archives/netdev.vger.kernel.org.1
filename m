Return-Path: <netdev+bounces-45299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFCF7DC007
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554C0B20D29
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2341865A;
	Mon, 30 Oct 2023 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2tMAD+v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922F19BAA;
	Mon, 30 Oct 2023 18:42:43 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022AC6;
	Mon, 30 Oct 2023 11:42:42 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso3250364fac.2;
        Mon, 30 Oct 2023 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698691361; x=1699296161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqH2MDi7AS7ELU7awEeKmSV+na9z+gufigYPz4kD/JA=;
        b=d2tMAD+vWnOQP81Wi+R/8mGen9PWvNB+geMPKf9+FaUwa0JUfe8cA+Yjy5dy4UnhGi
         zy24NYDPCER0Pc1mQXeBJOKrSUZarbTD4PaL6QgSQWigGnkp9wn42KdT735ARTzQXBBF
         jCqxI5wjpiFgp4u9dmPL4h+0+4hsYpk9G97ugcKsWo/fEgTEMdo++xkCah1JF+/AHCZv
         aL0xgMB3UxGD3Pzy9hpgSdHzownt8b62cvRHgB45I0uBDEutgZlr7M9B3aCRSXe/4VF1
         LnrKOTx6UAIIs9Fa23ZVpnRwUkfMeOFLxvQnfBk4QHPB18r1fRcygd2zjqCQSFDkNECq
         xGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691361; x=1699296161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqH2MDi7AS7ELU7awEeKmSV+na9z+gufigYPz4kD/JA=;
        b=aG1hQBSbE0+3c2Bonm/uNn21V3NiXwzL7zXZSRDpVubLbfwsC1blzTUkk1/ZIxm1N6
         RPMDaWK1RheDz826fDTXoZipd/9XZTgTuQBTI8wB6UjWBjXA2KjvWY/mOSUUnTjZgfx6
         n0Dj+i6gybUS69KVSR4i98JnyWnWNz4Mc419MV7LJtK8YgV4NbLuzGv1rgVHCjrGopKv
         RiJihNbSBIqr4Y8EhN5qpkzwT4T7fkJbEMM2aE1Qft7DzfyAK7/mW1yzZplKtVRzLZW+
         TBfuri1+nTrMNP9DSv8kl/GtmM0ngVkfRAZZ5iBP40B6tGXFDaFHuuxlNjwlaAfhr0/J
         kVFg==
X-Gm-Message-State: AOJu0Yz6K9cas+qfPNhUodEkzst2itPv2ttXgbLxLKsfuXJkQhj80rXj
	u6nnJzB/fUtcgVEf9Yuu5qo=
X-Google-Smtp-Source: AGHT+IHIWUOtyavBIkY9CuNaKTneVZ9xeme/ndVJ216kK7foJS/nyOc35SqVApiTEFpV1cN5621OWg==
X-Received: by 2002:a05:6871:7505:b0:1e9:fd9b:735 with SMTP id ny5-20020a056871750500b001e9fd9b0735mr12630857oac.56.1698691361396;
        Mon, 30 Oct 2023 11:42:41 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id r21-20020ac85215000000b00417fa0cd77esm3638949qtn.80.2023.10.30.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:42:41 -0700 (PDT)
Date: Mon, 30 Oct 2023 14:42:40 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Kira <nyakov13@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Sven Joachim <svenjoac@gmx.de>,
	Ian Kent <raven@themaw.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Message-ID: <ZT_5IB1z0Ol03tnh@d3>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
 <2023103001-drew-parmesan-c61a@gregkh>
 <ZT_YntDOYEdlpx5x@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT_YntDOYEdlpx5x@d3>

On 2023-10-30 12:33 -0400, Benjamin Poirier wrote:
> On 2023-10-30 16:25 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Oct 31, 2023 at 02:04:00AM +1100, Benjamin Poirier wrote:
> > > This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.
> > > 
> > > On All Hallows' Eve, fear and cower for it is the return of the undead
> > > driver.
> > > 
> > > There was a report [1] from a user of a QLE8142 device. They would like for
> > > the driver to remain in the kernel. Therefore, revert the removal of the
> > > qlge driver.
> > > 
> > > [1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/
> > 
> > Who's going to maintain this?
> 
> I was planning to update the MAINTAINERS entry to
> S:	Orphan
> when moving it back to drivers/net/. Would you prefer that I do that
> change in a second patch right after the revert in staging? That would
> certainly make things clearer.
> 
> > > Reported by: Kira <nyakov13@gmail.com>
> > > Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
> > > ---
> > > 
> > > Notes:
> > >     Once the removal and revert show up in the net-next tree, I plan to send a
> > >     followup patch to move the driver to drivers/net/ as discussed earlier:
> > >     https://lore.kernel.org/netdev/20231019074237.7ef255d7@kernel.org/
> > 
> > are you going to be willing to maintain this and keep it alive?
> 
> No.
> 
> > I'm all this, if you want to, but I would like it out of staging.  So
> 
> I'd like it out of staging as well. Since nobody wants to maintain it, I
> think it should be deleted. However, my understanding is that Jakub is
> willing to take it back into drivers/net/ as-is given that there is at
> least one user. Jakub, did I understand that correctly?
> 
> > how about applying this, and a follow-on one that moves it there once
> > -rc1 is out?  And it probably should be in the 'net' tree, as you don't
> > want 6.7 to come out without the driver at all, right?
> 
> Right about making sure 6.7 includes the driver. The 'net' tree is
> usually for fixes hence why I would send to net-next. So the driver
> would still be in staging for 6.7 (if you include the revert in your
> 6.7-rc1 submission) and would be back in drivers/net/ for 6.8.

Rereading, I think I misunderstood your suggestion. You're suggesting
that I submit the revert through the net tree rather than the staging
tree. That sounds good. I'll do that once the removal shows up there.

