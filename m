Return-Path: <netdev+bounces-103546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10929088B4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B22228F679
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C03194A77;
	Fri, 14 Jun 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbypNhf0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XP1qqB9z"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719A194A64;
	Fri, 14 Jun 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358495; cv=none; b=SxRHxeyDozLb/IlXhuVANqmikpwyzJR3VNe1L7mIf9AxDFF5qJiAMRd3zR4ZaNJepe01qKQvba2EiqhNUC4oDAg9gobRBdPkRyDXNwsk8A+s7weIbJlm8cgHc1YH5h/4almPP8h6Md1KvZD7QRoWh2jdbT7fgbApczN482sY2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358495; c=relaxed/simple;
	bh=85C5AS+ZySgPD7husJ3KBKPehqUc5jvt/XoisWXFmBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puBqC2VaW7/NB50gzK64/OzvMD2fKHBzDSU6BbsYAHCTmC8aMXxVkJXr5Db6MtLzqUOxKd1lp8mKOh0w/3bvsyJJEeQQZH1yjF4oAZv/Z6JYcTAjJdrHQOICxtRzm+RIRe4CH6xwJUmdlumQFRu9zzSF8xLkZckKAAlO2WMQFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbypNhf0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XP1qqB9z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Jun 2024 11:48:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718358491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlDxMWO87rdlhcTBOawUMW+iHXoaV9SzKYnYt4EAeLo=;
	b=GbypNhf0tm8Zlh7iSBTg8QZ/yY5tv9S2tg+jRkdLCZ5dGSdVfBcFYYrQ9gTf9tPp9bCau/
	PzLqqDGPe1rLvWm6Vu5NhMOS2xzfyLouFdKyzEyfLEOSuGiuQp154H4oOS1pG3bHNytvUk
	E/a8D9LvjLfaymILvw8Vkx1B+IvpFc9kXDXTmOv8JwKo+ewm+ofR7GKml5GYc0W1lFGUWq
	FMoQkJY9tNAexcqozw1LeR7EI3xFfxEl0tWLXo+yMaYflT3AkkYyR6qTLsZ9MqhC9wV+Dn
	ENW7U0m7QyJKTqe+7Ky6gz1suuE/7CqQ6dya7ngl8nX3kixjhuJdt/hASMeENw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718358491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlDxMWO87rdlhcTBOawUMW+iHXoaV9SzKYnYt4EAeLo=;
	b=XP1qqB9z/GVDT2GavGHbytzUJCj5HAzBNfWCpSzxyeGQELRESvJhNkBby4SKKmOEqIo0oH
	67SqKPcsoFTchQDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make xmit.recursion
 per task.
Message-ID: <20240614094809.gvOugqZT@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-9-bigeasy@linutronix.de>
 <20240612131829.2e33ca71@rorschach.local.home>
 <20240614082758.6pSMV3aq@linutronix.de>
 <CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>

On 2024-06-14 10:38:15 [+0200], Eric Dumazet wrote:
> > I think it should work fine. netdev folks, you want me to remove that
> > ifdef and use a per-Task counter unconditionally?
>=20
> It depends if this adds another cache line miss/dirtying or not.
>=20
> What about other fields from softnet_data.xmit ?

duh. Looking at the `more' member I realise that this needs to move to
task_struct on RT, too. Therefore I would move the whole xmit struct.

The xmit cacheline starts within the previous member (xfrm_backlog) and
ends before the following member starts. So it kind of has its own
cacheline.
With defconfig, if we move it to the front of task struct then we go from

| struct task_struct {
|         struct thread_info         thread_info;          /*     0    24 */
|         unsigned int               __state;              /*    24     4 */
|         unsigned int               saved_state;          /*    28     4 */
|         void *                     stack;                /*    32     8 */
|         refcount_t                 usage;                /*    40     4 */
|         unsigned int               flags;                /*    44     4 */
|         unsigned int               ptrace;               /*    48     4 */
|         int                        on_cpu;               /*    52     4 */
|         struct __call_single_node  wake_entry;           /*    56    16 */
|         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
|         unsigned int               wakee_flips;          /*    72     4 */
|=20
|         /* XXX 4 bytes hole, try to pack */
|=20
|         long unsigned int          wakee_flip_decay_ts;  /*    80     8 */

to

| struct task_struct {
|         struct thread_info         thread_info;          /*     0    24 */
|         unsigned int               __state;              /*    24     4 */
|         unsigned int               saved_state;          /*    28     4 */
|         void *                     stack;                /*    32     8 */
|         refcount_t                 usage;                /*    40     4 */
|         unsigned int               flags;                /*    44     4 */
|         unsigned int               ptrace;               /*    48     4 */
|         struct {
|                 u16                recursion;            /*    52     2 */
|                 u8                 more;                 /*    54     1 */
|                 u8                 skip_txqueue;         /*    55     1 */
|         } xmit;                                          /*    52     4 */
|         struct __call_single_node  wake_entry;           /*    56    16 */
|         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
|         int                        on_cpu;               /*    72     4 */
|         unsigned int               wakee_flips;          /*    76     4 */
|         long unsigned int          wakee_flip_decay_ts;  /*    80     8 */


stuffed a hole due to adding `xmit' and moving `on_cpu'. In the end the
total size of task_struct remained the same.
The cache line should be hot due to `flags' usage in

| static void handle_softirqs(bool ksirqd)
| {
|          unsigned long old_flags =3D current->flags;
=E2=80=A6
|         current->flags &=3D ~PF_MEMALLOC;

Then there is a bit of code before net_XX_action() and the usage of
either of the members so not sure if it is gone by then=E2=80=A6

Is this what we want or not?

Sebastian

