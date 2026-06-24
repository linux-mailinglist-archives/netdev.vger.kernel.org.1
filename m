Return-Path: <netdev+bounces-301662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zqbACynfO2oceggAu9opvQ
	(envelope-from <netdev+bounces-301662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:44:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC76BEC3E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ygf5Rpgo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301662-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473DC304224E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425B3B42E4;
	Wed, 24 Jun 2026 13:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D692D0610
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:42:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308563; cv=pass; b=sIsoPy4cKkIWuC1fGpw+7IHeGs83CEhsV5jkE7bSzpQIIDuoEGbBGSO76ynTjUE9zL58cvJjilZy3d/K7DeJ/OkOJE6MvvtH28ax/pJ529Y4Vyn/6hTiW3bp7drHY5Z6NMK5n03po1cc7MYJZU7VdR3cIFl95yiDDhOlW/4PjNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308563; c=relaxed/simple;
	bh=LRa5uC5sIo9ynceTk6iTbiYtdqTMv3fNyLerQsA4938=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOnWfXOIG/q1BcQ9SQO6mU3TU5ASE3NXYRHPy64CZVb/6kKpDTW0I5pAhbIo51NsVmdgs7kjl4DCEkXKvrQL8PEr1YVs/mg/doq6pkpqy7Kys4dV0on6d6yVhChEGrYr+tAkHtGCZG3GmgXN1FPLWiU3OXt0zE86QxQ1OClcV+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygf5Rpgo; arc=pass smtp.client-ip=209.85.217.46
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7269038ad05so783147137.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 06:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782308561; cv=none;
        d=google.com; s=arc-20240605;
        b=gLPQl2f7yYaEX5vvJ/EL6AVFPmp5570e0FE3C7wb3mOW8AhaVP6zoNdlJNMYpoYx/i
         FFMNyYrGAy2pZeB5wmUI3SipWK0h25MfsgaiSNQzPTnmCNF7sYBp28/iap5vOBpaSWau
         eZWWxDLkFYaoICrgqzTvnKRlWpRtLrdV48Z1mrbZd0mjWngMDwOoeWOnimYFaqS581BU
         Gzot2/2Ztwf1Dnio6yrNrZ2s1qc/TBXbkELTff073VjePS8jFwxAE32w03klsHlYX5eW
         WxYa6Fre7TlCJhEZ+mTUPt6Rb28Uf1iLiSSE9Aj/Hb55InyUk1RbyCYvRbRxr5lSeli7
         VvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76HR+eklWXgxHfzHdvnF6rFuKIHz69/Ic5PuGGNLF0I=;
        fh=jvpvPN+ombvKZ1uV/HgKozGtEzZu+sFam2RsqBn+C+c=;
        b=EbKlF0V2XJfXAW2G2MjetR+7JGW+j5brYSgUk26J5k6YZh3r3l6UMBJtt61+FQg+jb
         739+WMcHRD8NfZ8Aa/IfNsDsFOhxq693U8va6NwOUIm2WKz5tDQHPJYY4tqHCyp5SPMv
         6IYwdQ51/R6KSnR9Nhoe0LTVbAR63pbVFyaZlASDNpNCpSJ07rnOGxswwmab6cHKkuXu
         Ss9rS0z6zCtgpBo1vxsREOV+GiEacwtNUOALLufwEOZrOw8xqVNmB7UuuvIiYdV/0tqL
         4H/JXEZJTirqCfK8z0kVQeY/HRorQK/ssTE3PclQ2eXNz2W2DKYJ5+hUnPOK+dXxdT17
         OGHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782308561; x=1782913361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76HR+eklWXgxHfzHdvnF6rFuKIHz69/Ic5PuGGNLF0I=;
        b=Ygf5Rpgo5WvWn1y3CTWUR++ei0/g2bSsHwGZ85l5RSMdsdAaqUT382u7jQvnUEwXML
         keqUr7lk7kPlDW215iRyCJYNyPwsJDPJxyp0C0RqhIMciW27hHHixxXzSwSk/iX0CgoL
         8p8KTDM9yNmaUGRfqok27xz3fnQZttdY2vTjbmlzZDvPse616GuW947jbElA15R39Ac0
         cjOaJ89J69uV7D8XnjHJamJRxYFiBwY5jaXbPDlHgVsTna+CTmhoGi9yxcrW+bNeWv1J
         txMNCPAxYJeAMOwoz8Q9jeGvUAtLQioN1Wjgcom7IpZv97bnkxWyGo/i0LWQLRM/Odwr
         9IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308561; x=1782913361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76HR+eklWXgxHfzHdvnF6rFuKIHz69/Ic5PuGGNLF0I=;
        b=X5ud1R0qQ6ZOmBfe4AXyLagmQBtTD43q/6eM5KuwdKVGpF52DebRG/9GKeLAh89Og4
         HI9vRHrJkMeLLWG54Ix2UgqBQwFwqjgPg+ym74kD5c4sAgwY4x0AvpX5PML1/Vza5E7C
         NM+HrA6NzJtMD/G2FGr+8NoGfyBt4WZ7cJeOMAyWaiIme3XCL/qDd107LGNtlIjX/jrO
         y1hNQZUqH9Kt0kdiNF2XYQ6g6+XN1LyLvhfw8L2rXc36xtTkMvwN86yFt2zzFqzEncOD
         vR7K1AsZnc+yBkqkXuCd6enq1iRmvtG5W7CgpHyZygESU+2L1131ozPHWU+ZI6mW9xiV
         3hVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFl4tXYrMHUoT3j0me4a/3UM2fUC37MqHou/zxwGNIA1U6lSyout/KM5ZM50Ic0UBtW1+LjUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZU8cTqxGIzw7sz/9qPwCErVKruMvlA+UQmNitQIOzxCGrDLyP
	bdSOfsVz3Y5rmk0gCz49atEyuBsN7E0RzPe5V7u4XBxstuu+njhTMs7HHK7erxqWAA8wdYCPp7Y
	ZbzvC0+lO4tMCuvVvOQUEzV6eT6lph6k=
X-Gm-Gg: AfdE7cmR+dMduB3u9upAgTrbheZvbSZm+xTfy6iQ6ZvQna3v/1TjzotoNgDAzfrSJWy
	Vrc+r0TmRoZN513RbIdyelDbQdWZYgtxH4L6RM48R6rBL3KDcbsfkeNhM8wmtjjQGsh1oJvpTc1
	2kwefV092SIV+QTHVZrI8codxuG6LS5AXdvoz0x4+54z3ZUV8aZZIf6ho1CI5LvGlHFhPmOf307
	uMPe4GeSf6vCS6TlQ6Scp2I35RIntIelafbNjisRrXYn7C2vKoek9XlIAEvuEQg7C0lf6fr8g==
X-Received: by 2002:a05:6102:374a:b0:728:89af:8ecf with SMTP id
 ada2fe7eead31-731133ccfb4mr1528605137.7.1782308561343; Wed, 24 Jun 2026
 06:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com> <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
In-Reply-To: <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Wed, 24 Jun 2026 21:42:29 +0800
X-Gm-Features: AVVi8CdKIbid9l84CuIX2M2sbKaTZu1s3rgvykGU04lBKY0GztB0qoQu0wfAI9A
Message-ID: <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
Subject: Re: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80DC76BEC3E

On Wed, Jun 24, 2026 at 6:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jun 24, 2026 at 2:01=E2=80=AFAM Yue Sun <samsun1006219@gmail.com>=
 wrote:
> >
> > Hello,
> >
> > I hit a reproducible use-after-free in the UDP tunnel NIC offload work =
item.
> > The original local crash was reported by KFENCE as:
> >
> >   KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
> >
> > On current mainline, the C reproducer below triggers the same lifetime =
bug,
> > reported by KASAN before KFENCE samples the object:
> >
> >   BUG: KASAN: slab-use-after-free in __mutex_lock
> >   Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
> >
> > Tested kernel:
> >
> >   840ef6c78e6a ("Merge tag 'nfs-for-7.2-1' of git://git.linux-nfs.org/p=
rojects/anna/linux-nfs")
> >   Linux 7.1.0-11240-g840ef6c78e6a #31 SMP PREEMPT_DYNAMIC
> >
>
>
> Thanks or the report.
>
> Can you test the following patch?
>
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..c5f8d2f9d325de8f4d2247dda=
a52e33378851857
> 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -304,8 +304,8 @@ udp_tunnel_nic_device_sync(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>         if (!utn->need_sync)
>                 return;
>
> -       queue_work(udp_tunnel_nic_workqueue, &utn->work);
>         utn->work_pending =3D 1;
> +       queue_work(udp_tunnel_nic_workqueue, &utn->work);
>  }
>
>  static bool
> @@ -866,6 +866,11 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>
>         udp_tunnel_nic_lock(dev);
>
> +       if (utn->work_pending) {
> +               udp_tunnel_nic_unlock(dev);
> +               return;
> +       }
> +
>         /* For a shared table remove this dev from the list of sharing de=
vices
>          * and if there are other devices just detach.
>          */
> @@ -901,12 +906,6 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>         udp_tunnel_nic_flush(dev, utn);
>         udp_tunnel_nic_unlock(dev);
>
> -       /* Wait for the work to be done using the state, netdev core will
> -        * retry unregister until we give up our reference on this device=
.
> -        */
> -       if (utn->work_pending)
> -               return;
> -
>         udp_tunnel_nic_free(utn);
>  release_dev:
>         dev->udp_tunnel_nic =3D NULL;

I tested the patch, but unfortunately the C reproducer still triggers the
same use-after-free for me.

Tested on top of:

  840ef6c78e6a ("Merge tag 'nfs-for-7.2-1' of
git://git.linux-nfs.org/projects/anna/linux-nfs")

I booted the kernel with KASAN/KFENCE enabled and:

  panic_on_warn=3D1 panic_on_oops=3D1 kfence.sample_interval=3D1

Then I ran the same C reproducer:

  timeout -k 10 360 /root/repro

The VM panicked after about 236 seconds:

[ 236.471119][ T58] BUG: KASAN: slab-use-after-free in
__mutex_lock+0x16d0/0x1d80
[ 236.473404][ T58] Read of size 8 at addr ff11000076a63ea8 by task
kworker/u16:3/58
[ 236.476455][ T58] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[ 236.476478][ T58] Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_wo=
rk
[ 236.476787][ T58] __mutex_lock+0x16d0/0x1d80
[ 236.477020][ T58] udp_tunnel_nic_device_sync_work+0x32/0x9c0
[ 236.477068][ T58] process_one_work+0x9de/0x1bf0

The allocation/free stacks are still the same shape:
```
Allocated by task 11563:
__kmalloc_noprof
udp_tunnel_nic_netdevice_event+0x12d8/0x1e80
register_netdevice
nsim_create
nsim_dev_reload_up
devlink_reload

Freed by task 11609:
kfree
udp_tunnel_nic_netdevice_event+0xc26/0x1e80
unregister_netdevice_many_notify
nsim_destroy
nsim_dev_reload_down
devlink_reload

Last potentially related work creation:
queue_work_on
__udp_tunnel_nic_del_port+0x2af/0x320
udp_tunnel_notify_del_rx_port
__geneve_sock_release.part.0
geneve_stop

Second to last potentially related work creation:
queue_work_on
__udp_tunnel_nic_add_port+0x6ec/0xd70
udp_tunnel_notify_add_rx_port
geneve_open
```

My read of the patch is that it closes the small window where queue_work()
can publish the work before utn->work_pending is set, and it also prevents
udp_tunnel_nic_unregister() from flushing/freeing the object when
work_pending is already set.

However, the test above suggests that work_pending still does not fully
protect the lifetime of struct udp_tunnel_nic. The crashing work was still
queued through udp_tunnel_nic_device_sync() at line 308, so the patched pat=
h
was exercised. One suspicious point is that udp_tunnel_nic_device_sync_work=
()
clears utn->work_pending at the beginning of the worker, while the same wor=
k
item can still interact with replay/add/del-port state. The reproducer can
still end up with udp_tunnel_nic_unregister() freeing utn while a
udp_tunnel_nic_device_sync_work item later runs and dereferences the freed
utn->lock.

So this patch does not seem to be sufficient for this reproducer.

Thanks,
Yue

