Return-Path: <netdev+bounces-302224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6C2hJ8WmPmq0JgkAu9opvQ
	(envelope-from <netdev+bounces-302224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2736CEEF6
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=VHfq9S6C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302224-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302224-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 217883039385
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7053F9F46;
	Fri, 26 Jun 2026 16:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C03FD943
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:11:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490323; cv=pass; b=K3WgZ/3+B3OAoMaWhORh8c81HQz41QncQZ3gRLjDUPkd7q/9qxmz3OlHshAHa/Lw4eMg4Dg7Cp5N4g/waQ/HemxmxrIVgUKLVsohUZ2tc0LNbLt8jv8XAi49sWI0qpMTLbdREM7srnMhkgkWIrPtPXYJpfzvuvrZLhYZ74BrLW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490323; c=relaxed/simple;
	bh=t+bRc5tua2h22UL66WgekbHNR8+kStkdljkjSb9Lf+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ik37xOCzHfBuc7IdSDlziWUY3lE8ei/O0TAg6MsyTsvGeQaeq8vrXL4juV30Vg92WCNAIZ+wS3iZ/jvRWSLB8VPhgzoT6IFpA2C3sr/1isCvIeJezDso9FKzKrEyD4FPSRLoKE6KiqA8lUsje2MZOjzi+v9f4DEUC5HRaKVr788=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VHfq9S6C; arc=pass smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84236f9b638so521115b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782490319; cv=none;
        d=google.com; s=arc-20260327;
        b=dos/+Vi8jLHs5A8nLSZ6/PPfE7zkA2l3/Jt5ucBFHAOSD7JH0EBr8OyZuMiqEGfiOI
         KbtExl18sFJSFkTuC+JQrFvaNcT5jF6H1YO2T3PsYwSsGeFGUsBG8TLxLhb4wUbrEKL8
         raqcabF6uCWhcE51md/d0mXlGU8gZzG9ZoKHGJU50M/ju1wsN32OkU/fuUKEV4yddp1M
         rKzJh4gtzCX2vEim3VkU76QCYmmrwm0BC+jXPiyG5T43wkgDRtxkAVGHxwt82BiF2Zsh
         vKNDIfyWT+kptJr2GFkoA/pixoScKQ6LcLE3dILCxCgvbVquDDtCzRnb+bvMAH1cdxXB
         ucKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXQEyT7Q4jr5cIIxct5CGj348m6uRo9IrfssmoijES8=;
        fh=7V41OBPjdslGFggioTxKS4i14shBp0V9+JFAiFx5oQY=;
        b=Mk2WQf4WF7xnt1J1PLQj0lzr0c/INjzz5Oqw82oQJRvWRES4+EMYv/9pGxPjFII7xd
         DdvhIp7gT/Om2QmtdI+UlzixEGNY8fj/nEDcvMlV2+sLFB24Mze4PveOdoi6v+HoXy/R
         zLHRVxCjpyjdlN5iTVtbhAc2W74gOmEG7LERUV8ccZCoIJq6DLhQvC6CCPFJibuqt3qd
         43r4iwaublMZp8OQ8KW4/z14UoW2kjmNvkoO8ICRWrBf+hWhtzGo/KC3UZGqoubkD/jo
         crjxgrZ7N2OLX8zO5RkdSwm5qAa3OhkHyXkw4HQ3El8PdJzwwutCB5KjPdix2rr+3GNR
         MuFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782490319; x=1783095119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXQEyT7Q4jr5cIIxct5CGj348m6uRo9IrfssmoijES8=;
        b=VHfq9S6CQ9kgJFUCRZEWuKKVDsoCUPSxVrtyiRy0YN/CNjEUjQ7efUvjgTCWdW7p04
         xLuZvNeXcSWR4ue0KStp/o40/DbFc/XCCcgROmxX8+H7V85cpMp5yE82+6hyAY34oKdR
         DEH2G/TpQ1tmtt42vldKPe73u22dzQyYdZ8uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490319; x=1783095119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXQEyT7Q4jr5cIIxct5CGj348m6uRo9IrfssmoijES8=;
        b=cwtUF14PlXf+ld0+3IsepwFCyWuAI0OZ/HKEjNGGhHYB+zGWEZPqdlyxSmVE8J/KEs
         6pTx2A2HIpo9NeBX4Bb279WNChAeAzJ7vEEGWn1vtPID0HJirW1Qqhf9o5zEOVezWKIl
         2MGX5sk4ufLICm5ngh9SmkWbOKqxJFAW0bIkwOzkEWNS0DtVpuwWmlf+Lm49UqOTXh27
         QQQ2zRwDwkkBphRoohbCVukr9aYCZVf7J5pVqbGSh5ypJDG3lXSFL0ZRuHyFkzpCKjqS
         lNsO0vZa4gxmjB9l6RbulUvD1CqrrqbZrmw60z21VhhgsITR1L/ffntbgfPvF5/PIIEq
         IPjg==
X-Gm-Message-State: AOJu0YxkljYEr0xXMuzPI7voSGHQPampgylOmo2klYtcvI7UNuC4eWNk
	zLYdbPcGyV1G2cGJ+q1d9JUW2KtGqtfvR44W1ufDrkE6unyz7EFeNsmbWj5SeZ8+oMvjq27g08U
	ua86767I3b+Gmw3p9pY2XJGhKVpwofTGQQCTw/Mzm
X-Gm-Gg: AfdE7clhPtp3tdQNcPJT0DFiuyUdQKJbh/FDuPVCBZchx9hq///SDk2jAvllhpvIS8q
	p+98fzx439cerKLwbK/L/SgwK2yZXTJAfC2ezx74JLmJ1eg4JMdWp7ylRnaQHhGBTGJWshKNede
	WheVe8QQ8Fdri/7uGraF83mImskjGQ+lKWHZ4J0UK90RTLcAP63Y8VmFvMjGmuSGTZVxca79Gv/
	iu8ID7b26DvOkHYyPwBKxcjhdyih9ch332Km3wEn6gD+oL5gVfgu/JQ6O2LT+E3f3EFQz/amg==
X-Received: by 2002:a05:6a00:9a9:b0:845:d284:9e01 with SMTP id
 d2e1a72fcca58-845d284aa06mr879981b3a.59.1782490318736; Fri, 26 Jun 2026
 09:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624224016.24018-1-jhs@mojatatu.com> <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>
 <20260626141547.GA1310988@horms.kernel.org>
In-Reply-To: <20260626141547.GA1310988@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 12:11:47 -0400
X-Gm-Features: AVVi8Cecncdcl4VQwa1dstOAibkOpvT8I77lUEklwuWglJcyWzqV1iNugZHWSgI
Message-ID: <CAM0EoMntFA+fqs_BgT0E_KSsQHyf0W0u7OTngHHB7icrnUiC3A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, victor@mojatatu.com, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jiri@resnulli.us,m:victor@mojatatu.com,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,m:lkp@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302224-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,mail.gmail.com:mid,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA2736CEEF6

Hi Simon,

On Fri, Jun 26, 2026 at 10:15=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Jun 26, 2026 at 06:16:43AM -0400, Jamal Hadi Salim wrote:
> > "
> >
> > On Wed, Jun 24, 2026 at 6:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > The teql master->slaves singly linked list is not protected against
> > > multiple writes. It can be mod'ed concurently from teql_master_xmit()=
,
> > > teql_dequeue(), teql_init() and teql_destroy() without holding any li=
st
> > > lock or RCU protection.
> > >
> > > zdi-disclosures@trendmicro.com has demonstrated that the qdisc is fre=
ed
> > > after an RCU grace period, but teql_master_xmit() running on another
> > > CPU can still hold a stale pointer into the list, resulting in a
> > > slab-use-after-free:
> > >
> > > BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net=
/sched/sch_teql.c:142
> > > Read of size 8 at addr ffff88802923aa80 by task ip/10024
> > >
> > > The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET
> > > senders on a teql device against a thread that repeatedly adds/delete=
s the
> > > slave qdisc, together with a SLUB spray that reclaims the freed slot;=
 the
> > > resulting UAF is controllable enough to be turned into a read/write
> > > primitive against the freed qdisc object.
> > >
> > > The fix?
> > > Add a per-master slaves_lock spinlock that serializes all mutations o=
f
> > > master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> > > teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> > > around those updates.
> > > Annotate master->slaves and the per-slave ->next pointer with __rcu a=
nd
> > > use the appropriate RCU accessors everywhere they are touched:
> > > rcu_assign_pointer() on the writer side (under slaves_lock),
> > > rcu_dereference_protected() for the writer-side loads (also under
> > > slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit(=
) and
> > > rtnl_dereference() for the loads in teql_master_open()/teql_master_mt=
u(),
> > > which run under RTNL.
> > > Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the lis=
t
> > > traversal in teql_master_xmit(), so that readers either observe a ful=
ly
> > > linked list or are deferred until the in-flight mutation completes. T=
he two
> > > early-return paths in teql_master_xmit() are updated to release the R=
CU-bh
> > > read-side critical section before returning, since leaving it held wo=
uld
> > > disable BH on that CPU for good.
> > >
> >
> > sashiko-gemini's complaints:
> > https://sashiko.dev/#/patchset/20260624224016.24018-1-jhs%40mojatatu.co=
m
> > seem bogus to me (someone correct me if i am wrong). I am only going
> > to address the first claim of "TOCTOU / "resurrection" race in
> > teql_master_xmit()"
> > teql_master_xmit() holds rcu_read_lock_bh() across the entire
> > traversal. teql_destroy() freeing can only proceed once the qdisc's
> > RCU grace period has elapsed - so where is this TOCTOU? Let's say this
> > were true: both calls hold the slaves_lock.
> > The other issues are of similar nature.
>
> Hi Jamal,
>
> I think the central question here is about the protection offered by RCU
> in these code paths. And while I agree it protects the use of elements
> of the list, I think the problem flagged relates to the management of
> the list itself.
>
> The example AI gave me when I asked is like this:
>
>     Assume a TEQL master has one slave, `q`.
>     The list is circular: `q->next =3D=3D q`.
>
>     1. CPU A (Transmitting): Enters `teql_master_xmit()`.
>        It reads `master->sla ves` and gets a local pointer to `q`.
>
>     2.  CPU B (Destroying): Calls `teql_destroy(q)`.
>         It takes the lock, unlinks `q`, and sets `master->slaves =3D NULL=
`.
>         The list is now logically empty.
>
>     3.  CPU A: Finishes its work and prepares to rotate the list head
>         to the next slave.
>         It takes the lock.
>
>     4.  CPU A (The "Use" / The Resurrection):
>         It executes: `rcu_assign_pointer(master->slaves, NEXT_SLAVE(q));`
>         Because `q` was circular, `NEXT_SLAVE(q)` is still `q`.
>
>     5.  CPU A: Releases the lock.
>         **The global `master->slaves` is now `q` again.**
>
>     6.  The System: The RCU grace period expires. CPU B finishes
>         `teql_destroy()` and the memory for `q` is freed.
>
>     The global `master->slaves` pointer is now a **dangling pointer**
>     pointing to freed memory.
>


Yeah, thats the same earlier claim of TOCTOU (what sashiko-gemini
claimed was "resurrecting the freed q")
My view is rcu read lock blocks the subsequent call_rcu free - and
destroy() and xmit() already serialize on slaves_lock.
I could be totaly wrong, but it's almost like sashiko-gemini thinks
that the list-mutation lock _alone_ governs the object lifetime.
The rcu read-side critical section prevents the UAF, not just the
slaves_lock alone
Only reason i added slaves_lock was to prevent corrupting the list
state (whereas the RCU read lock prevents premature free).

In step #4 above this thing somehow leaves out any mention of the rcu
read lock entirely and places the free in step 6 as if it was
independent of CPU A's critical section.

I am not sure how to improve it.

> > OTOH, sashiko-claude
> > (https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260624224016.240=
18-1-jhs%40mojatatu.com)
> > does make some valid claims which are low value, so not sure a resend
> > is worth it.
> > For example in claim 1 it says "Should the changelog mention this
> > teql_dequeue() site too?" Sure I can - but just because I provided
> > extra information in the commit log, which I could have omitted, now I
> > have to add more info? ;->
>
> FWIIW, I think there is a value in tightening up the commit message.
> E.g. so it's accurate when we look at again in two years time.
> But I also lean towards it not being necessary to post an update
> only to address this.
>
>
> > The second claim is "rcu_dereference_bh()
> > should be rcu_dereference_protected() on writer side". Sparse didnt
> > complain and i dont see this as breakage rather a consistency measure.
>
> I think it would be good to address in the long run.  But as per my comme=
nt
> immediately above, I also lean towards it not being necessary to post an
> update only to address this.

I can resend with these two taken care of - but i am skeptical of what
sashiko-gemini is claiming (and i admit as a human the AI may see
something i am totally missing).

cheers,
jamal
>
> > Unless I am missing something ..
> >
> > cheers,
> > jamal

