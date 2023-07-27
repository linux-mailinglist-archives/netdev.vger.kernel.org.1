Return-Path: <netdev+bounces-21847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D99D765033
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F7028221F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29538107AC;
	Thu, 27 Jul 2023 09:47:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72910946
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:47:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46983E0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690451213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OkPmAayPDeHyXcIMrmOokqY8foYhEAqmOlnJq34vJA=;
	b=JU+eBv0WjDH1kqp9/JbX1alMPysJ6tYCOLbyxL13mqPzxyBgkI31wNOJhK56+MEzAra6Yi
	vUi39w+fKlrWMi0KSaQuGAQ4jzouKogqo0bcXvxA8gK9eQeP5PfTGn15E5MPPMz3YyaR5a
	rJw1jKG14A++7ugHby1MMShTCp5j794=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-2rszuQNMOvSsJlvwZeGr4Q-1; Thu, 27 Jul 2023 05:46:51 -0400
X-MC-Unique: 2rszuQNMOvSsJlvwZeGr4Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5226eaba9e9so450234a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690451210; x=1691056010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OkPmAayPDeHyXcIMrmOokqY8foYhEAqmOlnJq34vJA=;
        b=GVMC5iXn/NwCsH1Hl2whvGj8AWHtjIIUPMnWvVOZ5Cze7zZ5GFCO1kFpUFRFA4TJ0G
         85iGtEkLL+NsbWJq1Dotfvv4E9FoTtKFPJMg+lJNLVo6K95TPhfwm74GlUuGCJKrOhvh
         V0K6f1bbyPt43nk9UCZsiBhcbpR52NpKDMmCFlMsTosHRJOw7z5UYT63nLofychVK879
         LO/FB3wL8n3rnrDDrvszqZfY812poLR/S1xvvVveoPOWk00XSWlFWpANqEGv5K/zLSun
         z4NTfGADRgbFN8xZwN6+LdppcQBseZpED+uJLvfc/TzYGd1IWFSbkq3vXTm95niUS+6k
         aB8A==
X-Gm-Message-State: ABy/qLYpMbzwyMO7LRAVrXpNp/TAgZpSJZYkrl8AOD9oGfaQ4Y0x6Dj7
	gC8ZpH1u2AyvvVQLhYAeRQrxw8JiA2lNtybRk4ZBy3o45b3RMjzaXyn6OoauOJslPHIwSWCiYoj
	PBOTrga6SpHlAcO/a
X-Received: by 2002:a05:6402:1489:b0:522:3b94:c6f8 with SMTP id e9-20020a056402148900b005223b94c6f8mr1250122edv.37.1690451210312;
        Thu, 27 Jul 2023 02:46:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpfTNLuZLnTtrO8TWZKOIkB4YOY++DfnrAeL6F4rjv9p1h9W8it7NG7YKv6G2vviq2+n3zxQ==
X-Received: by 2002:a05:6402:1489:b0:522:3b94:c6f8 with SMTP id e9-20020a056402148900b005223b94c6f8mr1250106edv.37.1690451210017;
        Thu, 27 Jul 2023 02:46:50 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7db4a000000b00522584bb58esm436315edt.24.2023.07.27.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:46:49 -0700 (PDT)
Date: Thu, 27 Jul 2023 05:46:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230727054300-mutt-send-email-mst@kernel.org>
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > They really shouldn't - any NIC that takes forever to
> > program will create issues in the networking stack.
> 
> Unfortunately, it's not rare as the device/cvq could be implemented
> via firmware or software.

Currently that mean one either has sane firmware with a scheduler that
can meet deadlines, or loses ability to report errors back.

> > But if they do they can always set this flag too.
> 
> This may have false negatives and may confuse the management.
> 
> Maybe we can extend the networking core to allow some device specific
> configurations to be done with device specific lock without rtnl. For
> example, split the set_channels to
> 
> pre_set_channels
> set_channels
> post_set_channels
> 
> The device specific part could be done in pre and post without a rtnl lock?
> 
> Thanks


Would the benefit be that errors can be reported to userspace then?
Then maybe.  I think you will have to show how this works for at least
one card besides virtio.


-- 
MST


