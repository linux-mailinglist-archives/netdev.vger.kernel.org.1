Return-Path: <netdev+bounces-36433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6887AFC28
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4A9AB281889
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909201C6A5;
	Wed, 27 Sep 2023 07:35:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EC1C2B0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:35:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB618194
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695800138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ap6jvf8/2CoqbMpAwThp0QoWymIsVaHbvqKSWQ1uNLM=;
	b=Fqy8D0l6FwOEYKLxZ5SNUxqzF8TiJS01jP/nE7PHq/2zkS0zvyLB5DHKI1PgwJIr7YA6zH
	OTEmdHvc/VvvXGTnsBXQ60AKPFZINUNoV8JpsV35Cj9RBy8sNzq9LgjgX9ItYQvBeIQcGq
	1Eq5peUesYsJfI7ubyWhcyKxpd4wmK8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-gU3m1rqHMV-oU4_pMPIT8g-1; Wed, 27 Sep 2023 03:35:36 -0400
X-MC-Unique: gU3m1rqHMV-oU4_pMPIT8g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so98140385e9.3
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695800135; x=1696404935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap6jvf8/2CoqbMpAwThp0QoWymIsVaHbvqKSWQ1uNLM=;
        b=jqwljeFJQPOx0W2HuI/WxduysfI4w34UORTXacTZ0O0IPzT5hTD6P5Lv0hbMSowPD+
         lAv+AlIFjf5XiAzptp/muFjMVz8Yvu8tj5aIaZ4fC45fNW4ygPfyB78PpasLGi+ByckH
         aluYu5OY17ISNGZhm/RmB+hE4+4jQDIbbv57WWn6zQpgaN7AyJiT2vGk2Ua7zYNJ8pEc
         Mih4kTbmtFONjQSmexwGjgG1YnfPgWXu1PueVPM+N2AXWUxT+8QOB+7hvoMm1E+cPrnq
         Ncu6y6bSFKZEZIe/xTEIkRHo3nAGzqMfX/SzprIgxKcAJNMWcHqhzMAmKNDQ8CER0Dtz
         wARA==
X-Gm-Message-State: AOJu0YzzoKpvH2daInbzA488eCq+52LldXEL06ChWgTL2qiaR+mHnzZR
	UxZeeAGe9zW3a1VYEwlhE1puRmIkyy5tMKRfErVHwEu9zr4WeSSOCE24aYtr0ZqofYDm9qfam7u
	iBBNIT8Wlbg93GGKH
X-Received: by 2002:a7b:ce94:0:b0:401:c944:a4d6 with SMTP id q20-20020a7bce94000000b00401c944a4d6mr1190419wmj.28.1695800134934;
        Wed, 27 Sep 2023 00:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNeo+a3D1T3OSxeUepQ732xUxuE+Jh5ew/NsV6Yu1nas54YVkW3cnsBtEB4qZvL4QfCzEH8w==
X-Received: by 2002:a7b:ce94:0:b0:401:c944:a4d6 with SMTP id q20-20020a7bce94000000b00401c944a4d6mr1190398wmj.28.1695800134503;
        Wed, 27 Sep 2023 00:35:34 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.19.70])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c029300b004060f0a0fdbsm4495926wmk.41.2023.09.27.00.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:35:33 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:35:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1 08/12] vsock: enable setting SO_ZEROCOPY
Message-ID: <n4si4yyqs2svmvhueyxxyev2v3wxugzjjb25wpyveg3ns5nv6i@cfb4fyq5kdaf>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-9-avkrasnov@salutedevices.com>
 <ynuctxau4ta4pk763ut7gfdaqzcuyve7uf2a2iltyspravs5uf@xrtqtbhuuvwq>
 <d27b863d-8576-2c9b-c6a6-c8e55d7dad68@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d27b863d-8576-2c9b-c6a6-c8e55d7dad68@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 10:38:06PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.09.2023 15:56, Stefano Garzarella wrote:
>> On Fri, Sep 22, 2023 at 08:24:24AM +0300, Arseniy Krasnov wrote:
>>> For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
>>> be set in AF_VSOCK implementation where transport is accessible (if
>>> transport is not set during setting SO_ZEROCOPY: for example socket is
>>> not connected, then SO_ZEROCOPY will be enabled, but once transport will
>>> be assigned, support of this type of transmission will be checked).
>>>
>>> To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
>>> bit, thus handling SOL_SOCKET option operations, but all of them except
>>> SO_ZEROCOPY will be forwarded to the generic handler by calling
>>> 'sock_setsockopt()'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v5(big patchset) -> v1:
>>>  * Compact 'if' conditions.
>>>  * Rename 'zc_val' to 'zerocopy'.
>>>  * Use 'zerocopy' value directly in 'sock_valbool_flag()', without
>>>    ?: operator.
>>>  * Set 'SOCK_CUSTOM_SOCKOPT' bit for connectible sockets only, as
>>>    suggested by Bobby Eshleman <bobbyeshleman@gmail.com>.
>>>
>>> net/vmw_vsock/af_vsock.c | 46 ++++++++++++++++++++++++++++++++++++++--
>>> 1 file changed, 44 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 482300eb88e0..c05a42e02a17 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1406,8 +1406,16 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>             goto out;
>>>         }
>>>
>>> -        if (vsock_msgzerocopy_allow(transport))
>>> +        if (vsock_msgzerocopy_allow(transport)) {
>>>             set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>>> +        } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>>> +            /* If this option was set before 'connect()',
>>> +             * when transport was unknown, check that this
>>> +             * feature is supported here.
>>> +             */
>>> +            err = -EOPNOTSUPP;
>>> +            goto out;
>>> +        }
>>>
>>>         err = vsock_auto_bind(vsk);
>>>         if (err)
>>> @@ -1643,7 +1651,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>>>     const struct vsock_transport *transport;
>>>     u64 val;
>>>
>>> -    if (level != AF_VSOCK)
>>> +    if (level != AF_VSOCK && level != SOL_SOCKET)
>>>         return -ENOPROTOOPT;
>>>
>>> #define COPY_IN(_v)                                       \
>>> @@ -1666,6 +1674,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>>>
>>>     transport = vsk->transport;
>>>
>>> +    if (level == SOL_SOCKET) {
>>> +        int zerocopy;
>>> +
>>> +        if (optname != SO_ZEROCOPY) {
>>> +            release_sock(sk);
>>> +            return sock_setsockopt(sock, level, optname, optval, optlen);
>>> +        }
>>> +
>>> +        /* Use 'int' type here, because variable to
>>> +         * set this option usually has this type.
>>> +         */
>>> +        COPY_IN(zerocopy);
>>> +
>>> +        if (zerocopy < 0 || zerocopy > 1) {
>>> +            err = -EINVAL;
>>> +            goto exit;
>>> +        }
>>> +
>>> +        if (transport && !vsock_msgzerocopy_allow(transport)) {
>>> +            err = -EOPNOTSUPP;
>>> +            goto exit;
>>> +        }
>>> +
>>> +        sock_valbool_flag(sk, SOCK_ZEROCOPY,
>>> +                  zerocopy);
>>
>> it's not necessary to wrap this call.
>
>Sorry, what do you mean ?

I mean that can be on the same line:

	sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);

Stefano


