Return-Path: <netdev+bounces-13396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642273B6F1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4368F1C211A8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF023112;
	Fri, 23 Jun 2023 12:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F37211F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 12:15:56 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA810C1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:15:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4008324d85bso6224221cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687522554; x=1690114554;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ipPBe4YL0V106yJJMGiXuLH52MbAKhgbQL/aTCd9t8=;
        b=npWbXC1/fhNdWYlLRCkx6y0yTx16AWG7SF+3ysWJxP+7mkMUHdbaq+ED/SgTg0cI0m
         4pCPvubQY01tsI9NQDswkactp2sEGZfbsra5Dw+f/059jjIUI4smqNBFh1inH3raCuEb
         o0+RBkvBsSZ7JCbBnyNfGLqt2eIdzAYFX2OqyeOvAGuldiTscjNilsH8qsFsk0sJ7vwy
         nUN0OIYzaVGvE2qcMXRWkDCJ+VXFCUeahf8FUlMHHlPUSDeQilgiXta1D2fDFn+D2JtI
         jgOJpvQXRig8Dnz1nv1cOdeQPlREzTkh9fQ2p4jOLmno5ZLqNu7wp3Zf2Dwvm9FWYBoa
         alVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687522554; x=1690114554;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ipPBe4YL0V106yJJMGiXuLH52MbAKhgbQL/aTCd9t8=;
        b=CVkvXFNIQWSmREwwsH5c7ewGu9GeSp5MpJ++OwxL27uhbNTLukU0nJdivCVrHjEups
         gnq9ohWDkOjnmpVHciJKwhinInxkNy+6F3l//cjuMxNiwpwUtcZRJqnMuJIKJ77WivMq
         ckDnyjxuOSyPqhoE2wpBZzAeNV8s6UO9rHbG4KbE6jZOQ7XgBcvAz9NfPdkydF7HqjGd
         9eiSsfDPqGKOlxN9AZghUlVNYhJawE8H0+o0p5tbChUjoVhr9oMa7Im5NKVCRv2j1m+R
         M1oCrt36wyLuX8kAzFqQuhpDU5KLFV5POPlzWq45nKYOuiADV9zgFAys2Ff9cIiRP2ud
         /myQ==
X-Gm-Message-State: AC+VfDx3dsNwuMlsaJiNus6DQc4G+Y1zuO6NA06vsrHPyFbSIiv9i8XB
	s/+I3eqPseGzXXtffp8gZM360ausl4o=
X-Google-Smtp-Source: ACHHUZ6OtEn2NV0UAgib7+l0GiZ1FFbPHi8j3CFADlu5aqmCL22hwzx/6UhmiXJ52zt5zMp3x6imEQ==
X-Received: by 2002:a05:622a:1316:b0:3ff:28d9:ccdc with SMTP id v22-20020a05622a131600b003ff28d9ccdcmr14330714qtk.48.1687522554212;
        Fri, 23 Jun 2023 05:15:54 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id v27-20020a05622a189b00b003f7fd3ce69fsm4816685qtc.59.2023.06.23.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:15:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  donald.hunter@redhat.com
Subject: Re: [RFC net-next v1] tools: ynl: Add an strace rendering mode to
 ynl-gen
In-Reply-To: <20230619120025.74c33a5d@kernel.org> (Jakub Kicinski's message of
	"Mon, 19 Jun 2023 12:00:25 -0700")
Date: Fri, 23 Jun 2023 13:04:32 +0100
Message-ID: <m2mt0q9ygf.fsf@gmail.com>
References: <20230615151336.77589-1-donald.hunter@gmail.com>
	<20230615200036.393179ae@kernel.org> <m2o7lfhft6.fsf@gmail.com>
	<20230616111129.311dfd2d@kernel.org> <m2v8fjahus.fsf@gmail.com>
	<20230619120025.74c33a5d@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 19 Jun 2023 11:04:11 +0100 Donald Hunter wrote:
>> I tried these suggestions out and they seem a bit problematic. For
>> struct references I don't see a way to validate them, when it's not C
>> codegen. Non C consumers will need to enumarete the struct references
>> they 'understand'. The printk formats are meaningful in kernel, but not
>> directly usable elsewhere, without writing a parser for them.
>> 
>> It seems desirable to have schema validation for the values and I tried
>> using the %p printk formats as the enumeration. Using this format, the
>> values need to be quoted everywhere. See diff below.
>> 
>> The printk formats also carry specific opinions about formatting details
>> such as the case and separator to be used for output. This seems
>> orthogonal to a type annotation about meaning.
>> 
>> Perhaps the middle ground is to derive a list of format specificer
>> enumerations from the printk formats, but that's maybe not much
>> different from defining our own?
>
> Fair point. Our own names would be easier to understand -- OTOH I like
> how the print formats almost forcefully drive the point that these are
> supposed to be used exclusively for printing. 
>
> If someone needs to interpret the data they should add a struct.
>
> But I guess a big fat warning above the documentation and calling the
> attribute "print-format" / "print-hint" could work as well? Up to you.
>
> Hope this makes sense.

Does "display-hint" sound okay? Maybe me being a bit fussy vs
"print-hint" but it feels more appropriate to me.

>> I currently have "%pI4", "%pI6", "%pM", "%pMF", "%pU", "%ph", which
>> could be represented as ipv4, ipv6, mac, fddi, uuid, hex. From the
>> printk formats documentation, the only other one I can see is bluetooth.
>> The other formats all look like they cover composite values.
>
>> diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
>> index b474889b49ff..f3ecdeb7c38c 100644
>> --- a/Documentation/netlink/genetlink-legacy.yaml
>> +++ b/Documentation/netlink/genetlink-legacy.yaml
>
> If we're only talking about printing we will want to extend the support
> to new families as well.

Yep, makes sense. Is there any magic/scripted way of keeping the
different schemas in sync or do they just get modified independently?

