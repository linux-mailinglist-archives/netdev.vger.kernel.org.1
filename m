Return-Path: <netdev+bounces-284710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCWLF7bd+mk2TgMAu9opvQ
	(envelope-from <netdev+bounces-284710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3D4D687F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 255903004687
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983512356D9;
	Wed,  6 May 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jyb0WMfF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD632F12A5
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048431; cv=pass; b=qCyDZ10vXUwZMRV43aFiYoxQlt8JN9LLPaWGI4qp1y2LXzFzk7rZuEYqKKNgsge07/bZRjSQCXAzKIF/PGV3uHiCxboK8jSSuOY+Hy4zvYIcIoZAZCsu1MyjPfKhZduluwrEjZA8t7gc2V1hAsFkedTmDNNb/9q1qxq7l3RC9/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048431; c=relaxed/simple;
	bh=ZFnmxrNo70WpklfUyVACL3Oy4jcf+xqd3WgNxkh5AvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3AVmUJxDaPB/wtGbOWED5eCgJStjCod0Ebc24vthEJFqffZQvSyIU7oeSV+AYgseETmvzpVLt45dZhhGIO+zGI253d3MVFmy5hntN8xMRRmyz+zc4SUy/19Q1AA2N3NmjlKBzNdZVKd1TPAKSrV3lPhftoJyOgZGeHdR+CLVS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jyb0WMfF; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12ddbe104ccso6259264c88.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 23:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778048429; cv=none;
        d=google.com; s=arc-20240605;
        b=YnOup6ncboe1CN3lJs07Wey5cNBGGL4x6oSWiFfPaCxk7PZhkBcUOMekRIN4Ldlyqw
         mAYgFxN6USxqSbF+J7urT05bFB7E04jdQaXq9XGoFSQWMmMR8Alq+q29sM9zETJ5z4mz
         o+b6xuXRlfQZYfluuBt6GHeDT9Iz28ZMPa7/p3AEPWlurCXihhIOG7J2z6UQ0weXqlNd
         udAgLEgynVKs8i9hI2bmft7siL1mxzrbRfxCA1dy1Sms5O4jXtcqdb4nnLZDglveoQIk
         RiI3dJWhDaWbtV9If5FnoTssYmglokThIK5HnJW44Syry69ue9WJMA0xP62obS3xi/ii
         Kdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uNGn1qjxDE2jf86+NmckUHjftUOtsMEs4+hYqPdeOKU=;
        fh=Yko+7U/d4ofJ9KB87JXs072uXWzH9VxdPN4//Oz2lf4=;
        b=T7OuOvOPS7zP/FG3K6dkXNFwV2lCy8DLgQg55xDYs8JxZtPKAjoDhi60j5lWI4U1Wq
         LryBNgVL4GLpq8vDurRsu5zdF8Q6NAKvfEQFjjNgrBw4f0jHyXowQsSjxRZYvWIeEebn
         4SgnXJ1Lxbq3PLbEzV3koUL1WevApVG58FMPDP3r2gHVI38Ce6ROP3D073i7Zhbnf5Rj
         a7ja63pvq2Q1H3E4JFUR0C3EC7USrgdRHcd+DPSONa05feTslyAWJtHbP+ZSugTrd1oz
         gs2bJ9TCyu/rdbcUIc02Jhvh3wgWfYCIeuHwkQgaoPeLyqVv6wq4KKhUsc7k50c6a0uu
         NURw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778048429; x=1778653229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNGn1qjxDE2jf86+NmckUHjftUOtsMEs4+hYqPdeOKU=;
        b=Jyb0WMfF76QJkmz4e6G3OTKT9hdTh0Bj8lHFjMk5ri1XOSiV+0Pk2j7UwILzIQBmzn
         Xy80AFCYZiOtkgbs/KNzLFbgM2hsYAQlII4KjLtoQtTzVcJMNl59lgWOGgpQnjYhDWJL
         scD3eX4i01Whs1ws6qHdnOBQd8Vw1+dhdoCK+mqVz1OGMUxXQudK5QDAWZ1APRsXd04m
         5ViFKDDbPRCw5tNCtfCyB8xiLtjgeVfP0INuyreq9bvUUgdWPXuBMdtDA9UEGdquVLtK
         fGuqSXh1iV/QgGlP9uMVcd1bpw0ff3PZ63/Z5omyHJM19cV1RqZv2x+0HQZUUiBzXJoC
         7I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778048429; x=1778653229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uNGn1qjxDE2jf86+NmckUHjftUOtsMEs4+hYqPdeOKU=;
        b=KSxa1x5DPlmr6lbt6N5cDpk38gxuijdxbecoYmhHrmJZNRKvx6r7CHuyAa0Ai+99Pc
         e9PaRh4pK8fg292SFb8LtzzorZEXKRkjSWTm6WnpQyVczIB2Q+bYBT75WZlX2Cx0qc0I
         BdsfMoBBLaj+vNJpxQFFJjEYSbLxMiaZyqn1UZS0lT5P8Ey1C8JnqB4jhOqgFbqmVif5
         KIHmyw3bWsqeC/kgQ9+JG1R7bD0W1tIaasRftpfVTlCd7WbBaiftV8+nngsyEa+pEr8t
         FDPG4y1F67gC2hu7FzlPmyxufA/zL2CtHaxD0Gx1Y/Hao+4MOvyqtvFmF7NI4BmfD2ES
         pllg==
X-Forwarded-Encrypted: i=1; AFNElJ96XJrndbz2gk75h8FurKLhML/SpA6Nk79pJv1ZP4mW1LxpIm2eaW36dlGTRppH9zz5hMYACas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vHDP+B/X+1XnuAMVnaDK6vm3T40HnZIeyHHuQw/3MJVTdZTR
	f6Ro87R5VZ1Tul3TZclsQXZfYspbaCFiyjjh/FPtijI3yj1IPs+634EHEAaZVwNynzQGBQVLd97
	WUBRLrAmYMDkN76tJ3Asvy+w8R1FW0H5bORaE0wum
X-Gm-Gg: AeBDieuODTRHRnld0NJHapEK/MjY7yXs3iaI0B6M3A5viciMmRxy06bKfn4TiVS2naM
	01xURlUArMndtJ3ztXDJZeH6ndnMRihsgIitHcCo8sJ5Wq9fx9P411+9cuJy1XRYoft29l6W/R0
	+a02BXoEpBv1ZvfBO9iuvV5V1yZqOftzmWJjdywG5+pGuO2EE/UJw4Kvp9pFNboQROybPVpzSXv
	iF53F9r6Wvl3atGGry4peZzqVvb2nDUa2wk0vBMJO4qHs6XE1B5uwTZHkn3hzNQw2yUB2A9UqCA
	13EF2R+R+ifz5v/wzHdijRo4cwkfwA/Qsa40JPE/728l0RRLrTRyA13R4/KOmSYwMXs0CJsW+WW
	sSAsQ4DkIrli/sw6SWJk9rt3Qc9K5ykvQ5OWQjP6FlX7uweacdSFkk7ZI120GcamSZL0GjKS/5A
	==
X-Received: by 2002:a05:7022:662b:b0:128:d20a:2f40 with SMTP id
 a92af1059eb24-1317d893f21mr1195551c88.8.1778048428404; Tue, 05 May 2026
 23:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423053456.4097409-1-kuniyu@google.com> <afrY34dLXNUboevf@ly-workstation>
In-Reply-To: <afrY34dLXNUboevf@ly-workstation>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 5 May 2026 23:20:17 -0700
X-Gm-Features: AVHnY4L-vNJjr7nzTJhOeIyW1GiCbHjAkIalXHhXfu3EyxWdlnAU1pDs-BjouvA
Message-ID: <CAAVpQUC9jjKP5fZYr0HL9yJ-3QtMko-6=EEx1k2bcHZSWcbunA@mail.gmail.com>
Subject: Re: [PATCH v1 net] ipmr: Free mr_table after RCU grace period.
To: "Lai, Yi" <yi1.lai@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6AC3D4D687F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284710-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]

On Tue, May 5, 2026 at 11:00=E2=80=AFPM Lai, Yi <yi1.lai@intel.com> wrote:
>
> On Thu, Apr 23, 2026 at 05:34:54AM +0000, Kuniyuki Iwashima wrote:
> > With CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dn, ipmr_fib_lookup()
> > does not check if net->ipv4.mrt is NULL.
> >
> > Since default_device_exit_batch() is called after ->exit_rtnl(),
> > a device could receive IGMP packets and access net->ipv4.mrt
> > during/after ipmr_rules_exit_rtnl().
> >
> > If ipmr_rules_exit_rtnl() had already cleared it and freed the
> > memory, the access would trigger null-ptr-deref or use-after-free.
> >
> > Let's fix it by using RCU helper and free mrt after RCU grace
> > period.
> >
> > In addition, check_net(net) is added to mroute_clean_tables()
> > and ipmr_cache_unresolved() to synchronise via mfc_unres_lock.
> > This prevents ipmr_cache_unresolved() from putting skb into
> > c->_c.mfc_un.unres.unresolved after mroute_clean_tables()
> > purges it.
> >
> > For the same reason, timer_shutdown_sync() is moved after
> > mroute_clean_tables().
> >
> > Since rhltable_destroy() holds mutex internally, rcu_work is
> > used, and it is placed as the first member because rcu_head
> > must be placed within <4K offset.  mr_table is alraedy 3864
> > bytes without rcu_work.
> >
> > Note that IP6MR is not yet converted to ->exit_rtnl(), so this
> > change is not needed for now but will be.
> >
> > Fixes: b22b01867406 ("ipmr: Convert ipmr_net_exit_batch() to ->exit_rtn=
l().")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Hi Kuniyuki Iwashima,
>
> Greetings!
>
> I used Syzkaller and found that there is WARNING: suspicious RCU usage in=
 reg_vif_xmit in linux-next next-20260505.
>
> After bisection and the first bad commit is:
> "
> b3b6babf4751 ipmr: Free mr_table after RCU grace period
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_v=
if_xmit
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_v=
if_xmit/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_v=
if_xmit/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_v=
if_xmit/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_v=
if_xmit/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_v=
if_xmit/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260506_09=
1248_reg_vif_xmit/bzImage_next-20260505
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/260506_091248_reg_v=
if_xmit/next-20260505_dmesg.log
>
> "
> [   18.611146] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   18.611406] WARNING: suspicious RCU usage
> [   18.611657] 7.1.0-rc2-next-20260505-next-2026050 #1 Not tainted
> [   18.612022] -----------------------------
> [   18.612289] net/ipv4/ipmr.c:329 suspicious rcu_dereference_check() usa=
ge!
> [   18.612755]
> [   18.612755] other info that might help us debug this:
> [   18.612755]
> [   18.613314]
> [   18.613314] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   18.613758] 2 locks held by repro/725:
> [   18.614195]  #0: ffffffff87896440 (rcu_read_lock_bh){....}-{1:3}, at: =
__dev_queue_xmit+0x239/0x4140
> [   18.614860]  #1: ff1100000df5b918 (_xmit_PIMREG#2){+...}-{3:3}, at: __=
dev_queue_xmit+0x1d5d/0x4140
> [   18.615505]
> [   18.615505] stack backtrace:
> [   18.615814] CPU: 0 UID: 0 PID: 725 Comm: repro Not tainted 7.1.0-rc2-n=
ext-20260505-next-2026050 #1 PREEMPT(lazy)
> [   18.615826] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu4
> [   18.615831] Call Trace:
> [   18.615834]  <TASK>
> [   18.615838]  dump_stack_lvl+0x121/0x150
> [   18.615853]  dump_stack+0x19/0x20
> [   18.615864]  lockdep_rcu_suspicious+0x15b/0x1f0
> [   18.615882]  reg_vif_xmit+0x2ee/0x3c0

Thanks for the report.

I'll just move up rcu_read_lock() in reg_vif_xmit().

ipmr_fib_lookup() for CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
calls rcu_read_lock() at the same timing anyway.

