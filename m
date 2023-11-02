Return-Path: <netdev+bounces-45696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A07DF110
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDEF281A0E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA814273;
	Thu,  2 Nov 2023 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qFV8+5Ty"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0954748D
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:22:40 +0000 (UTC)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B7130;
	Thu,  2 Nov 2023 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698924147; bh=lVOBvHt9zIFFdmAYgkwcxc6AlYZJbPyqXFwtdBEFouU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qFV8+5TyT+YhQSTVs/iJITGhXqC1wlkBJ5N5uCDf8UYvwxvxzpsQtTU29S4x/WnLm
	 KfDuCT/AktW9EHmlD0hXykoAV/VfnoMevAznLQMHK8oKOqS+T0HoWdVmc+NkfUTLp2
	 UhkREsY72/t7LV0zvKpIN36Agw3At/oRXJkPQ1Og=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 41099A67; Thu, 02 Nov 2023 19:16:16 +0800
X-QQ-mid: xmsmtpt1698923776tkbu0ofz9
Message-ID: <tencent_ACEACCAC786A6F282DF16DCC95C8E852ED0A@qq.com>
X-QQ-XMAILINFO: NDz66ktblfzJ8++Qa9dsQEmaOm3y7ajJVx5KyHbFHKfvTts5cU0E525/EP+I+S
	 on1d5cESFt45GNPu+vQMuH8MJ2fAoG/DLb6iXV12kh10yrfZBoswkT4nA7ey6iS7RVL3yCYuhSgD
	 btNnEXJEJ3EQ7PW2yz6AY/ZdRgVcIZzNc8lLh+C5pXsDBphPnm8NAoGkySBgnw+FEBVPGNvu0p3F
	 6S8SqBsjlaYper74Psr04NBVqRnmmE6/GnUVpMu/Weq8iyxwn4/Pj80du4NufVzQPg7CYMI5LT0B
	 rzGvIj2VGUYV1hcQ8bgjlMHimhQ4NVSBGEzNbGnq/XCYatfAMT3fUMoMWWcQhDFp3MbP82XGIEYG
	 aK2OKp6RD0aUc4cIJzJctXGdnCoJYJYxyYjJ2FuRPA89CxBrD+tctbu6qzyNgu+D8scTP0Yg/yNd
	 p0LjLkYAfYn2ILW//c4e694CiOiLt1zYUf/WRS3EtcWpAn7jYF+G+hbr6rDxdIip/TTIFk8ORl0J
	 VjeW6s1SYFmDMeeRhKpuku76YlIK9z2g8FL4u6I401HpQAoWRxcM7nCyu9XnMCWtsCiFdERA3KE6
	 WYHkhSeCHCKufA62La5/x55RC5iTVLGvzCKWKAK7sRiTquI4qwrUyg2veWPJh4GjHTgfihaAvNs9
	 PVl6I1uYyLPZ6M+P4Ia5hqyIvDkl/KbvsSMwYZng+3w9ZEHE4/qMZ53z4+S+n4Ac9hlmo19GUzhb
	 qRfWeBFNAjfVS2dqJtS33vXcrMerL1uDCP6T7UO5HCtR+BChD0nrfzDyRMUapMTOonVEBS33A18l
	 wxSLl/F1VzoV5uDwEmqdj/dJqcF2tNmBVpSWLIeld9xMLB1cpGPzxJZr984gx8FumusF65U2pTS6
	 7WUJKxb9uWfQy8RRiaeObCGlWgYwSMk2nZ84LHTtLnDOArw6cv1oboeuhJF6IOoF66SfJ3JwuunJ
	 el7PwGC6o=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Date: Thu,  2 Nov 2023 19:16:17 +0800
X-OQ-MSGID: <20231102111616.227805-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZULphe-5N0M5x_Kk@hoboy.vegasvil.org>
References: <ZULphe-5N0M5x_Kk@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 Nov 2023 17:12:53 -0700 Richard Cochran wrote:
>> There is no lock protection when writing ptp->tsevqs in ptp_open(),
>> ptp_release(), which can cause data corruption,
>
>Really?  How?
Let me show the corruption that occurs in ptp_open() and ptp_release(), 

1. Corruption that appears in ptp_open(),
Link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911

list_add corruption. prev->next should be next (ffff88814a1325e8), but was ffff888078d25048. (prev=ffff888078d21048).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:32!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7237 Comm: syz-executor182 Not tainted 6.6.0-rc6-next-20231020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__list_add_valid_or_report+0xb6/0x100 lib/list_debug.c:32
Code: e8 2f a5 3a fd 0f 0b 48 89 d9 48 c7 c7 40 9d e9 8a e8 1e a5 3a fd 0f 0b 48 89 f1 48 c7 c7 c0 9d e9 8a 48 89 de e8 0a a5 3a fd <0f> 0b 48 89 f2 48 89 d9 48 89 ee 48 c7 c7 40 9e e9 8a e8 f3 a4 3a
RSP: 0018:ffffc90009b3f898 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88814a1325e8 RCX: ffffffff816bb8d9
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: ffff88807c7a9048 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88814a132000
R13: ffffc90009b3f900 R14: ffff888078d21048 R15: ffff88807c7a9048
FS:  0000555556c00380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef0aa1138 CR3: 000000007d17e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 ptp_open+0x1c5/0x4f0 drivers/ptp/ptp_chardev.c:122
 posix_clock_open+0x17e/0x240 kernel/time/posix-clock.c:134
 chrdev_open+0x26d/0x6e0 fs/char_dev.c:414
 do_dentry_open+0x8d4/0x18d0 fs/open.c:948
 do_open fs/namei.c:3621 [inline]
 path_openat+0x1d36/0x2cd0 fs/namei.c:3778
 do_filp_open+0x1dc/0x430 fs/namei.c:3808
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fc6c2099ae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef0aa1238 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc6c2099ae9
RDX: 0000000000000000 RSI: 0000000020000300 RDI: ffffffffffffff9c
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000130fc
R13: 00007ffef0aa124c R14: 00007ffef0aa1260 R15: 00007ffef0aa1250
 </TASK>

2. Corruption that appears in ptp_open(),
Link: https://syzkaller.appspot.com/x/log.txt?x=169a58d1680000

list_del corruption. prev->next should be ffff8880280e5048, but was ffff888025dc1048. (prev=ffff88814adb1048)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:62!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13142 Comm: syz-executor.2 Not tainted 6.6.0-rc6-next-20231018-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__list_del_entry_valid_or_report+0x11f/0x1b0
Code: 8f e9 8a e8 c3 d3 3a fd 0f 0b 48 89 ca 48 c7 c7 e0 8f e9 8a e8 b2 d3 3a fd 0f 0b 48 89 c2 48 c7 c7 40 90 e9 8a e8 a1 d3 3a fd <0f> 0b 48 89 d1 48 c7 c7 c0 90 e9 8a 48 89 c2 e8 8d d3 3a fd 0f 0b
RSP: 0018:ffffc90003167e08 EFLAGS: 00010086
RAX: 000000000000006d RBX: ffff8880280e4000 RCX: ffffffff816b9cd9
RDX: 0000000000000000 RSI: ffffffff816c3142 RDI: 0000000000000005
RBP: ffff888023b7c480 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000293
R13: ffff8880280e5008 R14: ffff8880280e5048 R15: ffff8880280e5050
FS:  00005555557e3480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f350fd98000 CR3: 000000002427a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ptp_release+0xca/0x2a0
 posix_clock_release+0xa4/0x160
 __fput+0x270/0xbb0
 __fput_sync+0x47/0x50
 __x64_sys_close+0x87/0xf0
 do_syscall_64+0x3f/0x110
 entry_SYSCALL_64_after_hwframe+0x63/0x6b 


The above two logs can clearly indicate that there is corruption when 
executing the operation of writing ptp->tsevqs in ptp_open() and ptp_release().
>
>> use mutex lock to avoid this
>> issue.
>>
>> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
>> and it should be deleted together.
>>
>> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
>> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>  drivers/ptp/ptp_chardev.c | 11 +++++++++--
>>  drivers/ptp/ptp_clock.c   |  3 +++
>>  drivers/ptp/ptp_private.h |  1 +
>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
>> index 282cd7d24077..e31551d2697d 100644
>> --- a/drivers/ptp/ptp_chardev.c
>> +++ b/drivers/ptp/ptp_chardev.c
>> @@ -109,6 +109,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>>  	struct timestamp_event_queue *queue;
>>  	char debugfsname[32];
>>
>> +	if (mutex_lock_interruptible(&ptp->tsevq_mux))
>> +		return -ERESTARTSYS;
>> +
>
>This mutex is not needed.
>
>Please don't ignore review comments.

Thanks,
edward


