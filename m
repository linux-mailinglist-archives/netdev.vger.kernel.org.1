Return-Path: <netdev+bounces-19892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCC75CB17
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF271C216E6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5227F3B;
	Fri, 21 Jul 2023 15:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1627F38
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:11:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95033586
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689952241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4yccWO+Y9iiMNd9c5vDAerEwJTFNEtbyszoY3g0yOQ=;
	b=dlO6oamhcr6NK2Z9zGRUvRYFDrZGdl7q7rXXS6k9+eBKqS9Wf4hGlCDElHpKnujkzFykLf
	7x/XfbTDayvVbAanK/7LKQAdqlfnPEU+bzcN1Knhea4368eWd6Ao2YfOdn82BF5glBH2P0
	BHawBh8dPNhRJbk4Dmoc7C52xMdAGVE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-hi9yrR6rMO6nJXJvSIxidA-1; Fri, 21 Jul 2023 11:10:40 -0400
X-MC-Unique: hi9yrR6rMO6nJXJvSIxidA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb736a7746so1995862e87.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952239; x=1690557039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4yccWO+Y9iiMNd9c5vDAerEwJTFNEtbyszoY3g0yOQ=;
        b=YpRmJR1xNBMwOBWVDV2W9nNTobN979iFaJ8q58pMCiTOeDcQ1Ehd0MaqTz18/xPnTR
         Jg7r9Cqj2bzEVmEB4Oo5ref4OQ4lrC7qzNZsFhCsLH81cqV65ZcJW0aSHJSbOX+6b94I
         U0xWOg9kyXfdNIr7/rNQB5qpm1fnJpbs752dpZlsbtk+vHJZItBWHyozbnf2BMTgnbOt
         oQptGcaIUblHzNaAFXqpcLO8f8fBtENyk11KRCgw/wPmrYoFxSNPlKvriMtELHwOysna
         WtaEXmPeCCjVsZThe8D+SuIRswNJ+L8cz9985C7jK/Iqv32EGixodvymi/2+e2iIh7yh
         zC5A==
X-Gm-Message-State: ABy/qLbgAzO86BvPWwWtevgc/sBAmEYB+XYrhNuCM1QDMXq7CvaQGABA
	XeBa3Bd3a/MZaAKd36/ksT4frt5p7OSVojUXF9r4Ahy08KbR/UnwI7pKdxCglfj5lkc7f23CMZe
	Zlv2RJYTzyGucN9XP
X-Received: by 2002:a05:6512:1110:b0:4f8:752f:3722 with SMTP id l16-20020a056512111000b004f8752f3722mr1478929lfg.5.1689952239046;
        Fri, 21 Jul 2023 08:10:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG80UHLozH4ZU/PWhBiy+uFifJgDbYZi2tfCTx1oFIwZIyUo80XDUOdkU+6dUavycXACm+s+Q==
X-Received: by 2002:a05:6512:1110:b0:4f8:752f:3722 with SMTP id l16-20020a056512111000b004f8752f3722mr1478907lfg.5.1689952238563;
        Fri, 21 Jul 2023 08:10:38 -0700 (PDT)
Received: from redhat.com ([193.142.201.81])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7d5ce000000b00521cb435d54sm2249319eds.37.2023.07.21.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:10:37 -0700 (PDT)
Date: Fri, 21 Jul 2023 11:10:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230721110925-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > 
> > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > 
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > 
> > > > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > more.  Thanks.
> > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > 
> > > > 
> > > > I'd like to see a full solution
> > > > 1- block until interrupt
> > > 
> > > Would it make sense to also have a timeout?
> > > And when timeout expires, set FAILED bit in device status?
> > 
> > virtio spec does not set any limits on the timing of vq
> > processing.
> 
> Indeed, but I thought the driver could decide it is too long for it.
> 
> The issue is we keep waiting with rtnl locked, it can quickly make the
> system unusable.

if this is a problem we should find a way not to keep rtnl
locked indefinitely.

> > > > 2- still handle surprise removal correctly by waking in that case
> > > > 
> > > > 
> > > > 
> > > > > > ---
> > > > > >     drivers/net/virtio_net.c | 4 +++-
> > > > > >     1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > >             * into the hypervisor, so the request should be handled immediately.
> > > > > >             */
> > > > > >            while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > +               cond_resched();
> > > > > >                    cpu_relax();
> > > > > > +       }
> > > > > > 
> > > > > >            return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > >     }
> > > > > > --
> > > > > > 2.39.3
> > > > > > 
> > > > > > _______________________________________________
> > > > > > Virtualization mailing list
> > > > > > Virtualization@lists.linux-foundation.org
> > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > 
> > 


