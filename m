Return-Path: <netdev+bounces-16520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77C74DAEA
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEEA1C20A71
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DAC134BA;
	Mon, 10 Jul 2023 16:21:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E493222
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:21:11 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E56100
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:21:10 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b06777596cso4040159fac.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689006069; x=1691598069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bqd8sVD55TDqaPI7nyA8Urp4fgq75aOHn7rcnvwgHs=;
        b=UFOeOSxYPieIOvUwf0fe+awiKEtagjwWVh3lO/xGB6rRQrTfUY/E0k12HBK9mAR/P/
         DeAkq3BMCQ+9NFojGSGBMeeNe+t9Id3tXiI2HIEXiXmLy+sOE46OcApH4IUy1/1gRj19
         JS9Q0tX379i2NLNkxw8HmfcdzyyqxD5mtn+dzQEUOUlVj4k+0p80gY0LDMyqo9BGERAJ
         M0AvIbVt72xEFwlam+efodJZYCYlM7LDXtkDHsWy3GYx7LqABY0bL6LImkuPAx4hALgy
         8NH9bpVHP6UvPNVLmx7DyAdz0WkvhmbNeJTJqBmNfG+buxOp1f83lmAkJhI43vV0InGL
         InWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689006069; x=1691598069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bqd8sVD55TDqaPI7nyA8Urp4fgq75aOHn7rcnvwgHs=;
        b=EtZMvt4VBnF4PO0dtAPigza7kTdj+sQqM3ccrKrDu60W2djHLfMqkZRO/wNw1M1rl9
         dp0qGeNlFRYQJWj/ZTyNDSlcfM1FWEf8QnpLx+KvwowCeM+bhduoKiwH5R+zkB7ceqfT
         FXD/wcd6L1PAgcK6nTfPldHIP65Vl5WQnmdwTroJBIfLHFohV94i5zXTt4myw/vYY8bg
         Edfub1s8nkdbNNMNk+oB7yRsPieScWQDCaPd6X9YMLVtto7/Gxu/jLkj2Lom/uDF06Lz
         +O71UL7YQhGh5bvsILm9IST19dv4j+G3018azfCrjGpZEj+jrrilDP0LQfEio9ylHpYL
         QwgA==
X-Gm-Message-State: ABy/qLZmZF9/QQDz3cQrWTSVj8wC334wXOk66eHCscncy/QbUvkNAkwd
	Sru/0VFIRX+XUqHwXh2HT/m4/A==
X-Google-Smtp-Source: APBJJlEXUb5uQpIr74f+/IoINFwfkQ398HYCwihjJoDWmJ7uI73lTUfZX+JmMu+ocRUNNAecI007jw==
X-Received: by 2002:a05:6870:41d0:b0:1b7:3364:6269 with SMTP id z16-20020a05687041d000b001b733646269mr3008318oac.32.1689006069547;
        Mon, 10 Jul 2023 09:21:09 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:5048:750f:5697:17a3? ([2804:14d:5c5e:44fb:5048:750f:5697:17a3])
        by smtp.gmail.com with ESMTPSA id c2-20020a056870a58200b001b72f4694e3sm88380oam.53.2023.07.10.09.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 09:21:09 -0700 (PDT)
Message-ID: <bd0106b7-36cd-44af-186a-723f86d23387@mojatatu.com>
Date: Mon, 10 Jul 2023 13:21:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2 4/4] selftests: tc-testing: add test for qfq with
 stab overhead
Content-Language: en-US
To: shaozhengchao <shaozhengchao@huawei.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com,
 simon.horman@corigine.com, paolo.valente@unimore.it
References: <20230707220000.461410-1-pctammela@mojatatu.com>
 <20230707220000.461410-5-pctammela@mojatatu.com>
 <71fadd96-2a2c-24d1-e5f6-6239db95d057@huawei.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <71fadd96-2a2c-24d1-e5f6-6239db95d057@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/07/2023 03:43, shaozhengchao wrote:
> 
> 
> On 2023/7/8 6:00, Pedro Tammela wrote:
>> A packet with stab overhead greater than QFQ_MAX_LMAX should be dropped
>> by the QFQ qdisc as it can't handle such lengths.
>>
>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   .../tc-testing/tc-tests/qdiscs/qfq.json       | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git 
>> a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json 
>> b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
>> index 965da7622dac..6b8798f8dd04 100644
>> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
>> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
>> @@ -261,5 +261,43 @@
>>           "teardown": [
>>               "$IP link del dev $DUMMY type dummy"
>>           ]
>> +    },
>> +    {
>> +        "id": "5993",
>> +        "name": "QFQ with stab overhead greater than max packet len",
>> +        "category": [
>> +            "qdisc",
>> +            "qfq",
>> +            "scapy"
>> +        ],
>> +        "plugins": {
>> +            "requires": [
>> +                "nsPlugin",
>> +                "scapyPlugin"
>> +            ]
>> +        },
>> +        "setup": [
>> +            "$IP link add dev $DUMMY type dummy || /bin/true",
>> +            "$IP link set dev $DUMMY up || /bin/true",
>> +            "$TC qdisc add dev $DUMMY handle 1: stab mtu 2048 tsize 
>> 512 mpu 0 overhead 999999999 linklayer ethernet root qfq",
>> +            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq 
>> weight 100",
>> +            "$TC qdisc add dev $DEV1 clsact",
>> +            "$TC filter add dev $DEV1 ingress matchall action mirred 
>> egress mirror dev $DUMMY"
>> +        ],
>> +        "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: matchall 
>> classid 1:1",
>> +        "scapy": [
>> +            {
>> +                "iface": "$DEV0",
>> +                "count": 22,
>> +                "packet": 
>> "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.10')/TCP(sport=5000,dport=10)"
>> +            }
>> +        ],
>> +        "expExitCode": "0",
>> +        "verifyCmd": "$TC -s qdisc ls dev $DUMMY",
>> +        "matchPattern": "dropped 22",
> Hi Pedro:
>      I test this patch, but the number of dropped packets in each
> test is random, but is always greater than 22. My local machine tests
> are not ok. Here's my test results:
> All test results:
> 
> 1..1
> not ok 1 5993 - QFQ with stab overhead greater than max packet len
>          Could not match regex pattern. Verify command output:
> qdisc qfq 1: root refcnt 2
>   Sent 0 bytes 0 pkt (dropped 26, overlimits 0 requeues 0)
>   backlog 0b 0p requeues 0

I see, looks like some IPv6 probes / ARP / etc... are going through.
I will fix it, thank you!

> 
> Zhengchao Shao
> 
>> +        "matchCount": "1",
>> +        "teardown": [
>> +            "$TC qdisc del dev $DUMMY handle 1: root qfq"
>> +        ]
>>       }
>>   ]


