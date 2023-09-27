Return-Path: <netdev+bounces-36432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3B7AFC23
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 42DDE1C20856
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CCB1C69C;
	Wed, 27 Sep 2023 07:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D133D6
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:34:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EA210E
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695800081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQQkzbHkwKvbUjj0WbZjfuE2ay8gjWtPd5Q/t3WKnBA=;
	b=IV24D3VcLoiVgCKig3J+dzBFej/siypqs85AaMLGAB4Oy7QGIQH96O0N+bF62rkXhWhB/a
	JiXBka6vULcX1LELcjM/akQSwNd4V70u8B0k9nOEnteIf9WquF6nX+lhnVxLOZnCNSPq7F
	U1adPZ1eEKbFQlLMhAL/P14dZAt3Ma0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-9aOY3oSINUC8xcY1OHU0-w-1; Wed, 27 Sep 2023 03:34:40 -0400
X-MC-Unique: 9aOY3oSINUC8xcY1OHU0-w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40540179bcdso81729125e9.2
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695800079; x=1696404879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQQkzbHkwKvbUjj0WbZjfuE2ay8gjWtPd5Q/t3WKnBA=;
        b=N1/17RJOzsVv0N0yKdk4+j/lyxo0MuiIA3gP5B35AWm3x9LoqJMrUXfWhLZFPMPIsC
         QbR5t8vUh6g4oi60bJe2IdJiME3Ghplte/kDFfl+frzelGmlrinS1LAKbUN53wDz5YK1
         rR9NZ0bGlOabSEJ8vpxi7jeiyjSzSZGRtTBaM6yN3cUXkayjhRJ4LP1Gu+0+aK0j32D5
         J6QYUP5zxLXPxFzoxOHMOBM9oMSAJELqR4YSgOQtZRsv9Ke6D+LJunAlD2t0cv1mSc83
         ZIlv0BNO30UCyiv2wogB4qn1r9hQ+DfqiHfc+5P3WOTVwx/bROaMmZVc2xxFuGnai8SQ
         WUnA==
X-Gm-Message-State: AOJu0Yz49ZH3MeLGvqhr+Oblvft6UIuCdxgJg6pQzJORx5H0ZXM57cng
	V8I4onkOk6nxhEG6OEib90Px1+mLF/JZyyfu/Dqtj0xNKJ/ncADOPCR3/Etjr+fG0WrKZ1EUIQU
	esYoPpZexpz2uG1bI
X-Received: by 2002:a05:600c:d5:b0:405:3dbc:8823 with SMTP id u21-20020a05600c00d500b004053dbc8823mr1254645wmm.12.1695800079123;
        Wed, 27 Sep 2023 00:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnZmkYOiHS5i6sh7ess3HJP64i/yX4oqCnk7AAXwH/cLkcjTdoQ8TWDw8MmUethf/PRXxO6g==
X-Received: by 2002:a05:600c:d5:b0:405:3dbc:8823 with SMTP id u21-20020a05600c00d500b004053dbc8823mr1254628wmm.12.1695800078722;
        Wed, 27 Sep 2023 00:34:38 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.19.70])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600c3d0500b004055858e7d8sm11631863wmb.7.2023.09.27.00.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:34:38 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:34:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1 02/12] vsock: read from socket's error queue
Message-ID: <j7e5az5xrrqvvs64dhwaboi5d4ls5aueu3gyeyyasdqmzbsozu@fni6x6mliw3t>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-3-avkrasnov@salutedevices.com>
 <3oys2ouhlkitsjx7q7utp7wkitnnl4kisl2r54wwa2addd644p@jzyu7ubfrcog>
 <ed26b2b7-bafc-a964-00e2-70da66640e46@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed26b2b7-bafc-a964-00e2-70da66640e46@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 10:36:58PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.09.2023 15:55, Stefano Garzarella wrote:
>> On Fri, Sep 22, 2023 at 08:24:18AM +0300, Arseniy Krasnov wrote:
>>> This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>>> is used to read socket's error queue instead of data queue. Possible
>>> scenario of error queue usage is receiving completions for transmission
>>> with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>>> and 'VSOCK_RECVERR'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v5(big patchset) -> v1:
>>>  * R-b tag removed, due to added defines to 'include/uapi/linux/vsock.h'.
>>>    Both 'SOL_VSOCK' and 'VSOCK_RECVERR' are needed by userspace, so
>>>    they were placed to 'include/uapi/linux/vsock.h'. At the same time,
>>>    the same define for 'SOL_VSOCK' was placed to 'include/linux/socket.h'.
>>>    This is needed because this file contains SOL_XXX defines for different
>>>    types of socket, so it prevents situation when another new SOL_XXX
>>>    will use constant 287.
>>>
>>> include/linux/socket.h     | 1 +
>>> include/uapi/linux/vsock.h | 9 +++++++++
>>> net/vmw_vsock/af_vsock.c   | 6 ++++++
>>> 3 files changed, 16 insertions(+)
>>> create mode 100644 include/uapi/linux/vsock.h
>>>
>>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>>> index 39b74d83c7c4..cfcb7e2c3813 100644
>>> --- a/include/linux/socket.h
>>> +++ b/include/linux/socket.h
>>> @@ -383,6 +383,7 @@ struct ucred {
>>> #define SOL_MPTCP    284
>>> #define SOL_MCTP    285
>>> #define SOL_SMC        286
>>> +#define SOL_VSOCK    287
>>>
>>> /* IPX options */
>>> #define IPX_TYPE    1
>>> diff --git a/include/uapi/linux/vsock.h b/include/uapi/linux/vsock.h
>>> new file mode 100644
>>> index 000000000000..b25c1347a3b8
>>> --- /dev/null
>>> +++ b/include/uapi/linux/vsock.h
>>
>> We already have include/uapi/linux/vm_sockets.h
>>
>> Should we include these changes there instead of creating a new header?
>>
>>> @@ -0,0 +1,9 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +#ifndef _UAPI_LINUX_VSOCK_H
>>> +#define _UAPI_LINUX_VSOCK_H
>>> +
>>> +#define SOL_VSOCK    287
>>
>> Why we need to re-define this also here?
>
>Reason of this re-define is that SOL_VSOCK must be exported to userspace, so
>i place it to include/uapi/XXX. At the same time include/linux/socket.h contains
>constants for SOL_XXX and they goes sequentially in this file (e.g. one by one,
>each new value is +1 to the previous). So if I add SOL_VSOCK to include/uapi/XXX
>only, it is possible that someone will add new SOL_VERY_NEW_SOCKET == 287 to
>include/linux/socket.h in future. I think it is not good that two SOL_XXX will
>have same value.
>
>For example SOL_RDS and SOL_TIPS uses the same approach - there are two same defines:
>one in include/uapi/ and another is in include/linux/socket.h

Okay, I was confused, I though socket.h was the uapi one.
If others do the same, it's fine.

But why adding a new vsock.h instead of reusing vm_sockets.h?

>
>>
>> In that case, should we protect with some guards to avoid double
>> defines?
>
>May be:
>
>in include/linux/socket.h
>
>#ifndef SOL_VSOCK
>#define SOL_VSOCK 287
>#endif
>
>But not sure...

Nope, let's follow others definition.

Sorry for the confusion ;-)

>
>>
>>> +
>>> +#define VSOCK_RECVERR    1
>>> +
>>> +#endif /* _UAPI_LINUX_VSOCK_H */
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index d841f4de33b0..4fd11bf34bc7 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -110,6 +110,8 @@
>>> #include <linux/workqueue.h>
>>> #include <net/sock.h>
>>> #include <net/af_vsock.h>
>>> +#include <linux/errqueue.h>
>>> +#include <uapi/linux/vsock.h>
>>>
>>> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
>>> static void vsock_sk_destruct(struct sock *sk);
>>> @@ -2137,6 +2139,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>>>     int err;
>>>
>>>     sk = sock->sk;
>>> +
>>> +    if (unlikely(flags & MSG_ERRQUEUE))
>>> +        return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 
>>> VSOCK_RECVERR);
>>> +
>>>     vsk = vsock_sk(sk);
>>>     err = 0;
>>>
>>> -- 
>>> 2.25.1
>>>
>>
>


