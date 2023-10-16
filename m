Return-Path: <netdev+bounces-41173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D67CA102
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9EC28116C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4917722;
	Mon, 16 Oct 2023 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or+NmpDD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C488154B2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:51:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A62DC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697442695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWJN0w7xWWzsBQvThID80a9TVLPdJu/x6hSW6zNhXtU=;
	b=Or+NmpDDiM7wlu9B7ifWC2YibUe2U8OB5d5Qj0pMF4IoT9fFrjxtcIKx4iFIZ9bGIRBAph
	01YYApzBMq3Hf+06gKms4Qzgmy5mlyLVtL44HZhuZ5p7iDfZTzvRjuZ1hq9onrOX/7QYE7
	K10gMfXXomd+csK0dfSnAg9O4CgxicI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-8QIxIXbVO_-mAgrWzLTvTQ-1; Mon, 16 Oct 2023 03:51:29 -0400
X-MC-Unique: 8QIxIXbVO_-mAgrWzLTvTQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-405629826ccso30926435e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697442688; x=1698047488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWJN0w7xWWzsBQvThID80a9TVLPdJu/x6hSW6zNhXtU=;
        b=VlerTZvOxbvV1XTxmp54hCBS0xSTYV/V1I/JRZDT3tuVqFqv6YSUuw8EsHWlDgRI9t
         dFxZrqIL9PSoTur1N6XZP6OeW8Q38O6JV4uvW52UcowtCJEvaqHA+HwXxOC5E0NQ5FAz
         8iTqGWBvjnG314JMnEE6Bwe7N+8caMb0KOntaFBlvV7z6PaC3KaTJNUa0fENWHt2MtRp
         WUykFCSN9dS/UV3eS9vLO1MGMAqpuAU4s8pIKyUgoBHjPY5WlEazi+f2vyJz8+b8z22L
         0TVWE9VrVYw2hxURBMTwTShOUu8uY3wZudSRPkEBwP/kE1xwtFn3HasJAcsBukLeC/r9
         dnpQ==
X-Gm-Message-State: AOJu0YxFHgyHTDFrXKWGJzFIbkl+ZWHnxdlB/2+0qg5zXXHVcc2n5y6K
	qnhQCGcRO89VuyGVsPPVZuOSuy3OJOZVy0M4kDBHx/Gd723vIr9H5MMpwwb5/i8rCNgWhRc2P99
	gc2L3Ml0Zaz6lGUpf
X-Received: by 2002:a5d:6389:0:b0:32d:b488:8dc3 with SMTP id p9-20020a5d6389000000b0032db4888dc3mr1990385wru.62.1697442687730;
        Mon, 16 Oct 2023 00:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1LXqPDGVCf1m88/1JdZzNWkDf44hKGDFwTs5dPfpIuJTAs3f3C5PNPBlsWn0kJItiQ6A7tQ==
X-Received: by 2002:a5d:6389:0:b0:32d:b488:8dc3 with SMTP id p9-20020a5d6389000000b0032db4888dc3mr1990361wru.62.1697442687392;
        Mon, 16 Oct 2023 00:51:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:f56b:1acf:3cb7:c133:f86d])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5944000000b003247d3e5d99sm7138692wri.55.2023.10.16.00.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:51:26 -0700 (PDT)
Date: Mon, 16 Oct 2023 03:51:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
Subject: Re: [PATCH net-next 2/5] virtio-net: separate rx/tx coalescing
 moderation cmds
Message-ID: <20231016035034-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <dc171e2288d2755b1805afde6b394d2d443a134d.1697093455.git.hengqi@linux.alibaba.com>
 <20231013181148.3fd252dc@kernel.org>
 <06d90cc8-ccc0-4b2f-ad42-2db4a6fb229f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d90cc8-ccc0-4b2f-ad42-2db4a6fb229f@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 03:45:38PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/10/14 上午9:11, Jakub Kicinski 写道:
> > On Thu, 12 Oct 2023 15:44:06 +0800 Heng Qi wrote:
> > > +
> > > +static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> > > +					  struct ethtool_coalesce *ec)
> > > +{
> > > +	struct scatterlist sgs_rx;
> > > +
> > ../drivers/net/virtio_net.c: In function ‘virtnet_send_rx_notf_coal_cmds’:
> > ../drivers/net/virtio_net.c:3306:14: error: ‘i’ undeclared (first use in this function); did you mean ‘vi’?
> >   3306 |         for (i = 0; i < vi->max_queue_pairs; i++) {
> >        |              ^
> >        |              vi
> 
> Will fix in the next version.
> 
> Thanks!

OK, however pls do test individual patches as well as the whole
patchset.

-- 
MST


