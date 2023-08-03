Return-Path: <netdev+bounces-23876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D9276DEE3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 05:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA84C281690
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B679FE;
	Thu,  3 Aug 2023 03:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0C8BE1
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 03:20:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA326B2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 20:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691032835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QovWFaxHnWeqR0vsWVD+az55lOwaqV+kKvtZL++WfzY=;
	b=T8sryNJAQ0kZ1BE8gimpDl5+Dgwx8JnyyZFcmFIlvDlQYlZPgoMI209R85NvM+OTo/Y8Sh
	VZb7tw4gSoFlvGb2ZZgfuiD5PIoHpXWwM2bApUztslvZw4rzrOTiQb+TcerdPSqCmqmWEg
	UYY8dpwJi6ael6VkZLuARcKtR1UAoUE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-uW2O7KxqMymIJKPlC5G2WA-1; Wed, 02 Aug 2023 23:20:33 -0400
X-MC-Unique: uW2O7KxqMymIJKPlC5G2WA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so4147781fa.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 20:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032832; x=1691637632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QovWFaxHnWeqR0vsWVD+az55lOwaqV+kKvtZL++WfzY=;
        b=LpdGaSj7BJTHjEUhO6XqZ8AtuwxRlaAIgc1zW1RcKcaoWfsbBkiEiCSe2cY2nashnM
         Gd8wlA49wenTU3EF3yhkBgRWfWfzKwTsxLvtQ25CZoI6ORyDgwes/Dlj0YMe1c5LMMh+
         wrzdTJAPL7H60vmdmFsNlcsl8zXqB3qYAu5a6sRWskpjGFpkYc9yQTCOScbVcFz6iKyp
         AdXlADCHmUDgMWQYC2dG3TojrPE2upGatHNnD8aXwbK8QFgNcgudoFFK+i39FFBfZjOy
         4VsZCfL+oBTbSrP2LsclNkm+V9Th80WIPD1FArmVn2rvwC0t0z8fPupb+sbh4ThHL4hg
         oLVQ==
X-Gm-Message-State: ABy/qLaUXdHBAjr4oz/5bjGsuI0dljw/6FrkVE9k4XBeO6KRTbo2jOjH
	EbaKuEbuGsLYYCktPGspbm12Lsq7LUDtX/UBI+ocQY6OMAu7RjtF7fxLniz8aXMyXUqg6eliQYv
	gkAzKlOCJPppD9GjfeDOdk/nLkm2ReoI8
X-Received: by 2002:a2e:964e:0:b0:2b9:e701:ac48 with SMTP id z14-20020a2e964e000000b002b9e701ac48mr6600485ljh.32.1691032832465;
        Wed, 02 Aug 2023 20:20:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlETOgSsHd7bMfj2t0yr6N9rcMcAX7TnYSzl+FA8xdXceqfOu5sepJNkq4Hwq08yfISEjwj2LTwuXlc9sOWBhWQ=
X-Received: by 2002:a2e:964e:0:b0:2b9:e701:ac48 with SMTP id
 z14-20020a2e964e000000b002b9e701ac48mr6600470ljh.32.1691032832279; Wed, 02
 Aug 2023 20:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801220710.464-1-andrew.kanner@gmail.com> <20230801220710.464-2-andrew.kanner@gmail.com>
In-Reply-To: <20230801220710.464-2-andrew.kanner@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 3 Aug 2023 11:20:20 +0800
Message-ID: <CACGkMEtRyEkpRetANvU1L97gLtVVT+vaBV1Hmh2QqZu9c9tvYw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com, 
	dsahern@gmail.com, jbrouer@redhat.com, john.fastabend@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 6:09=E2=80=AFAM Andrew Kanner <andrew.kanner@gmail.c=
om> wrote:
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
> xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
> ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But Jesper
> Dangaard Brouer <jbrouer@redhat.com> noted that after introducing the
> xdp_init_buff() which all XDP driver use - it's safe to remove this
> check. The original intend was to catch cases where XDP drivers have
> not been updated to use xdp.frame_sz, but that is not longer a concern
> (since xdp_init_buff).
>
> Running the initial syzkaller repro it was discovered that the
> contiguous physical memory allocation is used for both xdp paths in
> tun_get_user(), e.g. tun_build_skb() and tun_alloc_skb(). It was also
> stated by Jesper Dangaard Brouer <jbrouer@redhat.com> that XDP can
> work on higher order pages, as long as this is contiguous physical
> memory (e.g. a page).
>
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.c=
om/T/
> Link: https://syzkaller.appspot.com/bug?extid=3Df817490f5bd20541b90a
> Link: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmai=
l.com/T/
> Fixes: 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/core/filter.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..28a59596987a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4116,12 +4116,6 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *,=
 xdp, int, offset)
>         if (unlikely(data_end > data_hard_end))
>                 return -EINVAL;
>
> -       /* ALL drivers MUST init xdp->frame_sz, chicken check below */
> -       if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
> -               WARN_ONCE(1, "Too BIG xdp->frame_sz =3D %d\n", xdp->frame=
_sz);
> -               return -EINVAL;
> -       }
> -
>         if (unlikely(data_end < xdp->data + ETH_HLEN))
>                 return -EINVAL;
>
> --
> 2.39.3
>


