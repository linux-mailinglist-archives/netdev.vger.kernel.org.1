Return-Path: <netdev+bounces-40118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A117C5D68
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C382821A2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A339E12E4F;
	Wed, 11 Oct 2023 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2jhRyBD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182283A26E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 19:08:54 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1490;
	Wed, 11 Oct 2023 12:08:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a2874d2820so3195739f.1;
        Wed, 11 Oct 2023 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697051330; x=1697656130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOAHf3xPVNAj31p9ZuVv8f99VDpjedw2IWf54wQ2koM=;
        b=R2jhRyBDCYWcs+M0RzfihZ7KPwzHAVwLQ73iF/LdNZcnpyNzujkSLdfpvXXlpEdjwB
         PkUtczMQ95YKWio/huWt0GETC4zRtuwA9wK1MbmtRGq5lX9ej/o+BHcz2XhTT31N2ey/
         JQ5LtCmf4DfGmnh74d8vaxMi0foQ6cLIdH16rzG2no7KnvK5oSMt25m3OzJOAW9NQXEa
         QAh5Is0jsanS9d/RUZwZsooDlUl6zmfzqbEZqdtH8ySqmgHMzPMLxcIxnObRsjRin5XQ
         zsowaqO/vj2Pyh4otYjeyLZdTCGpzOuTQqycOHYOWObsBy9gmpVuyZVhmMw2ruYvStdA
         qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051330; x=1697656130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOAHf3xPVNAj31p9ZuVv8f99VDpjedw2IWf54wQ2koM=;
        b=U6IWOi7kB0NthWNqlKQVlJpLJh7UEx8/QFbv4NTX+CwnLhvhJecG6Wi+yLMyLfCf4M
         ms2lI5grpqtP7rq99hBdwdRMqzyysgFXQ08LERnxbCd4sCgs5HapwDJTcdviMfq8N357
         zq2libauY1fDEKwAgJNJ2Fvqgr6/dQh3qn2iQuh9SRkMas9KiqaBprpwmvA1OYZF52Oj
         jgYCG5B4tvafXEn7vGxX3i1TBXIE67CT9yEmU2/UFMVGJiMTG8SuZNygJ9YDNfWyZsdf
         gCixXwL4c9o4s5oiJ2BbYUwSOPTCK6JcRNHvA8tXjnmthpO9PV4o+PyoYVZ7AqcyNmax
         fapg==
X-Gm-Message-State: AOJu0Yz9TvhAxQG3F52bZdL8A1LRUADpZqOnc+erPIkkN6nd33Ax43hp
	29IVpX5zn94WBRVK3XqiuRA=
X-Google-Smtp-Source: AGHT+IEvyVcmyoResAsmvkfmIStWlRecPzJs24Pekw51sgdB1+vZgz26xmObGIfV15Y7nuH+4KXd1Q==
X-Received: by 2002:a6b:5a0a:0:b0:790:958e:a667 with SMTP id o10-20020a6b5a0a000000b00790958ea667mr21122819iob.2.1697051329738;
        Wed, 11 Oct 2023 12:08:49 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id n3-20020a5e8c03000000b0079ab2787139sm3852955ioj.7.2023.10.11.12.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:08:10 -0700 (PDT)
Message-ID: <b34b4e95-2d0c-4cb0-97b0-2613857d2c35@gmail.com>
Date: Thu, 12 Oct 2023 00:37:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove extra unlock for the mutex
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
 <2023101136-irritate-shrine-cde6@gregkh>
 <3073e9a6-9f10-4326-9734-7e203d509888@gmail.com>
 <CANn89i+hMbhLqXKCF2P=HVeeRSCxvgH_xY1b=T=udLFJjG3ZwA@mail.gmail.com>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <CANn89i+hMbhLqXKCF2P=HVeeRSCxvgH_xY1b=T=udLFJjG3ZwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 23:13, Eric Dumazet wrote:
> 
> There is no undefined behavior, only sparse that might be confused a little.
> 
> I do not think we can express in sparse the fact that
> inet_csk_find_open_port() acquires head->lock
> 
> (head being the return value of this function...)
> 
> The following does not help.
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index aeebe881668996057d1495c84eee0f0b644b7ad0..ed7b3993316cd1ba0b2859b0bd3f447e066bd3b5
> 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -323,6 +323,7 @@ static struct inet_bind_hashbucket *
>   inet_csk_find_open_port(const struct sock *sk, struct
> inet_bind_bucket **tb_ret,
>                          struct inet_bind2_bucket **tb2_ret,
>                          struct inet_bind_hashbucket **head2_ret, int *port_ret)
> +       __acquires(head->lock)
>   {
>          struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
>          int i, low, high, attempt_half, port, l3mdev;

Okay got it. Thank you for your time maintainers.And apologizes for not 
thoroughly checking before sending the patch. I have a question, there 
were some type checking warning as well from sparse tool. Can a create 
patch for fixing those type checking warning?


