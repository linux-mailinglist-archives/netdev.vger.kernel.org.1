Return-Path: <netdev+bounces-45278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95A7DBDF7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4033D1F22168
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D763D9;
	Mon, 30 Oct 2023 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNIkk47n"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690B19449;
	Mon, 30 Oct 2023 16:33:59 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF4BD;
	Mon, 30 Oct 2023 09:33:57 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cb9419975so28736021cf.2;
        Mon, 30 Oct 2023 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698683636; x=1699288436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yy/fnPpa0jOeepcXyiGpY13xr5whPHNEPKr/8Db8mQU=;
        b=PNIkk47nmgWVqxenzFLCDbKNQjzgCX1EMZGvxqyKk/h+jTRvKzDBrXD3XDCykKmlfG
         j7tMmGlRnDr9JnnuiIbx6eosALKl/HJpTcKT+b1LnTowccTcfIVXJYVLMN3jhnIE/lT8
         l8Euhl6y6FnEtBFjOxZQPYlF4iA6Ws+JlsmLuPzYAMKy/inXWhC8N3WJyzFMJCjl7YfA
         0/CXQ5uisxA+TYGL+jRdigEHr3t5PLNXeTrbZK2UomKkIqhd6W7c9uRMEkvkjKXuAzWX
         jTLTyMF4dZIdca89O9BUHtE0py+3WGMzaxTouvVpUGV+NH9etX8o6bL1O+nBQGySOQe9
         podQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683636; x=1699288436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy/fnPpa0jOeepcXyiGpY13xr5whPHNEPKr/8Db8mQU=;
        b=jebZZ0z7dbHvXS3c70NRxXXFxs9S8So4bAYUF5Qw6ivte/fJulbrThTFesy944UjNZ
         S/VN2A20cJhCrsrG+yMvA5EIwoIEfUawBKYPnTPthhSSP++xBFkmX1vYn9BOjd7tLUlE
         +EXgQwvQW5FQ+zBepjTu31FpY6bDYdv7t/q/HFJ+zAhmbdkZusHOSZTWKQqLafmy8pVy
         Ark8f3LA9IiwTDTkMNmf+cX1f83brMFsEJro4piF0ONISi9BFODH77R8sBlg5U9KVJit
         t4A2Su8HL8CNvv3sJ/zR0+fTcTusNgLWYfSx8ARJEanu4WqOIiKbJNT1Kshn2lUWDj5u
         abMA==
X-Gm-Message-State: AOJu0Yxa3ha9iGVQe/nkAoj4uGlFjxkUkMAPZCpquVI/qppJ810mT2mk
	Yw7t6llkro3XTRkcNlP3gPo=
X-Google-Smtp-Source: AGHT+IGlxvV1bY69VvuuL9ouNfj0x55GucbT/3lD15m+LNdSkViLselRgTy1gqXJdNfOOXiwuwqENw==
X-Received: by 2002:ac8:7d4f:0:b0:41e:204b:e978 with SMTP id h15-20020ac87d4f000000b0041e204be978mr12479125qtb.66.1698683636525;
        Mon, 30 Oct 2023 09:33:56 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id x21-20020ac86b55000000b004166ab2e509sm3500719qts.92.2023.10.30.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:33:56 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:33:55 -0400
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
Message-ID: <ZT_YntDOYEdlpx5x@d3>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
 <2023103001-drew-parmesan-c61a@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023103001-drew-parmesan-c61a@gregkh>

On 2023-10-30 16:25 +0100, Greg Kroah-Hartman wrote:
> On Tue, Oct 31, 2023 at 02:04:00AM +1100, Benjamin Poirier wrote:
> > This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.
> > 
> > On All Hallows' Eve, fear and cower for it is the return of the undead
> > driver.
> > 
> > There was a report [1] from a user of a QLE8142 device. They would like for
> > the driver to remain in the kernel. Therefore, revert the removal of the
> > qlge driver.
> > 
> > [1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/
> 
> Who's going to maintain this?

I was planning to update the MAINTAINERS entry to
S:	Orphan
when moving it back to drivers/net/. Would you prefer that I do that
change in a second patch right after the revert in staging? That would
certainly make things clearer.

> > Reported by: Kira <nyakov13@gmail.com>
> > Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
> > ---
> > 
> > Notes:
> >     Once the removal and revert show up in the net-next tree, I plan to send a
> >     followup patch to move the driver to drivers/net/ as discussed earlier:
> >     https://lore.kernel.org/netdev/20231019074237.7ef255d7@kernel.org/
> 
> are you going to be willing to maintain this and keep it alive?

No.

> I'm all this, if you want to, but I would like it out of staging.  So

I'd like it out of staging as well. Since nobody wants to maintain it, I
think it should be deleted. However, my understanding is that Jakub is
willing to take it back into drivers/net/ as-is given that there is at
least one user. Jakub, did I understand that correctly?

> how about applying this, and a follow-on one that moves it there once
> -rc1 is out?  And it probably should be in the 'net' tree, as you don't
> want 6.7 to come out without the driver at all, right?

Right about making sure 6.7 includes the driver. The 'net' tree is
usually for fixes hence why I would send to net-next. So the driver
would still be in staging for 6.7 (if you include the revert in your
6.7-rc1 submission) and would be back in drivers/net/ for 6.8.

> > +QLOGIC QLGE 10Gb ETHERNET DRIVER
> > +M:	Manish Chopra <manishc@marvell.com>
> > +M:	GR-Linux-NIC-Dev@marvell.com
> > +M:	Coiby Xu <coiby.xu@gmail.com>
> > +L:	netdev@vger.kernel.org
> > +S:	Supported
> > +F:	Documentation/networking/device_drivers/qlogic/qlge.rst
> > +F:	drivers/staging/qlge/
> 
> It's obvious taht these people are not maintaining this code, so they
> should be dropped from the MAINTAINERS file as well.

I agree.

