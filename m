Return-Path: <netdev+bounces-15245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC381746505
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 23:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD791C209C5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452F125CD;
	Mon,  3 Jul 2023 21:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E640134A0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 21:45:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66BD1A7
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688420715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tARB5Wn5Gx1zOd7JWlq2DBGoUqFTRjKmGP2nqR1fdFE=;
	b=amhh2oVIxAXbe6BOOkbmpOTEsB+DuQCK3RAYThQWfSKMpEPQE0zF4QUBcwoR+a//I47uBk
	gcT8t2c1gW/SGh32wwCKJy3YEhsY7a+IrmXw2DtIMCg6d+eOdiW0inNfhrN4Y9Q0L9nnUX
	owrjkUijEM/uThWrElJAKwF+IpuKLSM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-olhGOSwZOV6nmUM0D1_Wfg-1; Mon, 03 Jul 2023 17:45:14 -0400
X-MC-Unique: olhGOSwZOV6nmUM0D1_Wfg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143b277985so510330f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 14:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688420713; x=1691012713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tARB5Wn5Gx1zOd7JWlq2DBGoUqFTRjKmGP2nqR1fdFE=;
        b=E/Tmz/vDZHMYzRBgFiEK+xJLt0Vt7DHEnTtivCbKvBJMLAcFwanZqBd/U5uh/5o/Ux
         9OtrDFcFM7Uq4J/3YSHi17sCxUVFoxkr1zdxoztvapK0tt0M5mdEbZ6VErzZ4RNVbB7h
         9/v+Eh8y9Dpq/kTKZ6jKBW0E1T7ZkcNI9raPxlp6YIs03748LSATK1N/m2eGlRfHPejH
         JVBtXAW0NCSWWdAUvu+z1XeXStiyKxwMaB/IL2DZhwyk+IYlLNA+e0c6A5miPeJsJ/7M
         FB8JkFohivP/xSrfhXytnUPD5lnSg/N7ZL9DTGmR77j80RQdTfVzHnvs9G5giy9qiUYU
         tkjg==
X-Gm-Message-State: ABy/qLb0EAIT2OitW6DVZmxf0rIni5v/oGIx66V1OV7TLG1Qv/IJzX2y
	BIIz1gUDnx+dZbXbhxYk9Hg5KJjBvleAGhyIYykIf5TkoF3je6WlqOi9UYvZnQwMw0MNHAmeIiW
	0HI94Jls4U6ICJGKq
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id n2-20020adffe02000000b00313f124aa53mr9386199wrr.45.1688420713231;
        Mon, 03 Jul 2023 14:45:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwxrKykcKROIp8288hJK2F1DWQTpGg+15j/Wx8NbEXoDCuZbeNevgm5l58+rk/qYWMMQkJGg==
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id n2-20020adffe02000000b00313f124aa53mr9386193wrr.45.1688420712899;
        Mon, 03 Jul 2023 14:45:12 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b003143d80d11dsm611369wrw.112.2023.07.03.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:45:12 -0700 (PDT)
Date: Mon, 3 Jul 2023 17:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
	david.marchand@redhat.com, lulu@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230703174043-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 09:43:49AM +0200, Maxime Coquelin wrote:
> 
> On 7/3/23 08:44, Jason Wang wrote:
> > On Sun, Jul 2, 2023 at 9:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> > > > This small series enables virtio-net device type in VDUSE.
> > > > With it, basic operation have been tested, both with
> > > > virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> > > > adding VDUSE support using split rings layout (merged in
> > > > DPDK v23.07-rc1).
> > > > 
> > > > Control queue support (and so multiqueue) has also been
> > > > tested, but requires a Kernel series from Jason Wang
> > > > relaxing control queue polling [1] to function reliably.
> > > > 
> > > > [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> > > 
> > > Jason promised to post a new version of that patch.
> > > Right Jason?
> > 
> > Yes.
> > 
> > > For now let's make sure CVQ feature flag is off?
> > 
> > We can do that and relax on top of my patch.
> 
> I agree? Do you prefer a features negotiation, or failing init (like
> done for VERSION_1) if the VDUSE application advertises CVQ?
> 
> Thanks,
> Maxime

Unfortunately guests fail probe if feature set is inconsistent.
So I don't think passing through features is a good idea,
you need a list of legal bits. And when doing this,
clear CVQ and everything that depends on it.



> > Thanks
> > 
> > > 
> > > > RFC -> v1 changes:
> > > > ==================
> > > > - Fail device init if it does not support VERSION_1 (Jason)
> > > > 
> > > > Maxime Coquelin (2):
> > > >    vduse: validate block features only with block devices
> > > >    vduse: enable Virtio-net device type
> > > > 
> > > >   drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> > > >   1 file changed, 11 insertions(+), 4 deletions(-)
> > > > 
> > > > --
> > > > 2.41.0
> > > 
> > 


