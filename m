Return-Path: <netdev+bounces-34367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFD7A3EF5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 02:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8BC1C20869
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004BE629;
	Mon, 18 Sep 2023 00:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A152370
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:25:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384BB11C
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694996719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XGw7AdgYIk+RoEKFj7VSzvf+HqUpChJVq9bKRl2ets=;
	b=TkntXe/5AJ6EcuDQjCYYViIbwcnK/MBFNMSSdiCVWUc+bbkdlekPwWfuveoaScnDg8LMvr
	VUdigkqby0j95ULeF2Fg+FM4WXsGCG/Kbcv1X0wRcXVT4p2ogpaDVqQbArce8poBZ00rMN
	a2z0nyLq2EVfWfImwJKVPaIrUfS4NAI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-NNbB7QkMOaSt9fiPl7L38w-1; Sun, 17 Sep 2023 20:25:17 -0400
X-MC-Unique: NNbB7QkMOaSt9fiPl7L38w-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-780addd7382so376973839f.1
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 17:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694996717; x=1695601517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XGw7AdgYIk+RoEKFj7VSzvf+HqUpChJVq9bKRl2ets=;
        b=eRL15kh2Fdh2wm5DvDdFH2jIK+n2/iAybxPMQdDl/hmXKMK/qYe1cd/GKuP06smh8a
         YZsfYjCOL8+JW1qlm+wbte5dFbV9stydTl3uI4YdZfuXBPtJDLwq1XnWFjHjqVGo2EP/
         ZZLymuLJI7yLo+zozCkNBhFQp8vKyuFjLn/VI2qwe5SW2No0ophw9P70wz3gbsjAY/Jw
         +tNtB6wTpQCpg3AwTSfG3j6Xfr1qmQ5Np//XZ3EFowRnw8xyoAUX0EL9a3z0dRvuui+C
         3xqIo+FcOyiWrEkEyMTDX5jwfwF+LdgFKNX+hafNEd39r5wVuNhU/0zsWZIe1KiWGqe3
         muVg==
X-Gm-Message-State: AOJu0YyvuLPPfkBgLhArZm+SkfNVjQDnZDLy00JrARCghinScv8CVBlc
	EoBniqid5IuKu8x4cq2vkr7wasxzI4TdGhLayRzxM0EfIZRljpwFJLoyzGfgS8NEo5P4HViMXZg
	30T51j7im5MbemmzhjmPtZ5gyD1Y=
X-Received: by 2002:a92:c243:0:b0:34f:f373:ad7e with SMTP id k3-20020a92c243000000b0034ff373ad7emr465801ilo.1.1694996716960;
        Sun, 17 Sep 2023 17:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgUb4xgzcsF6D3DA7oMGkWPNDOVIlzmfnSfqk/GsC4gkgPnWHPQRcOFDq8+Xz2fcLmLDPI0A==
X-Received: by 2002:a92:c243:0:b0:34f:f373:ad7e with SMTP id k3-20020a92c243000000b0034ff373ad7emr465795ilo.1.1694996716745;
        Sun, 17 Sep 2023 17:25:16 -0700 (PDT)
Received: from [10.72.113.158] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m23-20020a635817000000b0056606274e54sm4393724pgb.31.2023.09.17.17.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 17:25:16 -0700 (PDT)
Message-ID: <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
Date: Mon, 18 Sep 2023 08:25:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230915201510.never.365-kees@kernel.org>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230915201510.never.365-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 9/16/23 04:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/ceph/mon_client.h | 2 +-
>   net/ceph/mon_client.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index b658961156a0..7a9a40163c0f 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -19,7 +19,7 @@ struct ceph_monmap {
>   	struct ceph_fsid fsid;
>   	u32 epoch;
>   	u32 num_mon;
> -	struct ceph_entity_inst mon_inst[];
> +	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
>   };
>   
>   struct ceph_mon_client;
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index faabad6603db..f263f7e91a21 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>   			       GFP_KERNEL);
>   	if (!monc->monmap)
>   		return -ENOMEM;
> +	monc->monmap->num_mon = num_mon;
>   
>   	for (i = 0; i < num_mon; i++) {
>   		struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
> @@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>   		inst->name.type = CEPH_ENTITY_TYPE_MON;
>   		inst->name.num = cpu_to_le64(i);
>   	}
> -	monc->monmap->num_mon = num_mon;

BTW, is this change related ?

>   	return 0;
>   }
>   

Else LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks!

- Xiubo



