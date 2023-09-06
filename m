Return-Path: <netdev+bounces-32344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C76794632
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 00:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307C01C209BF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC04C10941;
	Wed,  6 Sep 2023 22:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A06131
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 22:32:20 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A9619B6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 15:32:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76f0807acb6so21205085a.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694039539; x=1694644339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7pwTqtbc0SRtCc8sodvt2GgE2trx1vmLPyIifmTblUg=;
        b=P3AUlqh205Sms2ju7VThmoqyetbAqhKAPAngIJ/78CtZwNSEJi14dj/0liTPmlC881
         yaz/L6rnKvAX5Awpw51iRz6UEXO+UN1w9aqqyepCGPrirnn4rtt4fxDiBVk0Vu8QAubt
         gdlkCR8YQ7GHhLYGPNTVW52cZxUrwPIN793OUZ4ewnMhGWSV8CjVKk0TKYr3GH9/d5Xx
         LVDKidPkKfoN8YvSl8BDEYLBxJVuPhUDPOQZ/RAZeCDIApXjFqQRHkAFz+u4oX8tolNH
         m7YmEI/OekYGE53YHcfxP6mHEVS5GqqBo9mImbQ/hiKeHU9n2mL4sLr/qZv5ipJ0dqNf
         Q6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694039539; x=1694644339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pwTqtbc0SRtCc8sodvt2GgE2trx1vmLPyIifmTblUg=;
        b=FJqJb5NKjhAR0dvRrxTRyOU7gDUewpujeh4UUk/0YcTC5VSFU7jjkr7yOTENiWHMHj
         nSq2HQDM56ke6PHK1fqNeH+twUSGZqOo08DnDVGBeixFA8qdUKZp65NtjAy2+hRB2gzY
         lNt5go/l/HkwEwKR5M2XjXQXoVh0JcZcGLOID/TYF+F8FUds1SFL42wNyvLPBny7chRI
         omK4j6czuUXQV85fkJt1taQQkQUCvB9Vs1L+OougOinmOXd9amwC6RTzjzn59cS9rdpy
         W7ZFVfEI4kU99FTZZw2WRO0DaaqhSD+ary3BU9jQR6wEppBWW5GtymBl8CDQGIC6XZCF
         YWTA==
X-Gm-Message-State: AOJu0YzgbtJ6QO/lOrmwDbrdZ2W71Rj5NAE1du0bFepJfmHJGh/zuTqS
	mI8PEBd4ivEuWCB4ElOytOU=
X-Google-Smtp-Source: AGHT+IHZ/rZ98Rcpybhw3OJHzPptwRjMxQK3iwyJ+KWF3eO4yNMjyL8h2G/FcjAS+rjqFIZY4XlDSA==
X-Received: by 2002:a05:620a:3954:b0:770:96a1:5580 with SMTP id qs20-20020a05620a395400b0077096a15580mr2163717qkn.14.1694039538733;
        Wed, 06 Sep 2023 15:32:18 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id y2-20020a37e302000000b0076effd9809fsm5273004qki.110.2023.09.06.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:32:18 -0700 (PDT)
Date: Wed, 6 Sep 2023 18:32:17 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] pktgen: Introducing a parameter for
 non-shared skb testing
Message-ID: <ZPj98UXjJdsEsVJQ@d3>
References: <20230906103508.6789-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906103508.6789-1-liangchen.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-06 18:35 +0800, Liang Chen wrote:
> Currently, skbs generated by pktgen always have their reference count
> incremented before transmission, leading to two issues:
>   1. Only the code paths for shared skbs can be tested.
>   2. Skbs can only be released by pktgen.
> To enhance testing comprehensiveness, introducing the "skb_single_user"
> parameter, which allows skbs with a reference count of 1 to be
> transmitted. So we can test non-shared skbs and code paths where skbs
> are released within the network stack.

If my understanding of the code is correct, pktgen operates in the same
way with parameter clone_skb = 0 and clone_skb = 1.

clone_skb = 0 is already meant to work on devices that don't support
shared skbs (see IFF_TX_SKB_SHARING check in pktgen_if_write()). Instead
of introducing a new option for your purpose, how about changing
pktgen_xmit() to send "not shared" skbs when clone_skb == 0?

Note that for devices without IFF_TX_SKB_SHARING, it would no longer be
possible to have pktgen free skbs. Is that important?

