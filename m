Return-Path: <netdev+bounces-278338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFLLIeb73WkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:33:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E47723F760F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A7C307C844
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634603A4F27;
	Tue, 14 Apr 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5phyXF8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D93A640F
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155328; cv=none; b=CXmlDxj/gcbvhj8N1+R0Bh+IHP7N2rTiZFpA5oZIpsTt6of+BQeGMN7xxWdOwwopFZCeMQp7+lA+iLPN90BBCia1Uu9LAT4LJhzhUQsXHRGrLPYdk7AsSp9wu8g6NoH4r6vVZMC9+SdiB1ZKSYLsva9HwkcxPHvCcCUGOHDuJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155328; c=relaxed/simple;
	bh=+hEjv/YEIGD+t/a2dkN4zlIRGvn3FwnMz9kChxBTaK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyFEYENb/Bjc6LVfBNtWlot7prpGx7pykn9E30vYR3nQSbgXLI9GKQ6dQGg+SUD46p8PDZPFi/m99jCKHmxbZSmEzS5nJSfCtcM0Pg6+rR+AAVR9shZsQr+tlWYm3KC9GgeIJ6c3DYJoitmrzGUobsmp4oVY74FhUHmG9PpQ4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5phyXF8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f22f6b0feso1253671b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776155324; x=1776760124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZgpgC+hTRJV50/Tas0DS70HG1hlLWD71CdGjtmP/tU=;
        b=A5phyXF89WzDmfeXYgJdqglyJlcO83XPh2MmHXIrwj11urgHW6L0ntXFPx1hhO/OVw
         gXPD3Jfy1n9Pbs47a1rBErKGM3MFKFWSSfanBL6schXUWq3c71PdDdkzNrCwfZ3/jMtZ
         9zmgYXZhSkKkLP2pC8En11suzP07vqFyiVhsDjFf9IuZCwcebE/fUYjPLq+qhau1c37E
         aaf2tnzn/uLYE02nQDIxNJXtrDsjwM/ula121bBl5YlB1bHgUWzA5gTCcEnY0IAssfT5
         SHAU3I0Yh/32rk6qGlrLFrXJ0h+s8fyHGmSlYQt7zhIgZqj8pFNKB8AnjzG6phNrf54c
         SqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776155324; x=1776760124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZgpgC+hTRJV50/Tas0DS70HG1hlLWD71CdGjtmP/tU=;
        b=s0S0a2ZPqbTpdO9g4ns6rXzi+CwYn64/F2CioBEohNEhoyOxrmT0bSBSWTv5Ooy4H2
         TrnWHqChJDkfyLKlEIBNzwSnKXRYfDYNtrJjelxydD6jvG7PAVSwaDlbPpqzo/AWPVaO
         EmA2xOwUdPzTz1a0Zeh5/ETQYlp5pN0xB/es2eEmF7lW/PX/vMgttyDSdUIzOdYXp1zm
         guxy0gTRrK59J8G8telcF1h1o/OQP3MXxqlQin3161EXOggq6dMXf0ph+i1WCxkM/waW
         c3qdMPVgv7flUtyblks9S91gFM5PEaH/dKIqfN6lWdCc+/sE3ado4lotceSXfw1PdPYD
         Xopg==
X-Forwarded-Encrypted: i=1; AFNElJ9Qy0Vec0ev+7KL/YWDMmtiz5Pp0xG2KayIhKx0GgLvKW9w1ns6JtEkCbrADSSCim4pJtVYNdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hDflbXFXg1ix35bDXvHK0QygtCurrLZOpiAxG7umRFqGa/fh
	FO0uTGix6rMwz/toRymd/4p1PyhcEqt1a+Vz6bgltWgpyV6XqNwmetN+
X-Gm-Gg: AeBDiesJPG0FS7l0OrpgtJ6GX18Gr8EkwEcAej3SqeFRB+qwtY1PA9H64MtjxzeB+Ds
	qnSSCDch7NeAaazQ2UW2GUHlN/y7gg8eHgtl+/yhByDHbycc2dtBXzuLeETxOk58i+T6iy2/4f3
	8lPjQ1F5B6ZcFpA+jCzELV/lYjUz7HydQug/zHFGuVRr6jW6pFAnZb32a17xXzm07Qy3weYi3Kj
	vJ0DAS2G5YxBPPgTiwOQTk4qwULYgJ3ueRCpkWFqCx1pVmQsG4off+PPq5aNqyFCssUFqfSXQne
	5bShFz+Ijc5z/ktfdeGueRj/oq5CS6UVet93+ZHOnyTHlS/FMTwFxxRKCdQYeCqTH9Jf3oxIYxb
	3NduWrxIC6HWiXY36qqLW+ZwRuZM+dXpzG++MXp+Ynm92U1Dj8SlNH9GtHBpMvTT/Rly4sD/OVD
	wYCJverYX1sRd5DzKKRYDpHyYc1QSM67/nuc4mJTSrfJWr/E7h3IYmhmvs38EP
X-Received: by 2002:a05:6a00:399a:b0:82f:979:4013 with SMTP id d2e1a72fcca58-82f0c2509d8mr17075697b3a.37.1776155324174;
        Tue, 14 Apr 2026 01:28:44 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50d24bsm17237769b3a.57.2026.04.14.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 01:28:43 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:28:38 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net/sched: taprio: fix NULL pointer dereference
 in class dump
Message-ID: <ad36tuVF57bRFwHQ@SLSGDTSWING002>
References: <20260410153902.955227-2-bestswngs@gmail.com>
 <6f4ebd09-9fa9-4b6e-97b5-a6b1fcec8774@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4ebd09-9fa9-4b6e-97b5-a6b1fcec8774@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278338-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E47723F760F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-14 10:16, Paolo Abeni wrote:
> On 4/10/26 5:39 PM, Weiming Shi wrote:
> > When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> > is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
> > Subsequent RTM_GETTCLASS dump operations walk all classes via
> > taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> > returning the NULL pointer, then dereferences it to read child->handle,
> > causing a kernel NULL pointer dereference.
> > 
> > The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> > with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> > namespaces enabled, an unprivileged local user can trigger a kernel
> > panic by creating a taprio qdisc inside a new network namespace,
> > grafting an explicit child qdisc, deleting it, and requesting a class
> > dump. The RTM_GETTCLASS dump itself requires no capability.
> > 
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
> >  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
> >  Call Trace:
> >   <TASK>
> >   tc_fill_tclass (net/sched/sch_api.c:1966)
> >   qdisc_class_dump (net/sched/sch_api.c:2329)
> >   taprio_walk (net/sched/sch_taprio.c:2510)
> >   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
> >   tc_dump_tclass_root (net/sched/sch_api.c:2370)
> >   tc_dump_tclass (net/sched/sch_api.c:2431)
> >   rtnl_dumpit (net/core/rtnetlink.c:6827)
> >   netlink_dump (net/netlink/af_netlink.c:2325)
> >   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
> >   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
> >   </TASK>
> > 
> > Fix this by substituting &noop_qdisc when new is NULL in
> > taprio_graft(), following the same pattern used by multiq_graft() and
> > prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> > control-plane dump paths safe without requiring individual NULL checks.
> > 
> > Also update the data-plane NULL guards in taprio_enqueue() and
> > taprio_dequeue_from_txq() to check for &noop_qdisc, so that packets
> > are still dropped cleanly without inflating qlen/backlog counters.
> > 
> > Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > v2:
> >   - Update NULL checks in taprio_enqueue() and taprio_dequeue_from_txq()
> >     to test for &noop_qdisc instead of NULL, preventing qlen/backlog
> >     counter inflation when noop_qdisc drops packets (Sashiko)
> > ---
> >  net/sched/sch_taprio.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index f721c03514f60..XXXXXXXXX 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -634,7 +634,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> > 
> >  	child = q->qdiscs[queue];
> > -	if (unlikely(!child))
> > +	if (unlikely(child == &noop_qdisc))
> >  		return qdisc_drop(skb, sch, to_free);
> > 
> >  	if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
> > @@ -717,7 +717,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
> >  	int prio;
> >  	int len;
> >  	u8 tc;
> > 
> > -	if (unlikely(!child))
> > +	if (unlikely(child == &noop_qdisc))
> >  		return NULL;
> > 
> >  	if (TXTIME_ASSIST_IS_ENABLED(q->flags))
> > @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
> >  	if (!dev_queue)
> >  		return -EINVAL;
> > 
> > +	if (!new)
> > +		new = &noop_qdisc;
> > +
> >  	if (dev->flags & IFF_UP)
> >  		dev_deactivate(dev);
> > 
> > @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
> >  	*old = q->qdiscs[cl - 1];
> >  	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
> >  		WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
> > -		if (new)
> > +		if (new != &noop_qdisc)
> >  			qdisc_refcount_inc(new);
> >  		if (*old)
> >  			qdisc_put(*old);
> >  	}
> > 
> >  	q->qdiscs[cl - 1] = new;
> > -	if (new)
> > +	if (new != &noop_qdisc)
> >  		new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> > 
> >  	if (dev->flags & IFF_UP)
> > --
> > 2.43.0
> 
> Does not apply cleanly to net and looks seriously mangled. I suspect the
> above chunks should be part of the actual patch ?!?
> 
> Please, whatever tool you are using to help crafting the patch, double
> check the result manually before the actual submission.
> 
> /P
> 
Hi,

Sorry about the broken v2.  I'll double-check everything carefully and
resend as v3.

Thanks,
Weiming

