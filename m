Return-Path: <netdev+bounces-19652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41375B929
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1812D1C209F1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC82168AF;
	Thu, 20 Jul 2023 21:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D912FA49
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:03:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F0196
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689886988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QxbwNNsUJXE4WSdo9/9FQ7rzSbFKTC0HO55OeJQjfDA=;
	b=S5Ro2M267SuvvPwrbyE2THyQ7lXPkJIpQvDcl7HmZm6OK4B8Y4f2/I+BEVsylfXLBVzUeQ
	l0kcFeHF77YTNeBMKd9xoZw3GZDlPMDyEqQkYGR6JwT+09PI5Iw7MTBI4Et4ekS2pP2VB7
	atzMkB3ku8Vmczw+ShHCNN0nXZAHL2s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-bH45IXY6NnOXcHfoBxoH_Q-1; Thu, 20 Jul 2023 17:03:07 -0400
X-MC-Unique: bH45IXY6NnOXcHfoBxoH_Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b93f4c300bso12897721fa.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886985; x=1690491785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxbwNNsUJXE4WSdo9/9FQ7rzSbFKTC0HO55OeJQjfDA=;
        b=cHyyHwsVgdCkh/ufN3UIKPPNW3k/yM7IsmihFedQpnVnIGaK5K0We4/D/wT8C5nZuE
         MzSgk66GtPadJv0qV1PqframmYqEob7D+evKopLJykXZXXIG7brhoCM9zX4lIiw67lAY
         opCNHZxy96eT2blR6/edCdez+N4DvfYyFelPTUpJH0u8PlnRN8HwrACy7zspyF/eRNVd
         uuFjamPMPoc1dzuvSERyUdmqkk6syBaDDYcsO6G3lcLEthIM9QbBPeUa2czAW0tds/1g
         ArgvzjByn6bUk/jw1at3etyUUYE2Eq400xFXeSnTcjdAPLPuz60h05KT4j9n98DnT7GJ
         11cA==
X-Gm-Message-State: ABy/qLZxClM8m4CKSAgA0SfllOhDC+RTnPl2N3cIWLUp7ODC+IqWk6zL
	uGWYaLz50mD1F9Vguwhw7RhwB8RMnI5RvD67NFGR1mjGUnhR30LDqG9O/k4fv/NXYVrVOFzZvms
	WENJVP9b02S1YPEOR
X-Received: by 2002:a2e:9dcf:0:b0:2b6:dbc5:5ca4 with SMTP id x15-20020a2e9dcf000000b002b6dbc55ca4mr86347ljj.16.1689886985702;
        Thu, 20 Jul 2023 14:03:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkO9895VB0oEJzz7Mt1u7LjrPYNqoemBmNFeHR6tqktWs0kblZ6OrDWTCIs6FgX5K3EX736g==
X-Received: by 2002:a2e:9dcf:0:b0:2b6:dbc5:5ca4 with SMTP id x15-20020a2e9dcf000000b002b6dbc55ca4mr86325ljj.16.1689886985355;
        Thu, 20 Jul 2023 14:03:05 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c248900b003fbb618f7adsm1982153wms.15.2023.07.20.14.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 14:03:04 -0700 (PDT)
Date: Thu, 20 Jul 2023 17:02:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230720170001-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> On 7/20/23 1:38 AM, Jason Wang wrote:
> > 
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed on a device whose CVQ might be slow.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> This still leaves hung processes, but at least it doesn't pin the CPU any
> more.  Thanks.
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 

I'd like to see a full solution
1- block until interrupt
2- still handle surprise removal correctly by waking in that case



> > ---
> >   drivers/net/virtio_net.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9f3b1d6ac33d..e7533f29b219 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >           * into the hypervisor, so the request should be handled immediately.
> >           */
> >          while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > +              !virtqueue_is_broken(vi->cvq)) {
> > +               cond_resched();
> >                  cpu_relax();
> > +       }
> > 
> >          return vi->ctrl->status == VIRTIO_NET_OK;
> >   }
> > --
> > 2.39.3
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization


