Return-Path: <netdev+bounces-14989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097EC744DB9
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3F21C204F0
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C520FF;
	Sun,  2 Jul 2023 13:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3C20FE
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 13:37:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D0126
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688305034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fscz16jdu5EOdDpNFofgtOkAvApauMfws1a+RHlsQn0=;
	b=bqeo8LtrpydN8VC2qwddEFpcycLwhrbnIww6vqV/wB6qO9EyliH/c9a0h3rBAFIjFcQN1B
	KRg+e2CZbvDOtiO0c9BrAoRHLYmVSCwb7E8tQ83EWs4YykVBKkU/dCavmwbG1NtiH6fjh+
	Rp38ZlCft/tq20LsRM5Li/xxt9rY5Ls=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-CEn26MqpMXGkL3R0tmaGoQ-1; Sun, 02 Jul 2023 09:37:13 -0400
X-MC-Unique: CEn26MqpMXGkL3R0tmaGoQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-978a991c3f5so259969766b.0
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 06:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688305032; x=1690897032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fscz16jdu5EOdDpNFofgtOkAvApauMfws1a+RHlsQn0=;
        b=kCArk4aGGszm7a0Fz6SUXN2IwXBTh+J2moAKyXflyWPAlRtWYP1qCPgS8oPBTLB6tk
         zz8Y/5otD06tbXys/ZrPnkVmXezvmDvjDuBboLmC6OqTU5E6X2GEoqqCZUPd+88aycm6
         ryzk0eIqx670/LIsHg9mQs3hU31B99kjm3Z/3O10neDE0ByJmG9cV3Gtfycv8aSGbmZI
         bjzslXs5HkWUM8C63A0AYgBHI4InR2XO/hI4RIk/bTZodwobLUaia7C284rlsLCwNWS9
         eJj30d0wmIbD09AMr4fAbkaubMZ6vGdSIVbgwshT9qiWdyEhDddKU+R3O2GolttEjZso
         dbjQ==
X-Gm-Message-State: AC+VfDw1g5qvFHTbeGzdPoZQFlhg6ctniLoj9J5ILI+7usFkbsZFqr3I
	8oK8eu9BhWiBV66oBcxyDJJCjNZo2ZypcXLAsZ0L0qME7Vf9IORhSBW6Y9sLjXp505jFHG/A8K5
	7xwZcsgt3lgvfDgjZ
X-Received: by 2002:a17:906:b811:b0:979:65f0:cced with SMTP id dv17-20020a170906b81100b0097965f0ccedmr5934779ejb.17.1688305031943;
        Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGgYm6Pej4shREErdqqtoaKfnv59VDi8oQbzHD5HcPb5WjgVVGyKQF1QNN/hdRhbN02rqoIg==
X-Received: by 2002:a17:906:b811:b0:979:65f0:cced with SMTP id dv17-20020a170906b81100b0097965f0ccedmr5934769ejb.17.1688305031706;
        Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
Received: from redhat.com ([2.52.134.224])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709065ada00b00992025654c1sm7342793ejs.179.2023.07.02.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
Date: Sun, 2 Jul 2023 09:37:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: xieyongji@bytedance.com, jasowang@redhat.com, david.marchand@redhat.com,
	lulu@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230702093530-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
> 
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

Jason promised to post a new version of that patch.
Right Jason?
For now let's make sure CVQ feature flag is off?

> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)
> 
> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0


