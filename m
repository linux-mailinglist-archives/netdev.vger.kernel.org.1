Return-Path: <netdev+bounces-19645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DA75B8DC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383071C2145E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8387156FE;
	Thu, 20 Jul 2023 20:41:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF63D6A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:41:34 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1418C271E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:41:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fde022de07so996535e87.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689885691; x=1690490491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXGfryj3JnWN9Feoc8w9BGYqPrVXy8Lu8jILfQ+075I=;
        b=cWJLQt1qvY7qjP7GF1j3sJXR0EPj17c1eccsRUgyLEqQBDuU9e+KShJVqSbnjrqdnI
         Pkuyoux94FokFu6AAKk0ophScO7nRl53dlm0lnDHTvl+PMUqpl65uXNM3Go5Hd2jWskE
         xldxdWDTYeN6/IuBMzWkxSqzvG4D2cTyynphQbteJ9dkjH9VYhQZYQaGYKhTQpS4ljIE
         wYTZzDvaZC8mfVtkkgrZLGJ2w4bJwE36q/hLe+GAqyqL2HmsvdlHss0rMedin0+WTnfM
         TBuVz6KJH/O9psH/0IOEqweRKFSpHFh+l0AOnMaloUNSUiFcOAWO9ZGFMhvoVTh0RmY9
         tVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885691; x=1690490491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXGfryj3JnWN9Feoc8w9BGYqPrVXy8Lu8jILfQ+075I=;
        b=GLeE0UNIgLLzG7GmajyXp+3nwd7jNqex/NCKZGC0pVKuIOOiyxUPsA9AZon1dEcxaA
         sQqoOr0gqFEkl511O6y21VCV560/pEN+JU2azwMsQfMKiJs+FJ0AH94qjiJwnkwefMNI
         lHYxO2G5Qq91oS7MZT0sls2gajXtsnAXqUahMOo6FLfaOUcRW2sVUM+jirJy/Njwwfwa
         HtDasM7yt3jHvyDDQinyFxjgBGekjw8EiSbJp7nyC4vALKmArq38iLnAo0b05yAx4Adq
         MkNi4mNEku4w3Ky09PtRb9KYSoMoSU7UlJMEdpVlupORRZ0kMF3IdMYWdySqHIqJxzJr
         swHw==
X-Gm-Message-State: ABy/qLZ0t//R4ZCayP5aRjHPO1whA/tu5UNFWhcVif0NOu6oP8hm0Tdr
	KI+WNAd3w2erC4apMUi5KUkVeQ==
X-Google-Smtp-Source: APBJJlG0GoMeF7yXsTTTJGh7LhM1YlXEQP714hGJ4aGgRSnsHwN/mVYpx1+8aAlVS555IhRX1RoP0g==
X-Received: by 2002:a05:6512:2152:b0:4fd:d6ba:73c2 with SMTP id s18-20020a056512215200b004fdd6ba73c2mr2213679lfr.54.1689885691242;
        Thu, 20 Jul 2023 13:41:31 -0700 (PDT)
Received: from ?IPV6:2a02:8084:2562:c100:228:f8ff:fe6f:83a8? ([2a02:8084:2562:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b003f7f475c3bcsm6720092wmq.1.2023.07.20.13.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 13:41:30 -0700 (PDT)
Message-ID: <a6d09fcc-9516-4300-8771-5e163727cf15@arista.com>
Date: Thu, 20 Jul 2023 21:41:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 00/23] net/tcp: Add TCP-AO support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Ard Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>,
 Dan Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 Salam Noureddine <noureddine@arista.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230719202631.472019-1-dima@arista.com>
 <20230720105316.0ad41719@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20230720105316.0ad41719@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/20/23 18:53, Jakub Kicinski wrote:
> On Wed, 19 Jul 2023 21:26:05 +0100 Dmitry Safonov wrote:
>> This is version 8 of TCP-AO support. I base it on master and there
>> weren't any conflicts on my tentative merge to linux-next.
> 
> doesn't apply

Yeah, it did yesterday on next-20230719, but today's next-20230720 has
commit 5e5265522a9a ("tcp: annotate data-races around
tcp_rsk(req)->txhash"), which has a conflict.

I'll resend rebased v8.1-next

Thanks,
            Dmitry


