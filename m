Return-Path: <netdev+bounces-33837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C832E7A06E5
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B9FB20B09
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEB21A1F;
	Thu, 14 Sep 2023 14:07:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5F2421B
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:07:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFD41A2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694700445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHudOf8iuVH8gSyXltnig2N3UnhuMoM7BMALuIknbpk=;
	b=B/OIlWQCCNnNP9t8/f5NLGImajDU0sYjTQeX4GjbP6jbpDVYd4M12s0X1103odpvThorcJ
	TWVDPFa60xVYPNT6LOqf+HqAsnQgCkfUORynCh9d8NKiFsajOIfhJnHWlUGV4VrPbrJV2G
	2a0KwFLNIkwYM5/9Uwyg66lrDqHn44Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-3p_Nk4tPNBSJWZHlNFQ52g-1; Thu, 14 Sep 2023 10:07:23 -0400
X-MC-Unique: 3p_Nk4tPNBSJWZHlNFQ52g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40474e7323dso2855105e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694700441; x=1695305241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHudOf8iuVH8gSyXltnig2N3UnhuMoM7BMALuIknbpk=;
        b=UGrhS8EECXiJQOGbpedR5L+IirBztr8O7aXZNR1ywA8ZQqtH956dHWKQ0SCSZ/7B4T
         cPAepIA4y2KeVbJ4Sksg/S5l/j5sXYdldmFGhDxFOidtjzWQE2i/0sFHaie4rv904b44
         HLpRSfuheelM5fsVaYbMcoSLH9kmUb+XywpNr6yeZk+moEMyXZWTHD206GSQkYPgPQ3I
         9g0tkow7E9ETJhfURXqL1+Jz5DS39FOgJyKh3kEhXx8blboIj6vA0kEPvC+wb0chYtdK
         DHE33Uf6VcZ6amwEvgViQXFQZczNjyLQZb206LqsZjwc3eA4hfiT21ziBjDWkL4gD49N
         glkA==
X-Gm-Message-State: AOJu0YzqN34R09GZm2sJjb+Jxuk1tRDvYfOBbj8klgvtUWfsp2628EYw
	BVur0z4Bcmc7h1MWI1LH4gGgZiP+zPIhGCsym2bQGKgNYlK63g3fK3S037iEXYv9gGLW66XGBxv
	bAXvoNke54SUUP/WjAByX8ZaiF5A=
X-Received: by 2002:a05:600c:22c6:b0:401:b53e:6c57 with SMTP id 6-20020a05600c22c600b00401b53e6c57mr4834837wmg.9.1694700441099;
        Thu, 14 Sep 2023 07:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIqdAUEhMIPyjpv+aXEvjvAdHzcpL3PZnpBEW96reh9Fs+X2mFI8Jv7Jj2JWmjIb6ifqV2MQ==
X-Received: by 2002:a05:600c:22c6:b0:401:b53e:6c57 with SMTP id 6-20020a05600c22c600b00401b53e6c57mr4834802wmg.9.1694700440710;
        Thu, 14 Sep 2023 07:07:20 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.114.183])
        by smtp.gmail.com with ESMTPSA id c3-20020a056000104300b003143cb109d5sm1889389wrx.14.2023.09.14.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:07:20 -0700 (PDT)
Date: Thu, 14 Sep 2023 16:07:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <554ugdobcmxraek662xkxjdehcu5ri6awxvhvlvnygyru5zlsx@e7cyloz6so7u>
References: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230911202234.1932024-1-avkrasnov@salutedevices.com>

Hi Arseniy,

On Mon, Sep 11, 2023 at 11:22:30PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset is first of three parts of another big patchset for
>MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) <--- this patchset
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/.
>3) Updates for tests and utils.
>
>This series enables handling of fragged skbs in virtio and vhost parts.
>Newly logic won't be triggered, because SO_ZEROCOPY options is still
>impossible to enable at this moment (next bunch of patches from big
>set above will enable it).
>
>I've included changelog to some patches anyway, because there were some
>comments during review of last big patchset from the link above.

Thanks, I left some comments on patch 4, the others LGTM.
Sorry to not having spotted them before, but moving
virtio_transport_alloc_skb() around the file, made the patch a little
confusing and difficult to review.

In addition, I started having failures of test 14 (server: host,
client: guest), so I looked better to see if there was anything wrong,
but it fails me even without this series applied.

It happens to me intermittently (~30%), does it happen to you?
Can you take a look at it?

host$ ./vsock_test --mode=server --control-port=12345 --peer-cid=4
...
14 - SOCK_STREAM virtio skb merge...expected recv(2) returns 8 bytes, got 3

guest$ ./vsock_test --mode=client --control-host=192.168.133.2 --control-port=12345 --peer-cid=2

Thanks,
Stefano


