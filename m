Return-Path: <netdev+bounces-37191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B21B7B425D
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EE005282F58
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6DA17731;
	Sat, 30 Sep 2023 16:52:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67CA938
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 16:52:26 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D0FE3
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 09:52:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231d6504e1so11124259f8f.2
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1696092741; x=1696697541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP49E0lt1lRfwVwEUZNQYaCBfTY4UGz9ptrNHBZhxcM=;
        b=GODHPJ5OBk5OFYXKYp/AsgCbEs96zHybKMqld2zYIYMA8bWsDO9CD32R4Ve892efWh
         Rw8h6Qoitfo9fDFRXeGZ1URS0UWu9IJBVx4Vya++BEVhXwx8iJTXEUg7vtyzXuhFlYS7
         EaYP12e+2yYMGMjH/WAmkF/9TwNHyl/rOxe/+Raw1hFTZ4W/QiD6r+cTfVQujrg4ADiB
         t0EwhcgT/w1sqCgn4S5QesL/mVLbCPhL0Gs4zfmBWFR0O2+lvC4PwMCbZsvAUBYBpImL
         7PoPTdEUlEjZSUqF5Cz+l5zBQwpp7snU3QkdNZzBDQG/BZuIT+Nwotv31hy32RoOfd+U
         mAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696092741; x=1696697541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP49E0lt1lRfwVwEUZNQYaCBfTY4UGz9ptrNHBZhxcM=;
        b=KOXzA6shif8pE/8L/ZCSt9tnTifIXmIzx57DsX6NMqS6u8xwE1c6alx+95mulT4+EI
         P1Bf01qYY4QKM4TAqvvrTP+PHF0bT5kPmXuYI181HThcklz+ORJmBzNBfGcl6KxuIZKQ
         hmedWFy0b8GEMbXjPq92RrNbvsjCAGFRUnoE0n/m4ZG1RtGU6/2dvg+tCLQ4QGnBQkeO
         nxeWpQS5RbTMlbLAeBhS2Q3ouKKd2EF6HU3L13XTbC2xcGzUE3vZqIMPm/J+x0TceXkg
         Q3O1RW4EzLubZ6rEgkjrGoK16XhIflTJ0m8P1+VoAIcTzL7dX9+VjAee8ZtoQ/kCaBxZ
         q2Dw==
X-Gm-Message-State: AOJu0Yx5jhyiTrpDBUHSC5F4i1vMgJDd64uoFmUxgT4CmiZjRL58E7CO
	7p1XU75sH8Jp2XQOlp65lbjimw==
X-Google-Smtp-Source: AGHT+IFufhUosQmDbdYYO0lgqH5WgmabRsKPy1NuiT6FdEpd1klh9Lx806UT3kRvn4yTyQ0Y4WLs9Q==
X-Received: by 2002:adf:cf0a:0:b0:323:1689:6607 with SMTP id o10-20020adfcf0a000000b0032316896607mr6789063wrj.5.1696092741022;
        Sat, 30 Sep 2023 09:52:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id u1-20020adfed41000000b003247d3e5d99sm4921066wro.55.2023.09.30.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:52:20 -0700 (PDT)
Date: Sat, 30 Sep 2023 17:52:17 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
	Russ Weight <russell.h.weight@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Song Liu <song@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/15] cdrom: Remove now superfluous sentinel element
 from ctl_table array
Message-ID: <ZRhSQaNDJih5xABq@equinox>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-1-e59120fca9f9@samsung.com>
 <CGME20230928133705eucas1p182bd81a8e6aff530e43f9b0746a24eaa@eucas1p1.samsung.com>
 <2023092855-cultivate-earthy-4d25@gregkh>
 <20230929121730.bwzhrpaptf45smfy@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929121730.bwzhrpaptf45smfy@localhost>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 02:17:30PM +0200, Joel Granados wrote:
> On Thu, Sep 28, 2023 at 03:36:55PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 28, 2023 at 03:21:26PM +0200, Joel Granados via B4 Relay wrote:
> > > From: Joel Granados <j.granados@samsung.com>
> > > 
> > > This commit comes at the tail end of a greater effort to remove the
> > > empty elements at the end of the ctl_table arrays (sentinels) which
> > > will reduce the overall build time size of the kernel and run time
> > > memory bloat by ~64 bytes per sentinel (further information Link :
> > > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> > > 
> > > Remove sentinel element from cdrom_table
> > > 
> > > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > > ---
> > >  drivers/cdrom/cdrom.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > > index cc2839805983..451907ade389 100644
> > > --- a/drivers/cdrom/cdrom.c
> > > +++ b/drivers/cdrom/cdrom.c
> > > @@ -3654,8 +3654,7 @@ static struct ctl_table cdrom_table[] = {
> > >  		.maxlen		= sizeof(int),
> > >  		.mode		= 0644,
> > >  		.proc_handler	= cdrom_sysctl_handler
> > > -	},
> > > -	{ }
> > > +	}
> > 
> > You should have the final entry as "}," so as to make any future
> > additions to the list to only contain that entry, that's long been the
> > kernel style for lists like this.
> Will send a V2 with this included. Thx.
> 
> > 
> > So your patches will just remove one line, not 2 and add 1, making it a
> > smaller diff.
> indeed.
> 
> > 
> > thanks,
> > 
> > greg k-h
> 
> -- 
> 
> Joel Granados

Hi Joel,

Thank you for your patch. I look forward to seeing V2, and will be happy
to review it.

Regards,
Phil

