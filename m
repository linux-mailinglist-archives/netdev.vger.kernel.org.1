Return-Path: <netdev+bounces-278098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMqtJyf93Gk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269593ED509
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AD8B300615E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCF3CA4A2;
	Mon, 13 Apr 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNPSBEqy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D86BFCE;
	Mon, 13 Apr 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090404; cv=none; b=bUJywonZY0ptnJlfLsoO/53BJhAZukhQMAwA3jYVuUxQsRQJfWuJ/3xVqJt9eVh+6e/psb6EPCOg+4Y8CVet2ylhUK1gQRpWgWQ6dmsb3b/IXR9y6uPdoryGlUqUgn59ac7w6aDCVJp6c78O1rK7G/vUvlrMwJG97n4scQqXIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090404; c=relaxed/simple;
	bh=1MZND6bJkp684teTokHALQaNO0jbgoKDXwoMO9NTZKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oBQlcGhPk6LtEraFkQ5tIvnp+hhqjTeLxVTaY3Glt1cOFxd4m79O3uq4qiNwr/Fn2nwc5gPthowSngxzU4wIpdYRebZ8Cc0j/GomUxKprDOobMm6054kKup/BKFS+ah8XN1Koz4oS6otgLSBlF+iuqZTixRHsIK0WgolBULafWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNPSBEqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06E2C2BCAF;
	Mon, 13 Apr 2026 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776090404;
	bh=1MZND6bJkp684teTokHALQaNO0jbgoKDXwoMO9NTZKs=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=FNPSBEqyYqKaCRHmKDA9mDB7zo9qwtnfL+qUdo83ZhUBNQpRMcLGP0+WnmlHlNZtn
	 YeDji4KomZBx94yw+2BgdxCoYbIK9mSYwkWMDNT0cszgrbCAsXcWrcqb/Q5AhDk2r/
	 uGdR4vM1yh7sNGreus03m2gyx3Zm//aN0afYpEsjy4nc9cOnnnIuwNhtvwXB2DXc/+
	 kCE7luIvyqMQ0DY13PXyMI1L0QdOkjv0JrmIIAPfWWJ/qWtuXw4sDMDosXkl5G+1x0
	 Rge8BgNRK1ihU/C6JbFRjJnfaWu9pWXljw75PcrB/DC0lYjHXI7kCV69297M/W8FRI
	 2Xqjy70+mMilQ==
Message-ID: <af57d470-b4b4-4bb1-a2d9-57a7930063b1@kernel.org>
Date: Mon, 13 Apr 2026 16:26:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] possible deadlock in mptcp_pm_nl_set_flags
Content-Language: fr
To: syzbot <syzbot+dfa28bb6444d8f169cbb@syzkaller.appspotmail.com>
References: <69d90c16.050a0220.adfb3.000a.GAE@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <69d90c16.050a0220.adfb3.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278098-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dfa28bb6444d8f169cbb];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 269593ED509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 10/04/2026 16:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    591cd656a1bf Linux 7.0-rc7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1779ce06580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
> dashboard link: https://syzkaller.appspot.com/bug?extid=dfa28bb6444d8f169cbb
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-591cd656.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3e99d0e29df0/vmlinux-591cd656.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5877fee0a056/bzImage-591cd656.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dfa28bb6444d8f169cbb@syzkaller.appspotmail.com
> 
> netlink: 8 bytes leftover after parsing attributes in process `syz.8.6915'.
> netlink: 8 bytes leftover after parsing attributes in process `syz.8.6915'.
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Tainted: G             L     
> ------------------------------------------------------
> syz.8.6915/29783 is trying to acquire lock:
> ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
> ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4489 [inline]
> ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4843 [inline]
> ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_noprof+0x51/0x6e0 mm/slub.c:4885
> 
> but task is already holding lock:
> ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
> ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1482 [inline]
> ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags+0x605/0xd30 net/mptcp/pm_kernel.c:1551
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
>        lock_sock include/net/sock.h:1709 [inline]
>        inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:919
>        nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
>        recv_work+0x5fb/0x8c0 drivers/block/nbd.c:1021
>        process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
>        process_scheduled_works kernel/workqueue.c:3359 [inline]
>        worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
>        kthread+0x370/0x450 kernel/kthread.c:436
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #5 (&nsock->tx_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
>        nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
>        blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
>        blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
>        blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
>        blk_finish_plug block/blk-core.c:1257 [inline]
>        __submit_bio+0x584/0x6c0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
>        submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
>        blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>        submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
>        submit_bh fs/buffer.c:2826 [inline]
>        block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
>        filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
>        do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
>        read_mapping_folio include/linux/pagemap.h:1017 [inline]
>        read_part_sector+0xd1/0x370 block/partitions/core.c:723
>        adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:142 [inline]
>        blk_add_partitions block/partitions/core.c:590 [inline]
>        bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
>        blkdev_get_whole+0x187/0x290 block/bdev.c:764
>        bdev_open+0x2c7/0xe40 block/bdev.c:973
>        blkdev_open+0x34e/0x4f0 block/fops.c:697
>        do_dentry_open+0x6d8/0x1660 fs/open.c:949
>        vfs_open+0x82/0x3f0 fs/open.c:1081
>        do_open fs/namei.c:4677 [inline]
>        path_openat+0x208c/0x31a0 fs/namei.c:4836
>        do_file_open+0x20e/0x430 fs/namei.c:4865
>        do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
>        do_sys_open fs/open.c:1372 [inline]
>        __do_sys_openat fs/open.c:1388 [inline]
>        __se_sys_openat fs/open.c:1383 [inline]
>        __x64_sys_openat+0x12d/0x210 fs/open.c:1383
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (&cmd->lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
>        blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
>        blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
>        blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
>        blk_finish_plug block/blk-core.c:1257 [inline]
>        __submit_bio+0x584/0x6c0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
>        submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
>        blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>        submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
>        submit_bh fs/buffer.c:2826 [inline]
>        block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
>        filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
>        do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
>        read_mapping_folio include/linux/pagemap.h:1017 [inline]
>        read_part_sector+0xd1/0x370 block/partitions/core.c:723
>        adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:142 [inline]
>        blk_add_partitions block/partitions/core.c:590 [inline]
>        bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
>        blkdev_get_whole+0x187/0x290 block/bdev.c:764
>        bdev_open+0x2c7/0xe40 block/bdev.c:973
>        blkdev_open+0x34e/0x4f0 block/fops.c:697
>        do_dentry_open+0x6d8/0x1660 fs/open.c:949
>        vfs_open+0x82/0x3f0 fs/open.c:1081
>        do_open fs/namei.c:4677 [inline]
>        path_openat+0x208c/0x31a0 fs/namei.c:4836
>        do_file_open+0x20e/0x430 fs/namei.c:4865
>        do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
>        do_sys_open fs/open.c:1372 [inline]
>        __do_sys_openat fs/open.c:1388 [inline]
>        __se_sys_openat fs/open.c:1383 [inline]
>        __x64_sys_openat+0x12d/0x210 fs/open.c:1383
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #3 (set->srcu){.+.+}-{0:0}:
>        srcu_lock_sync include/linux/srcu.h:199 [inline]
>        __synchronize_srcu+0xa2/0x300 kernel/rcu/srcutree.c:1481
>        blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
>        blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
>        blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
>        blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
>        elevator_switch+0x17b/0x7e0 block/elevator.c:576
>        elevator_change+0x352/0x530 block/elevator.c:681
>        elevator_set_default+0x29e/0x360 block/elevator.c:754
>        blk_register_queue+0x412/0x590 block/blk-sysfs.c:946
>        __add_disk+0x73f/0xe40 block/genhd.c:528
>        add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
>        add_disk include/linux/blkdev.h:785 [inline]
>        nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
>        nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
>        do_one_initcall+0x11d/0x760 init/main.c:1382
>        do_initcall_level init/main.c:1444 [inline]
>        do_initcalls init/main.c:1460 [inline]
>        do_basic_setup init/main.c:1479 [inline]
>        kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
>        kernel_init+0x1f/0x1e0 init/main.c:1582
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #2 (&q->elevator_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        elevator_change+0x1bc/0x530 block/elevator.c:679
>        elevator_set_none+0x92/0xf0 block/elevator.c:769
>        blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
>        __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
>        blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5220
>        nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1489
>        nbd_genl_connect+0xff2/0x1a40 drivers/block/nbd.c:2239
>        genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>        genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>        genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>        netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec net/socket.c:727 [inline]
>        __sock_sendmsg net/socket.c:742 [inline]
>        ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
>        ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
>        __sys_sendmsg+0x170/0x220 net/socket.c:2678
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&q->q_usage_counter(io)#51){++++}-{0:0}:
>        blk_alloc_queue+0x610/0x790 block/blk-core.c:461
>        blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4429
>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4476
>        nbd_dev_add+0x492/0xb10 drivers/block/nbd.c:1954
>        nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
>        do_one_initcall+0x11d/0x760 init/main.c:1382
>        do_initcall_level init/main.c:1444 [inline]
>        do_initcalls init/main.c:1460 [inline]
>        do_basic_setup init/main.c:1479 [inline]
>        kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
>        kernel_init+0x1f/0x1e0 init/main.c:1582
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>        lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
>        __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
>        fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
>        might_alloc include/linux/sched/mm.h:317 [inline]
>        slab_pre_alloc_hook mm/slub.c:4489 [inline]
>        slab_alloc_node mm/slub.c:4843 [inline]
>        kmem_cache_alloc_lru_noprof+0x51/0x6e0 mm/slub.c:4885
>        sock_alloc_inode+0x25/0x1c0 net/socket.c:322
>        alloc_inode+0x68/0x250 fs/inode.c:347
>        new_inode_pseudo include/linux/fs.h:3003 [inline]
>        sock_alloc+0x44/0x280 net/socket.c:637
>        __sock_create+0xc2/0x860 net/socket.c:1569
>        mptcp_subflow_create_socket+0xec/0xa30 net/mptcp/subflow.c:1790
>        __mptcp_subflow_connect+0x3c6/0x1480 net/mptcp/subflow.c:1631
>        mptcp_pm_create_subflow_or_signal_addr+0xc3e/0x18d0 net/mptcp/pm_kernel.c:416
>        mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1460 [inline]
>        mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1487 [inline]
>        mptcp_pm_nl_set_flags+0x814/0xd30 net/mptcp/pm_kernel.c:1551
>        mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
>        mptcp_pm_nl_set_flags_doit+0x1b0/0x290 net/mptcp/pm_netlink.c:282
>        genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>        genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>        genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>        netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec net/socket.c:727 [inline]
>        __sock_sendmsg net/socket.c:742 [inline]
>        ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
>        ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
>        __sys_sendmsg+0x170/0x220 net/socket.c:2678
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   fs_reclaim --> &nsock->tx_lock --> sk_lock-AF_INET
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(sk_lock-AF_INET);
>                                lock(&nsock->tx_lock);
>                                lock(sk_lock-AF_INET);
>   lock(fs_reclaim);
> 
>  *** DEADLOCK ***

Same here, if I'm not mistaken, it looks like this issue is also due to
nbd introducing a lockdep dependency between reclaim and af_socket, and
this is similar to a previous report:

#syz dup: [syzbot] [mptcp?] possible deadlock in mptcp_subflow_create_socket (2)

If that's not correct, please induplicate it.

I'm not sure how MPTCP is being involved here, I guess it should not and
a simple fix is to forbid it. But maybe this issue is not specific to
MPTCP?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


