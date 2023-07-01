Return-Path: <netdev+bounces-14958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DB744911
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB52C28124B
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359CAD45;
	Sat,  1 Jul 2023 12:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375D3D67
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:59:46 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1113AA7
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 05:59:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-345c7a60882so104375ab.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688216384; x=1690808384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmKqXoPbcgUVrBrQ6jsm/AUPZ6mGXX2gVakj/WeJO6c=;
        b=GMqAHKs8JEeR7B+VTvQ2DIfkR4VVn/Lb78qPou66FsqY8+PCgAWYd8EDSMDxxz7Ovo
         O/p5hdkDQm8tpRa/uUDDzsCBnNXkuyvFoUMWpY3cjOL8YBlyUn2mtzqDu2CHb0Qaxn2B
         t8pfWtCPlNFAfKc3MKPk0l9zLkb273sjd+AegeKoNv00zTvzJ7s2LS6kJx476z5S1g4x
         6mzStSdc2VhSF6u5YmZZ04zWBR5eV9chkyqQzcHm+du83V0Fl1g1YxR48mMUCGw5hUI1
         8AMsM5DZafiHAu2pe+quNiVhMQhZ9s0JGzhynadRHHp7vBYJIX8k6pJ2b8fOxxB1rfWt
         64RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688216384; x=1690808384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmKqXoPbcgUVrBrQ6jsm/AUPZ6mGXX2gVakj/WeJO6c=;
        b=FVfm2F0qoNED+A16lndnVILjET5WCOCgVnADqGTYytWzvf0JjGXHH4wANxRSAOZz9F
         zSrqQUfOnfPA1N9TINFUkUF/kTUYhqVOCkFfzHzNAc9BarsSN7W67cz0lA9kuYHHR3am
         pnS4uouH1VBwWLyWjxpzaw4OP+GRHE6ZaRfBDLWu/E7ZJxCajRuGXVIXanDpHs6SF2Pf
         a0cilgjbJE6UDYZBP2hjBNM+Q7+FseSqTz/3RiPZbNWkLBRE/UpH84FBqIji0ker5Jq+
         YTuLeJd4fZOTrbadqT668gZZpV7ZUFFCEbIgT8P+9vLddwWcrNIVOEVntM484uSttEx9
         hc0w==
X-Gm-Message-State: ABy/qLafb5b4VWVfC+G2X1QLOwhn/VgQPHJwcxKiAOqUVmRH+kq5bITM
	QYLbL+fiROMZmzoUlouMc2fDdaSI4GJ6AYfaGDDS3Q==
X-Google-Smtp-Source: APBJJlF8PxHtVJMgV+SiOGMfR0hNRQ1aSPIqCTtUxJdYsfspG9rSVDUISd8Fcyx3Jg7HLrwKGYOB4B6CwUjKNXlUpMM=
X-Received: by 2002:a05:6e02:1aa4:b0:33d:ac65:f95e with SMTP id
 l4-20020a056e021aa400b0033dac65f95emr168702ilv.12.1688216383964; Sat, 01 Jul
 2023 05:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630153759.3349299-1-maze@google.com> <ZJ/bAeYnpnhEPJXb@gondor.apana.org.au>
 <CANP3RGduOc4UgNoeHE+jcDw7ExrbCm64LX6zwgyh5FfyYzGSGA@mail.gmail.com>
 <CANP3RGemhoHyeki_ZzbX4JAWuCq3YZOOs64=T5YZ0XSaK8wbpA@mail.gmail.com> <ZKAf4M5ypasK3fgI@gondor.apana.org.au>
In-Reply-To: <ZKAf4M5ypasK3fgI@gondor.apana.org.au>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 1 Jul 2023 14:59:31 +0200
Message-ID: <CANP3RGcfGGF0mPthDsct1sySFkHeL4jUmq-MFDFxjk6P5qBC1w@mail.gmail.com>
Subject: Re: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Benedict Wong <benedictwong@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> That's a good point.
>
> We should audit all the WARN_ONs in net/xfrm and get rid of the
> ones that can be triggered by a remote peer.

While I'm looking at this code...  I noticed the comment:

     if mode == xfrm.XFRM_MODE_TRANSPORT:
       # Due to a bug in the IPv6 UDP encap code, there must be at least 32
       # bytes after the ESP header or the packet will be dropped.
       # 8 (UDP header) + 18 (payload) + 2 (ESP trailer) = 28, dropped
       # 8 (UDP header) + 19 (payload) + 4 (ESP trailer) = 32, received
       # There is a similar bug in IPv4 encap, but the minimum is only 12 bytes,
       # which is much less likely to occur. This doesn't affect tunnel mode
       # because IP headers are always at least 20 bytes long.
       data = 19 * b"a"
       datalen = len(data)
       data += xfrm_base.GetEspTrailer(len(data), IPPROTO_UDP)

and indeed reducing the 19 to 18 results in the test failing.
(I'm guessing 'encap' in the comment really should be 'decap'...)

I guess this means short IPv6/ESP transport/UDP fail?

I'll dig a little deeper later...

