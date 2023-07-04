Return-Path: <netdev+bounces-15405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F77475C6
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD08E1C20A64
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11376AD9;
	Tue,  4 Jul 2023 15:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A76AB0
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:58:05 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3110C1
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:58:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89cb535afso9730125ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688486283; x=1691078283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ob5s66nJUuWrzVmIgcpj6gX1pVOIG43sjp0smeuqRk=;
        b=yTV0wkqS1/NR8efXnnWnTnPtMe05KXibp8pqQ7qrGhZHkRhc5dFDtTt1lCQQEQyuUW
         I0U/A19V8OfYLMIIBS4YaW0/2gFPbGU0BJVz0OvlUm9rVRLOoIjQp7b8Q43bJwYYZRBc
         4hlWlUDaF9uwG4nhXY1tcNXBM3ej6HAmBHkzUF0GfdyCZZksWEWNn5RK+53t6VS285dn
         xr6/wwYpfmDmkhzKyF/+rSnYOIhQ03zjUB+xLHxqihh+28KlRcg7flHvem2BLVKidv4X
         Rjif9fxwkS/VpS/NqXpaxy7SEOw/EIk2EWGItbyf6GCiUbw1wM+LDRgUTrJcMYOpEWkU
         HcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486283; x=1691078283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ob5s66nJUuWrzVmIgcpj6gX1pVOIG43sjp0smeuqRk=;
        b=C33UFleVAH5kJvHYbks21sQ+7Yh9q1+NwzlmvbsiB2VYqPFAj8PHyexOwGEZUea6I7
         BVH4/F0WMWmXIblageroFXbkOwOLINzTv6xOkt5HCtEZWl42iaPpL0xwyD/2gitETt67
         nvD7pWF15bIGJSCUWyO33ZuR39eymMQi34VLHmwRUJ6Z7y88Y2N4fCyTM/4ekTbmq3tQ
         Y/WurB6AK0pfIIC1xaBt7G4Kjbh0b4LskiIyonCjVHUo3o3qfvXx/Vy6esOZIiYsvJnb
         nKabEmUxYluD8Pw/hZyOVMk68Wiy+uPY5a6VBl3uZE+b3Y5tA6dNDTlPC7fyKmdpzB1l
         zdHQ==
X-Gm-Message-State: ABy/qLa4vhzgAh81odxyXNhQmgSuPiv5fglICpNtPqH6akmGpEeVdXl2
	sWlX5PLvNMHFoaHkBxiiHBxBqA==
X-Google-Smtp-Source: APBJJlETTmVVFs8YtNneUBEorttJnAIPN63N7o/Y7mFVilt6D8loeh6FMTP8QxF/HYxSqOZo7StQ2Q==
X-Received: by 2002:a17:902:9696:b0:1b8:971c:b7b8 with SMTP id n22-20020a170902969600b001b8971cb7b8mr4827989plp.47.1688486283606;
        Tue, 04 Jul 2023 08:58:03 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b001ab2b4105ddsm9344591plb.60.2023.07.04.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:58:03 -0700 (PDT)
Date: Tue, 4 Jul 2023 08:58:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, sergey.senozhatsky@gmail.com, pmladek@suse.com,
 tj@kernel.or, Dave Jones <davej@codemonkey.org.uk>, "open list:NETWORKING
 DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230704085800.38f05b56@hermes.local>
In-Reply-To: <ZKQ3o6byAaJfxHK+@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
	<20230703113410.6352411d@hermes.local>
	<ZKQ3o6byAaJfxHK+@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 4 Jul 2023 08:15:47 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hello Stephen,
> 
> On Mon, Jul 03, 2023 at 11:34:10AM -0700, Stephen Hemminger wrote:
> > On Mon,  3 Jul 2023 08:41:54 -0700
> > leitao@debian.org wrote:
> >   
> > > +config NETCONSOLE_UNAME
> > > +	bool "Add the kernel version to netconsole lines"
> > > +	depends on NETCONSOLE
> > > +	default n
> > > +	help
> > > +	  This option causes extended netcons messages to be prepended with
> > > +	  kernel uname version. This can be useful for monitoring a large
> > > +	  deployment of servers, so, you can easily map outputs to kernel
> > > +	  versions.  
> > 
> > This should be runtime configured like other netconsole options.
> > Not enabled at compile time.  
> 
> Do you mean I should add a new option to netconsole line? This is the
> current line format today:
> 
> 	[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> 
> If that is the case, I suppose I want to add something at the beginning
> of format, that specify that uname should be sent. What about something
> as?
> 
> 	[u][+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> 
> Thanks!

Keep it as simple as possible.
What ever program is reading udp socket knows where it is coming from.
The uname is really not needed.

