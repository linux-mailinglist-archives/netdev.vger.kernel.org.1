Return-Path: <netdev+bounces-13966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA973E37C
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D9D1C208BC
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99394C12A;
	Mon, 26 Jun 2023 15:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B830C2C1
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:36:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE210DF
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687793791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Veur/EKeEucIQvMxKWii3PHeDlJfVrEb91ZCZfO5tlg=;
	b=VV5DGGBnYCPdQk78gE9XiAccrPCTm3j9GwOXVakD5uD3CQXH0B++YiGRi/Of0r96cyTSxl
	ocKEGUKEpmrhvCJZowK3dXf6K6LIrvpkhzmq51SzrrZW048gIdmz35okENgiJQbdw1R8Ar
	+Bu+uteg195GC8nuUks+E67mu3zWkwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-u4zim-YINgKKpS4RjEkrgQ-1; Mon, 26 Jun 2023 11:36:29 -0400
X-MC-Unique: u4zim-YINgKKpS4RjEkrgQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9b003507bso16842555e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793788; x=1690385788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veur/EKeEucIQvMxKWii3PHeDlJfVrEb91ZCZfO5tlg=;
        b=SY1P0p+2owpfYNypt21Y1n15a25u6/297Mv+gJua+cECfnso+pmInvW8JVaSKV9m1p
         IQT24hHxX/4a2JuzmADiNc6omOK9iFdJS1afGlIoNQTX9CUux955otRhD3kKSAnh5mP8
         0JpaDyRHInBWoOsQaofbeYjiFyzrcsdQ+Qw8x+9dPxvnGruNEu+pgngjm5MwJ8E/tx2h
         1t5ueEM2ShBvJbftHaOOqpcr691TKTS3jMoh7zVBxecXdbJpet1fqC6s0Q2stKwAp4kS
         J70O2I0h9NoFW29oe0loY3AFl3TWGzvDpDfxhGItf0wTMBr66U34P2JpyMuOsl9uGuxF
         m5PQ==
X-Gm-Message-State: AC+VfDzXVJUMUhvyLP3siV11hqVAH9RqnaYqCDom0cOEilqZn7QW9XKM
	WQZeIdY/myWkiqErl6L5H+KBFO4hYGOVio7NiEcvQ+a3P7cORmtKOy++xsl650Hi0B/s3dPrdlH
	HzOI0xnf2fQOjDjSh
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id p1-20020a05600c204100b003fa78083e16mr7954054wmg.29.1687793788105;
        Mon, 26 Jun 2023 08:36:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JE+Pa90hkEnWZ1VrQhlMmSsls+KtMOsA3+quZnWIop516YIwu6zTpA6a8rTt6waN7qNK4uA==
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id p1-20020a05600c204100b003fa78083e16mr7954040wmg.29.1687793787831;
        Mon, 26 Jun 2023 08:36:27 -0700 (PDT)
Received: from redhat.com ([2.52.141.236])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bcb98000000b003f727764b10sm8134888wmi.4.2023.06.26.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:36:27 -0700 (PDT)
Date: Mon, 26 Jun 2023 11:36:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: syzbot <syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com>,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux-foundation.org
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read
 in __vhost_vq_attach_worker
Message-ID: <20230626113540-mutt-send-email-mst@kernel.org>
References: <000000000000df3e3b05ff02fe20@google.com>
 <20230626031411-mutt-send-email-mst@kernel.org>
 <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 10:03:25AM -0500, Mike Christie wrote:
> On 6/26/23 2:15 AM, Michael S. Tsirkin wrote:
> > On Mon, Jun 26, 2023 at 12:06:54AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    8d2be868b42c Add linux-next specific files for 20230623
> >> git tree:       linux-next
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12872950a80000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8ac8dd33677e8e0
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=8540db210d403f1aa214
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c1b70f280000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122ee4cb280000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/2a004483aca3/disk-8d2be868.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/5688cb13b277/vmlinux-8d2be868.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/76de0b63bc53/bzImage-8d2be868.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit 21a18f4a51896fde11002165f0e7340f4131d6a0
> >> Author: Mike Christie <michael.christie@oracle.com>
> >> Date:   Tue Jun 13 01:32:46 2023 +0000
> >>
> >>     vhost: allow userspace to create workers
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130850bf280000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=108850bf280000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=170850bf280000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com
> >> Fixes: 21a18f4a5189 ("vhost: allow userspace to create workers")
> > 
> > Mike, would appreciate prompt attention to this as I am preparing
> > a pull request for the merge window and need to make a
> > decision on whether to include your userspace-controlled
> > threading patchset.
> > 
> 
> Do you want me to resubmit the patchset or submit a patch against your vhost
> branch?

Resubmit pls.

> The bug is that vhost-net can call vhost_dev_reset_owner and that will
> free the workers. However, I leave the virtqueue->worker pointer set so
> we end up referencing the freed workers later on. When I handled a
> review comment between v5 and v6, I deleted that code thinking it was
> also not needed.
> 
> So the fix is:
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ab79b064aade..5a07e220e46d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -607,6 +607,10 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  
>  	if (!dev->use_worker)
>  		return;
> +
> +	for (i = 0; i < dev->nvqs; i++)
> +		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).
> 
> 


