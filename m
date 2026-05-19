Return-Path: <netdev+bounces-289502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oINAAGmKDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:06:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5991F581EFD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E27FF3150758
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080640801F;
	Tue, 19 May 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdZnXjes";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASW8MmXx"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149E40800A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204742; cv=none; b=F12BkY9ocQu9+2DTgX3g0cLAyFbdSQyOtfUK+wYvuifURqrM2M2bZT3YKa+4/QU+WbWEDMm9TU3bz0uVtIASSzq0Y0ijFiSifqJeoZmqaLXXSgYDfUbiU1isfcPF8YMoc5dA0XBFVOGv2XMaaLMCbeTuF9apdmUUt5wcvry+UVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204742; c=relaxed/simple;
	bh=tPghhxRJnB0jjLAb8HJXB8ewuPlR6939Iw61y0yT4oo=;
	h=From:To:Cc:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VY5VAeQAhdsetTZn/Z+aywa3FTlyFcp0h7ihYQ4WE9e50UjCoYuDQvkWErbVaqKb3VZKCvUW5mWY2s6wVDdQPR5B/cxqLWhEGJ2d5ZeV1pzZwpsGw6OImO1SBB4oZtmJqvriP7ClfkmElN9LMTTjpD2gc6k7+SeUerhk3BnqNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GdZnXjes reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASW8MmXx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779204739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Oa2bh2GId8P8GQWr0oWiZRdrWAPUGjG0feRgRc6k0k=;
	b=GdZnXjesawKtENYnBwUdJ4w5BmtIAWfTB2R2BD5Jst7ReZXdftvQ+1Vs/xcqVHshdKyTk3
	6eI+EZ/UTrRVC3FZReRVb+g4kaGDEUbwotxT0vUlUanXXP9g4x5HOgz3URMv070QCJMXcG
	rvpEn2NTZHbKd1pwolah0fT99GJ4RTyGb3cw7kmRXmgH2KVChn2SHR6svd6PtmjQ1N7N/P
	SddU8BFiavgXo2WJ8dXHqThEgFNw2sD+TdIBM70bKBI511RB3yclphY9KClnwBLsRgd+eR
	+h7OP7UrDqZVTU3x5khXPPGaW616JsxdToPOQ4PeZS79PD0OrkBHISpjM4z8fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779204739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Oa2bh2GId8P8GQWr0oWiZRdrWAPUGjG0feRgRc6k0k=;
	b=ASW8MmXxPoHlIvhkJwGuHM0hyYmGcqPWEtQNVPLkdCU/9rZMsF0PgE+1LPwWn5t11WZMv6
	d/S/h5G5BDAVHLCw==
To: Florian Zeitz <florian.zeitz@schettke.com>, yangbo.lu@nxp.com
Cc: =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Miroslav Lichvar <mlichvar@redhat.com>, Blanco
 Alcaine Hector <hector.blanco.alcaine@intel.com>, "Christopher S. Hall"
 <christopher.s.hall@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org
Subject: Re: ptp_vclock bug: Obtaining a mutex during RCU lock
In-Reply-To: <00a8cce8-410e-4038-98af-49be6d93d7bd@schettke.com>
References: <00a8cce8-410e-4038-98af-49be6d93d7bd@schettke.com>
Date: Tue, 19 May 2026 17:32:17 +0200
Message-ID: <87lddf2z5q.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spamd-Result: default: False [0.74 / 15.00];
	SIGNED_PGP(-2.00)[];
	R_DKIM_REJECT(1.00)[linutronix.de:s=2020,linutronix.de:s=2020e];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MULTIPLE_UNIQUE_HEADERS(0.70)[Cc];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linutronix.de : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-289502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,intel.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:-];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5991F581EFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue Jun 03 2025, Florian Zeitz wrote:
> Hi,
>
> I believe I have found a bug in the PTP vclock implementation.
>
> Occasionally, when running ptp4l and phc2sys on a virtual clock, I=20
> encounter the following warning from within the ptp4l process (full=20
> backtrace below):
> "Voluntary context switch within RCU read-side critical section!"
>
> As the backtrace shows the warning originates from=20
> `ptp_convert_timestamp()` in drivers/ptp/ptp_vclock.c, specifically line=
=20
> 203 where `mutex_lock_interruptible()` is called inside an RCU read-side=
=20
> critical section.
> Having read up on RCU, it seems to me that trying to obtain a mutex=20
> during an RCU lock is generally not allowed and voids the RCU lock=20
> should scheduling happen.
>
> This can occur whenever a timestamped packet is received while the mutex=
=20
> is still held by another call, in my case `ptp_vclock_gettime()`.

Yes. We're seeing exactly the same issue. Using a mutex in a RCU read
lock section is not allowed. Commit 67d93ffc0f3c ("ptp: vclock: use
mutex to fix "sleep on atomic" bug") introduced the mutex in the first
place.

Adding a few more people to Cc and keeping the context intact.

Any idea how to solve this? For example, using SRCU instead? Reverting
the commit in question?

Thanks,
Kurt

> To make this easier to reproduce, I've written a small test program that=
=20
> triggers frequent locking:
> ```c
> #define _GNU_SOURCE
>
> #include <fcntl.h>
> #include <sys/stat.h>
> #include <sys/timex.h>
> #include <time.h>
>
> #define CLOCKFD 3
> #define FD_TO_CLOCKID(fd) ((~(clockid_t)(fd) << 3) | CLOCKFD)
>
> int main(void) {
>    struct timespec time;
>    struct timex tmx =3D {0};
>
>    int fd =3D open("/dev/ptp1", O_RDWR);
>    clockid_t clock =3D FD_TO_CLOCKID(fd);
>
>    while (1) {
>      clock_gettime(clock, &time);
>      clock_adjtime(clock, &tmx);
>    }
> }
> ```
>
> Running this in parallel with ptp4l (in a gPTP setup, which sends SYNC=20
> messages at a higher rate than the default profile) typically reproduces=
=20
> the issue within a few minutes.
>
> Best Regards,
>
> Florian Zeitz
>
> ```
> [ 1084.825057] ------------[ cut here ]------------
> [ 1084.825072] Voluntary context switch within RCU read-side critical=20
> section!
> [ 1084.825091] WARNING: CPU: 1 PID: 677 at kernel/rcu/tree_plugin.h:331=20
> rcu_note_context_switch+0x4e4/0x
> 530
> [ 1084.825118] Modules linked in: rfkill rtc_pcf85063 regmap_i2c emc2305=
=20
> v3d vc4 snd_soc_hdmi_codec binf
> mt_misc gpu_sched drm_display_helper cec drm_shmem_helper drm_dma_helper=
=20
> bcm2835_codec(C) bcm2835_isp(C) rpi_hevc_dec bcm2835_v4l2(C)=20
> snd_soc_core drm_kms_helper bcm2835_mmal_vchiq(C) videobuf2_vmalloc=20
> snd_compress vc_sm_cma(C) v4l2_mem2mem snd_pcm_dmaengine=20
> videobuf2_dma_contig raspberrypi_hwmon i2c_mux_pinctrl videobuf2_memops=20
> videobuf2_v4l2 i2c_mux videodev snd_bcm2835(C) i2c_brcmstb snd_pcm=20
> snd_timer raspberrypi_gpiomem i2c_bcm2835 videobuf2_common mc snd=20
> pps_gpio nvmem_rmem uio_pdrv_genirq uio drm fuse=20
> drm_panel_orientation_quirks backlight dm_mod ip_tables x_tables ipv6
> [ 1084.825259] CPU: 1 UID: 0 PID: 677 Comm: ptp4l Tainted: G         C=20
>        6.12.30-v8-ptpfix+ #2
> [ 1084.825269] Tainted: [C]=3DCRAP
> [ 1084.825272] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)
> [ 1084.825277] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS=20
> BTYPE=3D--)
> [ 1084.825283] pc : rcu_note_context_switch+0x4e4/0x530
> [ 1084.825291] lr : rcu_note_context_switch+0x4e4/0x530
> [ 1084.825298] sp : ffffffc08162b7e0
> [ 1084.825302] x29: ffffffc08162b7e0 x28: ffffff8046414200 x27:=20
> ffffff807fb78c40
> [ 1084.825313] x26: 0000000000000001 x25: 0000000000000000 x24:=20
> 0000000000000000
> [ 1084.825324] x23: ffffff8046414200 x22: 0000000000000000 x21:=20
> ffffff8046414200
> [ 1084.825335] x20: 0000000000000000 x19: ffffff807fb79a40 x18:=20
> 0000000000000000
> [ 1084.825345] x17: 0000000000000000 x16: 0000000000000000 x15:=20
> 0000000000000000
> [ 1084.825355] x14: fffffffffffc78ef x13: 216e6f6974636573 x12:=20
> 206c616369746972
> [ 1084.825365] x11: ffffffd7ed4c54f8 x10: 00000000000001a8 x9 :=20
> ffffffd7ec11e494
> [ 1084.825375] x8 : 0000000000017fe8 x7 : 00000000fffff1a7 x6 :=20
> ffffffd7ed51d4f8
> [ 1084.825386] x5 : ffffff807fb663c8 x4 : 0000000000000000 x3 :=20
> 0000000000000027
> [ 1084.825396] x2 : 0000000000000000 x1 : 0000000000000000 x0 :=20
> ffffff8046414200
> [ 1084.825406] Call trace:
> [ 1084.825410]  rcu_note_context_switch+0x4e4/0x530
> [ 1084.825418]  __schedule+0xac/0xb58
> [ 1084.825425]  schedule+0x3c/0x150
> [ 1084.825429]  schedule_preempt_disabled+0x2c/0x58
> [ 1084.825435]  __mutex_lock.constprop.0+0x464/0x940
> [ 1084.825440]  __mutex_lock_interruptible_slowpath+0x1c/0x30
> [ 1084.825446]  mutex_lock_interruptible+0x68/0x80
> [ 1084.825452]  ptp_convert_timestamp+0x8c/0xd0
> [ 1084.825459]  __sock_recv_timestamp+0x2f0/0x490
> [ 1084.825466]  __sock_recv_cmsgs+0x5c/0x168
> [ 1084.825472]  packet_recvmsg+0x130/0x540
> [ 1084.825482]  sock_recvmsg+0x78/0xd0
> [ 1084.825487]  ____sys_recvmsg+0xb0/0x250
> [ 1084.825494]  ___sys_recvmsg+0xd8/0x100
> [ 1084.825500]  __sys_recvmsg+0x8c/0x100
> [ 1084.825507]  __arm64_sys_recvmsg+0x2c/0x40
> [ 1084.825513]  invoke_syscall+0x50/0x120
> [ 1084.825522]  el0_svc_common.constprop.0+0x48/0xf0
> [ 1084.825529]  do_el0_svc+0x24/0x38
> [ 1084.825536]  el0_svc+0x30/0xd0
> [ 1084.825543]  el0t_64_sync_handler+0x120/0x130
> [ 1084.825550]  el0t_64_sync+0x190/0x198
> [ 1084.825556] ---[ end trace 0000000000000000 ]---
> ```
>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmoMgoETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgu/zD/95+kjscu9/jZqzMYaOULsthQoLc5ez
qa1kMH0pu429ebFqfB07qNhVjup8L7tdDFrd3SgpPgtqvkjrCrb/I419q+nt0zix
4plJNWphDUoRc6CivHPBPq9CtR/GpSiUXMkHz7+CaJsgdocZypr7m+sKACLC/ZvV
P/QZ8+75SK0BASdWlO97D4VqzWAmrzluKjNx6Vn7u+qh8vZeo7Ewjcoy5Syc//6g
AtD+B4R2QTF5AzLDXPBxm+VbMN97ZyY+geH/R28o6F9e5R0RTMH5wwdkVXrmAW9O
ih8GOhpf3UczMuFIiLsXUaPANFqG5Ph6bYKYgrnFnkS+tjsgi1TD5nQ2Pa9HNvBU
7K4HEUxIMcFOm0tOsW4dh3tH5kc+YkqIWRijLkQwD8SE/mir0M+FnXKhvqy6jDYh
hE7he0mmjEUIf+htm7kRrgAxrh3wAQ9wthiRIYcCtP07H1r04qH8fJ5wZ8J6pbmW
yYaZEpbTFG+i3gI9hLQBb/vJKcIgM92sIIl9AZOhhgR0fSO8gn31UKbLKezXHKC1
0V6/84dTWFjsm1t7hF8+TfIgUpkMqorZCYaejr33303Jbnw8+OW+o83shnaweH9U
ed8AWikzwv4H4vozq7NZg+eBEPJ4GWxLIvPOX/xjFr2IhL1THEPRqRnXOvK7Ojvx
xBjaOuf6bA9t3Q==
=YxOW
-----END PGP SIGNATURE-----
--=-=-=--

