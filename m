Return-Path: <netdev+bounces-19997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F3F75D513
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF471C21769
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857F21D5D;
	Fri, 21 Jul 2023 19:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E921D3B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:33:52 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB13AAD
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:33:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so19312735e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689968009; x=1690572809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiIakR7GGY0mh3xcC7+ZeZTllDxNHTtdgGxePeuDbpQ=;
        b=kRGqTQoCPabrXfO1wZyS7kBgRGkabGALr22fhj6MeGD1xSGW98aIz17mPsvFGtDEQD
         hhCoXnztbvQiPovVS9LmH2FsSSIfdcNpMhsriHt/ojklXOQXdG3mPAxjphbgh24HvYn0
         ulypILvK3/IcgBW/YIhS/KcpnlZ5WloZO0+QiL3/OcKFfzaUfs3hc3C6pxARckozAbKl
         /7NJbPIirjQqZK5iKCgkmD15KHZJagBc7j2qlisFh+meMe/GhPcpXqeSXjx1Hkc7cBpL
         x+e1DqQHPESMZnh4ql8HrJAK67hwjE4y//nSsEjcS/iMvR/TLLXaKcdC7yPVMxDKWThn
         zq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968009; x=1690572809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiIakR7GGY0mh3xcC7+ZeZTllDxNHTtdgGxePeuDbpQ=;
        b=PjG2lkVQjh9sZzPeaIMzT3wCmoEXh0LQjS+cLcCqQx6Dba1dDoPjgRyLCa462vE8tI
         z24ruUw7ATCTlLpW2d1mSx7Z8fEnSEKLNeP6HDuebi38QeKh7p+h+u8Wn4EJPhW1HJIM
         RpR6WuyFQNLcteEWLqpxLB71ZimcFdhjwQH/Eyclzb2+W4I2iGsJToZ4IyihFM150zMd
         Maj0cTFcGAOvNGPNTaHj91Ma8wptpCm5SQwiQGkAOXlHsTmrdLUEin/GQNxK13pni7qJ
         As72ic6mUEMN+ZiUwzPuhLAEhCcmNbwJz2c0NGi8mSI7oSM8EiEnjDe/3pTYNC5VqQ4h
         FTBA==
X-Gm-Message-State: ABy/qLaCODqx5VaVIAIvH4CYOaU5riuNlFRN2orC/4YlG9oONa7MayrI
	0HaAcjtoSVWmdlSAs7M1PBhFIg==
X-Google-Smtp-Source: APBJJlEUIOe8JHpY836fs80K7GJobdy0OYgrT0dK/Px9YG+gTHTC2vuayMZ9Qy+gnh8dnzbKbrtb3w==
X-Received: by 2002:a05:600c:2907:b0:3fc:1bd:95a6 with SMTP id i7-20020a05600c290700b003fc01bd95a6mr2096561wmd.31.1689968008942;
        Fri, 21 Jul 2023 12:33:28 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm5001211wrv.26.2023.07.21.12.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 12:33:28 -0700 (PDT)
Message-ID: <d5157187-16fa-62c8-9098-04f644aacf14@arista.com>
Date: Fri, 21 Jul 2023 20:33:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8.1 net-next 00/23] net/tcp: Add TCP-AO support
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>,
 Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 Salam Noureddine <noureddine@arista.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
 Steen Hegelund <Steen.Hegelund@microchip.com>
References: <20230721161916.542667-1-dima@arista.com>
 <e35c16d2-c86c-8df2-8312-c8ab254d221a@kernel.org>
 <CANn89iLQhCu=daXAtMJDFGQ9mRCd99b=bR=nN5qw4un8DQ1tSQ@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iLQhCu=daXAtMJDFGQ9mRCd99b=bR=nN5qw4un8DQ1tSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/21/23 19:18, Eric Dumazet wrote:
> On Fri, Jul 21, 2023 at 8:12 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 7/21/23 10:18 AM, Dmitry Safonov wrote:
>>> Hi,
>>>
[..]
>>
>> For the set:
>> Acked-by: David Ahern <dsahern@kernel.org>
> 
> I will have to review this series, of course, if bots are happy.

Thanks David, Eric!
I appreciate both Acks and potential reviews.

Thanks,
             Dmitry


