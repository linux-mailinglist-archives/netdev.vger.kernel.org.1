Return-Path: <netdev+bounces-257907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCiMEUCSiWlz+wQAu9opvQ
	(envelope-from <netdev+bounces-257907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:52:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D4610CA24
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B323015CB9
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A9339847;
	Mon,  9 Feb 2026 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="13WL0Mhb"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B5339870;
	Mon,  9 Feb 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623486; cv=none; b=bTCrS4t5JkYzZ9ubBT+5UxodIQ0QL3mcybTSDa3LlLnN7kxCJvBy4Y1j7PZq2EPuO3MniSnJzl7KsXD/4aM/wlvWD1K8Y9IQOTEN2nkUWg+nUGSM8HDb2xZS+RuZ8qTstClVXVhpiEo6tV7tlJu+shWAW0DE//rS+arQ9mORjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623486; c=relaxed/simple;
	bh=KzR+XUFHWFGFhLBdPw4LRdc3yyO0mEalZ0i6rC0F58o=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A0BypIefK9xyKLUUoN1XmrzgzOWDT5oPaeTtVbU5E8ZnJLxDS8rouzzWXT8kQwc7kdRyXmM2kzkejxTLb1slterC5p7okPP/nUFkzVmMIagxWy/KmZGllpVILr4QHDiSn5icacelDeIJWo32F1uVWARgFRUGIoFaSEaT/v7c5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=13WL0Mhb; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XgdAS5fUskXZ+EiojyTfQNrDozOpweDEw9VNXUT9X30=;
	b=13WL0Mhb1E/+mI+tikSicZiPS8DEKyMmmrC4Fj1yh3pgjfjCshyrMCd3tRAzbuJVZXd0XyUY+
	QhyoEqlPzrT+pRri0mAQ1xVSdGBIerPikVyLvDIVVohE9jimxzrWk7OHU2VCpSJlV3+GL+657F/
	3ZZfYFFAjeeBNaZKRKc71ek=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4f8cG81Zzqz1cyNr;
	Mon,  9 Feb 2026 15:46:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CCA140363;
	Mon,  9 Feb 2026 15:51:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 15:51:16 +0800
Message-ID: <2b99c5ad-c6f6-4f24-9a62-e24d67d7a145@huawei.com>
Date: Mon, 9 Feb 2026 15:51:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Jiayuan Chen <jiayuan.chen@shopee.com>,
	<syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Konstantin
 Khlebnikov <khlebnikov@openvz.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] serial: caif: fix use-after-free in caif_serial
 ldisc_close()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, <netdev@vger.kernel.org>
References: <20260206074450.154267-1-jiayuan.chen@linux.dev>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260206074450.154267-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,linuxfoundation.org:email,shopee.com:email]
X-Rspamd-Queue-Id: 93D4610CA24
X-Rspamd-Action: no action


on 2026/2/6 15:44, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> There is a use-after-free bug in caif_serial where handle_tx() may
> access ser->tty after the tty has been freed.
>
> The race condition occurs between ldisc_close() and packet transmission:
>
>      CPU 0 (close)                     CPU 1 (xmit)
>      -------------                     ------------
>      ldisc_close()
>        tty_kref_put(ser->tty)
>        [tty may be freed here]
>                       <-- race window -->
>                                        caif_xmit()
>                                          handle_tx()
>                                            tty = ser->tty  // dangling ptr
>                                            tty->ops->write() // UAF!
>        schedule_work()
>          ser_release()
>            unregister_netdevice()
>
> The root cause is that tty_kref_put() is called in ldisc_close() while
> the network device is still active and can receive packets.
>
> Since ser and tty have a 1:1 binding relationship with consistent
> lifecycles (ser is allocated in ldisc_open and freed in ser_release
> via unregister_netdevice, and each ser binds exactly one tty), we can
> safely defer the tty reference release to ser_release() where the
> network device is unregistered.
>
> Fix this by moving tty_kref_put() from ldisc_close() to ser_release(),
> after unregister_netdevice(). This ensures the tty reference is held
> as long as the network device exists, preventing the UAF.
>
> Note: We save ser->tty before unregister_netdevice() because ser is
> embedded in netdev's private data and will be freed along with netdev
> (needs_free_netdev = true).
>
> How to reproduce: Add mdelay(500) at the beginning of ldisc_close()
> to widen the race window, then run the reproducer program [1].
>
> Note: There is a separate deadloop issue in handle_tx() when using
> PORT_UNKNOWN serial ports (e.g., /dev/ttyS3 in QEMU without proper
> serial backend). This deadloop exists even without this patch,
> and is likely caused by inconsistency between uart_write_room() and
> uart_write() in serial core. It has been addressed in a separate
> patch [2].
>
> KASAN report:
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in handle_tx+0x5d1/0x620
> Read of size 1 at addr ffff8881131e1490 by task caif_uaf_trigge/9929
>
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x10e/0x1f0
>   print_report+0xd0/0x630
>   kasan_report+0xe4/0x120
>   handle_tx+0x5d1/0x620
>   dev_hard_start_xmit+0x9d/0x6c0
>   __dev_queue_xmit+0x6e2/0x4410
>   packet_xmit+0x243/0x360
>   packet_sendmsg+0x26cf/0x5500
>   __sys_sendto+0x4a3/0x520
>   __x64_sys_sendto+0xe0/0x1c0
>   do_syscall_64+0xc9/0xf80
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f615df2c0d7
>
> Allocated by task 9930:
>
> Freed by task 64:
>
> Last potentially related work creation:
>
> The buggy address belongs to the object at ffff8881131e1000
>   which belongs to the cache kmalloc-cg-2k of size 2048
> The buggy address is located 1168 bytes inside of
>   freed 2048-byte region [ffff8881131e1000, ffff8881131e1800)
>
> The buggy address belongs to the physical page:
> page_owner tracks the page as allocated
> page last free pid 9778 tgid 9778 stack trace:
>
> Memory state around the buggy address:
>   ffff8881131e1380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881131e1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff8881131e1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                           ^
>   ffff8881131e1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881131e1580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> [1]: https://gist.github.com/mrpre/f683f244544f7b11e7fa87df9e6c2eeb
> [2]: https://lore.kernel.org/linux-serial/20260204074327.226165-1-jiayuan.chen@linux.dev/T/#u
>
> Reported-by: syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000a4a7550611e234f5@google.com/T/
> Fixes: 56e0ef527b18 ("drivers/net: caif: fix wrong rtnl_is_locked() usage")
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> ---
> v1 -> v2:
> Add Reviewed-by tag.
> Use correct Fixes tag.
> v1: https://lore.kernel.org/netdev/20260204081939.237738-1-jiayuan.chen@linux.dev/
> ---
>   drivers/net/caif/caif_serial.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index c398ac42eae9..b90890030751 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -284,6 +284,7 @@ static void ser_release(struct work_struct *work)
>   {
>   	struct list_head list;
>   	struct ser_device *ser, *tmp;
> +	struct tty_struct *tty;
>   
>   	spin_lock(&ser_lock);
>   	list_replace_init(&ser_release_list, &list);
> @@ -292,9 +293,11 @@ static void ser_release(struct work_struct *work)
>   	if (!list_empty(&list)) {
>   		rtnl_lock();
>   		list_for_each_entry_safe(ser, tmp, &list, node) {
> +			tty = ser->tty;
>   			dev_close(ser->dev);
>   			unregister_netdevice(ser->dev);
>   			debugfs_deinit(ser);

from log message:
Note: We save ser->tty before unregister_netdevice() because ser is
embedded in netdev's private data and will be freed along with netdev
(needs_free_netdev = true).
...

Therefore, since "ser" has already been released, "debugfs_deinit(ser)" should not be at this location.
Of course, this issue is not related to this patch itself.

...

Also, after calling "dev_close(ser->dev)", can we directly call tty_kref_put()?
At this point, there should be no more packets to receive, so you don't need to save "ser->tty" anymore.

Of course, the current changes also look good to me. so,
Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> +			tty_kref_put(tty);
>   		}
>   		rtnl_unlock();
>   	}
> @@ -355,8 +358,6 @@ static void ldisc_close(struct tty_struct *tty)
>   {
>   	struct ser_device *ser = tty->disc_data;
>   
> -	tty_kref_put(ser->tty);
> -
>   	spin_lock(&ser_lock);
>   	list_move(&ser->node, &ser_release_list);
>   	spin_unlock(&ser_lock);

