Return-Path: <netdev+bounces-23881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE276DF4A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9266E281F54
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944538F43;
	Thu,  3 Aug 2023 04:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B491847
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:09:35 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC113128
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:09:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-583b0637c04so8174707b3.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691035773; x=1691640573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLKbE72fszRtCmBUf1yCruJJZVOU4mn2hNfDAmMC0XA=;
        b=cpBdowDFD40Eqh/UARU1M1hx0GX56W7bbpDCRa9695TmPM5F73rxmgP2eEC7dP36BC
         sWySJP+XsJdeqiyFDjtBZ+UlGEm0MZqcPHU7rSHDlmSqslE7B4t7FVsn8LJ7v0CBxCKg
         c22YNYZvO3ObCcl4Vqb9DWnk30cDvdp3NVy+QpjxJF7gPIrML5EW6ouf/Mg7zX9yvqvt
         FKvO4CxmE2f2QBVY16M0rqLHStsUAUyP96gR+eX8QGVvOmf0/iX4eaKELZWdUvYJxnqZ
         QRai1MM4SgZHAuUGmlj1xX3v65IeGW0e6roCofZ0gWwhookxjMR55Nvt7TJ08iJ/a5Dh
         yphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691035773; x=1691640573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLKbE72fszRtCmBUf1yCruJJZVOU4mn2hNfDAmMC0XA=;
        b=E/ck/YqK/O1Hrj3QQMKPghNWV0nqnYX4DDcVzoBmPawCTqev7uMm33vIaRWYQa4JUS
         aC8zhMEulfvZUDtYmx1ehFEnq2UQBHchRGxBPm+EqwWhoeVDXZC0n/2XM+FV+4MP75ba
         5nByfrzur6B0NT9fOwNcSFf/XGLtKC+IbJMZR8Mv9GkknsLsH42bsZtCk3fEWWOIWRIi
         ZuWESunYAJ/sJFgn31uvW4yCrl/DfgGpt2gsYiGAEvVgnCeI/w30mEjbsYNlH/iL7y6o
         iszto0zuotOO+/Orm99nEnC8ufj2dimwfsDa+N0/LMC2jvZ1IlN8cbIgEDmq9WkqSRR3
         yAaQ==
X-Gm-Message-State: ABy/qLY92ybcoT2/IPgScmBhtVZbtB63frwN7Xktc9fhm+Xe/nVGrViP
	4HEXDpjx7rHxgYiF8c/Ia60=
X-Google-Smtp-Source: APBJJlEGuinGOHRRopA8VZoBHJTrWevtsfqih9LrsjXUnsbcFNGU+AB46RpiZdYNnypX2r3xRheTxA==
X-Received: by 2002:a0d:db4a:0:b0:579:e6e4:a165 with SMTP id d71-20020a0ddb4a000000b00579e6e4a165mr13513820ywe.10.1691035773049;
        Wed, 02 Aug 2023 21:09:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8ee8:bf27:b43f:7fec? ([2600:1700:6cf8:1240:8ee8:bf27:b43f:7fec])
        by smtp.gmail.com with ESMTPSA id l67-20020a0dfb46000000b005731dbd4928sm5062855ywf.69.2023.08.02.21.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 21:09:32 -0700 (PDT)
Message-ID: <65a8a91f-65af-e948-1386-fc7d0d413b77@gmail.com>
Date: Wed, 2 Aug 2023 21:09:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v5 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: kuifeng@meta.com
References: <20230802004303.567266-1-thinker.li@gmail.com>
 <20230802004303.567266-3-thinker.li@gmail.com>
 <85c6c94e-1243-33ae-dadd-9bcdd7d328d1@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <85c6c94e-1243-33ae-dadd-9bcdd7d328d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 19:06, David Ahern wrote:
> On 8/1/23 6:43 PM, thinker.li@gmail.com wrote:
> \> @@ -747,6 +750,97 @@ fib_notify_test()
>>   	cleanup &> /dev/null
>>   }
>>   
>> +fib6_gc_test()
>> +{
>> +	echo
>> +	echo "Fib6 garbage collection test"
>> +
>> +	STRACE=$(which strace)
>> +	if [ -z "$STRACE" ]; then
>> +	    echo "    SKIP: strace not found"
>> +	    ret=$ksft_skip
>> +	    return
>> +	fi
>> +
>> +	EXPIRE=10
>> +
>> +	setup
>> +
>> +	set -e
>> +
>> +	# Check expiration of routes every 3 seconds (GC)
>> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
>> +
>> +	$IP link add dummy_10 type dummy
>> +	$IP link set dev dummy_10 up
>> +	$IP -6 address add 2001:10::1/64 dev dummy_10
>> +
>> +	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
>> +
>> +	# Temporary routes
>> +	for i in $(seq 1 1000); do
>> +	    # Expire route after $EXPIRE seconds
>> +	    $IP -6 route add 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
>> +	done
>> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP -ne 1000 ]; then
> 
> race condition here ... that you can install all 1000 routes and then
> run this command before any expire. 10 seconds is normally more than
> enough time, but on a loaded server it might not be. And really it does
> not matter. What matters is that you install routes with an expires and
> they disappear when expected - and I believe the flush below should not
> be needed to validate they have been removed.

Without the flush below, the result will be very unpredictable or need 
to wait longer, at least two gc_interval seconds. We can
shorten gc_interval to 10s, but we need to wait for 20s to make it
certain. It is more predictable with the flush.

About race condition, I will remove the check.  Just like what you said,
it is not necessary.

