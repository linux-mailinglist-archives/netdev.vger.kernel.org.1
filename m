Return-Path: <netdev+bounces-26715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408A778A5E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621131C20AF0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52E63AE;
	Fri, 11 Aug 2023 09:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13553FE1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:51:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2082D44
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691747507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75rSna6DzYfcTF9jaKfqJtBw3nqCSolFXF00msNxr1E=;
	b=Ex8yGd2CymWVHOB4gdOyfKMljM20fnMsbSRcaJFIrJgqkgZLRA/g9TbaeuqwuRn6cnwQPm
	lchyzQ8D6LdEAFbFcrkldiEk2pLxJ0J6NR81D2oLdL3TNlE5BQNp2TiIgHS4rTCl2xLfy4
	eELJvMubtQebmNwVvZqC2Ool/+B7kS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-_AnfyD5GMQClEEJoKjIEvA-1; Fri, 11 Aug 2023 05:51:45 -0400
X-MC-Unique: _AnfyD5GMQClEEJoKjIEvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so11456545e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691747504; x=1692352304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75rSna6DzYfcTF9jaKfqJtBw3nqCSolFXF00msNxr1E=;
        b=KMIPODEbtrE4amWJgpJkyMOcISrGAFdFBo0l8LxorcyRfb+NDfMxvdMPsScDj0g8Gc
         m8g8qs2wYVnhmHMM1zxiTMUiS7kCzWz+uh7b5gd//rcL5g1fKu5yU/9eaDo4fNj+sdm/
         TUR4rUZM1UXZIPVvqfo1vWo8d9+r9Fnpqn21QEkH79XyB2+dRBDxhdzLx8hupZ/YZjVU
         nuk8xrOlpsk/iSUl94UhGXWSM2WopMoUwNlJmVujSEL7C1MYKiMguKYkiBfWz9P8k+H+
         JQErf078KNL6UpqgsAGGZojR3xJCr9AdljxbEElvd7F6XOFZCycKlhlYpj60lg35YapT
         61kA==
X-Gm-Message-State: AOJu0Yz4vCvefiLBkVKn98t8sBpdN2RgtvrtvXzAtrU1YhwdynrN0Nuy
	9Zek5Vbg2hPRTIiGRdD6zD84l8upyjcWWdn2fpJJjY1z0D5fWDrTj0FTHGndwxLUURTbG8jHKPI
	fB6scbIT0GpBxv9O8
X-Received: by 2002:a7b:c3d6:0:b0:3fe:29e0:5dad with SMTP id t22-20020a7bc3d6000000b003fe29e05dadmr1140833wmj.34.1691747504439;
        Fri, 11 Aug 2023 02:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA198YY0xgEGy8+3z1yxBa6f19jkcuo/4if9Wj0f4OcPhAZIbk5Q0G/vSZurrQnPJwZNM5zQ==
X-Received: by 2002:a7b:c3d6:0:b0:3fe:29e0:5dad with SMTP id t22-20020a7bc3d6000000b003fe29e05dadmr1140821wmj.34.1691747504059;
        Fri, 11 Aug 2023 02:51:44 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003fe2b081661sm7520672wmq.30.2023.08.11.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:51:43 -0700 (PDT)
Date: Fri, 11 Aug 2023 05:51:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811054859-mutt-send-email-mst@kernel.org>
References: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 05:43:25PM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 5:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Aug 11, 2023 at 05:18:51PM +0800, Jason Wang wrote:
> > > On Fri, Aug 11, 2023 at 1:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> > > > > On Fri, Aug 11, 2023 at 3:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > > > > > program will create issues in the networking stack.
> > > > > > > > > >
> > > > > > > > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > > > > > > > via firmware or software.
> > > > > > > > >
> > > > > > > > > Currently that mean one either has sane firmware with a scheduler that
> > > > > > > > > can meet deadlines, or loses ability to report errors back.
> > > > > > > > >
> > > > > > > > > > > But if they do they can always set this flag too.
> > > > > > > > > >
> > > > > > > > > > This may have false negatives and may confuse the management.
> > > > > > > > > >
> > > > > > > > > > Maybe we can extend the networking core to allow some device specific
> > > > > > > > > > configurations to be done with device specific lock without rtnl. For
> > > > > > > > > > example, split the set_channels to
> > > > > > > > > >
> > > > > > > > > > pre_set_channels
> > > > > > > > > > set_channels
> > > > > > > > > > post_set_channels
> > > > > > > > > >
> > > > > > > > > > The device specific part could be done in pre and post without a rtnl lock?
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Would the benefit be that errors can be reported to userspace then?
> > > > > > > > > Then maybe.  I think you will have to show how this works for at least
> > > > > > > > > one card besides virtio.
> > > > > > > >
> > > > > > > > Even for virtio, this seems not easy, as e.g the
> > > > > > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > > > > > appear to be atomic to the networking core.
> > > > > > > >
> > > > > > > > I wonder if we can re-consider the way of a timeout here and choose a
> > > > > > > > sane value as a start.
> > > > > > >
> > > > > > > Michael, any more input on this?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > I think this is just mission creep. We are trying to fix
> > > > > > vduse - let's do that for starters.
> > > > > >
> > > > > > Recovering from firmware timeouts is far from trivial and
> > > > > > just assuming that just because it timed out it will not
> > > > > > access memory is just as likely to cause memory corruption
> > > > > > with worse results than an infinite spin.
> > > > >
> > > > > Yes, this might require support not only in the driver
> > > > >
> > > > > >
> > > > > > I propose we fix this for vduse and assume hardware/firmware
> > > > > > is well behaved.
> > > > >
> > > > > One major case is the re-connection, in that case it might take
> > > > > whatever longer that the kernel virito-net driver expects.
> > > > > So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> > > > > and fail early?
> > > >
> > > > Ugh more mission creep. not at all my point. vduse should cache
> > > > values in the driver,
> > >
> > > What do you mean by values here? The cvq command?
> > >
> > > Thanks
> >
> > The card status generally.
> 
> Just to make sure I understand here. The CVQ needs to be processed by
> the userspace now. How could we cache the status?
> 
> Thanks

vduse will have to process it in kernel.

> >
> > > > until someone manages to change
> > > > net core to be more friendly to userspace devices.
> > > >
> > > > >
> > > > > > Or maybe not well behaved firmware will
> > > > > > set the flag losing error reporting ability.
> > > > >
> > > > > This might be hard since it means not only the set but also the get is
> > > > > unreliable.
> > > > >
> > > > > Thanks
> > > >
> > > > /me shrugs
> > > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > MST
> > > > > > > > >
> > > > > >
> > > >
> >


