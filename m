Return-Path: <netdev+bounces-19283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C48675A2AB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F9A1C21204
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6F2516F;
	Wed, 19 Jul 2023 23:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2422F03
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 23:12:35 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC401701;
	Wed, 19 Jul 2023 16:12:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qMGL1-0003Yx-B2; Thu, 20 Jul 2023 01:12:07 +0200
Date: Thu, 20 Jul 2023 01:12:07 +0200
From: Florian Westphal <fw@strlen.de>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>,
	dsterba@suse.cz, bakmitopiacibubur@boga.indosterling.com,
	clm@fb.com, davem@davemloft.net, dsahern@kernel.org,
	dsterba@suse.com, fw@strlen.de, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, josef@toxicpanda.com, kadlec@netfilter.org,
	kuba@kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux@armlinux.org.uk,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
	yoshfuji@linux-ipv6.org
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
 low! (2)
Message-ID: <20230719231207.GF32192@breakpoint.cc>
References: <20230719170446.GR20457@twin.jikos.cz>
 <00000000000042a3ac0600da1f69@google.com>
 <CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,PLING_QUERY,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Aleksandr Nogikh <nogikh@google.com> wrote:
> On Wed, Jul 19, 2023 at 7:11 PM syzbot
> <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com> wrote:
> >
> > > On Wed, Jul 19, 2023 at 02:32:51AM -0700, syzbot wrote:
> > >> syzbot has found a reproducer for the following issue on:
> > >>
> > >> HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
> > >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=15d92aaaa80000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
> > >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >> userspace arch: arm64
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b2d66a80000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214348aa80000
> > >>
> > >> Downloadable assets:
> > >> disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
> > >> vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
> > >> kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz
> > >
> > > #syz unset btrfs
> >
> > The following labels did not exist: btrfs
> 
> #syz set subsystems: netfilter

I don't see any netfilter involvement here.

The repro just creates a massive amount of team devices.

At the time it hits the LOCKDEP limits on my test vm it has
created ~2k team devices, system load is at +14 because udev
is also busy spawing hotplug scripts for the new devices.

After reboot and suspending the running reproducer after about 1500
devices (before hitting lockdep limits), followed by 'ip link del' for
the team devices gets the lockdep entries down to ~8k (from 40k),
which is in the range that it has on this VM after a fresh boot.

So as far as I can see this workload is just pushing lockdep
past what it can handle with the configured settings and is
not triggering any actual bug.

