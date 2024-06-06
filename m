Return-Path: <netdev+bounces-101388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 109CE8FE58C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C45D1F26307
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F98195977;
	Thu,  6 Jun 2024 11:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F890195973
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673782; cv=none; b=k1fE3oMFCrA9cpHGeF2XyxGmGhNmhJm82Tg+ho+PuUdgqtOuZaTlV1Sdk761ljzHhYsh5Wz8sJVO1ExbA9qvMr+IrAondrZUIGebQ2mk88U0J/4FfbgZ0J8tMgCehAUTXTQmCOSdFGpQlGjyXnN847fB1sAwVF5KCn3Ke+Xs1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673782; c=relaxed/simple;
	bh=VaIsKOS6bb8eFT5Lee0QllwZZNZFizy9wsv8/34PE10=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=IyB35q4g/H3KE242SPyh/MA8zHS3asrq+wqJtdU0+Mm2d48C5ytRgWoWYK52H+6bTomAyDyGN+ubUiFUOhx7jMzlkW3vI9CzLYxNLjwxonbw5eSDIr5dk38jM4QLvr7hl3Y7Pxx56u+glvM68PyIS0mNkXTMJ5ACZ7AUwdfVYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:58054)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sFBPh-007uUy-JR; Thu, 06 Jun 2024 05:36:13 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:40626 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sFBPg-00GOwp-8X; Thu, 06 Jun 2024 05:36:13 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org,  David Miller <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Jakub Kicinski <kuba@kernel.org>
References: <20240605235952.21320-1-cpaasch@apple.com>
Date: Thu, 06 Jun 2024 06:34:31 -0500
In-Reply-To: <20240605235952.21320-1-cpaasch@apple.com> (Christoph Paasch's
	message of "Wed, 05 Jun 2024 16:59:52 -0700")
Message-ID: <87a5jywbi0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sFBPg-00GOwp-8X;;;mid=<87a5jywbi0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18hEwVL4STXhy7VCjOvdZX37ALlG6TSFwY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christoph Paasch <cpaasch@apple.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 582 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.18
	(0.2%), extract_message_metadata: 14 (2.5%), get_uri_detail_list: 3.0
	(0.5%), tests_pri_-2000: 13 (2.2%), tests_pri_-1000: 2.4 (0.4%),
	tests_pri_-950: 1.24 (0.2%), tests_pri_-900: 1.03 (0.2%),
	tests_pri_-90: 112 (19.2%), check_bayes: 109 (18.8%), b_tokenize: 13
	(2.2%), b_tok_get_all: 15 (2.6%), b_comp_prob: 4.3 (0.7%),
	b_tok_touch_all: 73 (12.5%), b_finish: 0.99 (0.2%), tests_pri_0: 404
	(69.4%), check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 3.1
	(0.5%), poll_dns_idle: 0.88 (0.2%), tests_pri_10: 2.4 (0.4%),
	tests_pri_500: 15 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net] net: Don't warn on ENOMEM in
 __dev_change_net_namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Christoph Paasch <cpaasch@apple.com> writes:

> syzkaller found a WARN in __dev_change_net_namespace when
> device_rename() returns ENOMEM:

So device_rename() is returning ENOMEM.

Which mean the rename fails.  Which means the machine has entered an
inconsistent state.

Actions have already been taken that essentially can not be rolled back.

That warrants a warning.  If device_rename is going to return ENOMEM in
some case that isn't error injection __dev_change_net_namespace needs to
be updated to deal with this case.

This patch looks like it is shooting the messenger rather than doing
something useful.

The fact that the warning has not happened until now suggests that this
is not a real world failure scenario but instead this failure is some
erroneous error injection triggered by syzkaller.

I think there was a version of __dev_change_net_namespace that did not
have this failure mode that was never merged into the main tree.  At
about the same time as this code was being merged, sysfs support was
merged and added a number of new failure cases that were frankly ABI
breaking if the were to be allowed to happen.  A real tail wagging
the dog scenario.  Eventually dev_change_name was updated to deal
with it, but that effort has not been put into
__dev_change_net_namespace.

If you want to fix it please fix it, but let's not remove the warning
that tells us there is a problem in the first place.

Thank you,
Eric

>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6395 at net/core/dev.c:11430 __dev_change_net_namespace+0xba7/0xbf0
> Modules linked in:
> CPU: 1 PID: 6395 Comm: syz-executor.1 Not tainted 6.9.0-g4eea1d874bbf #66
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:__dev_change_net_namespace+0xba7/0xbf0 net/core/dev.c:11430
> Code: 05 d6 72 34 01 01 48 c7 c7 ea e8 c4 82 48 c7 c6 21 d2 cb 82 ba bf 07 00 00 e8 25 cc 39 ff 0f 0b e9 5b f8 ff ff e8 c9 b3 4f ff <0f> 0b e9 ca fc ff ff e8 bd b3 4f ff 0f 0b e9 5f fe ff ff e8 b1 b3
> RSP: 0018:ffffc90000d1f410 EFLAGS: 00010293
> RAX: ffffffff81d1d487 RBX: ffff8881213b5000 RCX: ffff888115f9adc0
> RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
> RBP: ffffc90000d1f4e0 R08: ffffffff81d1d14a R09: 205d393032343136
> R10: 3e4b5341542f3c20 R11: ffffffff81a40d20 R12: ffff88811f57af40
> R13: 0000000000000000 R14: 00000000fffffff4 R15: ffff8881213b5000
> FS:  00007fc93618e640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000468d90 CR3: 0000000126252003 CR4: 0000000000170ef0
> Call Trace:
>  <TASK>
>  do_setlink+0x154/0x1c70 net/core/rtnetlink.c:2805
>  __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
>  rtnl_newlink+0xe60/0x1210 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x689/0x720 net/core/rtnetlink.c:6595
>  netlink_rcv_skb+0xea/0x1c0 net/netlink/af_netlink.c:2564
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x430/0x500 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x43d/0x540 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xa4/0xd0 net/socket.c:745
>  ____sys_sendmsg+0x22a/0x320 net/socket.c:2585
>  ___sys_sendmsg+0x143/0x190 net/socket.c:2639
>  __sys_sendmsg net/socket.c:2668 [inline]
>  __do_sys_sendmsg net/socket.c:2677 [inline]
>  __se_sys_sendmsg net/socket.c:2675 [inline]
>  __x64_sys_sendmsg+0xd8/0x150 net/socket.c:2675
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x54/0xf0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fc936e686a9
>
> The WARN is there because device_rename() is indeed not meant to
> fail in __dev_change_net_namespace(), except for the case where
> it can't allocated memory.
>
> So, let's special-case the scenario where err == ENOMEM to silence the
> warning.
>
> AFAICS, this has been there since the initial implementation.
>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Fixes: ce286d327341 ("[NET]: Implement network device movement between namespaces")
> Signed-off-by: Christoph Paasch <cpaasch@apple.com>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4d4de9008f6f..ba0c9f705ddb 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11428,7 +11428,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>  	dev_set_uevent_suppress(&dev->dev, 1);
>  	err = device_rename(&dev->dev, dev->name);
>  	dev_set_uevent_suppress(&dev->dev, 0);
> -	WARN_ON(err);
> +	WARN_ON(err && err != -ENOMEM);
>  
>  	/* Send a netdev-add uevent to the new namespace */
>  	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);

