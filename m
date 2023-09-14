Return-Path: <netdev+bounces-33903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15B7A097A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040D528218F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2671CF8C;
	Thu, 14 Sep 2023 15:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39ED39C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:34:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2322B1FD2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694705668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buiiu+tLXB8hg1uWGuKZq7mBUyxAEPJaVjE6lmvNhuc=;
	b=FJHRA124CvtNQ5zbyuuNjH5XspAh0h8WEeAs+RuxDe1r29cnSi75HnaVQLH0gZsnQSw+B8
	Y73RGPG1wHJM859gw6YjCvq9cWEPWG7aQTdDIKijSBEjMKoFbsAHYKMrfQ8rKK6w7mXWdB
	sJeqWeWhMgYqiF0SeQFYW6c6Q9LEVBE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-YqMvyi2rMvurrZXuFfWynw-1; Thu, 14 Sep 2023 11:34:26 -0400
X-MC-Unique: YqMvyi2rMvurrZXuFfWynw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31facb07f53so493594f8f.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705665; x=1695310465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buiiu+tLXB8hg1uWGuKZq7mBUyxAEPJaVjE6lmvNhuc=;
        b=Ew23Q701f6lwmdJ5htotDfWCby98oACIFGIFeWWwVVzpaPa5//IVqwQz5iltFqjiFf
         Vq8KPYDj4s4jJz5ICi/fEFVEJCocYiMFJU0HzshLYqdv7a5q3o80VDzmyrgHc4IkPo1B
         ktNriTvV0SACJLmrKFzZERvuinNiV29v4qou1aO5pjPjFg3zQBkAUAvPgOOqXaLapIOo
         3R2QK8/c1RxZZmHojpWx62VjeRUGpnkObmUGRRg1yrbAVMlTOwokgcmjjPcQLUBM/BVW
         Wm/K+1Fpxf1fkCMWvq7nwL935Uh5WqWTIm2xkrC9Rk5tKfojjWXlBR+Oh430G+woi6EY
         HAbg==
X-Gm-Message-State: AOJu0YyE6wBN6R2aAJ7gI1MuHCl7KuJIY0tw6GpAjLpvJSxDI94scNn2
	KnNpqHAc/WgEvBaDPftVv2m8gx8Agyq+3a4jYLdoOqUwgtPEb8UFkfZlUBvzTEuUG5FYkhzaCbP
	24ywKdkFnYmLAQo7M
X-Received: by 2002:a5d:5948:0:b0:31c:8c5f:877e with SMTP id e8-20020a5d5948000000b0031c8c5f877emr1882391wri.33.1694705665493;
        Thu, 14 Sep 2023 08:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+nCbcXFaH/HOSF4+8+BhfwcplnBX+yHnh9Wu4fo/aPF7ErBAktIXQigHFHZ5NP8kmGbuZA==
X-Received: by 2002:a5d:5948:0:b0:31c:8c5f:877e with SMTP id e8-20020a5d5948000000b0031c8c5f877emr1882368wri.33.1694705665105;
        Thu, 14 Sep 2023 08:34:25 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.114.183])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003fee849df23sm2283011wmi.22.2023.09.14.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:34:24 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:34:18 +0200
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
Message-ID: <63xflnwiohdfo6m3vnrrxgv2ulplencpwug5qqacugqh7xxpu3@tsczkuqgwurb>
References: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
 <554ugdobcmxraek662xkxjdehcu5ri6awxvhvlvnygyru5zlsx@e7cyloz6so7u>
 <7bf35d28-893b-5bea-beb7-9a25bc2f0a0e@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bf35d28-893b-5bea-beb7-9a25bc2f0a0e@salutedevices.com>

On Thu, Sep 14, 2023 at 05:05:17PM +0300, Arseniy Krasnov wrote:
>Hello Stefano,
>
>On 14.09.2023 17:07, Stefano Garzarella wrote:
>> Hi Arseniy,
>>
>> On Mon, Sep 11, 2023 at 11:22:30PM +0300, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> this patchset is first of three parts of another big patchset for
>>> MSG_ZEROCOPY flag support:
>>> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>>>
>>> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>>> suggested to split it for three parts to simplify review and merging:
>>>
>>> 1) virtio and vhost updates (for fragged skbs) <--- this patchset
>>> 2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>>>   tx completions) and update for Documentation/.
>>> 3) Updates for tests and utils.
>>>
>>> This series enables handling of fragged skbs in virtio and vhost parts.
>>> Newly logic won't be triggered, because SO_ZEROCOPY options is still
>>> impossible to enable at this moment (next bunch of patches from big
>>> set above will enable it).
>>>
>>> I've included changelog to some patches anyway, because there were some
>>> comments during review of last big patchset from the link above.
>>
>> Thanks, I left some comments on patch 4, the others LGTM.
>> Sorry to not having spotted them before, but moving
>> virtio_transport_alloc_skb() around the file, made the patch a little
>> confusing and difficult to review.
>
>Sure, no problem, I'll fix them! Thanks for review.
>
>>
>> In addition, I started having failures of test 14 (server: host,
>> client: guest), so I looked better to see if there was anything wrong,
>> but it fails me even without this series applied.
>>
>> It happens to me intermittently (~30%), does it happen to you?
>> Can you take a look at it?
>
>Yes! sometime ago I also started to get fails of this test, not ~30%,
>significantly rare, but it depends on environment I guess, anyway I'm going to
>look at this on the next few days

Maybe it's just a timing issue in the test, indeed we are expecting 8
bytes but we received only 3 plus the 2 bytes we received before it
seems exactly the same bytes we send with the first
`send(fd, HELLO_STR, strlen(HELLO_STR), 0);`

Since it is a stream socket, it could happen, so we should retry
the recv() or just use MSG_WAITALL.

Applying the following patch fixed the issue for me (15 mins without
errors for now):

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 90718c2fd4ea..7b0fed9fc58d 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1129,7 +1129,7 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
         control_expectln("SEND0");

         /* Read skbuff partially. */
-       res = recv(fd, buf, 2, 0);
+       res = recv(fd, buf, 2, MSG_WAITALL);
         if (res != 2) {
                 fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
                 exit(EXIT_FAILURE);
@@ -1138,7 +1138,7 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
         control_writeln("REPLY0");
         control_expectln("SEND1");

-       res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
+       res = recv(fd, buf + 2, 8, MSG_WAITALL);
         if (res != 8) {
                 fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
                 exit(EXIT_FAILURE);

I will check better all the cases and send a patch upstream.

Anyway it looks just an issue in our test suite :-)

Stefano

>
>Thanks, Arseniy
>
>>
>> host$ ./vsock_test --mode=server --control-port=12345 --peer-cid=4
>> ...
>> 14 - SOCK_STREAM virtio skb merge...expected recv(2) returns 8 bytes, got 3
>>
>> guest$ ./vsock_test --mode=client --control-host=192.168.133.2 --control-port=12345 --peer-cid=2
>>
>> Thanks,
>> Stefano
>>
>


