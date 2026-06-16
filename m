Return-Path: <netdev+bounces-299790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +14dO8AZMWqAbgUAu9opvQ
	(envelope-from <netdev+bounces-299790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:39:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19068D9FD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cVbypWNr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299790-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B473096446
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF5423146;
	Tue, 16 Jun 2026 09:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB253ACF17
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:34:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602479; cv=pass; b=CcNSd91wZYyjD0Wl6va308Wj1GjLQqRwhxr76JbfAs0OOFa2DMH2QbfIcFX7nfiE7S8FTMmA34ZAx4bRcdRkVN98s2fOIMy4x5UNw2pB+krVSDKtnXzLP4yYy3nVbX0QilnGSKNmEk84L0V6w7Ssl23XcIkqtmBMZv6AyxJTpJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602479; c=relaxed/simple;
	bh=GVazTnBythNsskFgIpBlMlxrv3oZYIQVXFQi51ZYrhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahxzCZ67VcTGzHjJYXbBGXTDxBuxae3uwb+5Ub0ahI28Vfx+Kf2+1t6hjKZKgCf8M894OlZ4HpGp0xyhBS9irCapMjCNs+PQ4pxYgS1JjQDrQvOon1Y6atuTczWBMh9AGE9RtizHLfEL2Yao4doAg6Q+Kr77XOB9Mro+iPaqY7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVbypWNr; arc=pass smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so6084100a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781602475; cv=none;
        d=google.com; s=arc-20240605;
        b=cqoyEQixofyCJnIhE6xjwUS89K3XjrRbo5WDFZvMwLnIKzj51N8qA6xiCMzXHicewZ
         JJzQPjJ0pTZ5z1BOs6CWFXt02E8+tvKZGALw7SV4wCf9bLcJ0nOy3X9s6CvtxNJYwfCT
         H3cq9+Y6jw34JayxdJjBA25puL0o0WszAi9WmP0FGODdgJuK5yaDPFqy+rtLGA4+Kcmz
         Qrw+JcvQs7hdD2ir93cVHFXZUBq84GOGAbIJ9N7N5cbujoD74gUTEC9y9Iu8i1fg/dZy
         v5QKAPBj2BcPQquu9atAKOvjiLcuCtyqoijP5ZetxYI6jpM8a2zOGunObOaTaAuqv7rV
         KZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RpjEcJ+V1ClE14yZkPG7IvmcYbq1CkQq3NaXRVLmvgM=;
        fh=6diq9e2lwxukJM0gI/jjFXw/dmuWs/NwtX7O/n4ZcD8=;
        b=MTAHYGZpqzMbJgWbB0dUp7AloDU5FctFnZmQPcdSFaN9YS78VX82s3FZm/pTTW3GAN
         i3rOx+r4iSEjEr9xchqu+uuSgZ3oE3H7z1WF/glaHEwVTX2L6uToEz8MXUv1QTEf/89y
         7FJg0iGy3JYC4s/rIBlxyHCwqC3gvJrtoY8hhWov9rFqeuIPOxY73ylYZdcg2+vicNOp
         BkelsLYUXz/2kjYvguJav5MRv4Qe0IAY9A65+BJvkdeBJfUoX6HWVVnf6kWFpOVoHAq0
         5KNlWIK87yONEnoCu4aQs9ln6zdAo7m+6B1PdgogrL+7VcKfJbJi/rxpBSFH//f/qcHo
         4JQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602475; x=1782207275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpjEcJ+V1ClE14yZkPG7IvmcYbq1CkQq3NaXRVLmvgM=;
        b=cVbypWNrD5WQA7ZVQ5IES+Mf/t1nWWrN3gtmyey0V8bPl7LV6o9EdFMERdOw4tonWs
         sNutX00hHeP941rfRTXKYFmUCoXdkbdoB0m3sZkvDj3TGrub+vlISc/03YDMUuMbq2ky
         rv+aw9IH3d++1DZwURtgmvA5bDb6J1ni1il33BkZG5UhIcqhS9TTHFj2Ve+2XIl440hN
         iru41SzCXEwDOaRfn4gP+anEISDpcwBvDQBXnwvPrfX61p9h0LMNoUJ2lJjXrMjU1Txk
         MkTedNcY5Fh5eugVf5zvBLJO+j+9V4eAMwnJD4GpVgkzYx73xJOwrqNi5ZHEnzY10dSw
         7rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602475; x=1782207275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpjEcJ+V1ClE14yZkPG7IvmcYbq1CkQq3NaXRVLmvgM=;
        b=FxnQ9TOuOO6HZeMA9o1/aaXbWBJrxIYCe/YU0NAMP2qT10vYEpGlekznJIoqhMZ849
         aeuZ6HIalmYC1HDqk5k+MOHKQC0MgxxopABMttW+7hu8o845I4b40P8sxNPFKlEnrC5R
         r1ijEjrxgw0OnvLPv5/oJBPXXxDYTfwegZ2qyzMKkfC26O0J15utCptPOLy2b+v/5Shx
         Md4pcddwQm5owY7mnnZFxO5SSaCJgpdkyy160w/zQwJz2ItVBHtDRTn9l975NQ5WXZtE
         pwuWZzlLDOHoh5iZrILQxIhqca9ok/0wqKM2Dj6eeXhAVhWTdNRT3ElLfHy8X4oEdZa6
         dWkA==
X-Gm-Message-State: AOJu0YyqK+tyEzJ131rn8IQWd0oMvdfR4T3eLgvbuw+BQMgg4Rbsmc2M
	gmOdb1uxxBrc9QAntwFn+wwSGI6+unTYBSGbEuPBSP5JwvkoOKoCSNp7ZaJHqCKLGUrOwNW/nOk
	PbBvynUHOvHDPHMtKld5KAe6Av/Vq3ew=
X-Gm-Gg: Acq92OFlCHfyiojqBggsTUJXQsijuDpkcjTcIDVz5065JfESPcbAAYHDTbLF+DJiBsO
	6aYejDDLPU3chwxiFSUiMogYeALVaH67mTWYyjSOBv3ixi3Ea03Cs9TxkVRqjCWAENNNGSfRBAg
	27qDiQq/2dAdEn++H4s3zS/hv1Rn79gUI8835gDXPKvuT19CXyISi909Qt0DE+dPQx4JUWyMyTZ
	IBFWCP403Qn18N/TkDSQMBBq1/WdgtKJIRbzKn7Sh4GSXr5JeVwM0+xUkB5Md1kKShjwylWoXwl
	AgQNq+6YVzqV/L4OTJDD/5d57cgx1w3BhV2PQZlD4A==
X-Received: by 2002:a05:6402:538d:b0:687:74de:985b with SMTP id
 4fb4d7f45d1cf-69378a32942mr8887654a12.14.1781602474924; Tue, 16 Jun 2026
 02:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178144969601.60470.14764529841344817811@gmail.com>
In-Reply-To: <178144969601.60470.14764529841344817811@gmail.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Tue, 16 Jun 2026 12:34:24 +0300
X-Gm-Features: AVVi8CcRDEyAKGlKpvlo4m6U5CQa7Qzq-AaoBdECYCPWDC97Dfeu-pbDWjMDLws
Message-ID: <CAHfVqdXqZkrp5Dm0a8BJU0Tbc_T09A=e02PenwxrZFDMQrEmyQ@mail.gmail.com>
Subject: Re: [BUG] netdevsim: KASAN slab-use-after-free in ref_tracker_free
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299790-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shuangpeng.kernel@gmail.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:shuangpengkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[saeedbisharaos@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saeedbisharaos@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B19068D9FD

I tried gemini, here its analysis and a fix suggestion:

This is a brilliant, subtle bug. Let's break this down with a rigorous
audit of the Linux network device refcounting architecture to see
exactly why this Use-After-Free is occurring.
The root cause is a classic "Reverse-Teardown Fallacy" colliding with
the kernel's dual-refcount lifecycle for network devices (pcpu_refcnt
vs. kobject refcount).

The Dual-Lifecycle Trap
In modern kernel networking, a struct net_device is kept alive by two
distinct mechanisms that must be carefully orchestrated:
dev->pcpu_refcnt (Operational Lifecycle): Managed by dev_hold() and
dev_put(). This tracks active operational references. The
unregister_netdevice sequence blocks in netdev_run_todo() waiting for
this to hit zero before it invokes free_netdev().
dev->dev.kobj (Memory Lifecycle): The underlying memory structure
manager. free_netdev() drops a reference to this. When the kobject
refcount hits 0, device_release() is synchronously triggered, and the
kmalloc-cg-8k slab is actually freed.

The Exact Race Sequence
Look at the teardown order in the error path of sysfs_rtnl_lock():

unbreak:
    sysfs_unbreak_active_protection(kn);  // LINE 121
    dev_put(ndev);                        // LINE 122

Normally, developers write error paths in the exact reverse order of
initialization. However, in this specific case, adhering to that
convention is fatal.
The Setup: sysfs_rtnl_lock starts by calling dev_hold(ndev),
incrementing the pcpu_refcnt. It then calls
sysfs_break_active_protection(), which explicitly calls kobject_get(),
elevating the kobj memory refcount.
The Unregister Race: In parallel, another CPU initiates device
teardown (e.g., echo 1 > del_device on netdevsim). The sysfs entries
are deleted, and device_del() drops its primary kobj reference. The
teardown thread hits netdev_run_todo() and blocks, waiting for
sysfs_rtnl_lock to release its dev_hold.
The Lock Fails: sysfs_rtnl_lock fails to get the rtnl lock and jumps to unb=
reak.
The Fatal Drop (Line 121): sysfs_unbreak_active_protection(kn)
executes. It calls kobject_put(). Because the unregistration path
already dropped the standard kobject references, this is the absolute
last kobject reference. device_release() is synchronously invoked, and
the net_device memory is instantly freed to the slab.
The KASAN Trigger (Line 122): dev_put(ndev) executes. Under the hood,
it attempts to call netdev_tracker_free(&ndev->ref_tracker, ...). It
reads from the ndev structure that was just destroyed microseconds
earlier. KASAN screams.

To fix this, the teardown convention must be deliberately violated to
respect the underlying memory dependencies.

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a1b2c3d4e5f6..7f8e9d0c1b2a 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -118,8 +118,8 @@ static int sysfs_rtnl_lock(struct kobject *kobj,
struct attribute *attr,
  return 0;

 unbreak:
- sysfs_unbreak_active_protection(kn);
  dev_put(ndev);
+ sysfs_unbreak_active_protection(kn);
  return ret;
 }


On Mon, Jun 15, 2026 at 4:18=E2=80=AFAM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> Hi netdev maintainers,
>
> I hit the following KASAN report while testing an upstream kernel.
>
> The issue was reproduced with netdevsim. I have not confirmed whether thi=
s is
> specific to netdevsim or whether other net devices can trigger a similar =
issue.
>
> The KASAN report shows a slab-use-after-free in ref_tracker_free(), reach=
ed from
> sysfs_rtnl_lock() while reading phys_port_name.
>
> I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (Ma=
y 25 2026)
>
> To help trigger the bug more reliably, we applied a minimal diagnostic pa=
tch
> that only adds delays and print statements.
>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/b49765d646ec4610917015371aa1c3ca
>
> I'm happy to test debug patches or provide additional information.
>
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>
> [ 3145.449971][T17497] BUG: KASAN: slab-use-after-free in ref_tracker_fre=
e (lib/ref_tracker.c:295)
> [ 3145.452089][T17497] Read of size 1 at addr ffff888107678598 by task ca=
t/17497
> [ 3145.454439][T17497]
> [ 3145.454977][T17497] Tainted: [W]=3DWARN
> [ 3145.454980][T17497] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + P=
IIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [ 3145.454985][T17497] Call Trace:
> [ 3145.454991][T17497]  <TASK>
> [ 3145.454994][T17497]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stac=
k.c:120)
> [ 3145.455002][T17497]  print_report (mm/kasan/report.c:378 mm/kasan/repo=
rt.c:482)
> [ 3145.455028][T17497]  kasan_report (mm/kasan/report.c:595)
> [ 3145.455046][T17497]  ref_tracker_free (lib/ref_tracker.c:295)
> [ 3145.455083][T17497]  sysfs_rtnl_lock (include/linux/netdevice.h:4491 i=
nclude/linux/netdevice.h:4508 include/linux/netdevice.h:4534 net/core/net-s=
ysfs.c:122)
> [ 3145.455091][T17497]  phys_port_name_show (net/core/net-sysfs.c:665)
> [ 3145.455118][T17497]  dev_attr_show (drivers/base/core.c:2421)
> [ 3145.455128][T17497]  sysfs_kf_seq_show (fs/sysfs/file.c:65)
> [ 3145.455135][T17497]  seq_read_iter (fs/seq_file.c:231)
> [ 3145.455144][T17497]  vfs_read (fs/read_write.c:493 fs/read_write.c:574=
)
> [ 3145.455169][T17497]  ksys_read (fs/read_write.c:717)
> [ 3145.455181][T17497]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arc=
h/x86/entry/syscall_64.c:94)
> [ 3145.455188][T17497]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:121)
> [ 3145.455193][T17497] RIP: 0033:0x7fcf098c43ce
> [ 3145.455200][T17497] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 08 0b 00 e8=
 69 01 02 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14=
 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> [ 3145.455204][T17497] RSP: 002b:00007ffd05e76b98 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000000
> [ 3145.455211][T17497] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 0=
0007fcf098c43ce
> [ 3145.455214][T17497] RDX: 0000000000020000 RSI: 00007fcf095e4000 RDI: 0=
000000000000003
> [ 3145.455217][T17497] RBP: 00007fcf095e4000 R08: 00007fcf095e3010 R09: 0=
000000000000000
> [ 3145.455219][T17497] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0=
000000000000000
> [ 3145.455222][T17497] R13: 0000000000000003 R14: 0000000000020000 R15: 0=
000000000020000
> [ 3145.455227][T17497]  </TASK>
> [ 3145.455229][T17497]
> [ 3145.479014][T17497] Freed by task 17497 on cpu 0 at 3145.447575s:
> [ 3145.479559][T17497]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/c=
ommon.c:78)
> [ 3145.479963][T17497]  kasan_save_free_info (mm/kasan/generic.c:584)
> [ 3145.480411][T17497]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan=
/common.c:285)
> [ 3145.480813][T17497]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 m=
m/slub.c:6251 mm/slub.c:6566)
> [ 3145.481148][T17497]  device_release (drivers/base/core.c:2542)
> [ 3145.481567][T17497]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 =
include/linux/kref.h:65 lib/kobject.c:737)
> [ 3145.481951][T17497]  sysfs_rtnl_lock (net/core/net-sysfs.c:121)
> [ 3145.482351][T17497]  phys_port_name_show (net/core/net-sysfs.c:665)
> [ 3145.482782][T17497]  dev_attr_show (drivers/base/core.c:2421)
> [ 3145.483154][T17497]  sysfs_kf_seq_show (fs/sysfs/file.c:65)
> [ 3145.483586][T17497]  seq_read_iter (fs/seq_file.c:231)
> [ 3145.483975][T17497]  vfs_read (fs/read_write.c:493 fs/read_write.c:574=
)
> [ 3145.484334][T17497]  ksys_read (fs/read_write.c:717)
> [ 3145.484701][T17497]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arc=
h/x86/entry/syscall_64.c:94)
> [ 3145.485092][T17497]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:121)
> [ 3145.485592][T17497]
> [ 3145.485794][T17497] The buggy address belongs to the object at ffff888=
107678000
> [ 3145.485794][T17497]  which belongs to the cache kmalloc-cg-8k of size =
8192
> [ 3145.486991][T17497] The buggy address is located 1432 bytes inside of
> [ 3145.486991][T17497]  freed 8192-byte region [ffff888107678000, ffff888=
10767a000)
> [ 3145.488159][T17497]
> [ 3145.488367][T17497] The buggy address belongs to the physical page:
>
>
> Best,
> Shuangpeng
>

