Return-Path: <netdev+bounces-60277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275D81E6E3
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 11:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A911C20F77
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA54D5AD;
	Tue, 26 Dec 2023 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/KZCM/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602044D59B;
	Tue, 26 Dec 2023 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d4a7f0d17so33027115e9.1;
        Tue, 26 Dec 2023 02:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703586079; x=1704190879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r57M7drypBfFBLKNyoojpq8hOvL7UrNpx4l/8Uu5xJ4=;
        b=f/KZCM/hXMKawIUuoCg7ZbpEg0zlNQrsj7V13bPWRNkdqEoYoqokTfk5NANFGEhohB
         waXEcyVyytVvLAptQhYFbMDk5shbzwzIgr7uICta+97ms/a3SSwX3vX/7s13YXm8a7PG
         PB3N2l/O04B4ID+qO9Mgh/v95CpZFk4qVXSznJHPPAQmM9YGlDT8lQzXEtGAfzCpBwD/
         ghlvuRGSB1r+DuoxkQFPl+Z4R+Yw4NU2kRCe5uPnxB4SqWNCkMnDtILOIfxhVHANSAEQ
         o3BY36j+6pBCr3M0FJs+V28V3wDFwQmNK2/SbLD397aPk5D2aXLSH+2hoYo98yn3dWbJ
         6ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703586079; x=1704190879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r57M7drypBfFBLKNyoojpq8hOvL7UrNpx4l/8Uu5xJ4=;
        b=O1s97siX8gxdps7LuWedzfLcna/qLbPRUNjstlF6QXbl3bT4zHGh5RBOVIaDJ+BPqK
         o1saa6I7FAKKOjPcagUGA+25sbDgp7c0SEYyzVxQCh/I+MR209BR9EtB8m6mz+Twczhm
         FYItf2nCmH93Mel2pVbMffMM3oRPBRlm+eLrxVLz1TirAYKgnCeegGp4yor8u1K+gOgb
         woNOzEueeA8VpEs4iXsrbF8YBSbs8eXI51j2PrtwbQN1vu/ANgvrKDT6uI0GROjVejqM
         wZ2Oud9xiluDFy3vGHOpSTMm6fzy+p7K0l9QQxYwDDi0UFtwXm4N7jiCIjOfvIJMAoMt
         og2Q==
X-Gm-Message-State: AOJu0YwJ633JJm+BtSvfZ6ONith6zkO7BW5htZH6Uf2GKi1wnX5I+uwT
	Cb0QNDeFgl2VXlNqoEYvqThS/JmDrT5o+I5vPNsUlg==
X-Google-Smtp-Source: AGHT+IGcyQgxerBUK3Iob3Vhw6M94Mz1zHLi31gRvjH7WhoYInwaNtMI8Sj/4Hbd3xMv93l7L4nCEw==
X-Received: by 2002:a05:600c:3b13:b0:40d:5b8d:39f5 with SMTP id m19-20020a05600c3b1300b0040d5b8d39f5mr177496wms.39.1703586079231;
        Tue, 26 Dec 2023 02:21:19 -0800 (PST)
Received: from localhost (vps-bc70a8f0.vps.ovh.net. [57.128.171.125])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b0040c4886f254sm27841848wmo.13.2023.12.26.02.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:21:18 -0800 (PST)
Date: Tue, 26 Dec 2023 12:21:14 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Grant Grundler <grundler@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hayes Wang <hayeswang@realtek.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Douglas Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] r8152: Switch to using choose_configuration
Message-ID: <ZYqpGqSgZBV800Or@mail.gmail.com>
References: <20231223233523.4411-1-maxtram95@gmail.com>
 <20231223233523.4411-3-maxtram95@gmail.com>
 <CANEJEGuJFq3Wf8=DxTnrbENi586ccsi7Y+pgQWOSaqzvCp2aZg@mail.gmail.com>
 <CANEJEGu7j8JZ37=94TETTcK_K69YVOnvYWaQZT5Qr+6y6f20ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANEJEGu7j8JZ37=94TETTcK_K69YVOnvYWaQZT5Qr+6y6f20ow@mail.gmail.com>

On Mon, 25 Dec 2023 at 23:42:08 -0800, Grant Grundler wrote:
> On Mon, Dec 25, 2023 at 11:18 PM Grant Grundler <grundler@chromium.org> wrote:
> >
> > On Sat, Dec 23, 2023 at 3:36 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> > >
> > > With the introduction of r8152-cfgselector, the following regression
> > > appeared on machines that use usbguard: the netdev appears only when the
> > > USB device is inserted the first time (before the module is loaded), but
> > > on the second and next insertions no netdev is registered.
> > >
> > > It happens because the device is probed as unauthorized, and usbguard
> > > gives it an authorization a moment later. If the module is not loaded,
> > > it's normally loaded slower than the authorization is given, and
> > > everything works. If the module is already loaded, the cfgselector's
> > > probe function runs first, but then usb_authorize_device kicks in and
> > > changes the configuration to something chosen by the standard
> > > usb_choose_configuration. rtl8152_probe refuses to probe non-vendor
> > > configurations, and the user ends up without a netdev.
> > >
> > > The previous commit added possibility to override
> > > usb_choose_configuration. Use it to fix the bug and pick the right
> > > configuration on both probe and authorization.
> > >
> > > Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
> > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> >
> > Maxim,
> > Does this solve the same problem that Doug Anderson posted patches for
> > a few weeks ago?
> >
> > https://lore.kernel.org/all/20231201183113.343256-1-dianders@chromium.org/
> >
> > Those went through the USB tree, so that probably explains why you
> > didn't see them in the net.git tree.

Oh right, I didn't see these... Sorry for making noise then, Doug's
patches should solve my problem.

> Specifically, usb.git usb-next branch:
> "r8152: Choose our USB config with choose_configuration() rather than probe()"
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/drivers/net/usb/r8152.c?h=usb-next&id=aa4f2b3e418e8673e55145de8b8016a7a9920306
> 
> Given this has a fixes tag, and two people have now tracked this down
> and posted fixes for this problem, is there any chance of this landing
> in 6.7?
> 
> And it looks like Maxim's change could be rebased on top of Doug's
> patch and clean up a few more things. Do I see that correctly?

I only see some minor difference in error handling, not sure it's worth
chasing for.

> cheers,
> grant
> 
> >
> > cheers,
> > grant
> >
> > > ---
> > >  drivers/net/usb/r8152.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> > > index 9bf2140fd0a1..f0ac31a94f3c 100644
> > > --- a/drivers/net/usb/r8152.c
> > > +++ b/drivers/net/usb/r8152.c
> > > @@ -10070,6 +10070,11 @@ static struct usb_driver rtl8152_driver = {
> > >  };
> > >
> > >  static int rtl8152_cfgselector_probe(struct usb_device *udev)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static int rtl8152_cfgselector_choose_configuration(struct usb_device *udev)
> > >  {
> > >         struct usb_host_config *c;
> > >         int i, num_configs;
> > > @@ -10078,7 +10083,7 @@ static int rtl8152_cfgselector_probe(struct usb_device *udev)
> > >          * driver supports it.
> > >          */
> > >         if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
> > > -               return 0;
> > > +               return -EOPNOTSUPP;
> > >
> > >         /* The vendor mode is not always config #1, so to find it out. */
> > >         c = udev->config;
> > > @@ -10094,20 +10099,15 @@ static int rtl8152_cfgselector_probe(struct usb_device *udev)
> > >         }
> > >
> > >         if (i == num_configs)
> > > -               return -ENODEV;
> > > -
> > > -       if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
> > > -               dev_err(&udev->dev, "Failed to set configuration %d\n",
> > > -                       c->desc.bConfigurationValue);
> > > -               return -ENODEV;
> > > -       }
> > > +               return -EOPNOTSUPP;
> > >
> > > -       return 0;
> > > +       return c->desc.bConfigurationValue;
> > >  }
> > >
> > >  static struct usb_device_driver rtl8152_cfgselector_driver = {
> > >         .name =         MODULENAME "-cfgselector",
> > >         .probe =        rtl8152_cfgselector_probe,
> > > +       .choose_configuration = rtl8152_cfgselector_choose_configuration,
> > >         .id_table =     rtl8152_table,
> > >         .generic_subclass = 1,
> > >         .supports_autosuspend = 1,
> > > --
> > > 2.43.0
> > >

