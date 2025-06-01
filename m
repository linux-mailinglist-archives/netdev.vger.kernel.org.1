Return-Path: <netdev+bounces-194525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B91AC9E92
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A933B4C15
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47B1A5B8B;
	Sun,  1 Jun 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="YAKbHLGF"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104092DCBFC;
	Sun,  1 Jun 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748783466; cv=none; b=Kz+nNwivhNzqFsax+WjFVh/MQVMu/w2qx8dWlgB36AYKOEQxj4Hed65XdARxA2/Iijp2+Dajqam22R4c3C8DlWCiX8vxwgri12DmZ0ITgXgCUya7mPyeGJiqeBXFDzvzQCUkoUZba0HRxa1qd7SbTjTyS22VcfzWW816C8KXSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748783466; c=relaxed/simple;
	bh=0gfsVUXR8Mg0vAlqqGSmzDfYzGuevOP+m14e9LsiocA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT4WlXPLIKiPhYdV+ytTjGXoqg1EDY5Ph+OWQ/UbQxXdQme7uYpSqVtRix8LhuAPdMkx0USjayxVgzI6ySVJiut83CqSaA7nGrwnWAwIMS/XfAY/83EgsCRb2Q5Li7NCXobExHksictOf+Rml5QTWO8WX5pK7oBmyxYZ4LHynHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=YAKbHLGF; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748783454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RqEhWe1zc+zD6NdVa3r6beSKjDCk/bjWY/syOEcqjOU=;
	b=YAKbHLGFjlPdMKEswAJsu6KsfayUqF7eionq+6TK2Tjln+rAZmwpYnxslJVxLynQdBTG6W
	OMeUp0FLl4nVDYx/sNjMRW53bsyzSuAGWMtru8JwIahCES0PXwQwrMFAzly2PomLQM+iTo
	T7lnocJKmJo+k3Vk+KTOw/0r9wsoAoQ=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 01 Jun 2025 15:10:50 +0200
Message-ID: <3742218.iIbC2pHGDl@sven-l14>
In-Reply-To: <bb85858d-b123-45ce-8fae-9658e13b822c@universe-factory.net>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <4860101.CbtlEUcBR6@sven-desktop>
 <bb85858d-b123-45ce-8fae-9658e13b822c@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9566920.CDJkKcVGEf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9566920.CDJkKcVGEf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 01 Jun 2025 15:10:50 +0200
Message-ID: <3742218.iIbC2pHGDl@sven-l14>
MIME-Version: 1.0

On Sunday, 1 June 2025 11:26:25 CEST Matthias Schiffer wrote:
[...]
> > And saying this, the `batadv_hardif_get_by_netdev` call was also used to
> > retrieve additional information about alll kind of interfaces - even wh=
en they
> > are not used by batman-adv directly. For example for figuring out if it=
 is a
> > wifi interface(for the TT wifi flag). With you change here, you are bas=
ically
> > breaking this functionality because you now require that the netdev is =
a lower
> > interface of batman-adv. Therefore, things like:
> >=20
> >=20
> >                     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
> >         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BCbr-lan=E2=94=9C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >         =E2=94=82           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98      =E2=94=82
> >         =E2=94=82                         =E2=94=82
> >         =E2=94=82                         =E2=94=82
> >       =E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=90                    =
=E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90
> >       =E2=94=82ap0=E2=94=82                    =E2=94=82bat0=E2=94=82
> >       =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98                    =
=E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98
> >                                   =E2=94=82
> >                                   =E2=94=82
> >                                =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=
=94=80=E2=94=80=E2=94=90
> >                                =E2=94=82mesh0=E2=94=82
> >                                =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
> >                                         =20
> >                                         =20
> > Is not handled anymore correctly in TT because ap0 is not a lower inter=
face of
> > any batadv mesh interface. And as result, the ap-isolation feature of TT
> > will break.
> >=20
> > Kind regards,
> > 	Sven
>=20
> Hmm, this is a tricky one. Only having the hardifs around while they're=20
> used for meshing means we need some other way to determine the wifi flags=
 -=20
> but doing it on demand for every batadv_tt_local_add() seems like it coul=
d=20
> be used to facilitate a DoS on the RTNL by causing large numbers of TT=20
> entries to be added, as the lock needs to be held for resolving the iflin=
k.

Uhm, using a mutex in this place is a bad idea. If batadv_tt_local_add is=20
called from the non-batadv_interface_tx context then rtnl_lock is already=20
held - which is not the biggest problem because we can handle this with mor=
e=20
code. But when it is called from the batadv_interface_tx context then it is=
=20
usually in a context which doesn't allow sleeping. Here an example output w=
hen=20
adding an rtnl_lock/rtnl_unlock in this place:

[    9.141427][   T43] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    9.141835][   T43] WARNING: suspicious RCU usage
[    9.142213][   T43] 6.15.0+ #1 Tainted: G           O      =20
[    9.142630][   T43] -----------------------------
[    9.142981][   T43] ./include/linux/rcupdate.h:409 Illegal context switc=
h in RCU read-side critical section!
[    9.143674][   T43]=20
[    9.143674][   T43] other info that might help us debug this:
[    9.143674][   T43]=20
[    9.144334][   T43]=20
[    9.144334][   T43] rcu_scheduler_active =3D 2, debug_locks =3D 1
[    9.144904][   T43] 6 locks held by kworker/1:2/43:
[    9.145255][   T43]  #0: ffff888007be2558 ((wq_completion)mld){+.+.}-{0:=
0}, at: process_one_work+0xcee/0x1420
[    9.145944][   T43]  #1: ffff88800792fd38 ((work_completion)(&(&idev->mc=
_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x798/0x1420
[    9.146713][   T43]  #2: ffff88800a58e5a8 (&idev->mc_lock){+.+.}-{4:4}, =
at: mld_ifc_work+0x2a/0x200
[    9.147319][   T43]  #3: ffffffff83405120 (rcu_read_lock){....}-{1:3}, a=
t: mld_sendpack+0x17f/0xc00
[    9.147949][   T43]  #4: ffffffff83405120 (rcu_read_lock){....}-{1:3}, a=
t: ip6_finish_output2+0x294/0x1650
[    9.148621][   T43]  #5: ffffffff834050c0 (rcu_read_lock_bh){....}-{1:3}=
, at: __dev_queue_xmit+0x18a/0xff0
[    9.149286][   T43]=20
[    9.149286][   T43] stack backtrace:
[    9.149743][   T43] CPU: 1 UID: 0 PID: 43 Comm: kworker/1:2 Tainted: G  =
         O        6.15.0+ #1 NONE=20
[    9.149747][   T43] Tainted: [O]=3DOOT_MODULE
[    9.149748][   T43] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.1 11/11/2019
[    9.149751][   T43] Workqueue: mld mld_ifc_work
[    9.149754][   T43] Call Trace:
[    9.149756][   T43]  <TASK>
[    9.149759][   T43]  dump_stack_lvl+0x6f/0xa0
[    9.149764][   T43]  lockdep_rcu_suspicious.cold+0x4e/0x8b
[    9.149768][   T43]  __might_resched+0x26a/0x380
[    9.149771][   T43]  ? rcu_read_unlock+0x80/0x80
[    9.149773][   T43]  ? batadv_primary_if_get_selected+0x320/0x320 [batma=
n_adv]
[    9.149786][   T43]  ? mark_held_locks+0x40/0x70
[    9.149791][   T43]  __mutex_lock+0x113/0x1be0
[    9.149795][   T43]  ? batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.149807][   T43]  ? batadv_bla_get_backbone_gw+0xad1/0xdf0 [batman_ad=
v]
[    9.149819][   T43]  ? mutex_lock_io_nested+0x18d0/0x18d0
[    9.149824][   T43]  ? batadv_bla_claim_dump_entry.isra.0+0x6d0/0x6d0 [b=
atman_adv]
[    9.149835][   T43]  ? ret_from_fork_asm+0x11/0x20
[    9.149841][   T43]  ? batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.149852][   T43]  ? batadv_bla_rx+0xe00/0xe00 [batman_adv]
[    9.149862][   T43]  batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.149878][   T43]  ? batadv_tt_global_hash_count+0x110/0x110 [batman_a=
dv]
[    9.149892][   T43]  batadv_interface_tx+0x4b4/0x1820 [batman_adv]
[    9.149905][   T43]  ? batadv_skb_head_push+0x220/0x220 [batman_adv]
[    9.149917][   T43]  ? skb_csum_hwoffload_help+0x650/0x650
[    9.149922][   T43]  dev_hard_start_xmit+0x15c/0x640
[    9.149926][   T43]  ? validate_xmit_skb.isra.0+0x62/0x4a0
[    9.149930][   T43]  __dev_queue_xmit+0x44d/0xff0
[    9.149933][   T43]  ? netdev_core_pick_tx+0x230/0x230
[    9.149938][   T43]  ip6_finish_output2+0x7f8/0x1650
[    9.149942][   T43]  ? icmp6_dst_alloc+0x30a/0x480
[    9.149946][   T43]  mld_sendpack+0x5de/0xc00
[    9.149951][   T43]  ? mld_report_work+0x620/0x620
[    9.149957][   T43]  ? mld_send_cr+0x4ff/0x7f0
[    9.149961][   T43]  mld_ifc_work+0x32/0x200
[    9.149965][   T43]  process_one_work+0x814/0x1420
[    9.149971][   T43]  ? pwq_dec_nr_in_flight+0x540/0x540
[    9.149977][   T43]  ? assign_work+0x168/0x240
[    9.149980][   T43]  worker_thread+0x618/0x1010
[    9.149985][   T43]  ? __kthread_parkme+0xf7/0x260
[    9.149989][   T43]  ? process_one_work+0x1420/0x1420
[    9.149991][   T43]  kthread+0x3bb/0x760
[    9.149994][   T43]  ? kvm_sched_clock_read+0x11/0x20
[    9.149997][   T43]  ? local_clock_noinstr+0x4e/0xe0
[    9.150000][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.150002][   T43]  ? __lock_release+0x154/0x2a0
[    9.150005][   T43]  ? ret_from_fork+0x1b/0x70
[    9.150010][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.150012][   T43]  ret_from_fork+0x31/0x70
[    9.150015][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.150018][   T43]  ret_from_fork_asm+0x11/0x20
[    9.150025][   T43]  </TASK>
[    9.150026][   T43]=20
[    9.171355][   T43] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    9.171360][   T43] WARNING: suspicious RCU usage
[    9.171363][   T43] 6.15.0+ #1 Tainted: G           O      =20
[    9.171366][   T43] -----------------------------
[    9.171367][   T43] kernel/sched/core.c:8780 Illegal context switch in R=
CU-bh read-side critical section!
[    9.171371][   T43]=20
[    9.171371][   T43] other info that might help us debug this:
[    9.171371][   T43]=20
[    9.171372][   T43]=20
[    9.171372][   T43] rcu_scheduler_active =3D 2, debug_locks =3D 1
[    9.171374][   T43] 6 locks held by kworker/1:2/43:
[    9.171377][   T43]  #0: ffff888007be2558 ((wq_completion)mld){+.+.}-{0:=
0}, at: process_one_work+0xcee/0x1420
[    9.171392][   T43]  #1: ffff88800792fd38 ((work_completion)(&(&idev->mc=
_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x798/0x1420
[    9.171402][   T43]  #2: ffff88800a58e5a8 (&idev->mc_lock){+.+.}-{4:4}, =
at: mld_ifc_work+0x2a/0x200
[    9.171413][   T43]  #3: ffffffff83405120 (rcu_read_lock){....}-{1:3}, a=
t: mld_sendpack+0x17f/0xc00
[    9.171423][   T43]  #4: ffffffff83405120 (rcu_read_lock){....}-{1:3}, a=
t: ip6_finish_output2+0x294/0x1650
[    9.171433][   T43]  #5: ffffffff834050c0 (rcu_read_lock_bh){....}-{1:3}=
, at: __dev_queue_xmit+0x18a/0xff0
[    9.171459][   T43]=20
[    9.171459][   T43] stack backtrace:
[    9.171462][   T43] CPU: 1 UID: 0 PID: 43 Comm: kworker/1:2 Tainted: G  =
         O        6.15.0+ #1 NONE=20
[    9.171467][   T43] Tainted: [O]=3DOOT_MODULE
[    9.171468][   T43] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.1 11/11/2019
[    9.171470][   T43] Workqueue: mld mld_ifc_work
[    9.171474][   T43] Call Trace:
[    9.171476][   T43]  <TASK>
[    9.171479][   T43]  dump_stack_lvl+0x6f/0xa0
[    9.171484][   T43]  lockdep_rcu_suspicious.cold+0x4e/0x8b
[    9.171490][   T43]  __might_resched+0x336/0x380
[    9.171493][   T43]  ? rcu_read_unlock+0x80/0x80
[    9.171496][   T43]  ? batadv_primary_if_get_selected+0x320/0x320 [batma=
n_adv]
[    9.171508][   T43]  ? mark_held_locks+0x40/0x70
[    9.171513][   T43]  __mutex_lock+0x113/0x1be0
[    9.171517][   T43]  ? batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.171529][   T43]  ? batadv_bla_get_backbone_gw+0xad1/0xdf0 [batman_ad=
v]
[    9.171541][   T43]  ? mutex_lock_io_nested+0x18d0/0x18d0
[    9.171546][   T43]  ? batadv_bla_claim_dump_entry.isra.0+0x6d0/0x6d0 [b=
atman_adv]
[    9.171557][   T43]  ? ret_from_fork_asm+0x11/0x20
[    9.171564][   T43]  ? batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.171574][   T43]  ? batadv_bla_rx+0xe00/0xe00 [batman_adv]
[    9.171585][   T43]  batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.171601][   T43]  ? batadv_tt_global_hash_count+0x110/0x110 [batman_a=
dv]
[    9.171616][   T43]  batadv_interface_tx+0x4b4/0x1820 [batman_adv]
[    9.171629][   T43]  ? batadv_skb_head_push+0x220/0x220 [batman_adv]
[    9.171641][   T43]  ? skb_csum_hwoffload_help+0x650/0x650
[    9.171647][   T43]  dev_hard_start_xmit+0x15c/0x640
[    9.171650][   T43]  ? validate_xmit_skb.isra.0+0x62/0x4a0
[    9.171654][   T43]  __dev_queue_xmit+0x44d/0xff0
[    9.171657][   T43]  ? netdev_core_pick_tx+0x230/0x230
[    9.171663][   T43]  ip6_finish_output2+0x7f8/0x1650
[    9.171667][   T43]  ? icmp6_dst_alloc+0x30a/0x480
[    9.171671][   T43]  mld_sendpack+0x5de/0xc00
[    9.171676][   T43]  ? mld_report_work+0x620/0x620
[    9.171682][   T43]  ? mld_send_cr+0x4ff/0x7f0
[    9.171686][   T43]  mld_ifc_work+0x32/0x200
[    9.171690][   T43]  process_one_work+0x814/0x1420
[    9.171696][   T43]  ? pwq_dec_nr_in_flight+0x540/0x540
[    9.171702][   T43]  ? assign_work+0x168/0x240
[    9.171706][   T43]  worker_thread+0x618/0x1010
[    9.171710][   T43]  ? __kthread_parkme+0xf7/0x260
[    9.171715][   T43]  ? process_one_work+0x1420/0x1420
[    9.171717][   T43]  kthread+0x3bb/0x760
[    9.171720][   T43]  ? kvm_sched_clock_read+0x11/0x20
[    9.171723][   T43]  ? local_clock_noinstr+0x4e/0xe0
[    9.171727][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.171729][   T43]  ? __lock_release+0x154/0x2a0
[    9.171732][   T43]  ? ret_from_fork+0x1b/0x70
[    9.171736][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.171739][   T43]  ret_from_fork+0x31/0x70
[    9.171742][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.171745][   T43]  ret_from_fork_asm+0x11/0x20
[    9.171752][   T43]  </TASK>
[    9.171754][   T43] BUG: sleeping function called from invalid context a=
t kernel/locking/mutex.c:578
[    9.171756][   T43] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 43, name: kworker/1:2
[    9.171759][   T43] preempt_count: 202, expected: 0
[    9.171761][   T43] 6 locks held by kworker/1:2/43:
[    9.171763][   T43]  #0: ffff888007be2558 ((wq_completion)mld){+.+.}-{0:=
0}, at: process_one_work+0xcee/0x1420
[    9.171774][   T43]  #1: ffff88800792fd38 ((work_completion)(&(&idev->mc=
_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x798/0x1420
[    9.171784][   T43]  #2: ffff88800a58e5a8 (&idev->mc_lock){+.+.}-{4:4}, =
at: mld_ifc_work+0x2a/0x200
[    9.171794][   T43]  #3: ffffffff83405120 (rcu_read_lock){....}-{1:3}, a=
t: mld_sendpack+0x17f/0xc00
[    9.171804][   T43]  #4: ffffffff83405120 (rcu_read_lock){....}-{1:3}, a=
t: ip6_finish_output2+0x294/0x1650
[    9.171813][   T43]  #5: ffffffff834050c0 (rcu_read_lock_bh){....}-{1:3}=
, at: __dev_queue_xmit+0x18a/0xff0
[    9.171823][   T43] CPU: 1 UID: 0 PID: 43 Comm: kworker/1:2 Tainted: G  =
         O        6.15.0+ #1 NONE=20
[    9.171827][   T43] Tainted: [O]=3DOOT_MODULE
[    9.171828][   T43] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.1 11/11/2019
[    9.171829][   T43] Workqueue: mld mld_ifc_work
[    9.171832][   T43] Call Trace:
[    9.171833][   T43]  <TASK>
[    9.171834][   T43]  dump_stack_lvl+0x6f/0xa0
[    9.171838][   T43]  __might_resched.cold+0x160/0x1bc
[    9.171842][   T43]  ? rcu_read_unlock+0x80/0x80
[    9.171844][   T43]  ? batadv_primary_if_get_selected+0x320/0x320 [batma=
n_adv]
[    9.171855][   T43]  ? mark_held_locks+0x40/0x70
[    9.171859][   T43]  __mutex_lock+0x113/0x1be0
[    9.171863][   T43]  ? batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.171874][   T43]  ? batadv_bla_get_backbone_gw+0xad1/0xdf0 [batman_ad=
v]
[    9.171886][   T43]  ? mutex_lock_io_nested+0x18d0/0x18d0
[    9.171891][   T43]  ? batadv_bla_claim_dump_entry.isra.0+0x6d0/0x6d0 [b=
atman_adv]
[    9.171902][   T43]  ? ret_from_fork_asm+0x11/0x20
[    9.171908][   T43]  ? batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.171919][   T43]  ? batadv_bla_rx+0xe00/0xe00 [batman_adv]
[    9.171929][   T43]  batadv_tt_local_add+0x3d4/0x1d20 [batman_adv]
[    9.171945][   T43]  ? batadv_tt_global_hash_count+0x110/0x110 [batman_a=
dv]
[    9.171960][   T43]  batadv_interface_tx+0x4b4/0x1820 [batman_adv]
[    9.171972][   T43]  ? batadv_skb_head_push+0x220/0x220 [batman_adv]
[    9.171984][   T43]  ? skb_csum_hwoffload_help+0x650/0x650
[    9.171990][   T43]  dev_hard_start_xmit+0x15c/0x640
[    9.171993][   T43]  ? validate_xmit_skb.isra.0+0x62/0x4a0
[    9.171997][   T43]  __dev_queue_xmit+0x44d/0xff0
[    9.172000][   T43]  ? netdev_core_pick_tx+0x230/0x230
[    9.172006][   T43]  ip6_finish_output2+0x7f8/0x1650
[    9.172010][   T43]  ? icmp6_dst_alloc+0x30a/0x480
[    9.172013][   T43]  mld_sendpack+0x5de/0xc00
[    9.172018][   T43]  ? mld_report_work+0x620/0x620
[    9.172024][   T43]  ? mld_send_cr+0x4ff/0x7f0
[    9.172029][   T43]  mld_ifc_work+0x32/0x200
[    9.172032][   T43]  process_one_work+0x814/0x1420
[    9.172039][   T43]  ? pwq_dec_nr_in_flight+0x540/0x540
[    9.172044][   T43]  ? assign_work+0x168/0x240
[    9.172048][   T43]  worker_thread+0x618/0x1010
[    9.172053][   T43]  ? __kthread_parkme+0xf7/0x260
[    9.172056][   T43]  ? process_one_work+0x1420/0x1420
[    9.172059][   T43]  kthread+0x3bb/0x760
[    9.172061][   T43]  ? kvm_sched_clock_read+0x11/0x20
[    9.172065][   T43]  ? local_clock_noinstr+0x4e/0xe0
[    9.172069][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.172072][   T43]  ? __lock_release+0x154/0x2a0
[    9.172076][   T43]  ? ret_from_fork+0x1b/0x70
[    9.172080][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.172084][   T43]  ret_from_fork+0x31/0x70
[    9.172089][   T43]  ? kthread_is_per_cpu+0xc0/0xc0
[    9.172092][   T43]  ret_from_fork_asm+0x11/0x20
[    9.172100][   T43]  </TASK>

So, even getting the parent (see `ASSERT_RTNL` in=20
`netdev_master_upper_dev_get`) of the lower interface is a no-go at that=20
point.


> One option might be to add a cache for the wifi flag (and possible other=
=20
> information, I'll have to check if there is anything else), but store it =
in=20
> the mesh interface, only for interfaces that are bridged with the mesh.=20
> Cache entries could be created on demand when a local TT entry is added f=
or=20
> an unknown IIF; when to remove cache entries is something I'll have to=20
> figure out.
>=20
> Simpler ideas how to solve this are welcome :)

Having something like a simple (rcu)hash(table) (yes, similar to the global=
=20
hardif list), which only stores entries for non-mesh netdev's when they are=
=20
(above) a wifi interface, might be enough. It is only for the =20
"ap-isolation" feature but I guess that someone will not be happy if we=20
break it.

Kind regards,
	Sven
--nextPart9566920.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDxRWgAKCRBND3cr0xT1
y7MUAP9jxtvDk3BJevLb+8D6M2OtLzL6sEnErbRg2SGjKKx55AD+OCjW6Ne+8dmS
QvS0LWcbrPHkGeTbCAx2Nj+zB0cj5gA=
=mhAw
-----END PGP SIGNATURE-----

--nextPart9566920.CDJkKcVGEf--




