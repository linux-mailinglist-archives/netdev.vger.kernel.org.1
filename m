Return-Path: <netdev+bounces-19651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD25875B920
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894C5282026
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3176168A9;
	Thu, 20 Jul 2023 20:58:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C26156FE
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:58:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F81273F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689886705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dqf8Jjm5t/QS+Vt8DTpJf/dAD7LQ0qakHIdy8mWAJw=;
	b=UmnmSsDSkxAsM+SRlaAfp6nq3cW26g1IopSZYBJyqvSOoIYwIt4k9LceIX0ML1rESVaaQp
	xmPBtSVHcjCr9X1hYMX9HY37Lxr/2YJ/nu3va33RJGa1kObWvE0IGpMscKqAaaBSFvrsb1
	Mdsm6fEcigpUid0I8ii5giOVydu5+y8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-CVPTjCyXODiaBfyveZ-r-Q-1; Thu, 20 Jul 2023 16:58:24 -0400
X-MC-Unique: CVPTjCyXODiaBfyveZ-r-Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-315a03cae87so1067884f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886703; x=1690491503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dqf8Jjm5t/QS+Vt8DTpJf/dAD7LQ0qakHIdy8mWAJw=;
        b=QgHa3jKx3EMvmEcVSq8lMzAwneA6ptZEJNhIPJD8T77IPWXMdG6yvyGHLGY+odgvah
         hGqJlRaWtbmkIXFPXqwpwp0hXn3HXFRpTVKFlTcqC1a8fn326LgZrVrtSZLXnXhekRjs
         6IOiv7ikrcG3W0Fg73jZ1DPnUnKZlr+pfL4WeNF4GiP8T3jw7mnL3+fuMjpNivpcr5EO
         iZowDFAhxkQxx7U6y4camUvAeyfVAyMiG0IKeSuec3MNBzREI/kLITPQQuOVuVk5IeWT
         xGCluIa2FCnefhn6r3yEeg4svxPo7lNGHoJ1ago6BbCELP4O32gVPzG6kzVzmpstp3Kj
         X/iw==
X-Gm-Message-State: ABy/qLZwKfnF2m+ykSY42xCVyCEl9tFn98bo1n4PzklGg4NverQN9xAM
	ZhwEniRh5Xk6UNRMQQ73z0Gj+z9m3tVAkw+8RIaa5blI3dCVMkFa4gCHTsvp2vP4aNXu48sUUbb
	b+8jrmQKqUAf4V9gO
X-Received: by 2002:adf:fc48:0:b0:314:77a:c2a6 with SMTP id e8-20020adffc48000000b00314077ac2a6mr24898wrs.25.1689886703220;
        Thu, 20 Jul 2023 13:58:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGGVPES+OLvpID+VHOy6r8D1EwH01kkL+pN8O6wPgr+LrofdyHrBq3n7dIj/lcIXZPoNV3xA==
X-Received: by 2002:adf:fc48:0:b0:314:77a:c2a6 with SMTP id e8-20020adffc48000000b00314077ac2a6mr24892wrs.25.1689886702902;
        Thu, 20 Jul 2023 13:58:22 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d6889000000b0031432c2fb95sm2275327wru.88.2023.07.20.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:58:22 -0700 (PDT)
Date: Thu, 20 Jul 2023 16:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230720164930-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 08:31:13AM -0700, Shannon Nelson wrote:
> On 7/20/23 1:38 AM, Jason Wang wrote:
> > 
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed on a device whose CVQ might be slow.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
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
> 
> The cover letter suggests that this addresses the infinite poll for buggy
> devices, but I don't see how that is resolved here.  This should make it a
> little nicer to the system, but it still is going to poll forever on a
> device that has gone catatonic.  Is there a reason that I'm missing that we
> don't have a polling limit here?
> 
> sln

we don't know what the limit would be. but given it's a workqueue
now, why does it still have to poll as opposed to blocking?


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


