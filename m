Return-Path: <netdev+bounces-20651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D3760627
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545592816CB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE71876;
	Tue, 25 Jul 2023 03:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4361114
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:01:24 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E8D10FD
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:01:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-682a5465e9eso1177314b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690254081; x=1690858881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOm9JtzAMmxvhoSbX2NtL3QoGfALrOaBCsSuiN3HvS8=;
        b=S6qTrQW9jNBAqKkMe5A0Cu8+HbQDlzC3TLro07t5ACviirx/XqhnqUPjiclTs78MVw
         L8tR0RX+uwWODTuNUCn9GO7p4bXpfIsdbkjqpY0PqVfJilI1CACHVzYlY/iV0sWP5V/3
         T3P+fsJZrl/T8/61jZYJY4PyQofvYiMvXNGAlNPnqvgQIdqIJpCErJLddWxt9/CHMYvA
         fQfQW01/Y2q+AlIExOo9mNzILsmJhUWs4VPYn88so7T3w1Nn66xNTb/c35K8Neo4b+tp
         wg91etpXIESM3veFJOsmMl9xQ0iXGYxs+8+DAjrpr00+sWBSXajvrars1puw7bQqkMd4
         /qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690254081; x=1690858881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOm9JtzAMmxvhoSbX2NtL3QoGfALrOaBCsSuiN3HvS8=;
        b=Es2NiGlogvnswAjubWtUeaRcwpj+PeVBPL5b4mkJaXAfcCguvavGvdwk2pq5AWtHcH
         SyO8adOkp4hf4eQLz+ZsRHENdgI2uK+/U5DC4lEVM8PS6RCSTym0lsORp0Pfo3i78ia0
         XLIWSot9Aw9I8p4HEBj/LvALKszkU4SdshqY94pNEwu5crtgAYjfO3DVzsy3l2SgvoD1
         c1C+yAFk7CzGwoCctBqSua2m+AvzDhzuqGXxsFkGWOz7OiP1MCRiujOt9i6zUYWy5Gpl
         hU4IE9LsYPBw74FKk5BTKJXhS5lV3AZ8xmNurkf8ZYb/RaMlfSP2Q17zDQBPoibTl0gj
         MyCg==
X-Gm-Message-State: ABy/qLbABYCttIG+eA6DUNrMfWR/3FmfEd5YcgG6wULTIYJIEt9cQV08
	Zb7jw3Vv9SpyEjlO5t+OjGDP+w==
X-Google-Smtp-Source: APBJJlFM6WPSihXOKl0X4zg92CAAfeqIP/jkVagMNd5II31TO+klkQLkXzKhhJFyUFA6pGL+niCVGA==
X-Received: by 2002:a05:6a20:160d:b0:111:a0e5:d2b7 with SMTP id l13-20020a056a20160d00b00111a0e5d2b7mr15056320pzj.4.1690254081364;
        Mon, 24 Jul 2023 20:01:21 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id fe15-20020a056a002f0f00b0066ccb8e8024sm8472563pfb.30.2023.07.24.20.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 20:01:20 -0700 (PDT)
Message-ID: <9b149dd9-1617-9af4-4252-6d0df01f93b1@bytedance.com>
Date: Tue, 25 Jul 2023 11:01:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
 <20230724122549.GA3731903@hirez.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230724122549.GA3731903@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Peter,

On 2023/7/24 20:25, Peter Zijlstra wrote:
> On Mon, Jul 24, 2023 at 05:43:10PM +0800, Qi Zheng wrote:
> 
>> +void shrinker_unregister(struct shrinker *shrinker)
>> +{
>> +	struct dentry *debugfs_entry;
>> +	int debugfs_id;
>> +
>> +	if (!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))
>> +		return;
>> +
>> +	down_write(&shrinker_rwsem);
>> +	list_del(&shrinker->list);
>> +	shrinker->flags &= ~SHRINKER_REGISTERED;
>> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>> +		unregister_memcg_shrinker(shrinker);
>> +	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
>> +	up_write(&shrinker_rwsem);
>> +
>> +	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
> 
> Should there not be an rcu_barrier() right about here?

The shrinker_debugfs_remove() will wait for debugfs_file_put() to
return, so when running here, all shrinker debugfs operations have
been completed. And the slab shrink will hold the read lock of
shrinker_rwsem to traverse the shrinker_list, so when we hold the
write lock of shrinker_rwsem to delete the shrinker from the
shrinker_list, the shrinker will not be executed again.

So I think there is no need to add a rcu_barrier() here. Please let
me know if I missed something.

Thanks,
Qi

> 
>> +
>> +	kfree(shrinker->nr_deferred);
>> +	shrinker->nr_deferred = NULL;
>> +
>> +	kfree(shrinker);
>> +}
>> +EXPORT_SYMBOL(shrinker_unregister);
> 

