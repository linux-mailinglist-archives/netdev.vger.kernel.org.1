Return-Path: <netdev+bounces-19004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1677594AB
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EF1C20F89
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F413AF9;
	Wed, 19 Jul 2023 11:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED99BA38
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:54:30 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B447C7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:54:28 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3159adb7cb5so1636499f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767667; x=1692359667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iibJZf1MO5qf9sqGK5FjYmeBRCfxvOFvuqnNYLw9dxA=;
        b=J1xR2oDbqkS9A8cClZn+z7+ZoqF6P4IwP5EhNdPEkT22aMHooz7N3uD1T8CFquiaFZ
         qtroukVTTG9yjTS3LeNsg6wY7cO5VgnZCDeldwmPWLDCjMdylhBX6/xZkJgta9qnXBvb
         6XPxtp6gT4BUbROrmL65Bsoov5w37gRsw9mJwJDVqTsoNEiBC55vYwynbwrvN1VBtRua
         WHR2a5FZagHqCgXnHyWFEYSxUySFy5xofDh9Axwzy55h6RgaEofIJ+yCNd6t8k+J9lWj
         bVmN7rHXmpKz5Ef0cAGPOa3lxlO4l04n3q1az+FL41SqiifbN33ekapelTcS4n5knov8
         z/og==
X-Gm-Message-State: ABy/qLYyv8fMb4T+DihaLDUpeYFcreap2/0MhjyzSq2oACjWEMyLy/uA
	UXr5MRguPISQUX4YTEdxLsA=
X-Google-Smtp-Source: APBJJlH76eIThhwx3BP0l3BGhULMnlpurLoS8TeSckHEAp0cIa9HBdeAS+mUAcNet9mJCEs04RomaQ==
X-Received: by 2002:adf:fc09:0:b0:313:e8fb:b00f with SMTP id i9-20020adffc09000000b00313e8fbb00fmr2267945wrr.6.1689767666572;
        Wed, 19 Jul 2023 04:54:26 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6411000000b00314145e6d61sm5173631wru.6.2023.07.19.04.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:54:25 -0700 (PDT)
Message-ID: <ce600dd6-90c2-6a4d-48df-02152174ad51@grimberg.me>
Date: Wed, 19 Jul 2023 14:54:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
 <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
 <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
 <a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
 <20230718115921.4de52fd6@kernel.org>
 <8d866cf2-df52-5085-f0d4-864d15b8667d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8d866cf2-df52-5085-f0d4-864d15b8667d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>>>> And my reading seems that the current in-kernel TLS implementation
>>>>> assumes TCP as the underlying transport anyway, so no harm done.
>>>>> Jakub?
>>>>
>>>> While it is correct that the assumption for tcp only, I think the
>>>> right thing to do would be to store the original read_sock and call
>>>> that...
>>>
>>> Ah, sure. Or that.
>>
>> Yup, sorry for late reply, read_sock could also be replaced by BPF
>> or some other thing, even if it's always TCP "at the bottom".
> 
> Hmm. So what do you suggest?
> Remember, the current patch does this:
> 
> @@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct tls_strparser 
> *strp)
>          desc.count = 1; /* give more than one skb per call */
> 
>          /* sk should be locked here, so okay to do read_sock */
> -       sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
> +       tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
> 
>          return desc.error;
>   }
> 
> precisely because ->read_sock() gets redirected when TLS engages.
> And also remember TLS does _not_ use the normal redirection by 
> intercepting the callbacks from 'struct sock', but rather replaces the 
> ->ops callback in struct socket.
> 
> So I'm slightly at a loss on how to implement a new callback without 
> having to redo the entire TLS handover.
> Hence I vastly prefer just the simple patch by using tcp_read_sock() 
> directly.

I think this is fine. The tls parser is exclusive to the bottom socket
being a tcp socket anyways, read_sock() was by definition until Hannes's
patch 6/6 always tcp_read_sock. So this is a valid replacement IMO.
I don't think that it is worth the effort to "prepare" for generalizing
the tls parser.

