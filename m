Return-Path: <netdev+bounces-20014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55E75D608
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E669E1C21739
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462BDF4E;
	Fri, 21 Jul 2023 20:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96930DDDA
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 20:57:53 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9762733
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:57:52 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583b019f1cbso3147097b3.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689973071; x=1690577871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+ejcHLhVMNgmOooBwJpkbt4FpPS4HFmK5yXkFI2jSQ=;
        b=cE+5ulYb8M03HTAVhZ3TLVVy19C1eq9Jr9+z/4MLk4YgDBiNTxMdNiFek/6jQyo8QO
         wfaRw3Om4szvVkCtvCvsXpyLB7Kiyt81aZH7mRNsaJJ4Jym8RUwzemmWcBPN6AmHj7RX
         o7ZwiSFaEEIRlYC2Y3BksaXUPttjQP3OQT+5Bhc5DMhJXJqlwpjIlpLBeP4BCmh4r1AG
         gX1GxKzlo+2l7GCDGvQGS15qAn9cvQNvWjZ7a0pvEKdULjKKJaPKycTxhQQFaHP+I+2W
         AEXp23aD0NbnkKnKc2GJVwHz5kS0mh58MSVgNU/Lha4aqt3cjI7iiIIsf/sb33f0Ggx3
         fNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689973071; x=1690577871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+ejcHLhVMNgmOooBwJpkbt4FpPS4HFmK5yXkFI2jSQ=;
        b=VQnvdYXta27dDXE1hm0o3JmUnfo42bNUYIHOdP0yHc+RNVqPGDS2RbN3MUlPZby7g2
         1zC4gMV7FdnuJyj2H7RgWpQJnkKMjpu5woJbhV4Dumikn98duP+iyDQhuMZ/r9/ggIMo
         VlxsOlIwr4RelEVTwVUnHLT+TsNpJrGWmHsozPHppq+Ms2fqI1kV6XKTXD9+J8vEPln+
         goC745TPgF8//HrFJ0bP1P5Zp5wot9KbexMRz05n69sOAwWyEXZXxsP0jTMSQX+O4ln1
         n9CNsqq/YCtbYvlau6BpQE/9Sc1PqsXnWLw3SHi86PI9a8WYIDA3BTBjDNpzjV5Q/Q+i
         0KOQ==
X-Gm-Message-State: ABy/qLZCr8oexC0mOw2T/QkJBeqbczr6Ds4bBuYb2TVh68yZhjowzzdl
	B0qa90Z3Ci/1jt/j72tCGuw=
X-Google-Smtp-Source: APBJJlHbBRlgSxUV2VhxP7dTpuvoIFKzexbfZ77PSM+VQWuoAfnfR6ABxMMTJhvaysODQ2rEXi8bqg==
X-Received: by 2002:a81:4e55:0:b0:579:dde6:d32e with SMTP id c82-20020a814e55000000b00579dde6d32emr1143196ywb.28.1689973071485;
        Fri, 21 Jul 2023 13:57:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a927:bf54:acf2:ee0a? ([2600:1700:6cf8:1240:a927:bf54:acf2:ee0a])
        by smtp.gmail.com with ESMTPSA id t64-20020a818343000000b005832ca42ba6sm1155102ywf.3.2023.07.21.13.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 13:57:51 -0700 (PDT)
Message-ID: <5537f391-681f-1107-c838-b045f0482b3a@gmail.com>
Date: Fri, 21 Jul 2023 13:57:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
 <20230718180321.294721-3-kuifeng@meta.com>
 <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
 <3057afe9-ac48-84e2-bd39-b227d2dcbc2f@gmail.com>
 <239ca679597a10b6bc00245c66419f4bdedaff83.camel@redhat.com>
 <03ef2491-6087-4fd4-caf7-a589d0dfda13@gmail.com>
 <0b992d26-f22d-7310-308a-339300628690@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <0b992d26-f22d-7310-308a-339300628690@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/21/23 13:01, David Ahern wrote:
> On 7/21/23 12:31 PM, Kui-Feng Lee wrote:
>>>
>>> sysctl -wq net.ipv6.route.flush=1
>>>
>>> # add routes
>>> #...
>>>
>>> # delete expired routes synchronously
>>> sysctl -wq net.ipv6.route.flush=1
>>>
>>> Note that the net.ipv6.route.flush handler uses the 'old' flush value.
>>
>> May I use bpftrace to measure time spending on writing to procfs?
>> It is in the order of microseconds. time command doesn't work.
>>
> 
> Both before this patch and after this patch are in microseconds?
> 

The test case includes two parts. First part, add 1k temporary routes
only. Second part, add 5k permanent routes before adding 1k temporary
routes. In both cases, they wait for a few second and run sysctl -wq
net.ipv6.route.flush=1 to force gc. I use bpftrace to measure the time
the syscalls that write to procfs. Following are the numbers (5 times 
average) I got.

Without the patch
  1k temp w/o 5k perm: ~588us
  1k temp w/  5k perm: ~1055us
With the patch
  1k temp w/o 5k perm: ~550us
  1k temp w/  5k perm: ~561us

