Return-Path: <netdev+bounces-15758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01207498E5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BCD2809D7
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BDE79F4;
	Thu,  6 Jul 2023 10:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AF79F2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 10:01:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2D1BEA
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688637714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
	b=A2l7ieAu6OqAPIPg+NmbiXNz3+uqI9DMT0EyqhKT+9Vev1l1BPQWM0LLQguyJ0whQG1Y5b
	YDSygl/upsmEd/nwfXHHw6nIEEQJ32QwwXe3pHR/CbGGglHPkDoIn88EI5ZHqj8zbg00bi
	DehP2AJrVa4lvcmhCSDRKg3DMMu0WpU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Sm7ci6_LPOOiC0W-Eud6YQ-1; Thu, 06 Jul 2023 06:01:50 -0400
X-MC-Unique: Sm7ci6_LPOOiC0W-Eud6YQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-57059f90cc5so6229437b3.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637709; x=1691229709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
        b=FCYjhkhuq670SaPYcfbbk32YtYzATYlHwDA2yjf5BdUomAyUQ+Bjjl8X/JcNuY0NuD
         dzEBTqca3euIe6Uj090AAx79X42yt6S13e9sg4CV131nagiWMFbVwS8iohWYIqGURH4Z
         B48fwx7fMo1mQQoUi+GaRzIQvuANaQFNgpvCRXViKam7y13jAm5ANopBv47jYfbWqvZT
         VZ5kuLqQzShnQGBLXeUf7u1w+a9MJs5aK+aGnCCYJ2JwovXyrmb24NKLEKzIZBtACO1K
         Huq8gmoop2O2KgBYsm43G3z2lZSG7hz9KlXMEPaK2pYEAbkjgJ4rXdDlj7GPfJYu4mH/
         10sA==
X-Gm-Message-State: ABy/qLbXNvZlkfomcLGWn6vUh5ew+KmxTrrkNQyAS5/uob6eP9p0AA76
	7CQ6z/8DYs4j4R/rlxdILOP0RlWGVMMVfShYsoQl4rUaiExmi6/2q2gOFlboSyC+c4pYHW5DPFD
	tw2XxHOtFJSDRv1WyvSVEmT14uX2tGZim
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id t126-20020a818384000000b0056d0c9739f4mr1424689ywf.8.1688637709731;
        Thu, 06 Jul 2023 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnS8DTGuBigSC1cOUEhrHGP3AjZEn+XIDZR976mIx9TGjJA3wYtGsoU6qHdLxp+gcwyMWCUHKwipRzaY/ylEo=
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id
 t126-20020a818384000000b0056d0c9739f4mr1424668ywf.8.1688637709450; Thu, 06
 Jul 2023 03:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704234532.532c8ee7.gary@garyguo.net>
In-Reply-To: <20230704234532.532c8ee7.gary@garyguo.net>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Jul 2023 12:01:38 +0200
Message-ID: <CAGxU2F4_br6e3hEELXP_wpQSZTs5FYhQ-iahiZKzMMRYWpFXdA@mail.gmail.com>
Subject: Re: Hyper-V vsock streams do not fill the supplied buffer in full
To: Gary Guo <gary@garyguo.net>, Dexuan Cui <decui@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Gary,

On Wed, Jul 5, 2023 at 12:45=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> When a vsock stream is called with recvmsg with a buffer, it only fills
> the buffer with data from the first single VM packet. Even if there are
> more VM packets at the time and the buffer is still not completely
> filled, it will just leave the buffer partially filled.
>
> This causes some issues when in WSLD which uses the vsock in
> non-blocking mode and uses epoll.
>
> For stream-oriented sockets, the epoll man page [1] says that
>
> > For stream-oriented files (e.g., pipe, FIFO, stream socket),
> > the condition that the read/write I/O space is exhausted can
> > also be detected by checking the amount of data read from /
> > written to the target file descriptor.  For example, if you
> > call read(2) by asking to read a certain amount of data and
> > read(2) returns a lower number of bytes, you can be sure of
> > having exhausted the read I/O space for the file descriptor.
>
> This has been used as an optimisation in the wild for reducing number
> of syscalls required for stream sockets (by asserting that the socket
> will not have to polled to EAGAIN in edge-trigger mode, if the buffer
> given to recvmsg is not filled completely). An example is Tokio, which
> starting in v1.21.0 [2].
>
> When this optimisation combines with the behaviour of Hyper-V vsock, it
> causes issue in this scenario:
> * the VM host send data to the guest, and it's splitted into multiple
>   VM packets
> * sk_data_ready is called and epoll returns, notifying the userspace
>   that the socket is ready
> * userspace call recvmsg with a buffer, and it's partially filled
> * userspace assumes that the stream socket is depleted, and if new data
>   arrives epoll will notify it again.
> * kernel always considers the socket to be ready, and since it's in
>   edge-trigger mode, the epoll instance will never be notified again.
>
> This different realisation of the readiness causes the userspace to
> block forever.

Thanks for the detailed description of the problem.

I think we should fix the hvs_stream_dequeue() in
net/vmw_vsock/hyperv_transport.c.
We can do something similar to what we do in
virtio_transport_stream_do_dequeue() in
net/vmw_vsock/virtio_transport_common.c

@Dexuan WDYT?

Thanks,
Stefano


