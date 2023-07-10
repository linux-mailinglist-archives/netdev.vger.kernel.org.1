Return-Path: <netdev+bounces-16619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62674E04E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FFB28133E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED8A16407;
	Mon, 10 Jul 2023 21:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE7156F4
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:36:23 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB29E0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:36:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666ecb21fb8so8427486b3a.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689024981; x=1691616981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QG81dWOU8+2ZMkJte6cgGvEOzd5BwfWPVokHYZjTCI=;
        b=YVhfLbBTU4JQlqdFpX2Ac0IgNx/KSHgY/Ejx2BdoDE/MLijjJYYMBBwq6Ge8MevxjD
         EEfd4626N9pgSJJiqdeOyu1+EHmFMw8fh/GUKqiT8HvaQg6JVVwKxh1wrSdJzin4Vr/Z
         JV6Y9FF44gvlIobv+bgjxcKa2uDrZzEL293g2lXwFqZjK1zbfG4NGPMkepmdk89iC3IZ
         TU4S/lHGUj4LFO6qvZ5xNXoauDexLCzPXYDFBWH4XSfxBvpFTA65emmBgFfDntbIv3vc
         JQwRFFdb8TwKqE3lpN8gtn96Go4HkixsjBHYumLD9yaYpGrMNXgoP9XKL5KhyvIlrZ1s
         OpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689024981; x=1691616981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QG81dWOU8+2ZMkJte6cgGvEOzd5BwfWPVokHYZjTCI=;
        b=CRObVlYlpA61uF9CHMGDqkxrVSmm+PcxXnyLSa8MMxTYMXWP5IM1oBnTPcNB4lTz2E
         GIPlBS/u8qWrhJGFYZRqYzoxRBEWjThoHSZ+jf/FYg4cQ06mgnhFtWpaFSFrZGgdCd8O
         FbI+jqw7zs25tGe0FLTYquH2b5E+6THb+kVR/DsVlTQLW/tKZnF9Y0gNsbS7ijmFPQgS
         O/4q47evqozYSAC8CVbdHqJhK3cpsJKv6Y8LSqrrEIFPEgPOXazduwTb9LUuT6btJ7c/
         tYeaR47xE0OdNuZlUWDEBOZtj3DB+eAiNUFkh13FBtqeAbzfnt3wksZ7c9dIQPA3kWzE
         RY9A==
X-Gm-Message-State: ABy/qLZBqwhbHDWpw+lq1BS3FNh4L3cw68BdDs9dn6rw1YTthCCryEfL
	Ey7tSHQzqzaoZbuc8IWwRS576nCwGI4=
X-Google-Smtp-Source: APBJJlHIuDFrwsAjRxk1OL9H4JWUY+yazFv9EjV7KH84+DIRy01I9YCDp3Q6Nc1wAFBQaSPiE5gAOrH7j9k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2392:b0:674:1663:1283 with SMTP id
 f18-20020a056a00239200b0067416631283mr18725049pfc.1.1689024981471; Mon, 10
 Jul 2023 14:36:21 -0700 (PDT)
Date: Mon, 10 Jul 2023 14:36:19 -0700
In-Reply-To: <20230626113540-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000df3e3b05ff02fe20@google.com> <20230626031411-mutt-send-email-mst@kernel.org>
 <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com> <20230626113540-mutt-send-email-mst@kernel.org>
Message-ID: <ZKx509XelfwPIkhX@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in __vhost_vq_attach_worker
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, 
	syzbot <syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com>, jasowang@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023, Michael S. Tsirkin wrote:
> On Mon, Jun 26, 2023 at 10:03:25AM -0500, Mike Christie wrote:
> > On 6/26/23 2:15 AM, Michael S. Tsirkin wrote:
> > > On Mon, Jun 26, 2023 at 12:06:54AM -0700, syzbot wrote:
> > >> Hello,
> > >>
> > >> syzbot found the following issue on:
> > >>
> > >> HEAD commit:    8d2be868b42c Add linux-next specific files for 20230623
> > >> git tree:       linux-next
> > >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12872950a80000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8ac8dd33677e8e0
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=8540db210d403f1aa214
> > >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c1b70f280000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122ee4cb280000
> > >>
> > >> Downloadable assets:
> > >> disk image: https://storage.googleapis.com/syzbot-assets/2a004483aca3/disk-8d2be868.raw.xz
> > >> vmlinux: https://storage.googleapis.com/syzbot-assets/5688cb13b277/vmlinux-8d2be868.xz
> > >> kernel image: https://storage.googleapis.com/syzbot-assets/76de0b63bc53/bzImage-8d2be868.xz
> > >>
> > >> The issue was bisected to:
> > >>
> > >> commit 21a18f4a51896fde11002165f0e7340f4131d6a0
> > >> Author: Mike Christie <michael.christie@oracle.com>
> > >> Date:   Tue Jun 13 01:32:46 2023 +0000
> > >>
> > >>     vhost: allow userspace to create workers
> > >>
> > >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130850bf280000
> > >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=108850bf280000
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=170850bf280000
> > >>
> > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >> Reported-by: syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com
> > >> Fixes: 21a18f4a5189 ("vhost: allow userspace to create workers")
> > > 
> > > Mike, would appreciate prompt attention to this as I am preparing
> > > a pull request for the merge window and need to make a
> > > decision on whether to include your userspace-controlled
> > > threading patchset.
> > > 
> > 
> > Do you want me to resubmit the patchset or submit a patch against your vhost
> > branch?
> 
> Resubmit pls.

Closing this out from syzbot's perspective since v9 (now in linux-next and Linus'
tree) added back Mike's fix.

#syz invalid

