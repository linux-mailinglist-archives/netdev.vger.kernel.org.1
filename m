Return-Path: <netdev+bounces-20660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D410276069B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7951C20D5D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8D46A8;
	Tue, 25 Jul 2023 03:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180B3D6D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:28:14 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EB1720
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-682a5465e9eso1181685b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690255690; x=1690860490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wY4cILkEhsrpRf+mNddP0nleKOSU9sayj8Z5h0ToXM=;
        b=PknHptOa2Z8+2vaclzexjcjHcgGTKnQ0JRJ89LK+GvkJZyUzNmFYDaw4LaxhrbAB97
         Qlt49eA21cgLfip1YkLzQvNHl9NRE1uu+H3yLMzr5GUQw2R94ASja3LKRc7K2/IuJ877
         /rUQws3HOX4h/pSV0QLIC/txctttQBZDy4goWlpNGxYwzk8J6CttdGDNpskz9IiWFE6E
         W06R7YBvAlwN2Ll/k0WZ+e8J2UJKgy2rlagtK3lUaqPgpyCrwLsDTNoP/0MXBrAUaLK4
         fe8VXE6m3BmotnBeZ7KmASyzpGnPX5FsNzpJdMUNn5TjD0dfcmx5lygJuqraNOT+sjor
         yB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690255690; x=1690860490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wY4cILkEhsrpRf+mNddP0nleKOSU9sayj8Z5h0ToXM=;
        b=gk2LlV4sbsGp8PMgibD2NzSGxv250X88IDjMiQfmhVA7neJXctgtmGZdxlRYv0jwyH
         MpPjMKCsHp0DxlIaXhL+eKHho1YKsfbWg33SzblIyWHVu0E33vq9xUF8YGOTzFNVSccW
         VaGja2D5YN1tlZMYpnagxHLaC3Uy984XZzPRprUrssOYyw1CacN0jt0RKNbt75poOqzU
         RkbUcSVf/bwp2KikCzksBYUWaeiy8tFILRR02z8UjkI8RPRoDUlf8nl3t8MhAv4tODk2
         TgDckb3F3gGz4TxVhSmJw5GNG8AZe+rGvgpiLhICIVgoKENUNVi4S9yZ1JW86GB/xLO5
         WTpQ==
X-Gm-Message-State: ABy/qLb+cQplLkfODmqQs4m5xuYstPytRvQDlQzvRq4lcbN4RO/IbTdU
	yvPNgIzd+3rPexbh2KUCcS7uYA==
X-Google-Smtp-Source: APBJJlHvnzRChS6v/nee9rDGEWxm9C29UVXVwYKOSH3HP5ue/guAsHAKmcdiSeukVqd30tCkGAz2cw==
X-Received: by 2002:a05:6a00:cd1:b0:677:bb4c:c321 with SMTP id b17-20020a056a000cd100b00677bb4cc321mr15272930pfv.0.1690255690395;
        Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c25:884:3ed:e1db:b610? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78283000000b00682a9325ffcsm8407714pfm.5.2023.07.24.20.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 20:28:10 -0700 (PDT)
Message-ID: <bbd36d96-b6b8-08c3-1092-e3d0b255134a@bytedance.com>
Date: Tue, 25 Jul 2023 11:27:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/47] mm: vmscan: move shrinker-related code into a
 separate file
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
 tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
 Christian Brauner <brauner@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, tytso@mit.edu, steven.price@arm.com, cel@kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, yujie.liu@intel.com,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>, x86@kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, rcu@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-2-zhengqi.arch@bytedance.com>
 <97E80C37-8872-4C5A-A027-A0B35F39152A@linux.dev>
 <d2621ad0-8b99-9154-5ff5-509dec2f32a3@bytedance.com>
 <6FE62F56-1B4E-4E2A-BEA9-0DA6907A2FA9@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6FE62F56-1B4E-4E2A-BEA9-0DA6907A2FA9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/25 11:23, Muchun Song wrote:
> 
> 
>> On Jul 25, 2023, at 11:09, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>
>>
>> On 2023/7/25 10:35, Muchun Song wrote:
>>>> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>>
>>>> The mm/vmscan.c file is too large, so separate the shrinker-related
>>>> code from it into a separate file. No functional changes.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>> include/linux/shrinker.h |   3 +
>>>> mm/Makefile              |   4 +-
>>>> mm/shrinker.c            | 707 +++++++++++++++++++++++++++++++++++++++
>>>> mm/vmscan.c              | 701 --------------------------------------
>>>> 4 files changed, 712 insertions(+), 703 deletions(-)
>>>> create mode 100644 mm/shrinker.c
>>>>
>>>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>>>> index 224293b2dd06..961cb84e51f5 100644
>>>> --- a/include/linux/shrinker.h
>>>> +++ b/include/linux/shrinker.h
>>>> @@ -96,6 +96,9 @@ struct shrinker {
>>>>   */
>>>> #define SHRINKER_NONSLAB (1 << 3)
>>>>
>>>> +unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>>>> +    int priority);
>>> A good cleanup, vmscan.c is so huge.
>>> I'd like to introduce a new header in mm/ directory and contains those
>>> declarations of functions (like this and other debug function in
>>> shrinker_debug.c) since they are used internally across mm.
>>
>> How about putting them in the mm/internal.h file?
> 
> Either is fine to me.

OK, will do in the next version.

> 
>>
>>> Thanks.
> 
> 

