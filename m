Return-Path: <netdev+bounces-17531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1BD751E89
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95BB281CCB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431510782;
	Thu, 13 Jul 2023 10:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886241094A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:11:37 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207E2700
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:11:32 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3159b524c56so146949f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243090; x=1689847890;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPR1yMWcnyOiGmafPtw2/cYgBmCNFxdYca8sNpEDilo=;
        b=DCRBuXVhhR6zhl4kHOeLtqq+oCIodGEIyX7ozcZ+OmtrvFK6jEJzan8zckib+2Imb8
         OMC/SYRFlJCesZ0g/HdAYxAO79/9X0xMhq2XtTOq/KeLL4VAA6CV3VAQMllQQGJMBMr+
         rZ/pg/lXWmH9pdPw6dq1DaGsrDDWtGQ87AGC+zH0/+1zejMfrnWLZccVg98/PrgeeLtL
         p18TkQaxh0K7o2bsRpPfFfjkE9wtzoNieWBhfuVOMTL+TcIEcUtZuxYDWrFm2Lq0bh5B
         267EZ4fxHWiz8t2gBGXRzYX7g8WrHqfNM82Pf1fRL9TctSoK/WBs4onPgWwdkX/iwJ9O
         1bGg==
X-Gm-Message-State: ABy/qLY19pNf4hGJtyhRpntp8/ppELHCu8IW0frEtshEPWwNqjOqswYw
	+Q2WvP4lm2k+dA1WR7rSidY=
X-Google-Smtp-Source: APBJJlHSSOwWWcq5EnKi0HGVpp3whUMYunvm9+18uatw5jvZuogV3lrMw4sMRIzHpNVOkOhyf5vxaw==
X-Received: by 2002:adf:dd8a:0:b0:313:dfa5:291c with SMTP id x10-20020adfdd8a000000b00313dfa5291cmr957156wrl.7.1689243090288;
        Thu, 13 Jul 2023 03:11:30 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b00313f031876esm7493988wrr.43.2023.07.13.03.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:11:29 -0700 (PDT)
Message-ID: <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
Date: Thu, 13 Jul 2023 13:11:28 +0300
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
To: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
 <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> skbs are unrelated to the TCP window. They relate to the socket send
>> buffer. skbs left dangling would cause server side to run out of memory,
>> not for the TCP window to close. The two are completely unrelated.
> 
> Ouch.
> Wasn't me, in the end:
> 
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index f37f4a0fcd3c..ca1e0e198ceb 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -369,7 +369,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, 
> struct sk_buff *in_skb,
> 
>   static int tls_strp_read_copyin(struct tls_strparser *strp)
>   {
> -       struct socket *sock = strp->sk->sk_socket;
>          read_descriptor_t desc;
> 
>          desc.arg.data = strp;
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
> Otherwise we'd enter a recursion calling ->read_sock(), which will 
> redirect to tls_sw_read_sock(), calling tls_strp_check_rcv(), calling 
> ->read_sock() ...

Is this new? How did this pop up just now?

> It got covered up with the tls_rx_reader_lock() Jakub put in, so I 
> really only noticed it when instrumenting that one.

So without it, you get two contexts reading from the socket?
Not sure how this works, but obviously wrong...

> And my reading seems that the current in-kernel TLS implementation 
> assumes TCP as the underlying transport anyway, so no harm done.
> Jakub?

While it is correct that the assumption for tcp only, I think the
right thing to do would be to store the original read_sock and call
that...

