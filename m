Return-Path: <netdev+bounces-16669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FB74E3FD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A890A1C20C75
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 02:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F22A50;
	Tue, 11 Jul 2023 02:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C241210D
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:14:04 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9112E
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:14:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b71ee710edso4086660a34.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689041642; x=1691633642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6uIHGOdmZfL+T1GMJbCDwwHgEZGlM6pitGd6U3b5kuA=;
        b=s/w5sFvpQ4avdgNzxiTCuFiPz+XYJ9TKmo+Pow4V1Tf/kYSg0MeZhvWheTbXwr4k9n
         SerU9rah2xQNZap1dZKrk4b6IpS1KLO26iOKOKOLNdgbyoLNmOfryhQixNfScyoftl5c
         7vepQllHEotjwAqVObZAYf8ouLogtvSb1gd7ViSJnLH88MOT4L76xfYwkIs5/BOhfmB0
         vHfUqJpkRmrR8JDnUNJuVKKl6YdLtFKz2isuu4q1HFO3bgdei3iRB8D3pGD5jgqpBU/N
         chZ0YEioPVdsCjTweN5GJVO5XH30LIMsKVEHJm/WpuctHCtCAAZUpUerhv3AZuyYyLnM
         1cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689041642; x=1691633642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uIHGOdmZfL+T1GMJbCDwwHgEZGlM6pitGd6U3b5kuA=;
        b=K6SKrbFbXiy6jdelnhu6jPpO60Tfu+t9pyTzEptDXN50q/X2CVY+lHrSkhlnzFbGXG
         CCiMNL/nzJ/e4JlslEhPTG2G5JTzWGkSmi7mqZX0O850OBo20ecanRbKWG0yArbl6XvX
         476L/Sl6GMt0t9TK5+l1zi5EdLx/gJ2kunhIxZG3KTdDdZIk4Im1832IzuQzCcMNS0is
         1SR7fuzB5UT3XfVgyZel5yTa9XAHCofuNjqg1PtjUt5agxgCbbh1E0orQV1zFdxa883V
         OdR+AzoYJmd0zxIrclgPO3TKZnYe1GWdPnXi4wqPX8LCdFcYFuuEYK/2Yh+RR/wb6Mgo
         fYaA==
X-Gm-Message-State: ABy/qLZFKK7G03oxgiWLYUQWbu1JTXlX6nUFU3YZoKRC7+09+14YuNm+
	A9wZ4p2p/2lLXKB4lZbWWykoYg==
X-Google-Smtp-Source: APBJJlEiRFc8h28KW8PPoqy8zWoEsi4jB+T51oLaeYBeg1ojbiahPWAk7/viwDPlO8UZnyRJfXbH8Q==
X-Received: by 2002:a9d:6ad2:0:b0:6b8:8696:5acd with SMTP id m18-20020a9d6ad2000000b006b886965acdmr12758161otq.26.1689041641921;
        Mon, 10 Jul 2023 19:14:01 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:5048:750f:5697:17a3? ([2804:14d:5c5e:44fb:5048:750f:5697:17a3])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d5612000000b006b9443ce478sm555680oti.27.2023.07.10.19.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 19:14:01 -0700 (PDT)
Message-ID: <5250b984-ce32-dc3b-5b8c-3937da4c4715@mojatatu.com>
Date: Mon, 10 Jul 2023 23:13:57 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] net/sched: make psched_mtu() RTNL-less safe
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, mysuryan@cisco.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vijaynsu@cisco.com,
 xiyou.wangcong@gmail.com
References: <20230711000429.558248-1-pctammela@mojatatu.com>
 <20230711001426.24422-1-kuniyu@amazon.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230711001426.24422-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/07/2023 21:14, Kuniyuki Iwashima wrote:
> From: Pedro Tammela <pctammela@mojatatu.com>
> Date: Mon, 10 Jul 2023 21:04:29 -0300
>> Eric Dumazet says[1]:
>> ---
> 
> I think we shouldn't use `---` here, or the message below will
> be dropped while merging.

Thanks for catching this. Will resend.

> 
> 
>> Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
>> without holding RTNL, so dev->mtu can be changed underneath.
>> KCSAN could issue a warning.
>> ---
>>
>> Annotate dev->mtu with READ_ONCE() so KCSAN don't issue a warning.
>>
>> [1] https://lore.kernel.org/all/CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com/
>>
>> Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
>> Suggested-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   include/net/pkt_sched.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
>> index e98aac9d5ad5..15960564e0c3 100644
>> --- a/include/net/pkt_sched.h
>> +++ b/include/net/pkt_sched.h
>> @@ -134,7 +134,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
>>    */
>>   static inline unsigned int psched_mtu(const struct net_device *dev)
>>   {
>> -	return dev->mtu + dev->hard_header_len;
>> +	return READ_ONCE(dev->mtu) + dev->hard_header_len;
>>   }
>>   
>>   static inline struct net *qdisc_net(struct Qdisc *q)
>> -- 
>> 2.39.2


