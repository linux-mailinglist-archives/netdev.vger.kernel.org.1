Return-Path: <netdev+bounces-303273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CAPHNv/dQ2rJkgoAu9opvQ
	(envelope-from <netdev+bounces-303273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:17:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EEA6E5D7D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:17:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=u0IPYxCK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303273-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303273-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D9013022DCB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED532E134;
	Tue, 30 Jun 2026 15:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C722424C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:13:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832386; cv=pass; b=Gxfe1gu3sEuikc1VgirN54f8SkaVYE7sQb0OAWXlt0R7FA+ip4ss8tdDeSJZFn6Q/PcVlBZynWuWxUuBUqW0Bb52Ne3mAvPIKSPvcc7weRzRSffHWrI5gMjUxLZa0jB1yHEJF+rbvBDrym8Ys3w5fSZkjgjprQIuc3zWWYMceJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832386; c=relaxed/simple;
	bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue+m2zhiZ2x9cDNHyBUKjiXugZts2yQDZ5+eXfVKxRa+OI7Lyw5qqiLvEsJeJEAk3o7M7zIIBK/Dv4+ddgJfIzfpjYGwXe6QufbvoNkGLkiwxZyHsElFvR4G+tF3fLBSlLY+8PRGU1NI8I3yT8ZxUWaC4kZBqAy7SO613vm1ycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=u0IPYxCK; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847aebc56b6so256421b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782832385; cv=none;
        d=google.com; s=arc-20260327;
        b=CXoaOPpcb/G+USC3ZjV9jwNckneIZHPf7ITpGnlcmNt2bXgVFpT5kVsm3BADKYf9QY
         88K+EV9Z917DXc1AeWN1/f57AHF5X/4MHpfsZSIgG26HvAJUG7b0HX9FMSQvhU5t3isb
         gr0b1YNp0fZy/V/mnTljnDkZ4sooyYTtnFRnoE+EZqGpUUS+FBriutnnEiCaanu/Jluc
         uvfv9p9MmbUJgLW/67nt33D/ILRdyTVA0Cd7pI3ZMTLerF/BydlHZbagAdFQWvlK1nV6
         tEgO4n+ke9W6xCp30OopxuzL/Q+cGeR9etRh9WSTv16QV3Qn+hk4PqSjULzyPSiT3tX/
         +BvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
        fh=z2Ww3/ONHYFhHH/rtkEWWeVeD8bqw808Qvyz5K9Fozo=;
        b=E4bBhBGklumoFPWD/mqw3+msivwZe9guzDKrUpIhWLyrPCD/Ogive0CTNgZFJPbjUl
         zbq/W8GwBRloN+a18sZwwXkDnqvQjkA+NJ9vcVKpQE2Y71SfiiiDi7g83lR6a2O6HNYk
         dSDuLLk8m/Vbjyjn66lC6CbzK1lL4zrQzVL2+Oc19Qx4q8CEF/BxtX+9EitjjtgPpT7f
         31JUQDN/n4/JXi1RfWOfu/mfTL2AylKjWGgMR7+sp+N59NZiv29h2/cqnU0AEtF6iO0Z
         Tb+1Zc7Ub6bZ0WqJpyslIRDaKkFZIvxH3Q9zfolhpdxSMmAep+66QPLLLdPqzBYWgFjk
         mJeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782832385; x=1783437185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
        b=u0IPYxCKGJAuEgUYMjWBG2ou/o00l2/OmyMv8Ly2jdrVfYDtudr5vkrDcQdsbaG3pg
         qO96WJ/e0yQm05m0iXnd5v0DgiTpJSO5431M95fsZIARe7pzzsqId/sv+p43YbRzsyNg
         1Bxp8Gk8Ethw/oPP5fJBbTX0luOYmH9p6tDV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832385; x=1783437185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
        b=lGU1iMF5MiSxBeER3ukjeKIWT3quFyf/eErTZ2Na+cV0PQGslIQzjTdf4umDX1meuP
         V1Y2D4E+L0Jc/oudNctobEZVA7uQCzqsFx6ryDHb0waiO8nlHCf+DT6izZM+c4FNICsj
         JvFUUagABuJHw57xb4FEU1SJNP846gvTxD+N42QjB8hNT1FnTyPQtagNhGaTc97DQzf7
         Kec3BZU2gYlRuw1XO9rpPKz5pEn8Fo2RdcKC8wQfmFGogpBOEQtloW/n3pv2k5x0sJTc
         l+m4x6pXaDiF8BkkuR5iK06b82LIxbch72lIIdYhKGVGsHsjj9BH1sas70P2BrUIb/Ps
         XNlA==
X-Gm-Message-State: AOJu0YxQium8UwK0a3ajLD2ShdxqDGe/dP/IPd4XgsmftxRX565InJHZ
	cYtZMbYELCN0aBn0UO4e4aQwf8MztpEwhIOuL3p2HCxgge/1ejHqz6WwxPTppyZ49Akg1LBvdTZ
	8oqvvo1xv8uPGq4+/Zq2YXZh5/rIGlo0R+yCI9h0kbDCF9vHeuSM=
X-Gm-Gg: AfdE7cnTLPz1GS06MlnYoVWWLuftBYktBDk9BCSrdksufCE0MBzP9Wbvzx13lEbUO0Y
	l/y8BpTkVFiz8G25vH7iDZx7K8c9uJukSy6aZiILXAMpdn76auynw9teeUq4P7vB5BEW8F5NOFN
	VL9fb6LRjIYT7a8eY9qw5oXfkbscsnV14yPkzhsghE0nmdT4eROF14/qO9kXWLEr8LZUJfqbN2A
	hrMr9UIVs0ELcx4zRjPO2NDmY1ZqrLbBHQnUsX7T+N05Jbv3b2vjet+4MlspiqG7xQWDHSbBA==
X-Received: by 2002:a05:6a00:22cb:b0:847:8449:2bb6 with SMTP id
 d2e1a72fcca58-847add5ed31mr1031837b3a.4.1782832384500; Tue, 30 Jun 2026
 08:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628111229.669751-1-jhs@mojatatu.com> <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
 <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com> <3dab7c8e-aed3-41f2-97e0-558c7a82f925@redhat.com>
In-Reply-To: <3dab7c8e-aed3-41f2-97e0-558c7a82f925@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 30 Jun 2026 11:12:53 -0400
X-Gm-Features: AVVi8CfDVmG9Z4yADXh5AS1CG7Y0BA3PaEb22keblCHUYnyd1XomuuYfPnXpfXM
Message-ID: <CAM0EoMmzrJHLzFczYsXGcr7oEJ2-TSrkPVJJa4ROwPwA+MFj3Q@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:victor@mojatatu.com,m:jiri@resnulli.us,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303273-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,mail.gmail.com:mid,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,vger.kernel.org:from_smtp,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49EEA6E5D7D

On Tue, Jun 30, 2026 at 10:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 6/30/26 1:49 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 30, 2026 at 7:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
> >>> The teql master->slaves singly linked list is not protected against
> >>> multiple writes. It can be mod'ed concurently from teql_master_xmit()=
,
> >>> teql_dequeue(), teql_init() and teql_destroy() without holding any li=
st
> >>> lock or RCU protection.
> >>>
> >>> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is fre=
ed
> >>> after an RCU grace period, but teql_master_xmit() running on another
> >>> CPU can still hold a stale pointer into the list, resulting in a
> >>> slab-use-after-free:
> >>>
> >>> BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
> >>> Read of size 8 at addr ffff888013fb0440 by task poc/332
> >>> Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-5=
12)
> >>>
> >>> The fix?
> >>> Add a per-master slaves_lock spinlock that serializes all mutations o=
f
> >>> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> >>> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> >>> around those updates.
> >>> Annotate master->slaves and the per-slave ->next pointer with __rcu a=
nd
> >>> use the appropriate RCU accessors everywhere they are touched:
> >>> rcu_assign_pointer() on the writer side (under slaves_lock),
> >>> rcu_dereference_protected() for the writer-side loads (also under
> >>> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit(=
) and
> >>> rtnl_dereference() for the loads in teql_master_open()/teql_master_mt=
u(),
> >>> which run under RTNL.
> >>> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the lis=
t
> >>> traversal in teql_master_xmit(), so that readers either observe a ful=
ly
> >>> linked list or are deferred until the in-flight mutation completes. T=
he two
> >>> early-return paths in teql_master_xmit() are updated to release the R=
CU-bh
> >>> read-side critical section before returning, since leaving it held wo=
uld
> >>> disable BH on that CPU for good.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Reported-by: zdi-disclosures@trendmicro.com
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>
> >> Looks good, thanks!
> >>
> >> Please note that sashiko/gemini found a pre-existing issues which may
> >> require a follow-up/separate fix:
> >>
> >> https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.=
com
> >>
> >> (the 2nd one in the above link, IDK how to generate a direct link to a
> >> specific comment)
> >
> > I just sent v4 which covered that but i will send a followup instead
> > if you already applied.
>
> The PW bot is went on vacation and no 'patch applied' notification is
> reaching the ML; v3 is already applied.
>
> > BTW: What is the ruling on when Sashiko finds a pre-existing issue?
> > Should we address that as a separate follow-up patch? It is unclear
> > what the policy is.
>
> The general guidance is that pre-existing issues should be addressed
> separately.
>

Ok - i think it would help if this was documented somewhere..

> > This teql patch was one of the hardest to deal with in terms of
> > reproduciability and the fact sashiko kept coming up with pre-existing
> > issues - including the one Simon and I were discussing. Note: None of
> > the pre-existing issues affected reproducibility at all although i am
> > sure one of the AI-kiddies reading the sashiko reports will find a way
> > to create a poc (this is why i entertain fixing them when they look
> > simple enough)
> Not an ideal situation both ways (which is increasingly the case).
>
> Addressing incrementally pre-existing issues can lead to an huge/endless
> number of iterations when touching some unfortunate area (4 is _not_ a
> big number ;) delaying the actual fix indefinitely.
>

Agreed. I guess i get anxious the AI-kiddies seem to be following
sashiko and as soon as it complains about something they immediately
followup looking for new vectors and i feel like i will be going back
to fixing the next issue ;->

I just sent a followup.

cheers,
jamal
> /P
>
>

