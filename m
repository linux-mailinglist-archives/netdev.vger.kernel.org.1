Return-Path: <netdev+bounces-33332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24479D6E1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F9C1C20C30
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE33D7B;
	Tue, 12 Sep 2023 16:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F141C06
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:53:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7D1E110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694537610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc4+V5bh6p5NzLv7LF9hSohtp8QcmhcwlRvEw/hU9ug=;
	b=PdKpxKbgDm6i0Udxwv30EaUf+hLzzRwELyfxvK68vuhAG7WHu6tKcZYPG7pQ6O0Okqhf65
	KlwrWBGzKYRaIxGyUMEdJ2GtBAedx1W1o/Xzol6+NKsbyIBVTDBrFutuEN6Hs54RgVV9Ys
	xluCpBznxf/8uNPEe1pIjC/X0l0q8As=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-9YdGtUepNNCgOR8yicTabA-1; Tue, 12 Sep 2023 12:53:27 -0400
X-MC-Unique: 9YdGtUepNNCgOR8yicTabA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-501bef6b33aso966047e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537606; x=1695142406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nc4+V5bh6p5NzLv7LF9hSohtp8QcmhcwlRvEw/hU9ug=;
        b=PDzw/X6mciYNDaEY5VBKngwgoUP+QsGFNXCKWyRwPsPr85MSbvdj6DL8AK7fY0lsJ7
         UhCSsTfj54++Ju6NQ5oe+RonyywNJv04XPuNwH0q93HDU/BMeCifoXxTrc7p2WmHZF6w
         iOSPFA1JSQVyH4/cJX7ovfDSZze4e/WxcS4zHAk0tSdHIs1jYSvgP1T3it/Ybp4IDRh5
         7wUwXOUQF4VxPvINLrRHVAagfsD+zxLRBkriY1ngrOXOG8tkzmdiy/983BaESnPKNt5i
         bbZ88g/lmLXoqnJnAEln2Tvutg4vLNzJpS3Cm9v1DkGVJnrx96rCj5bVsK6TAOiQYbPs
         me1Q==
X-Gm-Message-State: AOJu0YyfkHmzfKLNnZP5JSwNp/sIWkO8GFRWksK8WaYs33nnl7Qrev+e
	htEJlM02Abz75NhoXzhcG6ier/wmD5BOKZoOqbrRggMpw7HBThq1cUjhdt08hDNR/pyarN3E6MN
	t35xAS2beEM70Sw2e
X-Received: by 2002:a05:6512:14b:b0:502:9b86:7112 with SMTP id m11-20020a056512014b00b005029b867112mr51064lfo.2.1694537605938;
        Tue, 12 Sep 2023 09:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9zqEAtYNJs425Tw5xYK7xk5fDmDx97idivW9+AuMvyrKi8iFS4UnFeFpx5tOwp92xSj67w==
X-Received: by 2002:a05:6512:14b:b0:502:9b86:7112 with SMTP id m11-20020a056512014b00b005029b867112mr51049lfo.2.1694537605588;
        Tue, 12 Sep 2023 09:53:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id sb5-20020a170906edc500b009a1be9c29d7sm7177110ejb.179.2023.09.12.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:53:25 -0700 (PDT)
Message-ID: <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
From: Paolo Abeni <pabeni@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Simon Horman
	 <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 12 Sep 2023 18:53:23 +0200
In-Reply-To: <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
	 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
	 <20230912152031.GI401982@kernel.org> <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > It's rather a gigantic list of heards that is very hard to follow.
> > > Sorting helps to see what's already included and what's not.
> > > It improves a maintainability in a long term.
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > Hi Andy,
> >=20
> > At the risk of bike shedding, the sort function of Vim, when operating
> > with the C locale, gives a slightly different order, as experssed by
> > this incremental diff.
> >=20
> > I have no objections to your oder, but I'm slightly curious as
> > to how it came about.
>=20
> !sort which is external command.
>=20
> $ locale -k LC_COLLATE
> collate-nrules=3D4
> collate-rulesets=3D""
> collate-symb-hash-sizemb=3D1303
> collate-codeset=3D"UTF-8"

I'm unsure this change is worthy. It will make any later fix touching
the header list more difficult to backport, and I don't see a great
direct advantage.

Please repost the first patch standalone.

Thanks,

Paolo


