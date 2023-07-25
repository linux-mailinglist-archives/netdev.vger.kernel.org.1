Return-Path: <netdev+bounces-20662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CC37606AA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57FA28174B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422134C80;
	Tue, 25 Jul 2023 03:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136E210F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:28:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2D1725
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690255727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTDAn74ufWGAYyDGlV6tL8ew2OmLpGw/P9rq29njGkg=;
	b=EhrABMrMyvRJ2Odry2SiXLgbUbNnjQBVfogtb7zSOfCxY3Zn6HYVRWhdjPDFy8rSWhkpco
	22Rd6FSbMHq1P7K/mRUW0QCRm9yIdxixxr9tNpcRzIoeXQKiZjbkhSCoB+izBg3WvPqsBW
	1nMbBG3COJzKqZLFdpTSAsKYcUXE3Wg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-6UZGHXvLNjio5xxRqGtEWQ-1; Mon, 24 Jul 2023 23:28:45 -0400
X-MC-Unique: 6UZGHXvLNjio5xxRqGtEWQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fdf0f40eb3so1669172e87.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690255724; x=1690860524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTDAn74ufWGAYyDGlV6tL8ew2OmLpGw/P9rq29njGkg=;
        b=cj539puneFxCz+wdLMoVEd8oSoYJpU42uNw2Wyz5ZPk4PbrHd6mLGCi7Wbk0K5JcVw
         r41fQ/LdQYXAGHH1NlleFHbV1FiIzjP5Pwp9rKkv0htPEjqS3MAgXPciOh2d70ysXqi0
         TywAntnyvwr7jpCSxsEwnQ0d1+yhBT8T84UuWNcG5ftg51HVP0ICgkVftyGKjWl/4q98
         CAJls+s1CPk/94TTHFxftDAcSDZ9udug1moIrTIRM1EPc/joseFTHJXn7VU0CsjIiT5r
         ma72BEW7wMi3HGF3MGeDWQCIIXdBnlbMR9ax9edNgA+qHX1HiMhERjsQf9p2B6Ym9/ZU
         9EbQ==
X-Gm-Message-State: ABy/qLYIf9BPrZTZ41H64vh1ykWVKxKfhtdpNFugpJd7agm809hahWRx
	kJCu9TViiCmJqyCJVj0mDQwdNYb8JSfYwqIYLP5Jpu0QsDurNfzAS5FMZjhzLWaQyUKatSX8ArS
	WTS7hJrWd7Brqfct2qRLFj0lakbE9uy04
X-Received: by 2002:ac2:5bc7:0:b0:4fb:7392:c72c with SMTP id u7-20020ac25bc7000000b004fb7392c72cmr5894671lfn.57.1690255724171;
        Mon, 24 Jul 2023 20:28:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5o+SrEQZCXouOwMSQiZ//uNeHhCD6S/5bhIifnn+1MgBriPB5z4uuFH2je1iSGA5hunLDbkddfPQyzZDyueA=
X-Received: by 2002:ac2:5bc7:0:b0:4fb:7392:c72c with SMTP id
 u7-20020ac25bc7000000b004fb7392c72cmr5894664lfn.57.1690255723877; Mon, 24 Jul
 2023 20:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724221326.384-1-andrew.kanner@gmail.com>
In-Reply-To: <20230724221326.384-1-andrew.kanner@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 11:28:32 +0800
Message-ID: <CACGkMEu2Outtv7F=H=aDhbnDRmDO5ZSuF9Gb583dLmaCVFknAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: net: use xdp only inside tun_build_skb()
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 6:14=E2=80=AFAM Andrew Kanner <andrew.kanner@gmail.=
com> wrote:
>
> Syzkaller reported the following issue:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Too BIG xdp->frame_sz =3D 131072
> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>   ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>   bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
> ...
> Call Trace:
>  <TASK>
>  bpf_prog_4add87e5301a4105+0x1a/0x1c
>  __bpf_prog_run include/linux/filter.h:600 [inline]
>  bpf_prog_run_xdp include/linux/filter.h:775 [inline]
>  bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
>  netif_receive_generic_xdp net/core/dev.c:4807 [inline]
>  do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
>  tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
>  tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
>  call_write_iter include/linux/fs.h:1871 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x650/0xe40 fs/read_write.c:584
>  ksys_write+0x12f/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> frame_sz < PAGE_SIZE check was introduced in commit c8741e2bfe87
> ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size").

I wonder if this check makes sense for xdp generic when skb is linearized.

> But
> tun_get_user() still provides an execution path to exceed XDP limits
> for packet size.

I'd suggest being specific to the execution path, which is actually
the generic XDP.

> The way to mitigate this is to reduce xdp to be used
> only in tun_build_skb(), without falling in tun_alloc_skb(), etc.
>
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.c=
om/T/
> Link: https://syzkaller.appspot.com/bug?id=3D5335c7c62bfff89bbb1c8f14cdab=
ebe91909060f
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  drivers/net/tun.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d75456adc62a..18ccbbe9830a 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1580,8 +1580,14 @@ static void tun_rx_batched(struct tun_struct *tun,=
 struct tun_file *tfile,
>  }
>
>  static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *t=
file,
> -                             int len, int noblock, bool zerocopy)
> +                             int len, int noblock, bool zerocopy, int *s=
kb_xdp)
>  {
> +       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> +           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE) {
> +               *skb_xdp =3D 0;

So if XDP is enabled, the packet will bypass the bpf program which is
sub-optimal. I think we should at least drop the packet in this case.

Thanks

> +               return false;
> +       }
> +
>         if ((tun->flags & TUN_TYPE_MASK) !=3D IFF_TAP)
>                 return false;
>
> @@ -1594,10 +1600,6 @@ static bool tun_can_build_skb(struct tun_struct *t=
un, struct tun_file *tfile,
>         if (zerocopy)
>                 return false;
>
> -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> -           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
> -               return false;
> -
>         return true;
>  }
>
> @@ -1809,7 +1811,7 @@ static ssize_t tun_get_user(struct tun_struct *tun,=
 struct tun_file *tfile,
>                         zerocopy =3D true;
>         }
>
> -       if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocop=
y)) {
> +       if (tun_can_build_skb(tun, tfile, len, noblock, zerocopy, &skb_xd=
p) && !frags) {
>                 /* For the packet that is not easy to be processed
>                  * (e.g gso or jumbo packet), we will do it at after
>                  * skb was created with generic XDP routine.
> --
> 2.39.3
>


