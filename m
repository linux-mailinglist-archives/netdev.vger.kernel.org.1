Return-Path: <netdev+bounces-32261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9E9793B8C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B903A1C20A14
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32BA94D;
	Wed,  6 Sep 2023 11:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3372ED6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:37:38 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFFA8;
	Wed,  6 Sep 2023 04:37:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf1f632b8so552316666b.1;
        Wed, 06 Sep 2023 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694000256; x=1694605056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIoumIefJG2c1Xl1YXw1HkNSCZ/LNc5JVGZQ1+f53m4=;
        b=CmMAFi5COHRlsnaUQV2snxFDXFXFnL5Y5SIFYCBkvxG6/bXO9e1pXW+q947M9eiySw
         IRUy2uxAR8TnYvIad4i8+QCFNCoWMZbuRAnn2NXwEMxG+TLk0sCHjKFkXW7ryK+EUgvr
         Z8CHKzZaPvF2sEYAIBxALgKXzrN2Pu/uh9bj13gFcRBq+GB6+I7t40GzMYBPwbnlC6ui
         Vft9VZyohsLXup0OfsXWgPf4b5fdrLt41ZG4Cb2SvtIs9LvD7K6kvkSffVO5PEfXH10f
         Xm6mxHmwym6ENtzRYfY7/TZ9LA8sj9C29M2X6qeLBXNf6N0JR94jvI0JXjW6T6WjMW8/
         72mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694000256; x=1694605056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIoumIefJG2c1Xl1YXw1HkNSCZ/LNc5JVGZQ1+f53m4=;
        b=d+4kylzHgsh8AN7oeRVyWRLdw3g96C1c3RVSqnyya7hmNwOpt+tFdgKqzszF1a7y9I
         ttZcvDOCGIzFjMANrU5UuyanWKwCIk7vz9cEgv2WkVngCOowSIdN8X0VAQXQpZWZXrXX
         aXqpUvMNb9H6rTs3HhNtR+dn777Jzje/2DugKE5l04bI8jUB4fx3OXQbA3ce8kOFPCM1
         aMfNjv+6D21pSBP5/6p+MX68EBHDqHlMcTX53PJmnc73LqkjRdy9QBvt/DReRcbHLM0y
         rlLm+CgxYFBgBp+SXno+RVYq5HN0PHa4LgIeyZ2BKRVe9oCNHuiiUdiRfog0Vv3PotSF
         IKlA==
X-Gm-Message-State: AOJu0YwFmbTmC+knMW1+/8L4Co/jatbakrudjY4re2DBWXcyVbiGuCPz
	U1YksxR8p/trcJcoEExOPuw=
X-Google-Smtp-Source: AGHT+IEraBL9rxIHDCWQ2SDZzeswphRbaKD1d3l7wr8DdkMV0w8KJiGZQFBUHKBDnqhRG1Yt475htA==
X-Received: by 2002:a17:906:4e:b0:9a5:cf23:de54 with SMTP id 14-20020a170906004e00b009a5cf23de54mr2168348ejg.38.1694000255736;
        Wed, 06 Sep 2023 04:37:35 -0700 (PDT)
Received: from [192.168.10.127] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906824300b0099b921de301sm8875255ejx.159.2023.09.06.04.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:37:35 -0700 (PDT)
Message-ID: <075308b2-7768-40b2-9c00-a5a14df62678@gmail.com>
Date: Wed, 6 Sep 2023 13:37:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
Content-Language: en-US, it-IT
To: Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Oliver Neukum <oliver@neukum.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
 <ZPcfsd_QcJwQq0dK@debian.me> <6315027e-d1ab-4dec-acf2-0a77bb948807@gmail.com>
 <ZPfZQsLKG9LKGR1G@debian.me>
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <ZPfZQsLKG9LKGR1G@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 06/09/2023 03:43, Bagas Sanjaya wrote:
> On Tue, Sep 05, 2023 at 09:34:53PM +0200, Sergio Callegari wrote:
>> I mean that with kernel 5.15 I could use the in-tree module with some
>> glitches (interface occasionally stopping on teleconferencing) as well as
>> the indicated out of tree module with no glitches.
>>
>> With current kernels (certainly from 6.2 on) manually setting a MAC address
>> breaks the interface. Furthermore, even if it compiles and loads fine, it is
>> impossible to use the out of tree module because it does not create the eth
>> device anymore (the eth device now appears with the cdc_ncn module). Being
>> this an out of tree module, this is not very important, though.
> Then can you please file issue against your external module on that
> GH link?

Done, but as mentioned, out-of-tree implementations on GH are less 
interesting than having the in-tree driver working properly.

So if the in-tree driver could be fixed to correctly support the manual 
configuration of the hardware (MAC) address as it used to be that would 
be the best. I hope that Andrew Lunn's hypothesis is correct, and that 
cdc_ncm can be extended to work with AX88179A even when a manual MAC 
addr is configured.

Thanks,

Sergio



