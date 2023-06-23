Return-Path: <netdev+bounces-13464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA873BB02
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D191C21198
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2CAD2E;
	Fri, 23 Jun 2023 15:05:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DAAD24
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:05:12 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971510F6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:05:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-312826ffedbso816481f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532705; x=1690124705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cs1KSJ9UrnFd8QnDhZFxPHhGj3XIdiVqhL8dVMT6b48=;
        b=O/9duzCX3a0RpOyFDZxgj++rg5Jdve3OxQLiNTQLRfJ2C5bz12RbEHwQj/V6s/eyis
         I7LQy2tS7SxrJOhtCKJZUI+FQS3/kdgF5clHG/FW0c1QxSBdD4DN/E8CeapWqy1QHrv7
         cfl5hOEsSutdTqH9ORco7BrESTPOHdy7ygpjvqn9L/qcDdkevc8SU0qNsb2U4dhiLBbN
         gvYu9TK5HdPnAK2Ir7wSYPoHV+t018WdeFOSRgvOYMSEq3kE/8/g+PUrxbE/nkzGsOEu
         Oaed7WHXlEppNi4sb0Vseuzg2qmIL7mZw3XPqxQJK2s+g6cLMT7V3PEzPb9cPBFOhW9A
         vaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532705; x=1690124705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs1KSJ9UrnFd8QnDhZFxPHhGj3XIdiVqhL8dVMT6b48=;
        b=AA0guiMOWsfe+AV0A5Y5c9QQ4yxj8G0nCiVbyvwpDbnd0jLpKuEtXIPFAbAAgtT+0j
         Dq4WRAcm9uFjcKiYICmG+Q1g7+yOFEc/oMT27+rKjQhq83KhL77ZE6EiKhri6LYGxBp4
         s0RVxeU0JB8MxE1gWs09M+Z+zlANsjXTFmkN39iaOPAx6ILpR3yll5ii3MaEsgnj+Lm4
         8Hjfwr+oktC/3iHjQt46RSGkrMuXha/1yImBODEN6QlcLSqn0YPNgfyJejSByBwJL48v
         tNwekHQo0D1HF7kv84roKtDFT39hG9J0zWPE5NQN9hoXhp01+aokFIntDDUj9DEqaj7G
         7kfw==
X-Gm-Message-State: AC+VfDxMLZrIPzVkmEfGDK3lAbqlHZGEIXxnPPyto8N1cDxbRax7bIeJ
	v9xYK+MY7b+sCSfN5yeJCFU=
X-Google-Smtp-Source: ACHHUZ5j/rNKo5dkgHLwSXu1rz+mxJ6TZviQ9SX6LcxpKg2hCuAHznTf+oym0nDNZUq3ZKRQL3Z4Qw==
X-Received: by 2002:a5d:5546:0:b0:30f:c042:95e3 with SMTP id g6-20020a5d5546000000b0030fc04295e3mr15884587wrw.11.1687532705068;
        Fri, 23 Jun 2023 08:05:05 -0700 (PDT)
Received: from [192.168.43.77] (82-132-230-75.dab.02.net. [82.132.230.75])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d4dcf000000b0030ae53550f5sm9761018wru.51.2023.06.23.08.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:05:04 -0700 (PDT)
Message-ID: <f3427348-41ee-e0bf-79b6-9ff5120e8110@gmail.com>
Date: Fri, 23 Jun 2023 16:03:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net-next v2] net/tcp: optimise locking for blocking splice
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <80736a2cc6d478c383ea565ba825eaf4d1abd876.1687523671.git.asml.silence@gmail.com>
 <CANn89i+fhE76=i2J0VFacQoOqqA_iJNLazjbcHFGpu4JA6+1BQ@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89i+fhE76=i2J0VFacQoOqqA_iJNLazjbcHFGpu4JA6+1BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 15:17, Eric Dumazet wrote:
> On Fri, Jun 23, 2023 at 2:40 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Even when tcp_splice_read() reads all it was asked for, for blocking
>> sockets it'll release and immediately regrab the socket lock, loop
>> around and break on the while check.
>>
>> Check tss.len right after we adjust it, and return if we're done.
>> That saves us one release_sock(); lock_sock(); pair per successful
>> blocking splice read.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: go with Paolo's suggestion
>>      aggressively shrink the patch
>>
>>   net/ipv4/tcp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 71b42eef9dbf..d56edc2c885f 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -839,7 +839,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>>                  tss.len -= ret;
>>                  spliced += ret;
>>
>> -               if (!timeo)
>> +               if (!tss.len || !timeo)
>>                          break;
>>                  release_sock(sk);
>>                  lock_sock(sk);
> 
> SGTM, thanks.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> I wonder if the "release_sock();sock_lock();"  could be replaced by
> sk_flush_backlog() anyway ?
> Or is there any other reason for this dance ?

Now as you mentioned, it definitely sounds like that. And the code
is 15 years old, perhaps nobody was paying attention.


> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 71b42eef9dbf527098963bc03deecf55042e2021..d03d38060944d63d2728a7bf90a5c117b7852d8b
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -841,8 +841,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
> 
>                  if (!timeo)
>                          break;
> -               release_sock(sk);
> -               lock_sock(sk);
> +               sk_flush_backlog();
> 
>                  if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
>                      (sk->sk_shutdown & RCV_SHUTDOWN) ||

-- 
Pavel Begunkov

