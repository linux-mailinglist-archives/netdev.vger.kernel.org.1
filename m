Return-Path: <netdev+bounces-22149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179717663BE
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 07:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501621C217B6
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E68BFE;
	Fri, 28 Jul 2023 05:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571B5241
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:46:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31E3AAE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690523191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMwD0drsqajj2gsdvqQy67JhYI7KDBbsBKbn31rEdKA=;
	b=J4GiWAcIQ29KKEWDhWnDa7phRuWZ54WDl8Duibg4YXS92zlf0HQuVUE+y2ZGi24q4M6BtS
	0ptH+O2cJI/cq/QnmRZ1oq8P/fA7AqOz6RreUifJ2chj9TdqhkzqD2WgwBq2O+LNlhnzht
	ikzP8f/3XyLvuSiUND7a5+pPwqPBNMI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-4lcdqMo6MnScvZQWO9gZ1Q-1; Fri, 28 Jul 2023 01:46:29 -0400
X-MC-Unique: 4lcdqMo6MnScvZQWO9gZ1Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52256d84ab1so1380593a12.3
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 22:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690523189; x=1691127989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMwD0drsqajj2gsdvqQy67JhYI7KDBbsBKbn31rEdKA=;
        b=Hg3cgehxe2IR5AOsY35uctEhmPSir0ngVSbQVFEd0KYjJcjyTRBr1AUZGNpK0XGlmf
         g73jf0E2cVADw2131wvvsEopfH5J0FgGXHAW6C5lAjmryUQBc+J0/rmLz7PiEOtvt0NK
         vTCL9gfZ64eYS1IzSo/eH203KEAQYdCBQWjn7EbfxcnkYp1rOh611bm6wII4sFCWGaQ3
         NZO1pCRIWyKEVTk323EH2ZbnALd7ymaFxLy+5e7nlbgyMWShieJo4TaEyGqjXir20Ehy
         ahjmEkpgLjkBlCqcsQKiyNWnPh45I/cNtJGkTxqwqOH82Mi5mG4lnqZRb0slYqB37Zud
         zyNg==
X-Gm-Message-State: ABy/qLazbHY7is2toDnpufL/Kt7cZpLgz7lM2mjDeOipWqQ8dzIb30Y8
	X0w8NrkBKt9ckvfVwtXrLJXyK6r9wMWAqnAx+n13Y4sZxRp/oNdiQtfBBvtHwAcPJPtIvAbbmeG
	WPx59D6ebhdBoCb/Z
X-Received: by 2002:a05:6402:64a:b0:522:38f9:e653 with SMTP id u10-20020a056402064a00b0052238f9e653mr925621edx.30.1690523188872;
        Thu, 27 Jul 2023 22:46:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwNX2G2yaLNlyBnSQngMGgFCKafl26b6p6i9OLIBTwmvo9JWC9mtmTi/aUFyCJtgfKzLDHvA==
X-Received: by 2002:a05:6402:64a:b0:522:38f9:e653 with SMTP id u10-20020a056402064a00b0052238f9e653mr925594edx.30.1690523188591;
        Thu, 27 Jul 2023 22:46:28 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id h2-20020aa7c602000000b00522536c2e6esm1419837edq.38.2023.07.27.22.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:46:27 -0700 (PDT)
Date: Fri, 28 Jul 2023 01:46:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	jiri@nvidia.com, dtatulea@nvidia.com, gavi@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
Message-ID: <20230728014601-mutt-send-email-mst@kernel.org>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 03:28:32PM +0200, Paolo Abeni wrote:
> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> > Add interrupt_coalesce config in send_queue and receive_queue to cache user
> > config.
> > 
> > Send per virtqueue interrupt moderation config to underlying device in
> > order to have more efficient interrupt moderation and cpu utilization of
> > guest VM.
> > 
> > Additionally, address all the VQs when updating the global configuration,
> > as now the individual VQs configuration can diverge from the global
> > configuration.
> > 
> > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> FTR, this patch is significantly different from the version previously
> acked/reviewed, I'm unsure if all the reviewers are ok with the new
> one.
> 
> [...]

still ok by me

Acked-by: Michael S. Tsirkin <mst@redhat.com>

let's wait for Jason too.

> >  static int virtnet_set_coalesce(struct net_device *dev,
> >  				struct ethtool_coalesce *ec,
> >  				struct kernel_ethtool_coalesce *kernel_coal,
> >  				struct netlink_ext_ack *extack)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > -	int ret, i, napi_weight;
> > +	int ret, queue_number, napi_weight;
> >  	bool update_napi = false;
> >  
> >  	/* Can't change NAPI weight if the link is up */
> >  	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> > -	if (napi_weight ^ vi->sq[0].napi.weight) {
> > -		if (dev->flags & IFF_UP)
> > -			return -EBUSY;
> > -		else
> > -			update_napi = true;
> > +	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
> > +		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
> > +						      vi->sq[queue_number].napi.weight,
> > +						      &update_napi);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (update_napi) {
> > +			/* All queues that belong to [queue_number, queue_count] will be
> > +			 * updated for the sake of simplicity, which might not be necessary
> 
> It looks like the comment above still refers to the old code. Should
> be:
> 	[queue_number, vi->max_queue_pairs]
> 			
> Otherwise LGTM, thanks!
> 
> Paolo


