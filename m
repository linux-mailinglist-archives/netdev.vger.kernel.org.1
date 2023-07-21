Return-Path: <netdev+bounces-19880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ECB75CA78
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F32822BB
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461F27F14;
	Fri, 21 Jul 2023 14:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCB27F12
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:46:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B030E8
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689950752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSmxBWHZqife/wyZDuG2oCanXHyMdbvWN3yQVprkoXU=;
	b=YYjhWN34Ehwg8Tj7GfqM0khJ97J3v3J4oav4Mnt9AzTDZ75JQHJycLpSqVciIVV0jcHMgz
	I61VEBo9n+CNzCP/IUE4Dd4OyA5CCgiDOI1oMRQWY19/9USPachyhLMzGJk4HJulQgpbkN
	rYQI05dIqrd67yZMnamiVPWzLVSoxsg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-WTImsFSXPBGwBA5xa3iBig-1; Fri, 21 Jul 2023 10:45:50 -0400
X-MC-Unique: WTImsFSXPBGwBA5xa3iBig-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e10b6148cso2501818a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950749; x=1690555549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSmxBWHZqife/wyZDuG2oCanXHyMdbvWN3yQVprkoXU=;
        b=jLCDl48z+f+ggWoB585cK+VFZ/Jcst8cqGago6UKxFtcG5iXVp1JE9R4G/E09ST85h
         DhpLgYX245C04oUU3ZErPIdom3puE2KWHI48Tmh1orDeblHNUdFx1WjAFh4ThcT3xNFQ
         W8KrCBG+nxwvjMBOATBUnHdJiOzLVjd+uzNN8D/kkNpn8fWznio0GssIDp2acWyTUvee
         wenPw1QguElACbF3WwRnNSoIRb+2W5Beh+8X4pDL4KcfPuY2WwOXmolHIPR6m+o0SwHM
         66KndpJkSVM4KQGXUokqSSNS/GbjkX96/h07Y0lxCnMwU+dRqZRgEtmrgrrFPmFXXuUz
         n8iw==
X-Gm-Message-State: ABy/qLYEo0EzcqBuAkGcKgz/2exNIsXb+wAtM/Y0NGPr/PqElBGnwV99
	OmT1lJKQr+0ATQsYe0V2A8/hv3l/Za1Ggq8cJvbBQ9mKpoUw4eLgy37+hUihG2Cj+J3e7fXGZnK
	F11TQUvlwAtVldgRt
X-Received: by 2002:aa7:db4e:0:b0:521:29a:8ee3 with SMTP id n14-20020aa7db4e000000b00521029a8ee3mr2186350edt.5.1689950749643;
        Fri, 21 Jul 2023 07:45:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFz1BiswVaH2Ai9c9vtY6LU5i5/TJTickO+NhgBFmERPHi2WvB/4gjph5Mu4Wx8zxL3o3ikyw==
X-Received: by 2002:aa7:db4e:0:b0:521:29a:8ee3 with SMTP id n14-20020aa7db4e000000b00521029a8ee3mr2186331edt.5.1689950749277;
        Fri, 21 Jul 2023 07:45:49 -0700 (PDT)
Received: from redhat.com ([193.142.201.78])
        by smtp.gmail.com with ESMTPSA id r26-20020a056402035a00b00521a3d8474csm2212152edw.57.2023.07.21.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:45:48 -0700 (PDT)
Date: Fri, 21 Jul 2023 10:45:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230721104445-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > 
> > > > Adding cond_resched() to the command waiting loop for a better
> > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > run other task(workqueue) instead of busy looping when preemption is
> > > > not allowed on a device whose CVQ might be slow.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > 
> > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > more.  Thanks.
> > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > 
> > 
> > I'd like to see a full solution
> > 1- block until interrupt
> 
> Would it make sense to also have a timeout?
> And when timeout expires, set FAILED bit in device status?

virtio spec does not set any limits on the timing of vq
processing.

> > 2- still handle surprise removal correctly by waking in that case
> > 
> > 
> > 
> > > > ---
> > > >    drivers/net/virtio_net.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > >            * into the hypervisor, so the request should be handled immediately.
> > > >            */
> > > >           while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > -              !virtqueue_is_broken(vi->cvq))
> > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > +               cond_resched();
> > > >                   cpu_relax();
> > > > +       }
> > > > 
> > > >           return vi->ctrl->status == VIRTIO_NET_OK;
> > > >    }
> > > > --
> > > > 2.39.3
> > > > 
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 


