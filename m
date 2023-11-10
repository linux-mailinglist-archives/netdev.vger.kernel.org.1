Return-Path: <netdev+bounces-46969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BA7E7797
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 03:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43216281009
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 02:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7A36A;
	Fri, 10 Nov 2023 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="FC4Z56F1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B6365
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:35:28 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854744B6
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:35:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc53d0030fso13322385ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 18:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699583728; x=1700188528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgBCZy2pjUuwCfBCOpo5jIZ1qaDezMqXli99KyuJnHQ=;
        b=FC4Z56F195QyVpxnAR/i+IeafZuOCFsxZ87TjS+XEZQZIoQz8Yk5o5zf/Eo3scDO30
         jx7Z5DKIsOyeJGrgf8y74KDAH2+T+k6CO0HHy3a9zcXkF3ogzKRgU4SXXG6f/4XvNUq/
         0TPwokrlpwr71T3FuMDbCudqimgSRKr2yvXR0gQVOuy89t8AmLjlgEvvnnfVQWQ0V0zk
         raYoenr88Quo2ga3mum2/NkEJF1rRiE2KtjbrRhBV0Bzeafdy2AC1nVZeajsabo+789v
         JhKaf7kWyEc1pyn3k19LmFSaqsB07cwDHuz6oacwWWnfRWNvFD62HTdrr/w8DjRPT91d
         Ro6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583728; x=1700188528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tgBCZy2pjUuwCfBCOpo5jIZ1qaDezMqXli99KyuJnHQ=;
        b=LB22gBRf14II0nr9Ixay+AJohbL1bNrcuYa3HJTYeJejlYwaMviJ/s8JO4Esgsveb/
         sbV2vrijFnfNa9ejSJvA2LyWEvNxF36dY1JXS7WK9Y2gd02r3DP82pBC5Nb/WAHQN9yT
         zKX/c0898fmBZ9WrUuJRwFcWayAutJj9y/UgGRhq620BhGqlLHks2JKdVnJmhVQ6UKY5
         iMrfbzqT/btmM6Bvbgh4BFXQS+7T19hU36IJlQAPDH2bPoB13zqWX1FlqTac58mlktJF
         rlg4Gc4Zax6ODrAali+C49AC+7Tpm8hF8iZSDYlm1gjMS6rsrj+egjKchO95BMwLQ8YR
         qktQ==
X-Gm-Message-State: AOJu0Yw6ftq37XLRKjgWhSlPOCuWdSMJNSxjtghxE2K6YAAQZ5mM4U3o
	WyEjs3EnvqAkF3H/+yvwNMOv8g==
X-Google-Smtp-Source: AGHT+IGCfJ57fE5I6PC+b/RBA92MbOtNNOguMY70hceIo5tX8FfGSjZaEzdMhxaZgy6Ghrv39djblw==
X-Received: by 2002:a17:902:d4c5:b0:1cc:5f5a:5d3 with SMTP id o5-20020a170902d4c500b001cc5f5a05d3mr1629031plg.22.1699583727790;
        Thu, 09 Nov 2023 18:35:27 -0800 (PST)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b001c0a4146961sm4207161plb.19.2023.11.09.18.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:35:27 -0800 (PST)
Message-ID: <0fda4dff-9683-48a8-9b5b-2fdec9daabc0@shopee.com>
Date: Fri, 10 Nov 2023 10:35:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
 <20231109095502.5a03bfd5@hermes.local>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20231109095502.5a03bfd5@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/11/10 01:55, Stephen Hemminger wrote:
> On Wed,  8 Nov 2023 06:46:41 +0000
> Haifeng Xu <haifeng.xu@shopee.com> wrote:
> 
>> call stack:
>> ......
>> PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
>> [ffffa7a8e96bbac0] __schedule at ffffffffb0719898
>> [ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
>> [ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
>> [ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
>> [ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
>> [ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
>> [ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
>> [ffffa7a8e96bbc80] device_del at ffffffffb0209af8
>> [ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
>> [ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
>> [ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
>> [ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
>> [ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
>> [ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
>> [ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
>> [ffffa7a8e96bbf10] kthread at ffffffffafae132a
>> [ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92
>>
>> 290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-exporter"
>> [ffffa7a8d14dbb80] __schedule at ffffffffb0719898
>> [ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
>> [ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
>> [ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
>> [ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
>> [ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
>> [ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
>> [ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
>> [ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
>> [ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
>> [ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
>> [ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
>> [ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
>> [ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
>> [ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
>> [ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
>> [ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
>> [ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
>> [ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
>> ......
>>
>> Problem description:
>>
>> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
>> but there are many readers which hold the kernfs_rwsem, so it has to sleep
>> for a long time to wait the readers release the lock. Thread 278176 and any
>> other threads which call bonding_show_bonds() also need to wait because
>> they try to accuire the rtnl_mutex.
>>
>> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
>> However, the addition and deletion of bond_list are only performed in
>> bond_init()/bond_uninit(), so we can intoduce a separate read-write lock
>> to synchronize bond list mutation.
>>
>> What's the benefits of this change?
>>
>> 1) All threads which call bonding_show_bonds() only wait when the
>> registration or unregistration of bond device happens.
>>
>> 2) There are many other users of rtnl_mutex, so bonding_show_bonds()
>> won't compete with them.
>>
>> In a word, this change reduces the lock contention of rtnl_mutex.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  drivers/net/bonding/bond_main.c  | 4 ++++
>>  drivers/net/bonding/bond_sysfs.c | 6 ++++--
>>  include/net/bonding.h            | 3 +++
>>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> Reader-writer locks are slower than spin locks and should be discouraged> Would it be possible to use RCU here instead?
 
In most cases，there are many threads which want to iterate over the bond_list,
the registration or unregistration of bond device rarely happens.

