Return-Path: <netdev+bounces-31670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC27E78F79C
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974E61C20B38
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D001FA9;
	Fri,  1 Sep 2023 04:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E61C3E
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:08:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB13E54
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693541325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vAEme2KcwNj8ElOSfFjCJ2hxkQyLdnTJ01In+1K7No=;
	b=W6tbv1pSgS+J5uaUKBXvvHHb/GgIMKxwiFlchS/5XV5Z4g6G7eEHG+mygd0HefJGNef4Ym
	sK5TAfxHVByFDxgCiCRQdaADySHevPZ5zYENvs/qyPv8RZRlGj2DfrTCAdPtYHZOM7R9Bw
	eU6zPeyaIYjkwXNaRcnSDfKo54mZG5g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-xEh_HWxsOMymgH6I6BYkxQ-1; Fri, 01 Sep 2023 00:08:44 -0400
X-MC-Unique: xEh_HWxsOMymgH6I6BYkxQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c09c1fd0abso17552595ad.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693541323; x=1694146123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vAEme2KcwNj8ElOSfFjCJ2hxkQyLdnTJ01In+1K7No=;
        b=egqMfp7hYv8LnEurT36hiuLJhdtqLQUte/aH4dzJ02U8xBLx0OZNDVCevtR6U3H0bW
         NdTJnftYH/3NFVBG99zDDU+Ojw58C4SFKzI7h0pfNqhCT/tx305cTBWi1QB73327Ms2d
         9abuzKdyvZD/m4qt2/7jKghLFsOi8t7GU88BmwJd2tHt+KlPsRCDGoEytbuS5J8xy5/D
         4hTCX3b/xzWgJkVd/XpX5wwQQVOhk6yP/eXP0XYe009EPW9T4e53zTMTRkVRZxtKA+0Y
         dHA4ON6792MErKmMR1CpUWZCFnwwAPuUbaw3Jn071TBrRQ2BR3rZxpCrtpJWX254Vtyc
         S+ng==
X-Gm-Message-State: AOJu0Yy8Md/ExkGOZ1kB1q8+aToad0hZwFj8Tt3GFHhQ90Gjfldwbekg
	KjPzdqQbQu8PcZuJ0hypr06r9/kP/cbnl/Yd9Pcv0uQDm9pqRZhgWiRcNHnHGFiISAH4npN1+Oh
	iRAvP8hJwwwqxGWKf
X-Received: by 2002:a17:902:ce83:b0:1b8:a389:4410 with SMTP id f3-20020a170902ce8300b001b8a3894410mr2165075plg.0.1693541323286;
        Thu, 31 Aug 2023 21:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGpJHSaFUxfNQbPShMOTj8pzFSKBo0PMibNqmcad2bpNkdcelC5VHSRKexr4LJ2dd9/ZZPRA==
X-Received: by 2002:a17:902:ce83:b0:1b8:a389:4410 with SMTP id f3-20020a170902ce8300b001b8a3894410mr2165056plg.0.1693541323012;
        Thu, 31 Aug 2023 21:08:43 -0700 (PDT)
Received: from [10.72.113.184] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001b9e9f191f2sm1977357plw.15.2023.08.31.21.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 21:08:42 -0700 (PDT)
Message-ID: <f2d90a8d-dc6e-9bb2-a4bc-285dc7c9b3ea@redhat.com>
Date: Fri, 1 Sep 2023 12:08:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ceph/decode=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
Content-Language: en-US
To: Li kunyu <kunyu@nfschina.com>, idryomov@gmail.com, jlayton@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230902201112.4401-1-kunyu@nfschina.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230902201112.4401-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 9/3/23 04:11, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the
> assignment.
> Bad is not used and can be removed.
>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   net/ceph/decode.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/decode.c b/net/ceph/decode.c
> index bc109a1a4616..9f5f095d8235 100644
> --- a/net/ceph/decode.c
> +++ b/net/ceph/decode.c
> @@ -50,7 +50,7 @@ static int
>   ceph_decode_entity_addr_legacy(void **p, void *end,
>   			       struct ceph_entity_addr *addr)
>   {
> -	int ret = -EINVAL;
> +	int ret = 0;
>   
>   	/* Skip rest of type field */
>   	ceph_decode_skip_n(p, end, 3, bad);

Hi Kunyu,

The 'bad' lable is used here in this macro.

Thanks

- Xiubo

> @@ -66,8 +66,7 @@ ceph_decode_entity_addr_legacy(void **p, void *end,
>   			      sizeof(addr->in_addr), bad);
>   	addr->in_addr.ss_family =
>   			be16_to_cpu((__force __be16)addr->in_addr.ss_family);
> -	ret = 0;
> -bad:
> +
>   	return ret;
>   }
>   


