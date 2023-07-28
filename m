Return-Path: <netdev+bounces-22245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C635E766B02
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891481C21872
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D41095A;
	Fri, 28 Jul 2023 10:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31810795
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:49:50 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0ED1BC3;
	Fri, 28 Jul 2023 03:49:49 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so2536349a12.2;
        Fri, 28 Jul 2023 03:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541387; x=1691146187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVIaQsb7ph4vtvvBb5aH72jSkwPqs8dOlQZNLadpB5k=;
        b=UIa+dmT13DH5sXYhbYjswUqU4RrToNk3RD0kGRxfBF2rVCWZ9crS61BSgWwBeBXeGY
         AQ1NDLvx2XmCcXB5u6660oQ82TDMFSf0L6aUec6RhR1MJ+QM0ER7qWvUueDnML8D3L+Y
         W9kV79IW8NVGuGnWyAFaaD989n1BPIzov4AKrXklb6AkXkA+pW6KYw31YiovuRPfDLNB
         +1/4DNgXgkYGPXUDid8H+gDsgdPA4lpT71CMxOXGhZJZ/suyAl4G5Bc/zlBWmiaiTCy9
         9ycUayC0tcQiPr8o66hBVg+4VTOU9SkLrhnfd+UNR+hwdLzcqysmOyaYY62qzcEKvCbB
         8mVQ==
X-Gm-Message-State: ABy/qLb4oUggvCZJQDnzGizpcGsP0dEeaO4vUT5YG7n+ApG0NZ5WimYc
	rcuQuKFNUG9h6rj8NAfqhg5pR1cV99o=
X-Google-Smtp-Source: APBJJlEHg8wyu5OL71CwwagmkKaWAJNuCisSJNkKBGipgS0ZmA7Ast3YVc/K2CygC9OkucGB2g7FSg==
X-Received: by 2002:a50:fa8d:0:b0:522:38cb:d8cb with SMTP id w13-20020a50fa8d000000b0052238cbd8cbmr1282442edr.20.1690541387204;
        Fri, 28 Jul 2023 03:49:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c717000000b0051bed21a635sm1663576edq.74.2023.07.28.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:49:46 -0700 (PDT)
Date: Fri, 28 Jul 2023 03:49:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Message-ID: <ZMOdSYry77qsRylG@gmail.com>
References: <20230727163132.745099-1-leitao@debian.org>
 <ZMK70fqdnfMPpc1x@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMK70fqdnfMPpc1x@d3>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 02:47:45PM -0400, Benjamin Poirier wrote:
> On 2023-07-27 09:31 -0700, Breno Leitao wrote:
> > Enable netconsole features to be set at compilation time. Create two
> > Kconfig options that allow users to set extended logs and release
> > prepending features enabled at compilation time.
> > 
> > Right now, the user needs to pass command line parameters to netconsole,
> > such as "+"/"r" to enable extended logs and version prepending features.
> > 
> > With these two options, the user could set the default values for the
> > features at compile time, and don't need to pass it in the command line
> > to get them enabled.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index 368c6f5b327e..4d0c3c532e72 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -332,6 +332,26 @@ config NETCONSOLE_DYNAMIC
> >  	  at runtime through a userspace interface exported using configfs.
> >  	  See <file:Documentation/networking/netconsole.rst> for details.
> > 
> > +config NETCONSOLE_EXTENDED_LOG
> > +	bool "Enable kernel extended message"
> > +	depends on NETCONSOLE
> > +	default n
> > +	help
> > +	  Enable extended log support for netconsole. Log messages are
> > +	  transmitted with extended metadata header in the following format
> > +	  which is the same as /dev/kmsg.
> > +	  See <file:Documentation/networking/netconsole.rst> for details.
> > +
> > +config NETCONSOLE_APPEND_RELEASE
>                      ^ PREPEND
> 
> > +	bool "Enable kernel release version in the message"
> > +	depends on NETCONSOLE_EXTENDED_LOG
> > +	default n
> > +	help
> > +	  Enable kernel release to be prepended to each netcons message. The
> > +	  kernel version is prepended to the first message, so, the peer knows what
>                                          ^ each
> 
> > +	  kernel version is send the messages.
> 
> "kernel release" is one thing and "kernel version" is another:
> root@vsid:~# uname --kernel-release
> 6.5.0-rc2+
> root@vsid:~# uname --kernel-version
> #37 SMP PREEMPT_DYNAMIC Thu Jul 27 14:20:44 EDT 2023
> 
> This option relates to the kernel release so please use the correct
> name consistently in the help text.

Good point. I will fix it in v2.

> > +	  See <file:Documentation/networking/netconsole.rst> for details.
> > +
> >  config NETPOLL
> >  	def_bool NETCONSOLE
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 87f18aedd3bd..3a74f8c9cfdb 100644
> 
> [...]
> 
> Why is it needed to change the default for these parameters? Is there a
> case where it's not possible to specify those values in the netconsole=
> parameter?
> 
> If the default is set to on, there is no way to disable it via the
> command line or module parameter, right?

This patch shouldn't be chagning the default value at all. The default
value should be =n, as it is today. Where do you see the default being
changed?

This is what the patch does, setting "default n".

    +config NETCONSOLE_EXTENDED_LOG
    +       bool "Enable kernel extended message"
    +       depends on NETCONSOLE
    +       default n

and

    +config NETCONSOLE_APPEND_RELEASE
    +       bool "Enable kernel release version in the message"
    +       depends on NETCONSOLE_EXTENDED_LOG
    +       default n


Thanks for the review.

