Return-Path: <netdev+bounces-39979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994747C5499
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A4A281EE6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA51EA92;
	Wed, 11 Oct 2023 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YznvrzBA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D13F4E5
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 12:58:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F09D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697029087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srINTOA9TWB2isXW3Sgrz+IUFVxpno9ZCmYhECMZXz8=;
	b=YznvrzBAxFd9HeEr8zA/vdlev/B7Znsa/HCmIusic5uYUya7WIEzndlqf7je8e9dkk+2wN
	1eusof51YuMgvHTZVf4ZbG+dQk3F/HL8mh0AO5IhFUtQv/JjpJvQf188dlhvKaZVnlC+rL
	3gjWnxdy32rQaDLpAXVNBx9TbdEJUys=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-wn_HuqjONZ6A6f2ICsMoMA-1; Wed, 11 Oct 2023 08:58:05 -0400
X-MC-Unique: wn_HuqjONZ6A6f2ICsMoMA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77422b0e373so742305785a.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029085; x=1697633885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srINTOA9TWB2isXW3Sgrz+IUFVxpno9ZCmYhECMZXz8=;
        b=GVLHbEyyEGlB6lER4eSOEmLQ5CmEy4tOJDHb664egQuhaHqc+cQRGbU8oB7/TEYpPv
         /B1rSmjZY2RUwfRZmN1vvSOhn7GmbcErz35LMJiPT6RVKJoHrHHgHJ5YptQwHgmcNKeR
         1mXvUhXYVay8PqVwkZZrPtyW4+QjeDwr3JMkJuYH9bXiyCppOdAUp6Dqd0Y9A3HpX6ne
         WZlvnQbtt8qON3CwAVdyQ61t8VI6zmeDOW97y/6A8b3NbDm7gbfrN9o4mIR0w3ySyjl0
         S7Z8EjB4+94mpzcmXYsjqMZEXuBZ/WTgiA+emk2wWk6wR+Wj3nl2ecqeyhWbGKvUkldf
         mA8A==
X-Gm-Message-State: AOJu0Yxtq30VLwLn54cXOM72DwCeKXm6b+BWx9UzMibfLZDWRomkz0+L
	RFSranxhk4lRWDkfH+iaWSyH5BXpGcz7BEXZWc/57xQORQE1ZDjh2/cAfN+dm0TW322j/8j6icA
	q1FZ9QxKq+lczS2WU
X-Received: by 2002:a05:620a:28c1:b0:772:64b3:889f with SMTP id l1-20020a05620a28c100b0077264b3889fmr23924387qkp.29.1697029085394;
        Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEat3sMaNphExceyLByW9stmPTXf2ifIIJ9bDX8SUeZpYDbCXHEF5UpdzIbTW2PMO+Wgc/Bfg==
X-Received: by 2002:a05:620a:28c1:b0:772:64b3:889f with SMTP id l1-20020a05620a28c100b0077264b3889fmr23924364qkp.29.1697029085125;
        Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it. [79.46.200.251])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a121000b0076cdc3b5beasm5193811qkj.86.2023.10.11.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:58:04 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:57:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v4 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <eey4hfz43popgwlwtheapjefzmxea7dk733y3v6aqsrewhq3mq@lcmmhdpwvvzc>
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:15:12PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=19537e125cc7cf2da43a606f5bcebbe0c9aea4cc
>
>Link to v1:
>https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>Link to v2:
>https://lore.kernel.org/netdev/20230930210308.2394919-1-avkrasnov@salutedevices.com/
>Link to v3:
>https://lore.kernel.org/netdev/20231007172139.1338644-1-avkrasnov@salutedevices.com/
>
>Changelog:
> v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
> v2 -> v3:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
> v3 -> v4:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.

I think I fully reviewed the series ;-)

Tests are all passing here, including the new ones. I also added
vsock_perf and vsock_uring_test to my test suite!

So for vsock point of view everything looks fine.

Let's see if there is anything about net (MSG_ZEROCOPY flags, etc.)

Thanks,
Stefano


