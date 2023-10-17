Return-Path: <netdev+bounces-41655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C650D7CB886
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 04:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0405B20EE4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52AEA50;
	Tue, 17 Oct 2023 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqAasL+I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C25622
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:41:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159CE6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697510468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwqQKdTBL0D2SjrYDF4mS3O0fCXJP4YXiINQ7Kptrd8=;
	b=BqAasL+IZIG49TxzzHW/lIocgX4SH+hCuILicMg0NFy6N+zHYIaeXavxWR7g0zOIZx/JK3
	ByUD47iu7lsJK3VavMOz4NMmobeMFtzWPamhzINro1ydxUtLDdSMtklfmwJ5ex3wHhvqYu
	l0NVESguY04Sp/g6A+lbuzGrVkjSwgg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-u4GcGJBGP6qK1B6u7l5HTw-1; Mon, 16 Oct 2023 22:41:07 -0400
X-MC-Unique: u4GcGJBGP6qK1B6u7l5HTw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c51a7df557so21056781fa.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510465; x=1698115265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwqQKdTBL0D2SjrYDF4mS3O0fCXJP4YXiINQ7Kptrd8=;
        b=n1JwoSIFrsBH3NOAYYHjv+UnSr2cO/axhgEVKEHHBSl1Dfg8jwFZdrINazWmj9FA9w
         2u6S2+AJ7JOgdwwcEMLfEhzz+bXUmeu1kApsiuYodJu5Kqn1cDeKl99zqMzQJsi//5M8
         f51kJByw5IllNqGqBFvCKBCPYaS3Om8CIw5oSWZod4qUsJBLbMyun5wcG98F2UUqMPmu
         K7iNEZi/EraZyOJEA6Nh1uGsyFv7MdqtWTHHvW0sSSKS4ojiGz6D3aTyuK5Ip0XVV965
         niQlezwaJLa9L1RoRc4F8DXi+wMnPqAlCOGB6Dy698ODDlMjOwB8rGq7ghSR06xG7fOf
         wA6g==
X-Gm-Message-State: AOJu0YxS5pdpLpm8D4wS0L9TLxxHk1nY84q/PJ1AhwhSgFBxMajiegKk
	4AZe6HGZjnLEJWBQV49QdLXJRKTVo+i6gqTMR/B8QlNGnJDJr9o7VH3xJInNslvwWB3RSyGS3Sd
	fsMdzTnF8hI/2O5R47Pvb6R32sodka99wGwMST2sT5zM=
X-Received: by 2002:a05:6512:44d:b0:507:984b:f174 with SMTP id y13-20020a056512044d00b00507984bf174mr630611lfk.48.1697510465661;
        Mon, 16 Oct 2023 19:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm2mI1YvYT71h6xVSxNCUqRlV51bZXoWzcc/xScgBgqxOLi6zLVCdZLmTioNsLto5jynkQh/FbmPYNOb8ysSE=
X-Received: by 2002:a05:6512:44d:b0:507:984b:f174 with SMTP id
 y13-20020a056512044d00b00507984bf174mr630602lfk.48.1697510465355; Mon, 16 Oct
 2023 19:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180851.3560092-1-edumazet@google.com> <652ddb83d8ec7_1bc2f32945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <652ddb83d8ec7_1bc2f32945d@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 10:40:54 +0800
Message-ID: <CACGkMEs1GZmPwGh5SUrYLW9QLS49+BQ8x1HQcGv=Xo1jq_Ea0g@mail.gmail.com>
Subject: Re: [PATCH net] tun: prevent negative ifindex
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 8:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > After commit 956db0a13b47 ("net: warn about attempts to register
> > negative ifindex") syzbot is able to trigger the following splat.
> >
> > Negative ifindex are not supported.
> >
> > WARNING: CPU: 1 PID: 6003 at net/core/dev.c:9596 dev_index_reserve+0x10=
4/0x210
> > Modules linked in:
> > CPU: 1 PID: 6003 Comm: syz-executor926 Not tainted 6.6.0-rc4-syzkaller-=
g19af4a4ed414 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/06/2023
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : dev_index_reserve+0x104/0x210
> > lr : dev_index_reserve+0x100/0x210
> > sp : ffff800096a878e0
> > x29: ffff800096a87930 x28: ffff0000d04380d0 x27: ffff0000d04380f8
> > x26: ffff0000d04380f0 x25: 1ffff00012d50f20 x24: 1ffff00012d50f1c
> > x23: dfff800000000000 x22: ffff8000929c21c0 x21: 00000000ffffffea
> > x20: ffff0000d04380e0 x19: ffff800096a87900 x18: ffff800096a874c0
> > x17: ffff800084df5008 x16: ffff80008051f9c4 x15: 0000000000000001
> > x14: 1fffe0001a087198 x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > x8 : ffff0000d41c9bc0 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : ffff800091763d88 x4 : 0000000000000000 x3 : ffff800084e04748
> > x2 : 0000000000000001 x1 : 00000000fead71c7 x0 : 0000000000000000
> > Call trace:
> > dev_index_reserve+0x104/0x210
> > register_netdevice+0x598/0x1074 net/core/dev.c:10084
> > tun_set_iff+0x630/0xb0c drivers/net/tun.c:2850
> > __tun_chr_ioctl+0x788/0x2af8 drivers/net/tun.c:3118
> > tun_chr_ioctl+0x38/0x4c drivers/net/tun.c:3403
> > vfs_ioctl fs/ioctl.c:51 [inline]
> > __do_sys_ioctl fs/ioctl.c:871 [inline]
> > __se_sys_ioctl fs/ioctl.c:857 [inline]
> > __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
> > __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> > invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
> > el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
> > do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
> > el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
> > el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
> > el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
> > irq event stamp: 11348
> > hardirqs last enabled at (11347): [<ffff80008a716574>] __raw_spin_unloc=
k_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> > hardirqs last enabled at (11347): [<ffff80008a716574>] _raw_spin_unlock=
_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
> > hardirqs last disabled at (11348): [<ffff80008a627820>] el1_dbg+0x24/0x=
80 arch/arm64/kernel/entry-common.c:436
> > softirqs last enabled at (11138): [<ffff8000887ca53c>] spin_unlock_bh i=
nclude/linux/spinlock.h:396 [inline]
> > softirqs last enabled at (11138): [<ffff8000887ca53c>] release_sock+0x1=
5c/0x1b0 net/core/sock.c:3531
> > softirqs last disabled at (11136): [<ffff8000887ca41c>] spin_lock_bh in=
clude/linux/spinlock.h:356 [inline]
> > softirqs last disabled at (11136): [<ffff8000887ca41c>] release_sock+0x=
3c/0x1b0 net/core/sock.c:3518
> >
> > Fixes: fb7589a16216 ("tun: Add ability to create tun device with given =
index")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>


