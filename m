Return-Path: <netdev+bounces-24160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC576F082
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731D8282281
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385224190;
	Thu,  3 Aug 2023 17:21:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FF1F937
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:21:14 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A42D68
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 10:21:13 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bb590d5cc0so730151fac.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1691083273; x=1691688073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHdWNd7NcxIk3qmFO2a77DMoqeY4hXR/sOoF4ciAHOQ=;
        b=u/1k5qObBVCl38/3CowQvVgypngd3K1HPJMlDnoQ6QtMtPiP3m3H/2eH+E4S3AG2BU
         F7A9YcqRvxkoV3qvqyc6RRe7lCWCq5dgrM5jf5mJJioLwHv7VZ+fJN7le2jVVBOl0L14
         1zUyZrjKsu5GMwlV/cVvm37GBXQ2Hkj4nPFulaNypdKHHTjqmJkeToq4JeXZ0qe7h6dH
         JQn6NB1zjbbbTmfMnuLFeCN14X26BxH1JXKNIicrRghk8IpJcr+8xM45xpWWLHfug32m
         EVLQDkwsHya09x1PU6t1tONJlqE5MArvrfKFLXPi9V8hjHAx/nDGQGMqQfq2zbh7lav/
         lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083273; x=1691688073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHdWNd7NcxIk3qmFO2a77DMoqeY4hXR/sOoF4ciAHOQ=;
        b=VLEatYTks1zifGRRsRjvqXFg6duwxH7360SE/QT3v7aRTj0RMzT/ktZkP81RmauX7a
         06Kw4Jhdzq6t6DnUfRjVQ12eR3ycroVZOU53QgY4l7VVQ1TbBtm4Eg+fqhIjk/L/keeu
         Hy4mfMp/ZR0CwJJ0UNYe3ktgaBWu1KiJFHG3rraGwz8Pjm1HSub3g1J+wIPwcXNM4coy
         7/sWtKxtfy2c26IO8hYk59WTOKJDpu8wqlmCzl/D3xFf1l8ToVy02eT0ncaPU7+jE2HP
         XpXfX0MWxzvmOSzPb165HotwpnMxsyWa3puXc/AUlTHM/Wo0+7vIsRsUDl3t8OD44of0
         BaGw==
X-Gm-Message-State: ABy/qLaKO55fMKOqHTA1ReztcC4qoGobwyihSVLFBAmKl3bMuZlAWu2E
	Kfr5IXLQA1mnMnXZMyBIWB31gw==
X-Google-Smtp-Source: APBJJlGH0lg4xAj9gNoRvacMhdgLpvXIeQDJkix5j8dz6wOxOx3nhnV4WJeq1As92cXHB5U1ImSKeA==
X-Received: by 2002:a05:6870:d7a6:b0:1b0:e98:163b with SMTP id bd38-20020a056870d7a600b001b00e98163bmr18685097oab.21.1691083272712;
        Thu, 03 Aug 2023 10:21:12 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:9170:5736:6909:750b:c9a8? ([2804:7f1:e2c1:9170:5736:6909:750b:c9a8])
        by smtp.gmail.com with ESMTPSA id v17-20020a056870955100b001bee99e97a9sm185013oal.43.2023.08.03.10.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 10:21:12 -0700 (PDT)
Message-ID: <918bf9fc-1c8f-a006-560e-b437581c6ec2@mojatatu.com>
Date: Thu, 3 Aug 2023 14:21:07 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 net-next 09/10] selftests/tc-testing: test that taprio
 can only be attached as root
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Peilin Ye <yepeilin.cs@gmail.com>, Pedro Tammela <pctammela@mojatatu.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Zhengchao Shao <shaozhengchao@huawei.com>, Maxim Georgiev <glipus@gmail.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-10-vladimir.oltean@nxp.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20230801182421.1997560-10-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 15:24, Vladimir Oltean wrote:
> Check that the "Can only be attached as root qdisc" error message from
> taprio is effective by attempting to attach it to a class of another
> taprio qdisc. That operation should fail.
> 
> In the bug that was squashed by change "net/sched: taprio: try again to
> report q->qdiscs[] to qdisc_leaf()", grafting a child taprio to a root
> software taprio would be misinterpreted as a change() to the root
> taprio. Catch this by looking at whether the base-time of the root
> taprio has changed to follow the base-time of the child taprio,
> something which should have absolutely never happened assuming correct
> semantics.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
If I understood correctly, these tests depend on CONFIG_PTP_1588_CLOCK_MOCK.
If that is the case, you should add it to the tdc
config file (tools/testing/selftests/tc-testing/config).

cheers,
Victor

