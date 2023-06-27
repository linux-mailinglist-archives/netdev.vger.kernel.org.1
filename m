Return-Path: <netdev+bounces-14180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787073F629
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597F1280F42
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F0BA30;
	Tue, 27 Jun 2023 07:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5DA94B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:53:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8675F1716
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687852421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaGOS9wkr6YWqK+5U8u6i1zG6qs2tTQ6/raZM0kVnbg=;
	b=aKnC6RLqIxgmZEjuFOfOyH6Erfvp+2OhzLZJ4V/jANJxz5eZ5c0IdKMECLcuwqbzrAb1WT
	OlhAY1m5WK09Fvsuux2hE4GTkK8umyUcBEuWT9zC5jo6ga93NF/d9Pik72QXdUbKvI76QX
	7xGo6CeBvw9hd6kbFNb8VcBD56DNTjY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-CFl-JCKANOKnKgXy1sUYaA-1; Tue, 27 Jun 2023 03:53:39 -0400
X-MC-Unique: CFl-JCKANOKnKgXy1sUYaA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9715654ab36so226264466b.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852413; x=1690444413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaGOS9wkr6YWqK+5U8u6i1zG6qs2tTQ6/raZM0kVnbg=;
        b=NxQ1RwH6ldMvqo3rL5EBzrBtPHXhImFtOiuSS3zzK0OYXPwTbxjt6OQkMujMGvadjP
         ft6ikjqtn83ejzzGv8BGK7H4uwtFV+EodwOwsQsa4ypqbNVNKTeLxAK7uHychXngbYjp
         Jfb37qn85IEYa5mngEGe9/zRHSsO7XT4UPsXNU13J57SBYa4vt4oG3UcY4v8aRmyES0D
         se19aBxrSPez2nrC0Fiu4nqSKTOl4t0GDueHDtqK3HdzXasEj2XUYQsFptHUYgvL+KkC
         mgBPNnt6fTdZ5KfpxRquU+UpSx3pZ+pQHJJbd73DZ+nM6/UVSb2uNFpd0JmeROcO45PA
         0yJQ==
X-Gm-Message-State: AC+VfDwV/5XUd07OoNbM7nbSBeB+hxXJGG1UtAPjS35KeeIlr9b8a/Ee
	56K1Qes7jXABOMfyN+YFHA+P9EdKj1AOCsYM/K1T973P0HvtIvx477WWN2Jp3R1sa9NkYVbzQpX
	rJkX0ldu/wXoM+TDD
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr15445251ejy.53.1687852413620;
        Tue, 27 Jun 2023 00:53:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iZHQ4sT71AvDVVWRhT6FBmJw3cWaMNmCzSmG2L5gutVyEA42mOg+6M3+BcIvlFY1BUoU07A==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr15445236ejy.53.1687852413286;
        Tue, 27 Jun 2023 00:53:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id r21-20020a1709067fd500b00988781076e2sm4235786ejs.78.2023.06.27.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:53:32 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:53:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 06/17] vsock: check error queue to set EPOLLERR
Message-ID: <pnbag2axu2uy7w2wrgiljutr3hifo3rltvkkc46wlrmhwzqr5b@pgaqr2m3iwof>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
 <rg3qxgiqqi5ltt4jcf3k5tcnynh2so5ascvrte4gywcfffusv4@qjz3tkumeq7g>
 <94a133e5-a180-a9b5-91cb-c0ca44af35ea@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a133e5-a180-a9b5-91cb-c0ca44af35ea@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 07:44:25AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:04, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:28PM +0300, Arseniy Krasnov wrote:
>>> If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>>> reader of error queue won't detect data in it using EPOLLERR bit.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This patch looks like it can go even without this series.
>>
>> Is it a fix? Should we add a fixes tag?
>
>Yes, it is fix and I can exclude it from this set to reduce number
>of patches, but there is no reproducer for this without MSG_ZEROCOPY
>support - at this moment this feature is the only user of error queue
>for AF_VSOCK.

Okay, so it's fine to keep it here, but please mention in the comment 
that without MSG_ZEROCOPY it can't be reproduced.

That way we know that we don't have to backport into the stable 
branches.

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>> Thanks,
>> Stefano
>>
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index efb8a0937a13..45fd20c4ed50 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1030,7 +1030,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
>>>     poll_wait(file, sk_sleep(sk), wait);
>>>     mask = 0;
>>>
>>> -    if (sk->sk_err)
>>> +    if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
>>>         /* Signify that there has been an error on this socket. */
>>>         mask |= EPOLLERR;
>>>
>>> -- 
>>> 2.25.1
>>>
>>
>


