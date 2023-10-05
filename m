Return-Path: <netdev+bounces-38342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A3D7BA75C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 39A3A281203
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6338BD4;
	Thu,  5 Oct 2023 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hV/n75So"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1B38BC9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 17:10:46 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E31E4CF7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 10:10:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f71b25a99so1213984f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696525843; x=1697130643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNrgw+yqYpdjuCEtrSz6iVPXz6l1oyQWLcHiTGD6UFI=;
        b=hV/n75Soqg9Z6J8DDQXTj3SsHDayMUGV5UBSSO0ja4dLzCYqIwc/cXv4p4jSI/m/Y4
         zphExXurQC+0pEChjmBREoQsDEyQqKVtf3kmPwvvc8K8sP02i4lyck/rwEw+ERUVMI/C
         +BNQwQ+cib04c1oANkx6gH1chGe3tENGvsJOnCJCpezC5OQs/JkIvhR/7oH+2LWajyg2
         13UVXPchS38/xmkfaNDEHK400K/bH4hUS5g5n14XVpqE6EELBzuHOVh8cloEjLi4L87Z
         N6G7ySNRDPXgUeDtPxCHoiARwOGfADVgALNAf+St/H2DNPhTYuHFdQheJxcKjJshRj9X
         Gv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696525843; x=1697130643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNrgw+yqYpdjuCEtrSz6iVPXz6l1oyQWLcHiTGD6UFI=;
        b=QhjHGFCSJvkI+4cqOiR352JHJf14O6Tfxxkii6lmV06mMbhv8xfe1US1l1SjVJRRBD
         +0KhS10kq67vN7YAB8GzDkXT34jf6TkApeuacbkPun92eY/cYfoWWpsADB6CquJ3BJVr
         Enwkvgmh+/BE7vhfN3ZOsQ2ioZD2M9ar+V5WmHXcPCYePmSZVCygU6uXDMFfwfpUv2sQ
         +8XIR5qHvoav5kKRCZuxtRew6sS5ZgIvgTJUlmVcuKogvqATrQaV/QCt5/+i6LSMJs88
         wx9Z6t9dC9jvycmOpJD5whIKpm19q2BU17ybtKNaBlVz9YFdptZsjwPLiF9Kc4eTiZme
         HOJg==
X-Gm-Message-State: AOJu0YxGM6G6UZX2mgO7Hg7PlmOxckshEHCNDO14lIv35HNc9gTfgMKr
	VU5AgLrbM3A1Iqc6f2a2ZMAVVg==
X-Google-Smtp-Source: AGHT+IFqvkrVzEF20ztaw/LQ53xt8fvGxgn7/DG6rZRMll52AtIpIyoMT19G8s4UykcFGhKaSeNtsg==
X-Received: by 2002:a05:6000:14e:b0:324:8700:6421 with SMTP id r14-20020a056000014e00b0032487006421mr5444658wrx.3.1696525842261;
        Thu, 05 Oct 2023 10:10:42 -0700 (PDT)
Received: from ?IPV6:2a02:8084:2562:c100:228:f8ff:fe6f:83a8? ([2a02:8084:2562:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b00402f7b50517sm1935874wmc.40.2023.10.05.10.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:10:41 -0700 (PDT)
Message-ID: <093805eb-2ea3-4745-bbd0-fef54040bd1f@arista.com>
Date: Thu, 5 Oct 2023 18:10:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 net-next 23/23] Documentation/tcp: Add TCP-AO
 documentation
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
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
 "Nassiri, Mohammad" <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>,
 Simon Horman <simon.horman@corigine.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20231004223629.166300-1-dima@arista.com>
 <20231004223629.166300-24-dima@arista.com> <87jzs2yp2y.fsf@meer.lwn.net>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <87jzs2yp2y.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jonathan,

On 10/4/23 23:56, Jonathan Corbet wrote:
> Dmitry Safonov <dima@arista.com> writes:
> 
>> It has Frequently Asked Questions (FAQ) on RFC 5925 - I found it very
>> useful answering those before writing the actual code. It provides answers
>> to common questions that arise on a quick read of the RFC, as well as how
>> they were answered. There's also comparison to TCP-MD5 option,
>> evaluation of per-socket vs in-kernel-DB approaches and description of
>> uAPI provided.
>>
>> Hopefully, it will be as useful for reviewing the code as it was for writing.
> 
> It looks like useful information; I just have one request...
> 
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> Acked-by: David Ahern <dsahern@kernel.org>
[..]
>> +1. Introduction
>> +===============
>> +
>> +.. list-table:: Short and Limited Comparison of TCP-AO and TCP-MD5
>> +
>> +   * -
>> +     - TCP-MD5
>> +     - TCP-AO
>> +   * - Supported hashing algorithms
>> +     - MD5 (cryptographically weak).
>> +     - Must support HMAC-SHA1 (chosen-prefix attacks) and CMAC-AES-128
>> +       (only side-channel attacks). May support any hashing algorithm.
> 
> ...can you please avoid using list-table if possible?  It makes the
> plain-text version nearly impossible to read.

Sure, I also find it unpleasant to look in plain-text.
As long as you don't suggest something else, I'll go with plain table::
for the next version - that seems to look a bit better.

Originally I went with list-table as that seems quite spread over
Documentation/, but probably worth avoiding another entry there:

[dima@Mindolluin linux-master]$ git grep -ho '[^ ]*table::'
Documentation/ | sort | uniq -c
      4 acceptable::
      4 csv-table::
      1 executable::
    594 flat-table::
    133 list-table::
     41 table::


Thanks,
           Dmitry


