Return-Path: <netdev+bounces-13428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E573B8E7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECD91C21230
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34A8C03;
	Fri, 23 Jun 2023 13:43:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3A8BF5
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:43:34 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED401FE1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:43:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51bdf83a513so667767a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687527811; x=1690119811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FasrEHhJIpaosfdkZQMTOlxj/Ad2x8oxOpc436FO1rM=;
        b=YeYAu5VFr1Ph5iq6WizR9YB83448kJpL5uBAeqBMohokQPHh5RewltDfCYK+S38oIW
         z5T5Zz+PvK6AIHy/smVEy0Rf7UkToFTQqGUiAR9y4n+4YTPq9vBCXER1RE/gIgUN9+mg
         dT13IuFYjU4KoC09QFoAm62eyfmTRwF+nh9QfDEqe2fUQ+pfv57qf0Tx1XsluIWrA1PR
         dyTgmZUSkiKL6Ou4wBKg3uh7Ifm/B4BsLZdY0SPKZ7GX1doJ74mDojg2W/VnNNTCUaIy
         /UyFbg5dD+xJXrMMpEZaMIxFU+W7m7VkIGBDpO2KOk8mEOx8zfw3koZf08ncRy8Eo4ee
         gUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687527811; x=1690119811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FasrEHhJIpaosfdkZQMTOlxj/Ad2x8oxOpc436FO1rM=;
        b=b+sqDEx2hjlDpmkz6qkOGzAA3FAT7zzJ8vX3myOT6lLgsh+MvfrxOqO2Shi4aqE+n9
         4tMyziseH7Q1FSbjx8NrEkoTShZgYRs4tvE4B6KXPZTbOogfowNKv+gL9A30D/fNvgm+
         4VhCNegCyCV3wL1vSEg1dtMcpkQratk1xdrM58VYV2rs4+zLgTjCWt0NGUpwcOuU7S2g
         M6La2PScMPWNiz6FrrPpheHU9COVtek3ERe2NT9BINumw46GbBIj51lQcQRHiEM+/SHc
         pvbCatFjTig5mCWK8YOcQorHkzV540wc1iCZXmmwjALNZnHyARgWHlV2XYmUjk2CjWpP
         lGDw==
X-Gm-Message-State: AC+VfDye23LWdOxE6IGnmBhAwKP1JWGrDteqP5zxUplqMOIaTL9jT7PS
	b61HbcoBDAVFih/u6SVPM865+kJ9b7I=
X-Google-Smtp-Source: ACHHUZ7t+DOfBITiyoydepxxrCXfShBVqbkXJDy9DX1Xg2GFdH8/AwbNqzk7PJomxjuyQiOCjRYikA==
X-Received: by 2002:a17:907:7da7:b0:989:2a82:fb0a with SMTP id oz39-20020a1709077da700b009892a82fb0amr9028318ejc.71.1687527811331;
        Fri, 23 Jun 2023 06:43:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::26ef? ([2620:10d:c092:600::2:7d95])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b009829dc0f2a0sm6013006ejc.111.2023.06.23.06.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:43:31 -0700 (PDT)
Message-ID: <14ce6ee2-922a-93c2-0d6e-5778822ca5d6@gmail.com>
Date: Fri, 23 Jun 2023 14:42:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net-next 1/2] net/tcp: optimise locking for blocking
 splice
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org
References: <cover.1684501922.git.asml.silence@gmail.com>
 <a6838ca891ccff2c2407d9232ccd2a46fa3f8989.1684501922.git.asml.silence@gmail.com>
 <c025952ddc527f0b60b2c476bb30bd45e9863d41.camel@redhat.com>
 <5b93b626-df9a-6f8f-edc3-32a4478b8f00@gmail.com>
 <e972fc86-b884-3600-4e16-c9dbb53c6464@gmail.com>
 <CANn89iLU0BWxWrh1a3cfh+vOhRuyU5UJ8d5oD7ZW_GLfkMtvAQ@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iLU0BWxWrh1a3cfh+vOhRuyU5UJ8d5oD7ZW_GLfkMtvAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/19/23 11:59, Eric Dumazet wrote:
> On Mon, Jun 19, 2023 at 11:27 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 5/24/23 13:51, Pavel Begunkov wrote:
>>> On 5/23/23 14:52, Paolo Abeni wrote:
>>>> On Fri, 2023-05-19 at 14:33 +0100, Pavel Begunkov wrote:
>>>>> Even when tcp_splice_read() reads all it was asked for, for blocking
>>>>> sockets it'll release and immediately regrab the socket lock, loop
>>>>> around and break on the while check.
>>>>>
>>>>> Check tss.len right after we adjust it, and return if we're done.
>>>>> That saves us one release_sock(); lock_sock(); pair per successful
>>>>> blocking splice read.
>>>>>
>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>> ---
>>>>>    net/ipv4/tcp.c | 8 +++++---
>>>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>>>> index 4d6392c16b7a..bf7627f37e69 100644
>>>>> --- a/net/ipv4/tcp.c
>>>>> +++ b/net/ipv4/tcp.c
>>>>> @@ -789,13 +789,15 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>>>>>         */
>>>>>        if (unlikely(*ppos))
>>>>>            return -ESPIPE;
>>>>> +    if (unlikely(!tss.len))
>>>>> +        return 0;
>>>>>        ret = spliced = 0;
>>>>>        lock_sock(sk);
>>>>>        timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
>>>>> -    while (tss.len) {
>>>>> +    while (true) {
>>>>>            ret = __tcp_splice_read(sk, &tss);
>>>>>            if (ret < 0)
>>>>>                break;
>>>>> @@ -835,10 +837,10 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>>>>>                }
>>>>>                continue;
>>>>>            }
>>>>> -        tss.len -= ret;
>>>>>            spliced += ret;
>>>>> +        tss.len -= ret;
>>>>
>>>> The patch LGTM. The only minor thing that I note is that the above
>>>> chunk is not needed. Perhaps avoiding unneeded delta could be worthy.
>>>
>>> It keeps it closer to the tss.len test, so I'd leave it for that reason,
>>> but on the other hand the compiler should be perfectly able to optimise it
>>> regardless (i.e. sub;cmp;jcc; vs sub;jcc;). I don't have a hard feeling
>>> on that, can change if you want.
>>
>> Is there anything I can do to help here? I think the patch is
>> fine, but can amend the change per Paolo's suggestion if required.
>>
> 
> We prefer seeing patches focusing on the change, instead of also doing
> arbitrary changes
> making future backports more likely to conflict.

Thank you for taking a look! I cut it down and resent.

I don't agree it's arbitrary, it's a clean up related to the
change. I'm just trying to not make the death by a thousand cuts
problem worse for networking, but I guess I'm worried for nothing.

-- 
Pavel Begunkov

