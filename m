Return-Path: <netdev+bounces-49162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DABC7F0F83
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE041C210FE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C7E125BD;
	Mon, 20 Nov 2023 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvcayZqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3ED95
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 01:55:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso4995a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700474125; x=1701078925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXik9sN9oPjNlP35QH0IkVw44/XuwaU3LqfwT7DUr34=;
        b=fvcayZqgDMrtjvbZojBvPRjYTlimdzYA/+lyywdlW97prQ+E7mgY8mds8FapeY7rvH
         HXJ1kRoUMOAuKlVMIJuKRftPQsTHQvluZK0WSvNXRX119Z45LbLX93uZg8qnslrU0ZNW
         ZrnrWTlkinBk8nEKa/nJHFu6G0jGaq+r9PbIZpEXjQp/zcQxS/aEZvyExjWiLvrPK6D2
         m9fehIQy0AwuCuu4KoCpvCUQal30jsIZuR+3Ij4EuiPn7YRPSniELB+VjNVx9yzV0o9e
         nCS3WiAvPnRPNro8PSjfKaliarEmFaCWJKBlNHU9S+2ytAq2sgtsKf9AX4tiSugL+5kb
         H/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474125; x=1701078925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXik9sN9oPjNlP35QH0IkVw44/XuwaU3LqfwT7DUr34=;
        b=q4i6ucNJPCVk7UkDytYG/FIGB8iMLD6+Rh/QEjBRWcqm879KSb55zB264mLbgLo8HZ
         PrxHZVHRtRngpoRQsuQaW+cRLEmZkLJhqKfrOot9XQdUVO64yIgaYniplnEaIh5L/9yJ
         BJ3pPrggoX5kPgonf5EiKtCYDJ0HEBrZA3J5ahOwi26HtKfuK6IWxLb8aam85ks3oZgI
         cohc7Xviw7Mq7IPx3r2dDVTtV2C505Q9LT3MAd9sdKozIG491sJqJPUvmgs/rdN1to4x
         xa10sbppqtBFqlkcLTgfvXh2m6Nu3l7Gac08VqTQmMBamurZlg6Fmy4ggdUgssLdl/fl
         j7DA==
X-Gm-Message-State: AOJu0YxztDFejDqetdXAjNhojQLx/LlLNbGst41YKrOkc0IgHW/MExxa
	6NhEp/pUkSP4DQPJ2mB4W/XN27/7/SfREUzxB4W5nlXFk0i3twR6dfA=
X-Google-Smtp-Source: AGHT+IGLyeTL8N3vqZ8p9XQyWBXZE+2KdHScmeVKG54pz248PW0AjCj5rhv3SFu+vAEP8EtsQHEajXYbYCANVG4nOKA=
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr218730edb.1.1700474125026; Mon, 20 Nov
 2023 01:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
 <20231119092530.13071-2-haifeng.xu@shopee.com>
In-Reply-To: <20231119092530.13071-2-haifeng.xu@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Nov 2023 10:55:11 +0100
Message-ID: <CANn89iJGZOg3ozTi+HLEd_WqVUiVHVXhD5_w8Dj8=4df2zxymw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bonding: use a read-write lock in bonding_show_bonds()
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 10:25=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com>=
 wrote:
>
> Problem description:
>
> Call stack:
> ......
> PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
> [ffffa7a8e96bbac0] __schedule at ffffffffb0719898
> [ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
> [ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
> [ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
> [ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
> [ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
> [ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
> [ffffa7a8e96bbc80] device_del at ffffffffb0209af8
> [ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
> [ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
> [ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
> [ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
> [ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
> [ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
> [ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
> [ffffa7a8e96bbf10] kthread at ffffffffafae132a
> [ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92
>
> 290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-expor=
ter"
> [ffffa7a8d14dbb80] __schedule at ffffffffb0719898
> [ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
> [ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
> [ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
> [ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
> [ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
> [ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
> [ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
> [ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
> [ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
> [ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
> [ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
> [ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
> [ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
> [ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
> [ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
> [ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
> [ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
> [ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
> ......
>
> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
> but there are many readers which hold the kernfs_rwsem, so it has to slee=
p
> for a long time to wait the readers release the lock. Thread 278176 and a=
ny
> other threads which call bonding_show_bonds() also need to wait because
> they try to acquire the rtnl_mutex.
>
> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
> However, the addition and deletion of bond_list are only performed in
> bond_init()/bond_uninit(), so we can introduce a separate read-write lock
> to synchronize bond list mutation. In addition, bonding_show_bonds() coul=
d
> race with dev_change_name(), so we need devnet_rename_sem to protect the
> access to dev->name.
>
> What are the benefits of this change?
>
> 1) All threads which call bonding_show_bonds() only wait when the
> registration or unregistration of bond device happens or the name
> of net device changes.
>
> 2) There are many other users of rtnl_mutex, so bonding_show_bonds()
> won't compete with them.
>
> In a word, this change reduces the lock contention of rtnl_mutex.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

