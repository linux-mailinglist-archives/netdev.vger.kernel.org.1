Return-Path: <netdev+bounces-275166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I1wNh4O0GlQ2wYAu9opvQ
	(envelope-from <netdev+bounces-275166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:59:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A739771D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF8330193A4
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D0308F07;
	Fri,  3 Apr 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="oWuO98S5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06C359A90
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242778; cv=pass; b=txKFMZgVDu/Mc17DKZXraJ8c5jdhA3mf1DQvG/B7ns7uN1HWrKBYf3DuPUpIpVFO8461UBYo42nCZRRDl1SeYllmw+tZgzDA7tgx68BY2gfFMSDqjWOZZ4OmcWfONXpc6O8fSz48Ic71gM9Af0dx7uFeLArlxlwKCmjhBgjYc0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242778; c=relaxed/simple;
	bh=AEf/NVl9Xl48gtHpmRzXl4iivMy3IIKXcz2RuQUIAKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBgyjeK/yzDcAu+UFmgoZBnq9PmFrTMDSLoy5K2sRvGThxPmZXx2JJGlS6FTArFbWy38tN8jFZi7iQyJgH9wBQr7iCBvo+GTcTx2vv/O0SXUbEGqfcrw2Hs9lekYZRjMTfe1MJ0orGNdxeA0N74QMAIW0a2ABwBovnT7CrKGXsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=oWuO98S5; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82735a41920so732532b3a.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 11:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775242774; cv=none;
        d=google.com; s=arc-20240605;
        b=HFeWPCdCzk9F3bkz57KrNaBU5qVSeQnORayAiJWPeWNs0XRIVKWIYvGJ9yy2ZIXwJY
         0GjviIhQ1nWlza7+YdwxEHWRtcmIUGQ9VjhIXOztTi6ZRPRyISxHoXQO6mvcJ1SCzohA
         dcv0TEyI1gyy8iAwl1f31GK7N/ILRs7L8rp0V//4xBoachbxWDWOl02MdL+uRtF3qxza
         dduKThdF413jVS9bD6yOgux3msl80VsrlheeI//8UTC5mAB+gTsKap4k33zvTF6QHEmA
         /lsMkd9qLzKEvUH8mS5DhyC7+QwGzIWccUqzCb5UoGHXcD24d7eB87AlDLFqTrNjOAvy
         D84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HbWiQegiRgK5gaUNH4IXslqVXBhUEQ4yp9oXUz/qaCI=;
        fh=71KVowZ+YUc7NaA+sMtzLc/d0lwcFFizDfYzdBHhSm4=;
        b=DpLZpPOEllAVwbjKCwtTHVdJ5I0aBKasgjTQplTgZ7A43e3BNUrjZM5ihxGpi7HdKU
         XuVwewszCtMyAmLwKUQ+q3hPwJKzZfp/THjAARhWpGjsRz0g6GiCppYuMl7E+ci5pm4I
         ZcWFoo2vOJaAkruLhvyFcox7o11vNQI+ik+etfcuaxJw3XQwahFmEBNfLUkJHgG78RGu
         KIh5P1oVAtFKjPSfHkpgF9LIxgY6PaRk9SyMZhq4ZwMB+mMdor786ugbADHiCSHtNkFu
         UbNS18ooJErb65XP1TDmVrUN5THZuYzRzpsudhMKL74wSDk2OENHpH/8ju4nWHcrTSEn
         VvCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1775242774; x=1775847574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbWiQegiRgK5gaUNH4IXslqVXBhUEQ4yp9oXUz/qaCI=;
        b=oWuO98S5ldgU6PXxkqd2rVi7uvNYOqkUHSyGZLl+1YLRtURY/w3QEiKE7bSLA1kTZB
         sO6KJtuT+U9hvT2qQcJB2ehwb7WAEm5yvRQFV1E+8TX+z1GlaLGuarW6L7arR3Pbasfn
         iP9WUQKJL5i1Qh5/V9N/nM0Rguno8vk3vQAWkoeTwCH3Wett3cDhaq62Eb1lI5q2V0na
         QseqijNneOT7Hb04hOT2fy5k/vwyCTJ/B5y5ac99Ype5iAoi5KbRWM27q2zdgi4k4Wws
         CzZTtzQpaQ58CEeKoTewcA2TXOp/TplNbV6pzIhjR3/fotQuWyjnFU2u6TbdGsVsL2Zb
         tQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242774; x=1775847574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbWiQegiRgK5gaUNH4IXslqVXBhUEQ4yp9oXUz/qaCI=;
        b=XKPqxwbah2F61F89Ugz2Bh56y+bNeJbo5zCjzEa2UCP8TJLh6SjptX+Ldl+22SdXmJ
         /dFAFsFAXr+BzeYF7gYIvzA1oQcKkYr5D7WFqSWqWC2WjH9Rwfj7A4PHTr1A/YacNADQ
         Ogg6rOWwCqddVKRYTi0iBRhLHbfgY3OduabhoCffLFpQne+BLzWr0vVUmqqxSrrwAcKM
         +/SNmobIW46xM5uRC2WVAeUcAv9Dj3rVu7ddsGOn159NfQPpfoGDXPb+F1ab769Ko0x6
         fO2BPNkvb/zCzDgsVL8Sz8SkMBeiGJGyBBTHV3+tcgNo99SJ+e651vhQE9T/OqZ0I+SJ
         gfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXneyBw1KdOBBFjEmBGseCkSRAMRcicT7Mz2qH/LJYejHJ0nojBMSydQ9kDYvMs/C/BH4uTN2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnWf4y8eN38VspAIClrsftw0SICcEpaImh3EuO+NoiEUbQePi
	SC7MEz901GtmUMNjQrUJpLODigPNnH5qusY3uLwzOMYWW6mb6EfwGmdaxf1hmGENItgztl2Dmmb
	MbA9RyRRysntz3TqpOvqVyU14tztCtYs7LYE4AqdKrsPS6kr+LEMiPQ==
X-Gm-Gg: ATEYQzwq9XiRDrYyQN4wxl5Jb2Hm6rPnjXjzuFMcWRpISFpXz0eZYOlSJzkAuVz9H1d
	l6PMLQvYtKLpxRICsBSUbzOk0fhp+oN1kzuzUmHmSSRgH3tXCW2wdxLW8c8AsP9KL6cr0KPrePk
	3e1IEVw0VvrgoBl0JenGVavM6jEx+GUw/jVSxmyXmsSYG+59STxd1GBe2050y0uLjqe6P2nkETc
	LPMC1RUKGa42jq9sq042BaoRciYTsUJMTpv5AuM5wW5W7reSQTKEFVn+IaKnDvmhxwvvcMqnTfA
	Z3rjANwliNixFYWc8LQ=
X-Received: by 2002:a05:6a00:4292:b0:82a:6d3d:9ba1 with SMTP id
 d2e1a72fcca58-82d0da9c60bmr3674970b3a.24.1775242774345; Fri, 03 Apr 2026
 11:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dcd085bd504ec1d0698690e08e2e1c4d0edff8e4.1775232030.git.dcaratti@redhat.com>
In-Reply-To: <dcd085bd504ec1d0698690e08e2e1c4d0edff8e4.1775232030.git.dcaratti@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 3 Apr 2026 14:59:22 -0400
X-Gm-Features: AQROBzC3C7SMHHoGl7HxSgLKWBILjZPZQWRjGMIkobI47bZY_t8XiFc6kqs2Xls
Message-ID: <CAM0EoMm2MpiZ-Rn7PVE8rYq8bOkrqs+0PAjuLi23iLN6Eih2sg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cls_fw: fix NULL dereference of "old"
 filters before change()
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-275166-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 242A739771D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 12:04=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Like pointed out by Sashiko [1],

Just found out about this ;-> So bye-bye old AI? ;->
I must say, finding this specific bug is impressive.

>TC filters are added to a shared block
> before their ->change() function is called. This is a problem for cls_fw:
> an invalid filter created with the "old" method can still classify some
> packets before it is destroyed by the validation logic added by Xiang.
>

I think the real issue is that the filter is exposed to the datapath
before change() is invoked. i.e as you noted 1. init() was invoked, 2.
then the filter was exposed and 3. The change() was initiated.
So the packet arrived somewhere between step 2 and 3 and boom.
In the past - before commit ed76f5edccc9
(https://lore.kernel.org/netdev/20190204123301.4223-7-vladbu@mellanox.com/)
you couldnt expose the filter to the datapath before the change() was
completed..

Observation on consistency pov:
You will always get a "q" when you invoke tcf_block_q() if there are
no shared blocks attached. But that doesnt mean the "create"
configuration is complete; it is only complete if step 3 above
completes. This is because we are not sure if change() will result in
"old" or "new" lookup setup. So the check you added for q may be
inconsistent from that perspective and fw should have returned -1 like
all classifiers...
I cant think of a simple solution to verify if the config is
"inconsistent" other than to add something that gets checked in the
datapath (and when absent, return -1)
From that perspective, your check is not catastrophic, so it may be ok.
At minimal the Fixes: needs to change to Vlads commit? Good news is
only fw _seems_ to suffer from this challenge...


cheers,
jamal


> Therefore, insisting with repeated runs of the following script:
>
>  # ip link add dev crash0 type dummy
>  # ip link set dev crash0 up
>  # mausezahn  crash0 -c 100000 -P 10 \
>  > -A 4.3.2.1 -B 1.2.3.4 -t udp "dp=3D1234" -q &
>  # sleep 1
>  # tc qdisc add dev crash0 egress_block 1 clsact
>  # tc filter add block 1 protocol ip prio 1 matchall \
>  > action skbedit mark 65536 continue
>  # tc filter add block 1 protocol ip prio 2 fw
>  # ip link del dev crash0
>
> can still make fw_classify() hit the WARN_ON() in [2]:
>
>  WARNING: ./include/net/pkt_cls.h:88 at fw_classify+0x244/0x250 [cls_fw],=
 CPU#18: mausezahn/1399
>  Modules linked in: cls_fw(E) act_skbedit(E)
>  CPU: 18 UID: 0 PID: 1399 Comm: mausezahn Tainted: G            E       7=
.0.0-rc6-virtme #17 PREEMPT(full)
>  Tainted: [E]=3DUNSIGNED_MODULE
>  Hardware name: Red Hat KVM, BIOS 1.16.3-2.el9 04/01/2014
>  RIP: 0010:fw_classify+0x244/0x250 [cls_fw]
>  Code: 5c 49 c7 45 00 00 00 00 00 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 5b =
b8 ff ff ff ff 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 <0f> 0b 90 eb a=
0 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90
>  RSP: 0018:ffffd1b7026bf8a8 EFLAGS: 00010202
>  RAX: ffff8c5ac9c60800 RBX: ffff8c5ac99322c0 RCX: 0000000000000004
>  RDX: 0000000000000001 RSI: ffff8c5b74d7a000 RDI: ffff8c5ac8284f40
>  RBP: ffffd1b7026bf8d0 R08: 0000000000000000 R09: ffffd1b7026bf9b0
>  R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000010000
>  R13: ffffd1b7026bf930 R14: ffff8c5ac8284f40 R15: 0000000000000000
>  FS:  00007fca40c37740(0000) GS:ffff8c5b74d7a000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fca40e822a0 CR3: 0000000005ca0001 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   tcf_classify+0x17d/0x5c0
>   tc_run+0x9d/0x150
>   __dev_queue_xmit+0x2ab/0x14d0
>   ip_finish_output2+0x340/0x8f0
>   ip_output+0xa4/0x250
>   raw_sendmsg+0x147d/0x14b0
>   __sys_sendto+0x1cc/0x1f0
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x126/0xf80
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7fca40e822ba
>  Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 =
ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 f=
f ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
>  RSP: 002b:00007ffc248a42c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>  RAX: ffffffffffffffda RBX: 000055ef233289d0 RCX: 00007fca40e822ba
>  RDX: 000000000000001e RSI: 000055ef23328c30 RDI: 0000000000000003
>  RBP: 000055ef233289d0 R08: 00007ffc248a42d0 R09: 0000000000000010
>  R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001e
>  R13: 00000000000186a0 R14: 0000000000000000 R15: 00007fca41043000
>   </TASK>
>  irq event stamp: 1045778
>  hardirqs last  enabled at (1045784): [<ffffffff864ec042>] __up_console_s=
em+0x52/0x60
>  hardirqs last disabled at (1045789): [<ffffffff864ec027>] __up_console_s=
em+0x37/0x60
>  softirqs last  enabled at (1045426): [<ffffffff874d48c7>] __alloc_skb+0x=
207/0x260
>  softirqs last disabled at (1045434): [<ffffffff874fe8f8>] __dev_queue_xm=
it+0x78/0x14d0
>
> Then, because of the value in the packet's mark, dereference on 'q->handl=
e'
> with NULL 'q' occurs:
>
>  BUG: kernel NULL  pointer dereference, address: 0000000000000038
>  [...]
>  RIP: 0010:fw_classify+0x1fe/0x250 [cls_fw]
>  [...]
>
> Skip "old-style" classification on shared blocks, so that the NULL
> dereference is fixed and WARN_ON() is not hit anymore in the short
> lifetime of invalid cls_fw "old-style" filters.
>
> V2: avoid NULL dereference without hitting WARN_ON() anymore (Sashiko)
>
> [1] https://sashiko.dev/#/patchset/20260331050217.504278-1-xmei5%40asu.ed=
u
> [2] https://elixir.bootlin.com/linux/v7.0-rc6/source/include/net/pkt_cls.=
h#L86
>
> Fixes: faeea8bbf6e9 ("net/sched: cls_fw: fix NULL pointer dereference on =
shared blocks")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/sched/cls_fw.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index 23884ef8b80c..646a730dca93 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -74,9 +74,13 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
>                         }
>                 }
>         } else {
> -               struct Qdisc *q =3D tcf_block_q(tp->chain->block);
> +               struct Qdisc *q;
>
>                 /* Old method: classify the packet using its skb mark. */
> +               if (tcf_block_shared(tp->chain->block))
> +                       return -1;
> +
> +               q =3D tcf_block_q(tp->chain->block);
>                 if (id && (TC_H_MAJ(id) =3D=3D 0 ||
>                            !(TC_H_MAJ(id ^ q->handle)))) {
>                         res->classid =3D id;
> --
> 2.52.0
>

