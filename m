Return-Path: <netdev+bounces-48683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674EB7EF394
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14441C2089C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB031599;
	Fri, 17 Nov 2023 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="bHuTbt9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFE98
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 05:15:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce1603f5cdso17648895ad.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 05:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1700226949; x=1700831749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jhoipxjw/PNUwMnP1oDAJ149BYrwgFddqUX2ryqFIg=;
        b=bHuTbt9MH9ukCXoSraHcBbDarQ2f31HVL+OoV22YgHyF3E6pdfBYe/zBZQSCEBg0rg
         hnclT8JXzTRZrCZFxrsxdfBShCuOnDf0W3ajJ7rjb9RO3ysy3PiziLEwm/p4YFZwnl6z
         XPt205sUR/EMwo1ENRtev6FCjHFO/ChcscurkxmhVYsIKQMfr5wSk4M6Ax6HkGYciUIt
         9xK0iKJ3Z3L1f90BhWwkxw+UWIxXfwWjuZE8EKJyM4Jtib2nNmSud9gOtib+fZX58IgI
         lcJF1ilQdcS1Q8QLU2cdn3I1HoyPhgKhcR86puoclL+gkRryqFYNVIkvPQlIMlUfLQyF
         4moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226949; x=1700831749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7jhoipxjw/PNUwMnP1oDAJ149BYrwgFddqUX2ryqFIg=;
        b=JHS19mApWEBxWQ9dak54X9buNFRt67db0MyUByZGJVH2Yer0abRJMwyHa+9QJAn0bC
         SmCLurifMGsD6GtgoRpnF7vSsH5HPVCgO51clmRy4366xVTB74reNBjyAI0owCP+mAbo
         yUANOrzRTFlQ7l559HVv4bo/wqbK/sa5dpIHdmWejjYtL8S4lgBYeLHQCs5E7GIuof7R
         zpxW00WfGhBnTniXFErFffbwrOmL8gYT/AlxBgPHjS4OqeHjYM1Rv/A+jqUN2Mcn3Bi8
         S6oIC4lSy4XMWjn/ij5TE2SinWn1IxMw1XEHwUjRsEurs/a4czj8C7wbrQJC9TguNoM7
         e5KQ==
X-Gm-Message-State: AOJu0Yz9cxJrzdAMcdQY+ruWf+dv1h22yfDxlEBp9UULdX8moGIHn/fA
	/XsghE9JAXJmC7hd5spPXIfogA==
X-Google-Smtp-Source: AGHT+IH7b2Noxcl7pieA0zocSiCHi0vhjtI0eduElXiMO/gPtxJolybhfxmfxADL8d1FEbNbEXYGdA==
X-Received: by 2002:a17:903:110c:b0:1c7:755d:ccc8 with SMTP id n12-20020a170903110c00b001c7755dccc8mr12173214plh.29.1700226949217;
        Fri, 17 Nov 2023 05:15:49 -0800 (PST)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b001c9b384731esm1337445plg.270.2023.11.17.05.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 05:15:48 -0800 (PST)
Message-ID: <76411980-e06d-43d8-8f63-b9a032e21b43@shopee.com>
Date: Fri, 17 Nov 2023 21:15:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bonding: use a read-write lock in bonding_show_bonds()
To: Eric Dumazet <edumazet@google.com>
Cc: andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
 <20231117104311.1273-1-haifeng.xu@shopee.com>
 <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/11/17 18:59, Eric Dumazet wrote:
> On Fri, Nov 17, 2023 at 11:43 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> Problem description:
>>
>> Call stack:
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
>> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
>> but there are many readers which hold the kernfs_rwsem, so it has to sleep
>> for a long time to wait the readers release the lock. Thread 278176 and any
>> other threads which call bonding_show_bonds() also need to wait because
>> they try to acquire the rtnl_mutex.
>>
>> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
>> However, the addition and deletion of bond_list are only performed in
>> bond_init()/bond_uninit(), so we can introduce a separate read-write lock
>> to synchronize bond list mutation.
>>
>> What are the benefits of this change?
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
>> v2:
>> - move the call stack after the description
>> - fix typos in the changelog
>> ---
>>  drivers/net/bonding/bond_main.c  | 4 ++++
>>  drivers/net/bonding/bond_sysfs.c | 6 ++++--
>>  include/net/bonding.h            | 3 +++
>>  3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 8e6cc0e133b7..db8f1efaab78 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5957,7 +5957,9 @@ static void bond_uninit(struct net_device *bond_dev)
>>
>>         bond_set_slave_arr(bond, NULL, NULL);
>>
>> +       write_lock(&bonding_dev_lock);
>>         list_del(&bond->bond_list);
>> +       write_unlock(&bonding_dev_lock);
>>
>>         bond_debug_unregister(bond);
>>  }
>> @@ -6370,7 +6372,9 @@ static int bond_init(struct net_device *bond_dev)
>>         spin_lock_init(&bond->stats_lock);
>>         netdev_lockdep_set_classes(bond_dev);
>>
>> +       write_lock(&bonding_dev_lock);
>>         list_add_tail(&bond->bond_list, &bn->dev_list);
>> +       write_unlock(&bonding_dev_lock);
>>
>>         bond_prepare_sysfs_group(bond);
>>
>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
>> index 2805135a7205..e107c1d7a6bf 100644
>> --- a/drivers/net/bonding/bond_sysfs.c
>> +++ b/drivers/net/bonding/bond_sysfs.c
>> @@ -28,6 +28,8 @@
>>
>>  #define to_bond(cd)    ((struct bonding *)(netdev_priv(to_net_dev(cd))))
>>
>> +DEFINE_RWLOCK(bonding_dev_lock);
>> +
>>  /* "show" function for the bond_masters attribute.
>>   * The class parameter is ignored.
>>   */
>> @@ -40,7 +42,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
>>         int res = 0;
>>         struct bonding *bond;
>>
>> -       rtnl_lock();
>> +       read_lock(&bonding_dev_lock);
>>
>>         list_for_each_entry(bond, &bn->dev_list, bond_list) {
>>                 if (res > (PAGE_SIZE - IFNAMSIZ)) {
>> @@ -55,7 +57,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
>>         if (res)
>>                 buf[res-1] = '\n'; /* eat the leftover space */
>>
>> -       rtnl_unlock();
>> +       read_unlock(&bonding_dev_lock);
>>         return res;
>>  }
> 
> This unfortunately would race with dev_change_name()

dev_change_name（）is either used in  dev_ifsioc(case: SIOCSIFNAME) or used in do_setlink(), so 
could these net devices which need to change name be related to bond？ I am not quite sure.

> 
> You probably need to read_lock(&devnet_rename_sem); before copying dev->name,
> or use netdev_get_name(net, temp_buffer, bond->dev->ifindex)


