Return-Path: <netdev+bounces-15332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06AD746E2A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 12:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C59E1C209DB
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C2568C;
	Tue,  4 Jul 2023 09:59:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479C53A7
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:59:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEAE9
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688464774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=892aSalStYsQtwptK7t1c8HIhOOHEUNVf5ArLGswb+M=;
	b=clAFMLIO/SSTyVkTTgBIlXftRafs8ivjSjjfw2k7bslktXiGb1KMroyZysOSzOVl5cVQK1
	F9DF73xSzIYV4DC3B15iTg2Y0AOwnsrVJf12Ni9Kd7WQmnYKLEpV9RVXu5V0ed/1gEdghp
	bADxt142SO+hF2K9uPDqmwumY9yLqTg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-PNXKLGAqOaWrPZKDugAnrQ-1; Tue, 04 Jul 2023 05:59:33 -0400
X-MC-Unique: PNXKLGAqOaWrPZKDugAnrQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31429e93f26so1961818f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 02:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688464772; x=1691056772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=892aSalStYsQtwptK7t1c8HIhOOHEUNVf5ArLGswb+M=;
        b=EBTPrWw8jVy7222GAPFIBkhbW7DPSovbd71i3ERndujO1qi/NYDOzhVEjtoSDS/Y22
         fLARr/BOCddVW6jPSITC4F7i0VLCqHMfbQsYCWfQp27bXHPw3gxKp5amvXB0HB+fKC79
         KkZ475ZLQc6DTIxeNSHFVvzfSO0ZLUrYJ1n9rieHwceEyal5y3SP8xnTIzbzYxjoSUDd
         6cLNhr5HoDrubeRbNfmq4MauyteP9byu8SGIKuAMIbdvDmUU3nCr3iXN5a1dItZkcKbV
         451lTklA2K4Hr0T8AoGiaZteyuzDBbOSvpRUqcfSrvLGWksY6/CKWIqLOtnCj8PzX7BB
         KzAA==
X-Gm-Message-State: ABy/qLaMpn+aIJztehPMGa1Lc8u686fCZE2l5ueJP7tMzJMYhK/0eUUq
	HQE/XbcuhQ5bOoEBFcndhUxscoMvHsFZdaNKCKkMIkHeqYbWiyame0yC8Bz/CSQ8Dto7J5CV605
	PrF22HZd+1ahhF884
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id q17-20020a5d61d1000000b00314012c4322mr9924371wrv.4.1688464772566;
        Tue, 04 Jul 2023 02:59:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFd/q5uFdR61nqrA+b7m+WX8tW3+kCffk5PcW2uKNzWMNMUWwL7eXK2DeOry/96kNoaIexczg==
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id q17-20020a5d61d1000000b00314012c4322mr9924352wrv.4.1688464772214;
        Tue, 04 Jul 2023 02:59:32 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm8771005wrt.37.2023.07.04.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 02:59:31 -0700 (PDT)
Date: Tue, 4 Jul 2023 05:59:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
	david.marchand@redhat.com, lulu@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230704055840-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
 <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 10:43:07AM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/3/23 23:45, Michael S. Tsirkin wrote:
> > On Mon, Jul 03, 2023 at 09:43:49AM +0200, Maxime Coquelin wrote:
> > > 
> > > On 7/3/23 08:44, Jason Wang wrote:
> > > > On Sun, Jul 2, 2023 at 9:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> > > > > > This small series enables virtio-net device type in VDUSE.
> > > > > > With it, basic operation have been tested, both with
> > > > > > virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> > > > > > adding VDUSE support using split rings layout (merged in
> > > > > > DPDK v23.07-rc1).
> > > > > > 
> > > > > > Control queue support (and so multiqueue) has also been
> > > > > > tested, but requires a Kernel series from Jason Wang
> > > > > > relaxing control queue polling [1] to function reliably.
> > > > > > 
> > > > > > [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> > > > > 
> > > > > Jason promised to post a new version of that patch.
> > > > > Right Jason?
> > > > 
> > > > Yes.
> > > > 
> > > > > For now let's make sure CVQ feature flag is off?
> > > > 
> > > > We can do that and relax on top of my patch.
> > > 
> > > I agree? Do you prefer a features negotiation, or failing init (like
> > > done for VERSION_1) if the VDUSE application advertises CVQ?
> > > 
> > > Thanks,
> > > Maxime
> > 
> > Unfortunately guests fail probe if feature set is inconsistent.
> > So I don't think passing through features is a good idea,
> > you need a list of legal bits. And when doing this,
> > clear CVQ and everything that depends on it.
> 
> Since this is temporary, while cvq is made more robust, I think it is
> better to fail VDUSE device creation if CVQ feature is advertised by the
> VDUSE application, instead of ensuring features depending on CVQ are
> also cleared.
> 
> Jason seems to think likewise, would that work for you?
> 
> Thanks,
> Maxime

Nothing is more permanent than temporary solutions.
My concern would be that hardware devices then start masking CVQ
intentionally just to avoid the pain of broken software.

> > 
> > 
> > > > Thanks
> > > > 
> > > > > 
> > > > > > RFC -> v1 changes:
> > > > > > ==================
> > > > > > - Fail device init if it does not support VERSION_1 (Jason)
> > > > > > 
> > > > > > Maxime Coquelin (2):
> > > > > >     vduse: validate block features only with block devices
> > > > > >     vduse: enable Virtio-net device type
> > > > > > 
> > > > > >    drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> > > > > >    1 file changed, 11 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > --
> > > > > > 2.41.0
> > > > > 
> > > > 
> > 


