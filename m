Return-Path: <netdev+bounces-26628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B944778704
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD5D1C20F98
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350510E4;
	Fri, 11 Aug 2023 05:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D44EC6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:42:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF21BD
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 22:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691732530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeOvN75tWxQhwMQjRUNg3DV6YRE1tdWFw7PsggN2KNo=;
	b=WiaxRU0AFzNYP40svR7OQtPMBf7yLEYHD3nbVYcOI+S76C3HuOSrQa1GQdmGYDrcqHAxvA
	6zLQMME7vVFZ05DCNB/zD5eTki13kLjYnmoBAUnUADx2viBwosrWvQI0lDIsOKLi7wS/4r
	Ym7kB9FwwicIJUTxEyaqmuyf1+uZEic=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-bnQRMJ-2OF-PakbztunfaQ-1; Fri, 11 Aug 2023 01:42:09 -0400
X-MC-Unique: bnQRMJ-2OF-PakbztunfaQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3176c4de5bbso993066f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 22:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691732528; x=1692337328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeOvN75tWxQhwMQjRUNg3DV6YRE1tdWFw7PsggN2KNo=;
        b=jZ7PnGqysRQFqrjQazLdwyETgFwApXgZWwJDSJHGHEbpJe2+eW+po2jQwO+oYNppW7
         TqQ+RQIvcJ6/yTeRpdHmU+FbCyiw6yWkOmicEV6WJnjR/Z/rJYpl0dZQgDWkHHhRcQ3H
         vxDFRaEmqCryn3+AGi/UQJf3H1wW/x6OMI2U+K2RAdJLgA6vmwaneBTQ/AiT6cMQftUZ
         p8xMxBkKPPjrgwbZBCYy+s7D1YB9oWYuTb9HxvFu33279XbbTccOw/DGmHdkjRCg8PVU
         iRfaEisjQIU3ZB4x0YQCRsZk975Yp0gOfbl3KOx65BJzthP4MyadJtfdcSR2BYGsVfju
         K9wg==
X-Gm-Message-State: AOJu0YyEOU9FyHxIBgBScqOUVYJaQ2k3FDDY2V1Kg1vpJDPvZoQuy2c2
	eRsuxg391aMXFfUsEQctOuF6071TdgnxkhfShcpjUbf6bXl1iC/EbbfU/TYie7DcqpU/+r4oL95
	D61DAMsz2jhN2DXOz
X-Received: by 2002:a5d:4dce:0:b0:315:ad1a:5abc with SMTP id f14-20020a5d4dce000000b00315ad1a5abcmr560341wru.5.1691732528058;
        Thu, 10 Aug 2023 22:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGChBTfjXHd170xzQjiykK6EKOoZmHX+FMr/7ZWK7WQpPsGbiHHN5KVtW18EcCe7s909p9kg==
X-Received: by 2002:a5d:4dce:0:b0:315:ad1a:5abc with SMTP id f14-20020a5d4dce000000b00315ad1a5abcmr560328wru.5.1691732527474;
        Thu, 10 Aug 2023 22:42:07 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d52ca000000b003140fff4f75sm4279428wrv.17.2023.08.10.22.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:42:06 -0700 (PDT)
Date: Fri, 11 Aug 2023 01:42:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811012147-mutt-send-email-mst@kernel.org>
References: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 3:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > program will create issues in the networking stack.
> > > > > >
> > > > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > > > via firmware or software.
> > > > >
> > > > > Currently that mean one either has sane firmware with a scheduler that
> > > > > can meet deadlines, or loses ability to report errors back.
> > > > >
> > > > > > > But if they do they can always set this flag too.
> > > > > >
> > > > > > This may have false negatives and may confuse the management.
> > > > > >
> > > > > > Maybe we can extend the networking core to allow some device specific
> > > > > > configurations to be done with device specific lock without rtnl. For
> > > > > > example, split the set_channels to
> > > > > >
> > > > > > pre_set_channels
> > > > > > set_channels
> > > > > > post_set_channels
> > > > > >
> > > > > > The device specific part could be done in pre and post without a rtnl lock?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > Would the benefit be that errors can be reported to userspace then?
> > > > > Then maybe.  I think you will have to show how this works for at least
> > > > > one card besides virtio.
> > > >
> > > > Even for virtio, this seems not easy, as e.g the
> > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > appear to be atomic to the networking core.
> > > >
> > > > I wonder if we can re-consider the way of a timeout here and choose a
> > > > sane value as a start.
> > >
> > > Michael, any more input on this?
> > >
> > > Thanks
> >
> > I think this is just mission creep. We are trying to fix
> > vduse - let's do that for starters.
> >
> > Recovering from firmware timeouts is far from trivial and
> > just assuming that just because it timed out it will not
> > access memory is just as likely to cause memory corruption
> > with worse results than an infinite spin.
> 
> Yes, this might require support not only in the driver
> 
> >
> > I propose we fix this for vduse and assume hardware/firmware
> > is well behaved.
> 
> One major case is the re-connection, in that case it might take
> whatever longer that the kernel virito-net driver expects.
> So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> and fail early?

Ugh more mission creep. not at all my point. vduse should cache
values in the driver, until someone manages to change
net core to be more friendly to userspace devices.

> 
> > Or maybe not well behaved firmware will
> > set the flag losing error reporting ability.
> 
> This might be hard since it means not only the set but also the get is
> unreliable.
> 
> Thanks

/me shrugs



> >
> >
> >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> >


