Return-Path: <netdev+bounces-32720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DEF799CBF
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 07:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5932813C5
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28161842;
	Sun, 10 Sep 2023 05:09:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093A17D4
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 05:09:36 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE811BF
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 22:09:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c364fb8a4cso30935395ad.1
        for <netdev@vger.kernel.org>; Sat, 09 Sep 2023 22:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694322574; x=1694927374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fr4vR5yVBhTVFzvgCw4xH5t9zyQi3zstexdd4SzkDRc=;
        b=QFVdrS/+JGFg+wyR26E/kX1hpm3SLCoYP4AYiAyM45uHT/LWEn98J2LCg99mor4IqM
         IzhDw3b3fyaOFLJ7z7zQSHHBrqcgdePrH/8/2cisMW92exMXCEL5XkK4WcQ6Zf8zy1sL
         WXLGeMqAPFo3Y3lux2m2uYifBhkbC793AYjFfZ2B3aF24KIfKhPxWf7BUmz9DgEi/TpV
         ZqOAoxv0Carbn297q1yhpZl9uIwzqF7gi1dyx0axOWjSIhAUVDFwtrk8yvNr6wZNsJOZ
         Kl4Yo7C/Ir+Pqp5T8FEhyiOHs2NSjAm588N1zR7woW6ZhwIbHrZU+iVz5EnV8BOcgxZa
         u45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694322574; x=1694927374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr4vR5yVBhTVFzvgCw4xH5t9zyQi3zstexdd4SzkDRc=;
        b=AjOHAwJ/imqtrT+3SaQc+YqgWEaaS82XxKFeXquBCBLb8gltO+sdCDsYeXWtglE4XP
         P41r0pkuRduSMJF9gup7JTBjDe34o5yLOk8hYt9+aMM9TeH0l2Bi/dP+4GqN78WEF7tE
         eTVUUe2a5SWlkODkH3GIICf7tHGTzBoioAAP95FFEwahCoKn/iLyFbrN96wlLwyoV0VG
         hl63hgR/CfsvnmGswDHwP4yiFs5PSyoDE0iXy0zlnSzqc0C6CVJGD2DznHKU+3fT1hNk
         LkqmeR+C8ElrhZUaaXw2tVsIbjwLfjZZn4Ay8WWTmyLOTh70vuS4cLG6EITOatgC+LVH
         mS0g==
X-Gm-Message-State: AOJu0Yx23iqaNuXXGXRAOKDZMgVEMS8bbbr4hMX2YTaZBytExAfj5Zd6
	YgvowLCVbr2kolPO+WBv5GbY1A==
X-Google-Smtp-Source: AGHT+IH7Zpp4q/SvBMI4vwkrI3AOmUYo29r9w/wHgFtVUiSkly+3ir+je0g5Oq9bZUW4pQ+8OFJR6A==
X-Received: by 2002:a17:903:1206:b0:1c0:7bac:13d4 with SMTP id l6-20020a170903120600b001c07bac13d4mr7725685plh.65.1694322573950;
        Sat, 09 Sep 2023 22:09:33 -0700 (PDT)
Received: from [10.254.5.171] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902f7d600b001bf5c12e9fesm4010683plw.125.2023.09.09.22.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 22:09:33 -0700 (PDT)
Message-ID: <57f8a247-bc5a-8aab-06a8-51608a3ce62b@bytedance.com>
Date: Sun, 10 Sep 2023 13:09:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: Re: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on
 alloc
To: Shakeel Butt <shakeelb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <1d935bfc-50b0-54f3-22f0-d360f8a7c1ac@bytedance.com>
 <CALvZod6zuPy5p6m5ins2+BQMwmEeAWiz+C5vtF7pVZdcmKNGcQ@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CALvZod6zuPy5p6m5ins2+BQMwmEeAWiz+C5vtF7pVZdcmKNGcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 11:42 PM, Shakeel Butt wrote:
> On Fri, Sep 8, 2023 at 12:55 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Friendly ping :)
>>
> 
> Sorry for the delay, I will get to this over this weekend.

Hi Shakeel, I am really appreciate your time! Thanks a lot!

