Return-Path: <netdev+bounces-20253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D54675EBE8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E822814E0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 06:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA4E1111;
	Mon, 24 Jul 2023 06:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9AC10F8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:46:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836BF4
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690181199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTud+4xJIlrBtYDivlKsgCTpB5copH4qn7rSFdRl64g=;
	b=O9mRm6WwWyE8nkUNziXju4D7OW3ZKV9rCvv7noLwO2scYAYC+vOUwmwHhj6hz8E/b4rUAW
	hAZf7rYNAD+Bc8slbWp/rQTTwsx6I9dR/PTptK31TwY0WOstKSu0MVLIFFnHW1ifgEwOKw
	ovyr3klRpZsoupS6+MNJrcNPjgm7Oeo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-p_RTVVtgOcSpzSclfZe3Cw-1; Mon, 24 Jul 2023 02:46:35 -0400
X-MC-Unique: p_RTVVtgOcSpzSclfZe3Cw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3142665f122so2432245f8f.0
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 23:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181194; x=1690785994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTud+4xJIlrBtYDivlKsgCTpB5copH4qn7rSFdRl64g=;
        b=GxCJcdBGwSFKjkcL2n+hejfr9H+wDrcB6O4aXYJxziz/bqpaWLq2kp3vaBOMti0ZkV
         2U8T4C38P0Nam2lbdLT+TnmwHNIknGC9BI7yG4kyJ2ufflnjAI7P6cknkSX79ywC5rCZ
         seaI77XIX+MUxUjUjuKOKXbG937jpwRHPaYX2jHkdbpmqKOioyPyL+hRvu9M/6oCzTNK
         pdUvs6nqY2x8TKhmUP3kjNjxOvYv29nNTYxJD4jRQyVPE5IEJkfiYGHB4eC8l+BOczZ7
         40mJ4fBFT2ZXrbgvlWOfRpvJk3mxQ+V1138llFDKLN/jT5XcDi+WhB/oJV3lEx65a4Y1
         dJSQ==
X-Gm-Message-State: ABy/qLbZSquc0Rk604gT1n5Z9dOhoEX0TUuQxSkqtOUWmc3LBiL2nEra
	OHxIVU4m/qgrjQmII+hNDkxTqdc/3byoVjpgZZWRgaCtBL1l/QjDHSPalyl7Sqs2OKclYVf+FPt
	wNdxHtKtDNs8gagz0
X-Received: by 2002:a5d:424c:0:b0:317:63d0:39b7 with SMTP id s12-20020a5d424c000000b0031763d039b7mr327865wrr.59.1690181194739;
        Sun, 23 Jul 2023 23:46:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7cP9fOXzAr0jWfZwNJi+YrbNFUYBFxWMQGqWLEJY1T7WSzpkq4AQlu25w+diyWyfiqS0faw==
X-Received: by 2002:a5d:424c:0:b0:317:63d0:39b7 with SMTP id s12-20020a5d424c000000b0031763d039b7mr327851wrr.59.1690181194315;
        Sun, 23 Jul 2023 23:46:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d5545000000b0031437ec7ec1sm11827434wrw.2.2023.07.23.23.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:46:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 02:46:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230723053441-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > 
> > > > > 
> > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > 
> > > > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > 
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > 
> > > > > > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > > > more.  Thanks.
> > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > 
> > > > > > 
> > > > > > I'd like to see a full solution
> > > > > > 1- block until interrupt
> > > > > 
> > > > > Would it make sense to also have a timeout?
> > > > > And when timeout expires, set FAILED bit in device status?
> > > > 
> > > > virtio spec does not set any limits on the timing of vq
> > > > processing.
> > > 
> > > Indeed, but I thought the driver could decide it is too long for it.
> > > 
> > > The issue is we keep waiting with rtnl locked, it can quickly make the
> > > system unusable.
> > 
> > if this is a problem we should find a way not to keep rtnl
> > locked indefinitely.
> 
> From the tests I have done, I think it is. With OVS, a reconfiguration is
> performed when the VDUSE device is added, and when a MLX5 device is
> in the same bridge, it ends up doing an ioctl() that tries to take the
> rtnl lock. In this configuration, it is not possible to kill OVS because
> it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> net.

So for sure, we can queue up the work and process it later.
The somewhat tricky part is limiting the memory consumption.


> > 
> > > > > > 2- still handle surprise removal correctly by waking in that case
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > ---
> > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > >              * into the hypervisor, so the request should be handled immediately.
> > > > > > > >              */
> > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > +               cond_resched();
> > > > > > > >                     cpu_relax();
> > > > > > > > +       }
> > > > > > > > 
> > > > > > > >             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > >      }
> > > > > > > > --
> > > > > > > > 2.39.3
> > > > > > > > 
> > > > > > > > _______________________________________________
> > > > > > > > Virtualization mailing list
> > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > 
> > > > 
> > 


