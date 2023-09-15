Return-Path: <netdev+bounces-34021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DD7A1929
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393F6282827
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81D5D51F;
	Fri, 15 Sep 2023 08:47:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A842F38
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:47:36 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C6C2728
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 01:47:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c43166b7e5so3963155ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694767654; x=1695372454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldtjCWhn5cbHIMPW1zk7VmYyZJ2iO7oYLIHE3RYnz9I=;
        b=ApnAbBcCZB5/4sZ51oiD9BqX2/NyW9ECiUOs80ohWFrPn+a8Im9RJRseXIermvH+ZO
         Mn/PvXdPxJ0fGMld9laYs81uj3dNxmyKauoXGTzqeTYKFPweOvA1Ao4c+VT6ro9N1m9p
         LYCrTsKyHDgC+QzF/GPGHBbowWG2byPmXck8TEfByBky0LNA/92hl7YnMST9XguU4vK3
         l94CscPwxnnWYz35cEfQJiRRQosuMvry3sWnYuKCOloCqao8BxXTX+7uO7AIxMiFKtQv
         WwXTmjWugSDhVLuBbv40VGRU70A0LqpbSBW2NxArUp1W/tQNbVo4xkUv3v0BPvMCWyTd
         FglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767654; x=1695372454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldtjCWhn5cbHIMPW1zk7VmYyZJ2iO7oYLIHE3RYnz9I=;
        b=Ceueymnqy9qiaXWYI5PyXaiNBXT3habQj9VXfnjuMl2daz9fpUokyN2EIv3eLj6SXe
         2qBUh1VTo9HBL3dp8Eg/rLEVTCLpLBg3naGLDg9fgnh/zGOAcxe8gIYcZ4EfGeVb+/kc
         pVFf7qzVZXoU5HKar1CwJWdzx2UydCp7TQhQ4w2GqCJNcMxDjA7+pSrXihF2fVR9deaC
         /2prIbTDOe0ss+kSSsRyiw3XS9boeo6HHW2R2xw1y7pjgdizpabQNRqRyBEeJza5QIrT
         24L1LJ3X0FTAFFPoqyqWYIpleVUS9xtZXrWpeN55aP0bnKR6oCIXzrYw5Tihu727EYux
         TP6A==
X-Gm-Message-State: AOJu0YzkUDBbpgsCzO42ZyY/jrMfvAnJ8XpyFGyPHPC4WVc8kc+3lpGh
	MkhmWm/Qky8szg1t4W4Eurx0dw==
X-Google-Smtp-Source: AGHT+IFwLxVHAWkalspdMHGEoI/dMr0rCuF/wfuyRQZl7VlakttPexcsCgvZYDr0fzlZrafT9Hx0ZA==
X-Received: by 2002:a17:902:c191:b0:1bb:ce4a:5893 with SMTP id d17-20020a170902c19100b001bbce4a5893mr883577pld.30.1694767654337;
        Fri, 15 Sep 2023 01:47:34 -0700 (PDT)
Received: from [10.84.152.163] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001bb28b9a40dsm2962631plb.11.2023.09.15.01.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 01:47:33 -0700 (PDT)
Message-ID: <8d6bf3e9-5e44-cd83-bc49-c9dddd7b6b03@bytedance.com>
Date: Fri, 15 Sep 2023 16:47:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
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
 <20230914212042.nnubjht3huiap3kk@google.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230914212042.nnubjht3huiap3kk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/15/23 5:20 AM, Shakeel Butt wrote:
> On Fri, Sep 01, 2023 at 02:21:25PM +0800, Abel Wu wrote:
>>
> [...]
>> As expected, no obvious performance gain or loss observed. As for the
>> issue we encountered, this patchset provides better worst-case behavior
>> that such OOM cases are reduced at some extent. While further fine-
>> grained traffic control is what the workloads need to think about.
>>
> 
> I agree with the motivation but I don't agree with the solution (patch 2
> and 3). This is adding one more heuristic in the code which you yourself
> described as helped to some extent. In addition adding more dependency
> on vmpressure subsystem which is in weird state. Vmpressure is a cgroup
> v1 feature which somehow networking subsystem is relying on for cgroup
> v2 deployments. In addition vmpressure acts differently for workloads
> with different memory types (mapped, mlocked, kernel memory).

Indeed.

> 
> Anyways, have you explored the BPF based approach. You can induce socket
> pressure at the points you care about and define memory pressure however
> your use-case cares for. You can define memory pressure using PSI or
> vmpressure or maybe with MEMCG_HIGH events. What do you think?

Yeah, this sounds much better. I will re-implement this patchset based
on your suggestion. Thank you for helpful comments!

Best,
	Abel

