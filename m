Return-Path: <netdev+bounces-16519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4874DAE3
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081301C20916
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A0E134B5;
	Mon, 10 Jul 2023 16:18:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F03222
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:18:56 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453C11F
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:18:55 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b8b8de2c6bso4159854a34.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689005934; x=1691597934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7XLnRslqGz4zTrB7g0IdPNbhgBRRRuV6Tl3MCxsp7E=;
        b=NKsgfkEa16qDWY/i5IH6nbLHul4wyGCyC4qsjKMDoSm/FxXxdrDnNYAZIXvhvT1yZS
         ET1eMnoojdKpbXpKJTKPTAIGNM3YnWaIVw4NH8oUQp+zxVEVLuK4A6OxAmd2fC/7cCG3
         FAWT/DC3N8ki/0ffk85RENerm/semDkcmWHFB76bD+UnRxvjmOM6pw3SYmqgib6T9Opr
         EGlpZMd6pB3+5ZlAHkCQgehSDCpuU4Xu7Ildmywse78Gu88O8CyPi3Tm3rkyVrwFi2rZ
         osbFvTwPFkJRYmb3TxA0F27bUGJ1xbdfJqF1FRWrMFle70Bzh1HAohtdjY9I4fyZUl+Z
         dJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005934; x=1691597934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7XLnRslqGz4zTrB7g0IdPNbhgBRRRuV6Tl3MCxsp7E=;
        b=HhOUMrYjMmUnNFzu9EXodhT+hd6tdn0hYzbiV+sUWVY1vRK7wHJuzbjhcSMEr1+DCW
         xoDLkn0IBZ0RYOqHFWpKYISRlYmN8R0GYoFHmrZGV/TwHIyWO/QFuJYbtNJxUdvOPsxM
         RZn9MwZOwkCGp31iVDl4KzzqQUDc+j+Cc0qTyCvOFDO8phUMncotWzsrsPSKFPIT2vna
         tHalatVVTYxKLP43BVtHqlXp1FhY3QNw3PcM/nrs5mRYYtu+Zw1Yl/YW8UhUxyWdRKkh
         PAvSpzhyhadLQywXJbNDhHoKQB9fhs8n3yDwGhQOgyCekZstMVuYYL0kntBRDhb/TexI
         71IQ==
X-Gm-Message-State: ABy/qLZMWFh5Mp/ipqhZwqycB25ZRjZQcLPi/UrgK633JS/VHsNFUDSi
	PjERDA/wXo7rk7wLDTav/r90zQ==
X-Google-Smtp-Source: APBJJlH/SBu3WBVwj7FBGn5G7OrFz0FrxQPXilkwmcztUvRTarQWFiUGHq4b05wF2GJcwcehJzNeCg==
X-Received: by 2002:a05:6830:2056:b0:6b5:e816:b64d with SMTP id f22-20020a056830205600b006b5e816b64dmr14127969otp.37.1689005934338;
        Mon, 10 Jul 2023 09:18:54 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:5048:750f:5697:17a3? ([2804:14d:5c5e:44fb:5048:750f:5697:17a3])
        by smtp.gmail.com with ESMTPSA id j10-20020a9d7f0a000000b006b97b24b407sm90391otq.56.2023.07.10.09.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 09:18:54 -0700 (PDT)
Message-ID: <2cee2f5e-7fdb-d8b2-8605-7f1274dcc88b@mojatatu.com>
Date: Mon, 10 Jul 2023 13:18:49 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2 1/4] net/sched: sch_qfq: reintroduce lmax bound
 check for MTU
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, shaozhengchao@huawei.com, victor@mojatatu.com,
 simon.horman@corigine.com, paolo.valente@unimore.it
References: <20230707220000.461410-1-pctammela@mojatatu.com>
 <20230707220000.461410-2-pctammela@mojatatu.com>
 <CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/07/2023 05:14, Eric Dumazet wrote:
> On Sat, Jul 8, 2023 at 12:01 AM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> 25369891fcef deletes a check for the case where no 'lmax' is
>> specified which 3037933448f6 previously fixed as 'lmax'
>> could be set to the device's MTU without any bound checking
>> for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.
>>
>> Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
>> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   net/sched/sch_qfq.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
>> index dfd9a99e6257..63a5b277c117 100644
>> --- a/net/sched/sch_qfq.c
>> +++ b/net/sched/sch_qfq.c
>> @@ -423,10 +423,17 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>>          else
>>                  weight = 1;
>>
>> -       if (tb[TCA_QFQ_LMAX])
>> +       if (tb[TCA_QFQ_LMAX]) {
>>                  lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
>> -       else
>> +       } else {
>> +               /* MTU size is user controlled */
>>                  lmax = psched_mtu(qdisc_dev(sch));
>> +               if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
>> +                       NL_SET_ERR_MSG_MOD(extack,
>> +                                          "MTU size out of bounds for qfq");
>> +                       return -EINVAL;
>> +               }
>> +       }
>>
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
> without holding RTNL,
> so dev->mtu can be changed underneath. KCSAN could issue a warning.
> 
> Feel free to submit this fix (I am currently traveling)

Sure! Thank you Eric.

> 
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index e98aac9d5ad5737592ab7cd409c174707cd68681..15960564e0c364ef430f1e3fcdd0e835c2f94a77
> 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -134,7 +134,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
>    */
>   static inline unsigned int psched_mtu(const struct net_device *dev)
>   {
> -       return dev->mtu + dev->hard_header_len;
> +       return READ_ONCE(dev->mtu) + dev->hard_header_len;
>   }
> 
>   static inline struct net *qdisc_net(struct Qdisc *q)


