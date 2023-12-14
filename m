Return-Path: <netdev+bounces-57343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8556B812E8C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE731C209D4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5613FB35;
	Thu, 14 Dec 2023 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlxKhC9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0BA7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:30:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcd44cdca3so1578461276.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702553443; x=1703158243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1Xn5PCqq+HNe5tE3ALtwtTuvdmYIjwsXdr+nvtNHAA=;
        b=qlxKhC9fX+R6WQcRh2YWxAk2apJePgf6t78w4RFTgrMwpz4CUqQ4ZkRp9W5IxSAAc8
         efP4cjr9sKvSHNfS8UIfGKvOH7ptbxfAL5IL+dRA1SbQnLslNVuoUu3MCDpWnbmW/7G2
         FTKvDWB2ED+Jul0jlQ/m/SPMTHHSFv4PW1g7WIUclbxwRxllhiNkn5QV/OjY+Vpif9RV
         dqwDfnU/1JlkRSggcCB7PrM0MAKDmWkTWkmiQsyKHPc+Cwf4C/ekb4i36SY1D05Xu2UE
         mpH31RO8io2x7tpKaSpC21NAi2pjj7jOzPy7IpI1mD3grCXBuK1aCvXc9zmly6JZWQ+/
         qoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553443; x=1703158243;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1Xn5PCqq+HNe5tE3ALtwtTuvdmYIjwsXdr+nvtNHAA=;
        b=rwHMqUo7F9tYmdJRtBz0FXf9QoUtBLohddYkJVs9c0fRkwRblwjfOs701yGlsgekXP
         XPSZSzvHOr7Ea8RAGnGP3ammoXu+/qSQlwaKpB5j3r1vb7WEd0NOa66jI/nK+vmF3+KG
         VgBt+59rr98+2Wp4ksA1+6LOVdfr2+WRpRN9u1V5h/cHLbWSgnEBvNkLu6Mj1L/zU66+
         WwzrKDnWfoh8ejWE6Py/LvPIH88C0bL2JkPn04MCwYLLImkIUd8TRELIk8ZMHw+S6zlL
         dmt88DzNrH8rYCYvz9mVqnDcJBAHsoZp1CUtCFDCXStzOd7IUKadlMrGUcoFbbCBZmRU
         QJ5A==
X-Gm-Message-State: AOJu0YxA9OdfBGGRWsXNH+X7ewsfUhY4Bapu8kJ4T1B1r04pHanLWPVY
	vtPXO/wONKJLmHWWhafYw8rbvRJu+Z81yA==
X-Google-Smtp-Source: AGHT+IGW3oO5Hwd+449430NxTg7eY0DkQpa1A+A7K3gi1Upqrgs8t4GOaSyRn6RQe6hTZvhLtKBV7q8lbntCCw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:bf92:0:b0:dbc:d3fd:ac61 with SMTP id
 l18-20020a25bf92000000b00dbcd3fdac61mr38638ybk.12.1702553443405; Thu, 14 Dec
 2023 03:30:43 -0800 (PST)
Date: Thu, 14 Dec 2023 11:30:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214113038.1470494-1-edumazet@google.com>
Subject: [PATCH net] net: sched: ife: fix potential use-after-free
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Alexander Aring <aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"

ife_decode() calls pskb_may_pull() two times, we need to reload
ifehdr after the second one, or risk use-after-free as reported
by syzbot:

BUG: KASAN: slab-use-after-free in __ife_tlv_meta_valid net/ife/ife.c:108 [inline]
BUG: KASAN: slab-use-after-free in ife_tlv_meta_decode+0x1d1/0x210 net/ife/ife.c:131
Read of size 2 at addr ffff88802d7300a4 by task syz-executor.5/22323

CPU: 0 PID: 22323 Comm: syz-executor.5 Not tainted 6.7.0-rc3-syzkaller-00804-g074ac38d5b95 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:364 [inline]
print_report+0xc4/0x620 mm/kasan/report.c:475
kasan_report+0xda/0x110 mm/kasan/report.c:588
__ife_tlv_meta_valid net/ife/ife.c:108 [inline]
ife_tlv_meta_decode+0x1d1/0x210 net/ife/ife.c:131
tcf_ife_decode net/sched/act_ife.c:739 [inline]
tcf_ife_act+0x4e3/0x1cd0 net/sched/act_ife.c:879
tc_act include/net/tc_wrapper.h:221 [inline]
tcf_action_exec+0x1ac/0x620 net/sched/act_api.c:1079
tcf_exts_exec include/net/pkt_cls.h:344 [inline]
mall_classify+0x201/0x310 net/sched/cls_matchall.c:42
tc_classify include/net/tc_wrapper.h:227 [inline]
__tcf_classify net/sched/cls_api.c:1703 [inline]
tcf_classify+0x82f/0x1260 net/sched/cls_api.c:1800
hfsc_classify net/sched/sch_hfsc.c:1147 [inline]
hfsc_enqueue+0x315/0x1060 net/sched/sch_hfsc.c:1546
dev_qdisc_enqueue+0x3f/0x230 net/core/dev.c:3739
__dev_xmit_skb net/core/dev.c:3828 [inline]
__dev_queue_xmit+0x1de1/0x3d30 net/core/dev.c:4311
dev_queue_xmit include/linux/netdevice.h:3165 [inline]
packet_xmit+0x237/0x350 net/packet/af_packet.c:276
packet_snd net/packet/af_packet.c:3081 [inline]
packet_sendmsg+0x24aa/0x5200 net/packet/af_packet.c:3113
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
__sys_sendto+0x255/0x340 net/socket.c:2190
__do_sys_sendto net/socket.c:2202 [inline]
__se_sys_sendto net/socket.c:2198 [inline]
__x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe9acc7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe9ada450c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fe9acd9bf80 RCX: 00007fe9acc7cae9
RDX: 000000000000fce0 RSI: 00000000200002c0 RDI: 0000000000000003
RBP: 00007fe9accc847a R08: 0000000020000140 R09: 0000000000000014
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe9acd9bf80 R15: 00007ffd5427ae78
</TASK>

Allocated by task 22323:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
____kasan_kmalloc mm/kasan/common.c:374 [inline]
__kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
kasan_kmalloc include/linux/kasan.h:198 [inline]
__do_kmalloc_node mm/slab_common.c:1007 [inline]
__kmalloc_node_track_caller+0x5a/0x90 mm/slab_common.c:1027
kmalloc_reserve+0xef/0x260 net/core/skbuff.c:582
__alloc_skb+0x12b/0x330 net/core/skbuff.c:651
alloc_skb include/linux/skbuff.h:1298 [inline]
alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6331
sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2780
packet_alloc_skb net/packet/af_packet.c:2930 [inline]
packet_snd net/packet/af_packet.c:3024 [inline]
packet_sendmsg+0x1e2a/0x5200 net/packet/af_packet.c:3113
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
__sys_sendto+0x255/0x340 net/socket.c:2190
__do_sys_sendto net/socket.c:2202 [inline]
__se_sys_sendto net/socket.c:2198 [inline]
__x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 22323:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
____kasan_slab_free mm/kasan/common.c:236 [inline]
____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
kasan_slab_free include/linux/kasan.h:164 [inline]
slab_free_hook mm/slub.c:1800 [inline]
slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
slab_free mm/slub.c:3809 [inline]
__kmem_cache_free+0xc0/0x180 mm/slub.c:3822
skb_kfree_head net/core/skbuff.c:950 [inline]
skb_free_head+0x110/0x1b0 net/core/skbuff.c:962
pskb_expand_head+0x3c5/0x1170 net/core/skbuff.c:2130
__pskb_pull_tail+0xe1/0x1830 net/core/skbuff.c:2655
pskb_may_pull_reason include/linux/skbuff.h:2685 [inline]
pskb_may_pull include/linux/skbuff.h:2693 [inline]
ife_decode+0x394/0x4f0 net/ife/ife.c:82
tcf_ife_decode net/sched/act_ife.c:727 [inline]
tcf_ife_act+0x43b/0x1cd0 net/sched/act_ife.c:879
tc_act include/net/tc_wrapper.h:221 [inline]
tcf_action_exec+0x1ac/0x620 net/sched/act_api.c:1079
tcf_exts_exec include/net/pkt_cls.h:344 [inline]
mall_classify+0x201/0x310 net/sched/cls_matchall.c:42
tc_classify include/net/tc_wrapper.h:227 [inline]
__tcf_classify net/sched/cls_api.c:1703 [inline]
tcf_classify+0x82f/0x1260 net/sched/cls_api.c:1800
hfsc_classify net/sched/sch_hfsc.c:1147 [inline]
hfsc_enqueue+0x315/0x1060 net/sched/sch_hfsc.c:1546
dev_qdisc_enqueue+0x3f/0x230 net/core/dev.c:3739
__dev_xmit_skb net/core/dev.c:3828 [inline]
__dev_queue_xmit+0x1de1/0x3d30 net/core/dev.c:4311
dev_queue_xmit include/linux/netdevice.h:3165 [inline]
packet_xmit+0x237/0x350 net/packet/af_packet.c:276
packet_snd net/packet/af_packet.c:3081 [inline]
packet_sendmsg+0x24aa/0x5200 net/packet/af_packet.c:3113
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
__sys_sendto+0x255/0x340 net/socket.c:2190
__do_sys_sendto net/socket.c:2202 [inline]
__se_sys_sendto net/socket.c:2198 [inline]
__x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88802d730000
which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 164 bytes inside of
freed 8192-byte region [ffff88802d730000, ffff88802d732000)

The buggy address belongs to the physical page:
page:ffffea0000b5cc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d730
head:ffffea0000b5cc00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013042280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 22323, tgid 22320 (syz-executor.5), ts 950317230369, free_ts 950233467461
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1544
prep_new_page mm/page_alloc.c:1551 [inline]
get_page_from_freelist+0xa28/0x3730 mm/page_alloc.c:3319
__alloc_pages+0x22e/0x2420 mm/page_alloc.c:4575
alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
alloc_slab_page mm/slub.c:1870 [inline]
allocate_slab mm/slub.c:2017 [inline]
new_slab+0x283/0x3c0 mm/slub.c:2070
___slab_alloc+0x979/0x1500 mm/slub.c:3223
__slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
__slab_alloc_node mm/slub.c:3375 [inline]
slab_alloc_node mm/slub.c:3468 [inline]
__kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
__do_kmalloc_node mm/slab_common.c:1006 [inline]
__kmalloc_node_track_caller+0x4a/0x90 mm/slab_common.c:1027
kmalloc_reserve+0xef/0x260 net/core/skbuff.c:582
__alloc_skb+0x12b/0x330 net/core/skbuff.c:651
alloc_skb include/linux/skbuff.h:1298 [inline]
alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6331
sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2780
packet_alloc_skb net/packet/af_packet.c:2930 [inline]
packet_snd net/packet/af_packet.c:3024 [inline]
packet_sendmsg+0x1e2a/0x5200 net/packet/af_packet.c:3113
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
__sys_sendto+0x255/0x340 net/socket.c:2190
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1144 [inline]
free_unref_page_prepare+0x53c/0xb80 mm/page_alloc.c:2354
free_unref_page+0x33/0x3b0 mm/page_alloc.c:2494
__unfreeze_partials+0x226/0x240 mm/slub.c:2655
qlink_free mm/kasan/quarantine.c:168 [inline]
qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
__kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
kasan_slab_alloc include/linux/kasan.h:188 [inline]
slab_post_alloc_hook mm/slab.h:763 [inline]
slab_alloc_node mm/slub.c:3478 [inline]
slab_alloc mm/slub.c:3486 [inline]
__kmem_cache_alloc_lru mm/slub.c:3493 [inline]
kmem_cache_alloc_lru+0x219/0x6f0 mm/slub.c:3509
alloc_inode_sb include/linux/fs.h:2937 [inline]
ext4_alloc_inode+0x28/0x650 fs/ext4/super.c:1408
alloc_inode+0x5d/0x220 fs/inode.c:261
new_inode_pseudo fs/inode.c:1006 [inline]
new_inode+0x22/0x260 fs/inode.c:1032
__ext4_new_inode+0x333/0x5200 fs/ext4/ialloc.c:958
ext4_symlink+0x5d7/0xa20 fs/ext4/namei.c:3398
vfs_symlink fs/namei.c:4464 [inline]
vfs_symlink+0x3e5/0x620 fs/namei.c:4448
do_symlinkat+0x25f/0x310 fs/namei.c:4490
__do_sys_symlinkat fs/namei.c:4506 [inline]
__se_sys_symlinkat fs/namei.c:4503 [inline]
__x64_sys_symlinkat+0x97/0xc0 fs/namei.c:4503
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82

Fixes: d57493d6d1be ("net: sched: ife: check on metadata length")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alexander Aring <aahringo@redhat.com>
---
 net/ife/ife.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ife/ife.c b/net/ife/ife.c
index 13bbf8cb6a3961d422d01cf5b16a724d16107419..be05b690b9ef29b3541e45af02f86f53b4b9681a 100644
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -82,6 +82,7 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	if (unlikely(!pskb_may_pull(skb, total_pull)))
 		return NULL;
 
+	ifehdr = (struct ifeheadr *)(skb->data + skb->dev->hard_header_len);
 	skb_set_mac_header(skb, total_pull);
 	__skb_pull(skb, total_pull);
 	*metalen = ifehdrln - IFE_METAHDRLEN;
-- 
2.43.0.472.g3155946c3a-goog


