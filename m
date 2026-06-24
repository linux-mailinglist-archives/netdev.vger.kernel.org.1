Return-Path: <netdev+bounces-301666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MO9XONbiO2omewgAu9opvQ
	(envelope-from <netdev+bounces-301666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD36BEE53
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:59:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ECZhB04C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301666-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DC363025F4F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5843B95F2;
	Wed, 24 Jun 2026 13:59:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494E3B7B7B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:59:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309588; cv=pass; b=Ae/v/i4L95eeqDgtNGGO3r82ksOUTICm+aJ4ixb3ykd1GJbsWsMrPUM9B4pHKDaPls6Terq4YGHSJei2VW9O0UEq6C7GFZQfQ8xi8xortN9iD4z7JreTIO8UXBkG/nYvoEJYglL9vFxBuvdI/tgknk/KVN3q5ZPDBJyFXw1+T38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309588; c=relaxed/simple;
	bh=V2EUYSdGtW7m3Aw4m6n9WbdlxjOlAz7SU+/a3C1AnzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajR+p4YHEoIeMJaWfdZ/0Np6YQRf+tzR/xcbcCXVJccAHaTqWnw91ThPU7IhLPResUXkdIuTaCaAIe/ORydmuxGg2+wVtk/KdWX4v9Hyc1QnLGfuSMATJgNIfgSwgO1eE3brgoLqGXQstYhBnupxcO6TamEmj7znjUHlX4AdaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECZhB04C; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-517dc520840so9723421cf.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 06:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309586; cv=none;
        d=google.com; s=arc-20240605;
        b=FetTSlgSirxcqgXHC5rpcxPiAdGOX6W8zboe7986y0uXuyQSuzr+BS5rukPc9+6np2
         dQt6dBr27iWYWsQ0NnJtWgUiBuTcw+RJP4/bBQC3GPVykOuTdZ8AQO6gR2Y2rbbJcXLL
         qUpj20440mLqy9ZJ97U/TQnlcAbELbW0eBha8BLbk6Cmlyhb4qccMPGVb9bxSpzmkIdy
         IBfBxzKI3X+2IEdoc3JwBs87z/aaP7KDX7X4YAsFP+2s90pzEU1YVyygBWuTfGnRXoNH
         i2t6+D4BCAIklKU9cs6/8gnWKjb/YRo+YLG4c7AldRVmLyOWDjHpL1ixpPDfzl0qRxGa
         j9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IPjZx587TohMDbgAlzqgaOnK/IpS5K+mfsCogDhtDgk=;
        fh=22emKQCdCwvaVfmfg07j/HUi64lqp5cAracPlTX+PSo=;
        b=Gb/M8ZxjhoGrTcZn92a8VPzSQU3DVaJjZ8anR+3FqUPXnsgmYt+Umv3igtYXEENsF9
         dYdz5aNuMpj5tXCbw17Bt1UAPZ3+hJMx1VXcLRHH+a6P/lrf9cEWT4n+spMs2elKq3Cp
         3WUb2rHu+JI03lgWrjqcXI6cVvQSYEvIgk47yE1HK2LYXRDUMCBRI4b19VxmXgIjqNNH
         eVea3za2Wpswxsw0/74onfZM1fwGVVXudyKjbEumTJh/F4ryR3kC24g5/WfjGJBaY2hc
         fksCdhd2NaxP6EXqItQkopDqX+RaIzFaAWJuldVNfsQWrjfyGEHU2M4tiPnmKYqM/a3Z
         uUrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782309586; x=1782914386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPjZx587TohMDbgAlzqgaOnK/IpS5K+mfsCogDhtDgk=;
        b=ECZhB04C1Le/GUG/id3Csa0Jo3cg/BGPfpPl06qgx90TslehBrAuvT5vO0jVHwFYCi
         X5vWzI7FK3WD+p/06sozo9turnnCrS5KiuNBmNIAuiDIX3cD2S7WF9lR0mDQPxCRpFDW
         9SYzTAL43v+oI7qhnsPSNiocEXdC5fU9ZkGU8Uj4qL4M1qXoM8z03XTnl6M3rLvo5lVz
         HLNMN0OdwFq9T5sfa6E6M6qFUVnLICK5sJHRD7Wce+9F4aPg9JmeMZ2/cYpuVZNP7mgD
         3U6Bn/OfRZY2//DKGO644bicFSC7dLJqkZOMvBmqUjLBjpfsat1k7gtznCRdpyFzpw1z
         7/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309586; x=1782914386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPjZx587TohMDbgAlzqgaOnK/IpS5K+mfsCogDhtDgk=;
        b=UN0JTOxKq6XdcwBT1DVG7ctnIEU9MaoxKKRv12kGLg2/23/qBHZsLPnnX6bGR5Qp1H
         iezdV76c1EUzy4p8Pai5faoMjqY8n94v3CJ9Y8aaMgGU4Y9VtRqVhWer7d2JqXPp6g8j
         oDsc2rzNn13bhl4s94K9PPLxS3gJBRwQzPv5BAVYrGy4RDYRIAUNZTzwzWpy8GWik6n5
         np+wgvTapsdOE7LAqkgibFHwD9mynhAxlztFdEBznTWzO2ma8TOnXtrQi8yC5PRIQioe
         E898x0FRd6cU0t8WS/M0p5VNN5gy7wVOXjZEgXMwRE0XTvNGV8mFLUug7gvhNlKRyeQ6
         8Mhw==
X-Forwarded-Encrypted: i=1; AFNElJ8nlPHxY/KjeEyZx+SuaVM/d2Ddte97FpIgim+5kkRUKZo/BaOb8XbTIxafUDR++5j07PR0V6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rog/rd2aYg/gWHiihJBIahJt2v7n6zHq3dgb8eAS8e8pVBAf
	L6/KdJaRk9mfhJvQEb2y4ljTboixZSZCM+Ez7mBvBiiozTFABIzKvqAzK0W77ShrqOM+oLvtn8X
	S3RjvNF4poOw/awFyVYhw6IAK4oxu7S/goigeHz1w
X-Gm-Gg: AfdE7ckhz0dTVlXFABPvBo9yTowoid+e77BKv6Yv37zH273B+PaVqc5hDeaWmpRqhQF
	U9/ixsKhU4RGkTWhME7QJ5/XTFxjSZgOLKY6Pkm8uUuqI5HmgvMj8Bsrapp0Lgu9gNzZaxwtlDD
	OvGixjKgp9Z27b1fa2cnwVG1ChXU2Z5EnLwprgoB8xaT2ZoeedVyC2jRd2xwOxBdmr47DIo0u7x
	YnwtHUZNF0C8Rl8ux5ubd+ul8votfrFrfkTO/gTy1E5qi3PLGaXWtSGYtYXj8GJEEKZu2E/QAUw
	pielF2mKkLLy5Vt4fIx8uWl7pHGGS7ecYvMeM3f1rg60iXmMiE1RhOEv5ETPHDU8X+3KxOHF5dj
	HIzJwzrF+Gw==
X-Received: by 2002:a05:622a:1101:b0:517:29f6:cee5 with SMTP id
 d75a77b69052e-51a61c70f0dmr50950161cf.49.1782309584831; Wed, 24 Jun 2026
 06:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
 <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com> <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
In-Reply-To: <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 06:59:33 -0700
X-Gm-Features: AVVi8CfNruVRxa-vPHeF0EFoTPk0YineqVA770lzyibgRqaNz2z7UDVceVDj4EY
Message-ID: <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com>
Subject: Re: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
To: Sam Sun <samsun1006219@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:samsun1006219@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301666-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62AD36BEE53

On Wed, Jun 24, 2026 at 6:42=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> w=
rote:
>
> On Wed, Jun 24, 2026 at 6:01=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jun 24, 2026 at 2:01=E2=80=AFAM Yue Sun <samsun1006219@gmail.co=
m> wrote:
> > >
> > > Hello,
> > >
> > > I hit a reproducible use-after-free in the UDP tunnel NIC offload wor=
k item.
> > > The original local crash was reported by KFENCE as:
> > >
> > >   KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
> > >
> > > On current mainline, the C reproducer below triggers the same lifetim=
e bug,
> > > reported by KASAN before KFENCE samples the object:
> > >
> > >   BUG: KASAN: slab-use-after-free in __mutex_lock
> > >   Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
> > >
> > > Tested kernel:
> > >
> > >   840ef6c78e6a ("Merge tag 'nfs-for-7.2-1' of git://git.linux-nfs.org=
/projects/anna/linux-nfs")
> > >   Linux 7.1.0-11240-g840ef6c78e6a #31 SMP PREEMPT_DYNAMIC
> > >
> >
> >
> > Thanks or the report.
> >
> > Can you test the following patch?
> >
> > diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> > index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..c5f8d2f9d325de8f4d2247d=
daa52e33378851857
> > 100644
> > --- a/net/ipv4/udp_tunnel_nic.c
> > +++ b/net/ipv4/udp_tunnel_nic.c
> > @@ -304,8 +304,8 @@ udp_tunnel_nic_device_sync(struct net_device *dev,
> > struct udp_tunnel_nic *utn)
> >         if (!utn->need_sync)
> >                 return;
> >
> > -       queue_work(udp_tunnel_nic_workqueue, &utn->work);
> >         utn->work_pending =3D 1;
> > +       queue_work(udp_tunnel_nic_workqueue, &utn->work);
> >  }
> >
> >  static bool
> > @@ -866,6 +866,11 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> > struct udp_tunnel_nic *utn)
> >
> >         udp_tunnel_nic_lock(dev);
> >
> > +       if (utn->work_pending) {
> > +               udp_tunnel_nic_unlock(dev);
> > +               return;
> > +       }
> > +
> >         /* For a shared table remove this dev from the list of sharing =
devices
> >          * and if there are other devices just detach.
> >          */
> > @@ -901,12 +906,6 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> > struct udp_tunnel_nic *utn)
> >         udp_tunnel_nic_flush(dev, utn);
> >         udp_tunnel_nic_unlock(dev);
> >
> > -       /* Wait for the work to be done using the state, netdev core wi=
ll
> > -        * retry unregister until we give up our reference on this devi=
ce.
> > -        */
> > -       if (utn->work_pending)
> > -               return;
> > -
> >         udp_tunnel_nic_free(utn);
> >  release_dev:
> >         dev->udp_tunnel_nic =3D NULL;
>
> I tested the patch, but unfortunately the C reproducer still triggers the
> same use-after-free for me.
>
> Tested on top of:
>
>   840ef6c78e6a ("Merge tag 'nfs-for-7.2-1' of
> git://git.linux-nfs.org/projects/anna/linux-nfs")
>
> I booted the kernel with KASAN/KFENCE enabled and:
>
>   panic_on_warn=3D1 panic_on_oops=3D1 kfence.sample_interval=3D1
>
> Then I ran the same C reproducer:
>
>   timeout -k 10 360 /root/repro
>
> The VM panicked after about 236 seconds:
>
> [ 236.471119][ T58] BUG: KASAN: slab-use-after-free in
> __mutex_lock+0x16d0/0x1d80
> [ 236.473404][ T58] Read of size 8 at addr ff11000076a63ea8 by task
> kworker/u16:3/58
> [ 236.476455][ T58] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [ 236.476478][ T58] Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_=
work
> [ 236.476787][ T58] __mutex_lock+0x16d0/0x1d80
> [ 236.477020][ T58] udp_tunnel_nic_device_sync_work+0x32/0x9c0
> [ 236.477068][ T58] process_one_work+0x9de/0x1bf0
>
> The allocation/free stacks are still the same shape:
> ```
> Allocated by task 11563:
> __kmalloc_noprof
> udp_tunnel_nic_netdevice_event+0x12d8/0x1e80
> register_netdevice
> nsim_create
> nsim_dev_reload_up
> devlink_reload
>
> Freed by task 11609:
> kfree
> udp_tunnel_nic_netdevice_event+0xc26/0x1e80
> unregister_netdevice_many_notify
> nsim_destroy
> nsim_dev_reload_down
> devlink_reload
>
> Last potentially related work creation:
> queue_work_on
> __udp_tunnel_nic_del_port+0x2af/0x320
> udp_tunnel_notify_del_rx_port
> __geneve_sock_release.part.0
> geneve_stop
>
> Second to last potentially related work creation:
> queue_work_on
> __udp_tunnel_nic_add_port+0x6ec/0xd70
> udp_tunnel_notify_add_rx_port
> geneve_open
> ```
>
> My read of the patch is that it closes the small window where queue_work(=
)
> can publish the work before utn->work_pending is set, and it also prevent=
s
> udp_tunnel_nic_unregister() from flushing/freeing the object when
> work_pending is already set.
>
> However, the test above suggests that work_pending still does not fully
> protect the lifetime of struct udp_tunnel_nic. The crashing work was stil=
l
> queued through udp_tunnel_nic_device_sync() at line 308, so the patched p=
ath
> was exercised. One suspicious point is that udp_tunnel_nic_device_sync_wo=
rk()
> clears utn->work_pending at the beginning of the worker, while the same w=
ork
> item can still interact with replay/add/del-port state. The reproducer ca=
n
> still end up with udp_tunnel_nic_unregister() freeing utn while a
> udp_tunnel_nic_device_sync_work item later runs and dereferences the free=
d
> utn->lock.
>
> So this patch does not seem to be sufficient for this reproducer.
>

Oh well.

u8 need_sync:1;
u8 need_replay:1;
u8 work_pending:1;

These bitfields are not safe, obviously :/

Time to convert them to atomic bit operations.

