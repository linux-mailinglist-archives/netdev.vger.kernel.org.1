Return-Path: <netdev+bounces-260866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPvtESnMnmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:17:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A292E195A2C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 590CF301BA95
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CEA38E5D5;
	Wed, 25 Feb 2026 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIJUm5Xu"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E42389DEC
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014609; cv=none; b=BSXmnbKD5oX+xwkMAyd4Fh0IUIDWAZFbty2T/REChC3bAOTF9hdGVDy19GjAdoOojOAWbpZbp8WHNJSL0/kyZaEphk+sdwfjrE6jwYRSqMAZ5NuMS5Unu1xdDv6LREYYQOuHdztppKrXbUJp3h6mYYaUe31DY0BGF/l1mBBjpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014609; c=relaxed/simple;
	bh=jcqFTm7Uj7qVLPgXd3OS0dLWBhKZqoVIkGa47hRee7k=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=I8KjTeKRRuyABBPP5PhN/j7edylbvc0d42+XtUiBi20xPxZLzUQDFOWKzJh+oQOHpMbg/DHI4GXXq9QjdHp0iSEOB2/H98kqEw1zhdo93c833R/qlCmEYBlKN+QJJ8O8RDwTPrToB7V2BEL6wrCNWQ3/Z6kmFrl6X3BxIWzRhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIJUm5Xu; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772014602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/UvpJXvW7YGB3SL/x0P0jxryOcXTLn+NBuuBTkbcqU=;
	b=NIJUm5XulJ8MTWbeoXT49gPoXNTzcz4q8ga2J1GuA2Eo+P55Y25S911piFgmlcdvU64chz
	lJ7eTCXTpOvNzu2iGYYLJsjauMvTGGx6wN/MQGQ3UcBUvI8emITmDt5HQCPSR6eQNl+G28
	8BN887fyMKGbuXnXtlnQfx0+lEMyqq8=
Date: Wed, 25 Feb 2026 10:16:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <beb5b67858a5e90709e67b7935430b9986306279@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] atm: lec: fix null-ptr-deref in
 lec_arp_clear_vccs
To: "Simon Horman" <horms@kernel.org>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Ingo
 Molnar" <mingo@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org
In-Reply-To: <aZ7Ex6c1ZeqvWLFp@horms.kernel.org>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
 <aZ60sfG1tdraA0zB@horms.kernel.org>
 <aZ7Ex6c1ZeqvWLFp@horms.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260866-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,shopee.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: A292E195A2C
X-Rspamd-Action: no action

February 25, 2026 at 17:45, "Simon Horman" <horms@kernel.org mailto:horms=
@kernel.org?to=3D%22Simon%20Horman%22%20%3Chorms%40kernel.org%3E > wrote:


>=20
>=20On Wed, Feb 25, 2026 at 08:37:05AM +0000, Simon Horman wrote:
>=20
>=20>=20
>=20> On Tue, Feb 24, 2026 at 12:46:38PM +0800, Jiayuan Chen wrote:
> >  From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> >  This issue can be easily reproduced using the syzkaller reproducer.
> >=20=20
>=20>  In the ATM LANE (LAN Emulation) module, the same atm_vcc can be sh=
ared by
> >  multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_=
vcc).
> >  When the underlying VCC is closed, lec_vcc_close() iterates over all
> >  ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> >=20=20
>=20>  For example, when lec_vcc_close() iterates through the hlists in
> >  priv->lec_arp_empty_ones or other ARP tables:
> >=20=20
>=20>  1. In the first iteration, for the first matched ARP entry sharing=
 the VCC,
> >  lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_=
back)
> >  and sets vcc->user_back to NULL.
> >  2. In the second iteration, for the next matched ARP entry sharing t=
he same
> >  VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv f=
rom
> >  vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to derefere=
nce it
> >  via `vcc->pop =3D vpriv->old_pop`, leading to a null-ptr-deref crash=
.
> >=20=20
>=20>  Fix this by adding a null check for vpriv before dereferencing it.=
 If
> >  vpriv is already NULL, it means the VCC has been cleared by a previo=
us
> >  call, so we can safely skip the cleanup and just clear the entry's
> >  vcc/recv_vcc pointers. Note that the added check is intentional and
> >  necessary to avoid calling vcc_release_async() multiple times on the
> >  same vcc/recv_vcc, not just protecting the kfree().
> >=20
>=20Sorry for coming back to this a 2nd time.
> After thinking about this some more I'd like to pass on
> some feedback from the AI powered review.
>=20
>=20I'll put the full text below. But in a nutshell: could you clarify
> why it is necessary to avoid calling vcc_release_async() multiple times=
.


Hi Simon,

Thanks for the feedback.

1. Regarding why it is necessary to avoid calling vcc_release_async() mul=
tiple times:
when vpriv is NULL, it means a previous call to lec_arp_clear_vccs() has =
already freed vpriv, set
vcc->user_back =3D NULL, restored vcc->push, and called vcc_release_async=
() for this VCC.
Calling vcc_release_async() again on an already-released VCC would redund=
antly set flags, set
sk_err, and trigger sk_state_change() on a socket that is already shuttin=
g down. While this may not
cause an immediate crash, it is semantically wrong =E2=80=94 the VCC has =
already been properly
released, and we should not repeat the teardown sequence.

That is why I intentionally placed the entire cleanup block (including vc=
c_release_async()) inside
the if (vpriv) guard, rather than only guarding the vpriv dereference. Th=
e NULL vpriv
serves as a reliable indicator that this VCC has already been processed b=
y a prior iteration.

2. Regarding the Fixes tag: the AI suggests pointing to 8d9f73c0ad2f ("at=
m: fix a memory leak of vcc->user_back"),
but that only introduced the entry->recv_vcc cleanup path. The entry->vcc=
 path has had the same bug since the
beginning =E2=80=94 if two ARP entries share the same VCC, the second cal=
l dereferences NULL vpriv via vcc->pop =3D vpriv->old_pop.
My patch fixes both paths, and the entry->vcc path bug traces back to the=
 original code,
so Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") is correct. I've verified tha=
t the entry->vcc path is
independently triggerable with a seperated reproducer [1] (it's not worth=
 to put it into selftest for legacy module)

I also don't think splitting this into two patches makes sense =E2=80=94 =
both paths are in the same function,
exhibit the same bug pattern, and the fix is identical.

Best,
Jiayuan



[1]:

// This demonstrates that the entry->vcc NULL dereference bug has existed
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/atm.h>
#include <linux/atmdev.h>
#include <linux/atmlec.h>

int main(void)
{
	int fd_lecd, fd_data;
	struct atmlec_ioc ioc_data;

	fd_lecd =3D socket(AF_ATMPVC, SOCK_DGRAM, 0);
	if (fd_lecd < 0) {
		perror("socket(AF_ATMPVC) for lecd");
		return 1;
	}

	if (ioctl(fd_lecd, ATMLEC_CTRL, 0) < 0) {
		perror("ioctl(ATMLEC_CTRL)");
		close(fd_lecd);
		return 1;
	}
	printf("LEC device 0 initialized (lec0)\n");

	fd_data =3D socket(AF_ATMPVC, SOCK_DGRAM, 0);
	if (fd_data < 0) {
		perror("socket(AF_ATMPVC) for data");
		close(fd_lecd);
		return 1;
	}


	memset(&ioc_data, 0, sizeof(ioc_data));
	ioc_data.dev_num =3D 0;
	ioc_data.receive =3D 0;  /* send VCC -> entry->vcc path */

	printf("Calling ATMLEC_DATA (1st time, receive=3D0 -> entry->vcc path)..=
.\n");
	if (ioctl(fd_data, ATMLEC_DATA, &ioc_data) < 0) {
		perror("ioctl(ATMLEC_DATA) #1");
		close(fd_data);
		close(fd_lecd);
		return 1;
	}

	printf("Calling ATMLEC_DATA (2nd time, same VCC -> 2nd entry in empty_on=
es)...\n");
	if (ioctl(fd_data, ATMLEC_DATA, &ioc_data) < 0) {
		perror("ioctl(ATMLEC_DATA) #2");
		close(fd_data);
		close(fd_lecd);
		return 1;
	}

	printf("Closing data VCC socket (will trigger NULL deref in entry->vcc p=
ath)...\n");
	close(fd_data);

	printf("If you see this, the bug was not triggered (maybe already fixed?=
)\n");

	close(fd_lecd);
	return 0;
}



panic:

[   42.814407] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
[   42.814431] #PF: supervisor read access in kernel mode
[   42.814433] #PF: error_code(0x0000) - not-present page
[   42.814435] PGD 0 P4D 0
[   42.814438] Oops: Oops: 0000 [#1] SMP PTI
[   42.814455] CPU: 1 UID: 0 PID: 452 Comm: repro_lec_vcc Not tainted 6.1=
9.0+ #175 PREEMPT_RT
[   42.814460] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   42.814464] RIP: 0010:lec_arp_clear_vccs+0x2a/0xe0
[   42.814532] Code: 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 4c 8b 67 3=
0 48 89 fb 4d 85 e4 74 5d 4d 8b ac 24 d0 08 00 00 49 8b 94 24 50 08 00 00=
 <49> 8b 45 00 49 89 84 24 30 08 00 00 41 80
[   42.814544] RSP: 0018:ffffd1674176bca0 EFLAGS: 00010286
[   42.814546] RAX: 0000000000000000 RBX: ffff89faca9c1800 RCX: 000000000=
0000000
[   42.814548] RDX: ffff89facc23a000 RSI: 0000000000000000 RDI: ffff89fac=
a9c1800
[   42.814550] RBP: ffffd1674176bcb8 R08: 0000000000000000 R09: 000000000=
0000000
[   42.814551] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89fac=
c10b000
[   42.814553] R13: 0000000000000000 R14: dead000000000100 R15: ffff89fac=
c10b000
[   42.814554] FS:  00007fb608daa740(0000) GS:ffff89fb536fb000(0000) knlG=
S:0000000000000000
[   42.814557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.814558] CR2: 0000000000000000 CR3: 000000010a8f0006 CR4: 000000000=
0770ef0
[   42.814563] PKRU: 55555554
[   42.814568] Call Trace:
[   42.814570]  <TASK>
[   42.814573]  lec_push+0x33e/0x7a0
[   42.814583]  vcc_release+0x72/0x210
[   42.814588]  __sock_release+0x40/0xc0
[   42.814636]  sock_close+0x18/0x30
[   42.814639]  __fput+0x114/0x310
[   42.814690]  fput_close_sync+0x3d/0xa0
[   42.814693]  __x64_sys_close+0x3e/0x90
[   42.814707]  x64_sys_call+0x1b7c/0x26e0
[   42.814748]  do_syscall_64+0xd3/0x1510
[   42.814801]  ? find_held_lock+0x31/0x90
[   42.814838]  ? exc_page_fault+0x94/0x260
[   42.814852]  ? lock_release+0xcd/0x280
[   42.814855]  ? handle_mm_fault+0x1ea/0x300
[   42.814884]  ? irqentry_exit+0x17f/0x780
[   42.814890]  ? clear_bhb_loop+0x30/0x80
[   42.814937]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.814939] RIP: 0033:0x7fb608ec3724
[   42.814981] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 90 f3 0f 1e fa 80 3d 25 49 0f 00 00 74 13 b8 03 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 4d
[   42.814983] RSP: 002b:00007ffdaeb3aeb8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000003
[   42.814986] RAX: ffffffffffffffda RBX: 00007ffdaeb3b028 RCX: 00007fb60=
8ec3724
[   42.814988] RDX: 0000000000000000 RSI: 00005609f3c8f2a0 RDI: 000000000=
0000004
[   42.814989] RBP: 00007ffdaeb3af00 R08: 00007fb608fb0b20 R09: 000000000=
0000000
[   42.814990] R10: 0000000000000001 R11: 0000000000000202 R12: 000000000=
0000001
[   42.814991] R13: 0000000000000000 R14: 00005609ce2cad90 R15: 00007fb60=
9005000
[   42.815009]  </TASK>
[   42.815010] Modules linked in:
[   42.815065] CR2: 0000000000000000
[   42.815066] ---[ end trace 0000000000000000 ]---
[   42.815079] RIP: 0010:lec_arp_clear_vccs+0x2a/0xe0
[   42.815082] Code: 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 4c 8b 67 3=
0 48 89 fb 4d 85 e4 74 5d 4d 8b ac 24 d0 08 00 00 49 8b 94 24 50 08 00 00=
 <49> 8b 45 00 49 89 84 24 30 08 00 00 41 80
[   42.815084] RSP: 0018:ffffd1674176bca0 EFLAGS: 00010286
[   42.815086] RAX: 0000000000000000 RBX: ffff89faca9c1800 RCX: 000000000=
0000000
[   42.815087] RDX: ffff89facc23a000 RSI: 0000000000000000 RDI: ffff89fac=
a9c1800
[   42.815088] RBP: ffffd1674176bcb8 R08: 0000000000000000 R09: 000000000=
0000000
[   42.815090] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89fac=
c10b000
[   42.815100] R13: 0000000000000000 R14: dead000000000100 R15: ffff89fac=
c10b000
[   42.815105] FS:  00007fb608daa740(0000) GS:ffff89fb536fb000(0000) knlG=
S:0000000000000000
[   42.815107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.815108] CR2: 0000000000000000 CR3: 000000010a8f0006 CR4: 000000000=
0770ef0
[   42.815112] PKRU: 55555554
[   42.815113] note: repro_lec_vcc[452] exited with irqs disabled
[   42.815116] BUG: sleeping function called from invalid context at kern=
el/locking/rtmutex_api.c:532
[   42.815118] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 452=
, name: repro_lec_vcc
[   42.815120] preempt_count: 0, expected: 0
[   42.815131] RCU nest depth: 1, expected: 0
[   42.815132] INFO: lockdep is turned off.
[   42.815134] CPU: 1 UID: 0 PID: 452 Comm: repro_lec_vcc Tainted: G     =
 D             6.19.0+ #175 PREEMPT_RT
[   42.815138] Tainted: [D]=3DDIE
[   42.815139] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   42.815140] Call Trace:
[   42.815142]  <TASK>
[   42.815143]  dump_stack_lvl+0xc1/0xf0
[   42.815178]  dump_stack+0x10/0x20
[   42.815180]  __might_resched+0x184/0x270
[   42.815206]  ? sched_mm_cid_exit+0x5e/0x1f0
[   42.815219]  __might_sleep+0x49/0x60
[   42.815223]  mutex_lock_nested+0x2f/0xc0
[   42.815238]  sched_mm_cid_exit+0x5e/0x1f0
[   42.815243]  do_exit+0xb6/0xac0
[   42.815274]  make_task_dead+0x94/0x180
[   42.815278]  rewind_stack_and_make_dead+0x16/0x20
[   42.815281] RIP: 0033:0x7fb608ec3724
[   42.815284] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 90 f3 0f 1e fa 80 3d 25 49 0f 00 00 74 13 b8 03 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 4d
[   42.815285] RSP: 002b:00007ffdaeb3aeb8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000003
[   42.815287] RAX: ffffffffffffffda RBX: 00007ffdaeb3b028 RCX: 00007fb60=
8ec3724
[   42.815289] RDX: 0000000000000000 RSI: 00005609f3c8f2a0 RDI: 000000000=
0000004
[   42.815290] RBP: 00007ffdaeb3af00 R08: 00007fb608fb0b20 R09: 000000000=
0000000
[   42.815291] R10: 0000000000000001 R11: 0000000000000202 R12: 000000000=
0000001
[   42.815292] R13: 0000000000000000 R14: 00005609ce2cad90 R15: 00007fb60=
9005000
[   42.815302]  </TASK>

> AI output was:
>=20
>=20 Is this description of the guard's purpose accurate? The commit mess=
age
>  states that the null check is "necessary to avoid calling
>  vcc_release_async() multiple times on the same vcc/recv_vcc, not just
>  protecting the kfree()."
>=20
>=20 Looking at vcc_release_async() in net/atm/common.c, it sets ATM_VF_C=
LOSE
>  flag, sets sk_shutdown |=3D RCV_SHUTDOWN, sets sk_err, clears ATM_VF_W=
AITING,
>  and calls sk_state_change(sk). Calling it multiple times would redunda=
ntly
>  set flags that are already set and trigger sk_state_change() multiple =
times
>  on an already-shutting-down socket.
>=20
>=20 While preventing multiple vcc_release_async() calls is beneficial, t=
he guard
>  is primarily needed to prevent the NULL dereference on vpriv->old_pop =
(which
>  would crash) and secondarily to prevent use-after-free on the kfree'd =
vpriv.
>  None of the repeated vcc_release_async() operations would necessarily =
cause
>  a crash or data corruption -- they would just set already-set flags an=
d
>  trigger redundant callbacks.
>=20
>=20 Could the commit message be more precise about the primary purpose o=
f the
>  guard being to prevent the NULL dereference, with preventing multiple
>  vcc_release_async() calls being a beneficial side effect rather than t=
he
>  main reason for the check?
>=20
>=20And, I believe due to that, AI goes on to comment about the fixes tag=
. FWIIW,
> I think the commit you cited is correct with respect to the first part =
of
> your patch which protecting against double-free. But I do begin to wond=
er
> if we may have two fixes in one patch.
>=20
>=20 Should the Fixes tag point to a more recent commit? The null pointer
>  dereference bug was directly introduced by commit 8d9f73c0ad2f ("atm: =
fix a
>  memory leak of vcc->user_back") in 2020. That commit added cleanup cod=
e for
>  entry->recv_vcc that frees vpriv and sets vcc->user_back to NULL witho=
ut
>  checking if vpriv is already NULL.
>=20
>=20 When multiple ARP entries share the same VCC, the second call to
>  lec_arp_clear_vccs() dereferences a NULL vpriv, causing the crash. Whi=
le the
>  entry->vcc path had similar code since 2005, commit 8d9f73c0ad2f intro=
duced
>  the recv_vcc path with the same vulnerability, making the bug exploita=
ble.
>=20
>=20 Consider:
>  Fixes: 8d9f73c0ad2f ("atm: fix a memory leak of vcc->user_back")
>=20
>=20>=20
>=20> Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GA=
E@google.com/T/
> >  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  Reviewed-by: Simon Horman <horms@kernel.org>
> >
>

