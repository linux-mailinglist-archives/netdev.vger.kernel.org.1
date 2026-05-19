Return-Path: <netdev+bounces-289523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKzTBLGRDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:37:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE85827C3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63F67302D2D3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110754963D2;
	Tue, 19 May 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu9oHfdj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9032B116
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208623; cv=none; b=A6ZGwVUjNTuNQc9RO0NqWM7dvwlWCMaiRUfUILguBHh7HqKNjYi6M0YQ0zHf7Sfc6R7eXouUn6VVR/IgSRZ83+R8dbF100uldV791khF4UvqwOeYGJfeKXpvSf3EHzWUvwWf1DsG0iBqfzb1gQG7+Fe6WFzW6sCDE1bliYt7/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208623; c=relaxed/simple;
	bh=c6rnsHTmOJn0HT8PUgVoUt7XbqOT8KHaZCwIa3vNCl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYYQ1wxMh7FNZ+n5WyWsJgynoU+e4QGBy8sZP+SW0hntxkdzuVSmTFKarY8gBUxQBfZJpdLbQFZ+WBU92zOAuIE59QT6bLV/hJnbUfpX5SQpqnqt1CVnNHKOVURWJtmWfFqB4hCBQB+XKXoDg7sydzg1G9WDP4B1si9jsnPTGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu9oHfdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33981C2BCB3;
	Tue, 19 May 2026 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208622;
	bh=c6rnsHTmOJn0HT8PUgVoUt7XbqOT8KHaZCwIa3vNCl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qu9oHfdjCFrW9Ou0KBbJ3gO0LAao8zy7JE7CXaNGz4IFMextrzzih33f6A3R1AmXT
	 rWAXw53Pq4wKfaZPsTBNxfm2XBe/A/qnbztl1wfCbkvStcTIDZkQC9Ef0LB9xNSD6v
	 kXD7hUWLdac/nSE2/PFReZicugXn8s6Ief4lelufzqKzHdBs/OLBy6FApJcMI6kf1d
	 ssQyrMYzDRq4GFmmF6CHD6Mxqw9MkkVmRPeR3ENCgctfg4/v+dZR/FqI0L+idG2wL7
	 JwgalNlCH5qP9mr80b8fb9Jc7CPTMrCyiT2lNQOtIJRrYxpXyRsEgDucazNJE73ZvH
	 vNwDYpgf7nUBg==
Date: Tue, 19 May 2026 09:37:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/2] rtnetlink: RTNL avoidance in
 rtnl_getlink()
Message-ID: <20260519093701.582b820d@kernel.org>
In-Reply-To: <20260519114355.2769474-1-edumazet@google.com>
References: <20260519114355.2769474-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289523-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6BE85827C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 11:43:53 +0000 Eric Dumazet wrote:
> Many shell scripts invoke iproute2 commands specifying a device by
> its name.
> 
> This series improves their performance avoiding RTNL acquisition
> for their (repeated) name->index conversion.

Hm.

[ 1414.868166][T10284] BUG: KASAN: slab-use-after-free in rtnl_fill_prop_list+0x5c0/0x620
[ 1414.868291][T10284] Read of size 8 at addr ff11000001d2c150 by task (udev-worker)/10284
[ 1414.868404][T10284] 
[ 1414.868445][T10284] CPU: 2 UID: 0 PID: 10284 Comm: (udev-worker) Not tainted 7.1.0-rc3-virtme #1 PREEMPT(full) 
[ 1414.868448][T10284] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1414.868450][T10284] Call Trace:
[ 1414.868452][T10284]  <TASK>
[ 1414.868453][T10284]  dump_stack_lvl+0x6f/0xa0
[ 1414.868459][T10284]  print_address_description.constprop.0+0x56/0x2d0
[ 1414.868464][T10284]  print_report+0xfc/0x1fa
[ 1414.868466][T10284]  ? __virt_addr_valid+0x102/0x440
[ 1414.868470][T10284]  ? __virt_addr_valid+0x1da/0x440
[ 1414.868472][T10284]  kasan_report+0x108/0x130
[ 1414.868475][T10284]  ? rtnl_fill_prop_list+0x5c0/0x620
[ 1414.868477][T10284]  ? rtnl_fill_prop_list+0x5c0/0x620
[ 1414.868479][T10284]  rtnl_fill_prop_list+0x5c0/0x620
[ 1414.868480][T10284]  ? __asan_memcpy+0x3c/0x60
[ 1414.868482][T10284]  rtnl_fill_ifinfo.isra.0+0x3d6/0x2c90
[ 1414.868484][T10284]  ? rcu_read_lock_any_held+0x3c/0x90
[ 1414.868487][T10284]  ? validate_chain+0x38b/0xc20
[ 1414.868490][T10284]  ? rtnl_fill_vf+0x460/0x460
[ 1414.868491][T10284]  ? lockdep_hardirqs_on_prepare.part.0+0x9a/0x160
[ 1414.868493][T10284]  ? lockdep_hardirqs_on+0x8c/0x130
[ 1414.868496][T10284]  ? __lock_acquire+0x508/0xc10
[ 1414.868498][T10284]  ? lock_acquire.part.0+0xbc/0x260
[ 1414.868499][T10284]  ? find_held_lock+0x2b/0x80
[ 1414.868502][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
[ 1414.868504][T10284]  ? mark_held_locks+0x40/0x70
[ 1414.868505][T10284]  ? lockdep_hardirqs_on_prepare.part.0+0x9a/0x160
[ 1414.868507][T10284]  ? lockdep_hardirqs_on+0x8c/0x130
[ 1414.868508][T10284]  ? _raw_spin_unlock_irqrestore+0x53/0x80
[ 1414.868510][T10284]  rtnl_getlink+0xa48/0xe50
[ 1414.868513][T10284]  ? find_held_lock+0x2b/0x80
[ 1414.868515][T10284]  ? rtnl_dump_ifinfo+0xfb0/0xfb0
[ 1414.868516][T10284]  ? mark_usage+0x61/0x170
[ 1414.868517][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
[ 1414.868518][T10284]  ? __lock_acquire+0x508/0xc10
[ 1414.868525][T10284]  ? lock_acquire.part.0+0xbc/0x260
[ 1414.868526][T10284]  ? find_held_lock+0x2b/0x80
[ 1414.868529][T10284]  ? mark_usage+0x61/0x170
[ 1414.868530][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
[ 1414.868531][T10284]  ? __lock_acquire+0x508/0xc10
[ 1414.868532][T10284]  ? bpf_address_lookup+0x232/0x290
[ 1414.868536][T10284]  ? lock_acquire.part.0+0xbc/0x260
[ 1414.868537][T10284]  ? find_held_lock+0x2b/0x80
[ 1414.868539][T10284]  ? rtnl_dump_ifinfo+0xfb0/0xfb0
[ 1414.868540][T10284]  ? __lock_release.isra.0+0x6b/0x1a0
[ 1414.868542][T10284]  ? rtnl_dump_ifinfo+0xfb0/0xfb0
[ 1414.868543][T10284]  rtnetlink_rcv_msg+0x6fd/0xbd0
[ 1414.868545][T10284]  ? validate_chain+0x38b/0xc20
[ 1414.868546][T10284]  ? rtnl_link_fill+0x920/0x920
[ 1414.868547][T10284]  ? __lock_acquire+0x508/0xc10
[ 1414.868549][T10284]  ? lock_acquire.part.0+0xbc/0x260
[ 1414.868551][T10284]  ? find_held_lock+0x2b/0x80
[ 1414.868553][T10284]  netlink_rcv_skb+0x14e/0x3a0
[ 1414.868556][T10284]  ? rtnl_link_fill+0x920/0x920
[ 1414.868558][T10284]  ? netlink_ack+0xce0/0xce0
[ 1414.868560][T10284]  ? netlink_deliver_tap+0xc5/0x330
[ 1414.868562][T10284]  ? netlink_deliver_tap+0x13c/0x330
[ 1414.868564][T10284]  netlink_unicast+0x47c/0x740
[ 1414.868566][T10284]  ? netlink_attachskb+0x800/0x800
[ 1414.868568][T10284]  ? __lock_acquire+0x508/0xc10
[ 1414.868570][T10284]  netlink_sendmsg+0x735/0xc60
[ 1414.868572][T10284]  ? netlink_unicast+0x740/0x740
[ 1414.868574][T10284]  ? __might_fault+0x97/0x140
[ 1414.868577][T10284]  ? __might_fault+0x97/0x140
[ 1414.868579][T10284]  __sys_sendto+0x2c9/0x400
[ 1414.868582][T10284]  ? __ia32_sys_getpeername+0xd0/0xd0
[ 1414.868586][T10284]  ? fput_close_sync+0xde/0x1b0
[ 1414.868589][T10284]  ? alloc_file_clone+0xe0/0xe0
[ 1414.868591][T10284]  __x64_sys_sendto+0xe4/0x1f0
[ 1414.868593][T10284]  ? trace_irq_enable.constprop.0+0x9b/0x180
[ 1414.868596][T10284]  ? lockdep_hardirqs_on+0x8c/0x130
[ 1414.868597][T10284]  ? do_syscall_64+0x82/0xfc0
[ 1414.868599][T10284]  do_syscall_64+0x117/0xfc0
[ 1414.868600][T10284]  ? trace_hardirqs_off+0xd/0x30
[ 1414.868602][T10284]  ? exc_page_fault+0xee/0x100
[ 1414.868604][T10284]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1414.868606][T10284] RIP: 0033:0x7fcd4191e08e
[ 1414.868609][T10284] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[ 1414.868611][T10284] RSP: 002b:00007ffc4c8b41c0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[ 1414.868614][T10284] RAX: ffffffffffffffda RBX: 0000557d5eaaee20 RCX: 00007fcd4191e08e
[ 1414.868615][T10284] RDX: 0000000000000020 RSI: 0000557d5eaa98e0 RDI: 0000000000000012
[ 1414.868616][T10284] RBP: 00007ffc4c8b41d0 R08: 00007ffc4c8b4220 R09: 0000000000000080
[ 1414.868617][T10284] R10: 0000000000000000 R11: 0000000000000202 R12: 0000557d5ec08060
[ 1414.868618][T10284] R13: 00007ffc4c8b4304 R14: 0000000000000000 R15: 00007ffc4c8b43a0
[ 1414.868621][T10284]  </TASK>
[ 1414.868621][T10284] 
[ 1414.876011][T10284] Allocated by task 10304:
[ 1414.876091][T10284]  kasan_save_stack+0x2f/0x50
[ 1414.876205][T10284]  kasan_save_track+0x14/0x30
[ 1414.876286][T10284]  __kasan_kmalloc+0x7b/0x90
[ 1414.876399][T10284]  register_netdevice+0x48b/0x1bc0
[ 1414.876477][T10284]  geneve_configure+0x6c3/0xcf0 [geneve]
[ 1414.876591][T10284]  geneve_newlink+0x189/0x220 [geneve]
[ 1414.876669][T10284]  rtnl_newlink_create+0x2da/0x8c0
[ 1414.876747][T10284]  __rtnl_newlink+0x22b/0xa50
[ 1414.876858][T10284]  rtnl_newlink+0x8d1/0xef0
[ 1414.876973][T10284]  rtnetlink_rcv_msg+0x6fd/0xbd0
[ 1414.877049][T10284]  netlink_rcv_skb+0x14e/0x3a0
[ 1414.877128][T10284]  netlink_unicast+0x47c/0x740
[ 1414.877204][T10284]  netlink_sendmsg+0x735/0xc60
[ 1414.877280][T10284]  __sys_sendto+0x2c9/0x400
[ 1414.877392][T10284]  __x64_sys_sendto+0xe4/0x1f0
[ 1414.877470][T10284]  do_syscall_64+0x117/0xfc0
[ 1414.877547][T10284]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1414.877680][T10284] 
[ 1414.877719][T10284] Freed by task 10304:
[ 1414.877818][T10284]  kasan_save_stack+0x2f/0x50
[ 1414.877894][T10284]  kasan_save_track+0x14/0x30
[ 1414.877968][T10284]  kasan_save_free_info+0x3b/0x60
[ 1414.878084][T10284]  __kasan_slab_free+0x43/0x70
[ 1414.878161][T10284]  kfree+0x123/0x5a0
[ 1414.878218][T10284]  unregister_netdevice_many_notify+0xf0d/0x1f20
[ 1414.878313][T10284]  rtnl_dellink+0x4a0/0xae0
[ 1414.878425][T10284]  rtnetlink_rcv_msg+0x6fd/0xbd0
[ 1414.878499][T10284]  netlink_rcv_skb+0x14e/0x3a0
[ 1414.878577][T10284]  netlink_unicast+0x47c/0x740
[ 1414.878657][T10284]  netlink_sendmsg+0x735/0xc60
[ 1414.878778][T10284]  __sys_sendto+0x2c9/0x400
[ 1414.878853][T10284]  __x64_sys_sendto+0xe4/0x1f0
[ 1414.878928][T10284]  do_syscall_64+0x117/0xfc0
[ 1414.879004][T10284]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1414.879098][T10284] 
[ 1414.879148][T10284] The buggy address belongs to the object at ff11000001d2c140
[ 1414.879148][T10284]  which belongs to the cache kmalloc-64 of size 64
[ 1414.879339][T10284] The buggy address is located 16 bytes inside of
[ 1414.879339][T10284]  freed 64-byte region [ff11000001d2c140, ff11000001d2c180)
[ 1414.879521][T10284] 
[ 1414.879559][T10284] The buggy address belongs to the physical page:
[ 1414.879689][T10284] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d2c
[ 1414.879910][T10284] flags: 0x80000000000000(node=0|zone=1)
[ 1414.879992][T10284] page_type: f5(slab)
[ 1414.880053][T10284] raw: 0080000000000000 ff1100000103cac0 ffd400000023ac90 ffd4000000074c90
[ 1414.880232][T10284] raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
[ 1414.880365][T10284] page dumped because: kasan: bad access detected
[ 1414.880495][T10284] 
[ 1414.880534][T10284] Memory state around the buggy address:
[ 1414.880609][T10284]  ff11000001d2c000: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[ 1414.880726][T10284]  ff11000001d2c080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1414.880837][T10284] >ff11000001d2c100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[ 1414.880948][T10284]                                                  ^
[ 1414.881042][T10284]  ff11000001d2c180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1414.881190][T10284]  ff11000001d2c200: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb

decoded: https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/653382/vm-crash-thr0-0

