Return-Path: <netdev+bounces-273941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNahFurHzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73B375CA6
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B59E230411C9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86137CD35;
	Wed,  1 Apr 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLoC3ncD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD42215055
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028197; cv=none; b=LsCefu3N01KKiEJLwGJEdxpQsp9Gdq0LwA6WgBrd9WkW8ghPHJp45cMK7Hvxlhzs+5TqAyBndVhYUaC0a8zT8+pGLtykE8NCiGoltKYrFoaPRZ/zZvA2OggtqizY4gONLvkxTkgvvpAOrFYnkji0J7e+qZaJcjGkd8VxR2aOia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028197; c=relaxed/simple;
	bh=MDLwY3hGJOdNA7uVlHCfOymMULOe/4nAfCiZBHj7HMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ4z6zauknldr5FFwcqAdiTK751BZe9DsT3yjMWoQ8SgQ/nmPTixqdjKdjF4ZXby01p4H1kb1AdBQiRoJarOgMzR9/bPZAtMF/PVvWst61rscxEqiovAx9P6Eul+QY7gzFjLwWz/sMuRNLHmfdy/ikgEYN210WsIcg5aRDE93EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLoC3ncD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d932cc948so2661816a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775028195; x=1775632995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0/p1uDng2sgquUAGmXmR5OASn6msZGNk3CdQw5m8PQ=;
        b=qLoC3ncDvvk5mbQ1jb3pIZf5f2VQSqtZ2nXIE9RG2NaDoCNs6OMlEmtJVnWbXLygTn
         x0py0JALZO7zcEQmlBiliBxFa9tMd7xsKLXnfjmpVi1yh+Ch5SbuJBK4uvPkvbVbt/0n
         YdPs8MbWokTC3mQtejVBrReNrXkUSWcQazC8qChMxaDVQpU42G5ftQoQJFC32vcc1OMw
         XqglEsgfk/A/0gZSMgJylg/lLVJa9ITc4z1bj2TruBdyjJJc78zAfiLc1tC0IEwjqe5w
         M8Xa8dWuAr79hF61rzutk49CsLb+iKpCp032G4CmhTGDWBuV/lwomJASYIQhwWVcy/qk
         DOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775028195; x=1775632995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0/p1uDng2sgquUAGmXmR5OASn6msZGNk3CdQw5m8PQ=;
        b=qSKRmKbqQ0YPxi4M4PeJqfHSBMBHiIoKOMqYRWtRL87jGTx+oXuOdeWFfcwh7SZBB/
         a1+iaOOJYd3XrnPxRX7DQOJTO25T4OqxpOt3Y+VNliX5Da3MVi3g8RCaJn3u89T4rsJn
         bGve6Yv7v1KpWKHBOyc3CvMxYdOGCl/C869bYedpIkb2Eq50V3FG8na7fZSaHJCkzabO
         7yZMjaSIhCaQgVzZ6jaWlqPbzapl9KrUAjVhGyya6uFa++CU6LjMVCi1pXltxLT2/sA3
         YcxYLhuZVXF/Zul/v4ZKkTdV3mM175TYmiE4kCfeHjXmdDRnETCCKN04XVohPf9GgN2y
         rRCw==
X-Forwarded-Encrypted: i=1; AJvYcCVajqAKjhJMUEglPJvacbKgzUxtaGzjseNvw960PY4ZoMBvM26SAj+DO553ivA8DV2Bo6Q384I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIn5+XFJZMqeAPAAKUQjd/8srYLDaZTomfuvVfL0Jf8vdyZQwE
	cfzNZKcPE/RYXUYIYNNt52ENmdKqiDhbXsdW808F8KaSl8JmQ7EFqH+W
X-Gm-Gg: ATEYQzyIxt5aHH9qQaBpIRBX5wYo5gk6v4a4ZWWLQpsfOGRc8+nYy/r0eV05a8i6qtM
	1JA2g5YlKFXMYcE0HUOFnEWAnqOKhw92xh285jQ6uvV+Xi282xGq0nDpMDK2UeWo5INcrntr7g4
	AXv2dDTNdnC7jtQjwsQYcxw/YiTdYosmto6+Io1s0mLtV+pHcTSOFDfXqrDeLmMhnBtqvZG+GsA
	TkiO1uBj+Zi01cIRXNXNAah129cZ+F8f1IVbj6JNBcp+c6FFj8qlFRnz9tU0W68djx+zPS0V5fQ
	xAgyH34Tek592g+EKZnnF13Xh1fGQXhT9AqOfN/ltklnM5DqILF9XRzW/jtj+gHZl4Pr2n2q6UA
	4eMvqOaV+1nmWxNV5DA6SVkSjw70PttyJp6eQhnJlFd7lgp8LcgJJM1KtUvDXJ6w20zyFBkub+Z
	BCX22mghEqyFrBNyNFdVCp/53e/cL9oxfoFiWThKMVWedvW4yeiTj0k4vF4cwt
X-Received: by 2002:a17:902:e785:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2b269ab02f1mr24259755ad.12.1775028194753;
        Wed, 01 Apr 2026 00:23:14 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765c7bsm140048795ad.49.2026.04.01.00.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:23:14 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:23:08 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net] ipvs: fix NULL deref in ip_vs_add_service error path
Message-ID: <aczH3FtMMM4vC5Fq@SLSGDTSWING002>
References: <20260401041611.3302189-2-bestswngs@gmail.com>
 <55c32c6e-8126-8a85-9ddb-1ecebedf2b67@ssi.bg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c32c6e-8126-8a85-9ddb-1ecebedf2b67@ssi.bg>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273941-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ssi.bg:email,asu.edu:email]
X-Rspamd-Queue-Id: EE73B375CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-01 09:38, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Wed, 1 Apr 2026, Weiming Shi wrote:
> 
> > When ip_vs_bind_scheduler() succeeds in ip_vs_add_service(), the local
> > variable sched is set to NULL.  If ip_vs_start_estimator() subsequently
> > fails, the out_err cleanup calls ip_vs_unbind_scheduler(svc, sched)
> > with sched == NULL.  ip_vs_unbind_scheduler() passes the cur_sched NULL
> > check (because svc->scheduler was set by the successful bind) but then
> > dereferences the NULL sched parameter at sched->done_service, causing a
> > kernel panic at offset 0x30 from NULL.
> > 
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> >  RIP: 0010:ip_vs_unbind_scheduler (net/netfilter/ipvs/ip_vs_sched.c:69)
> >  Call Trace:
> >   <TASK>
> >   ip_vs_add_service.isra.0 (net/netfilter/ipvs/ip_vs_ctl.c:1500)
> >   do_ip_vs_set_ctl (net/netfilter/ipvs/ip_vs_ctl.c:2809)
> >   nf_setsockopt (net/netfilter/nf_sockopt.c:102)
> >   ip_setsockopt (net/ipv4/ip_sockglue.c:1427)
> >   raw_setsockopt (net/ipv4/raw.c:850)
> >   do_sock_setsockopt (net/socket.c:2322)
> >   __sys_setsockopt (net/socket.c:2339)
> >   __x64_sys_setsockopt (net/socket.c:2350)
> >   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >   </TASK>
> > 
> > Fix by recovering the scheduler pointer from svc->scheduler before
> > cleanup when the local sched variable has been cleared.  This also
> > prevents a latent module refcount leak: without the recovery,
> > ip_vs_scheduler_put(sched) receives NULL and skips the module_put(),
> > so the scheduler module could never be unloaded if the kernel survived
> > past the dereference.
> > 
> > Fixes: 05f00505a89a ("ipvs: fix crash if scheduler is changed")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  net/netfilter/ipvs/ip_vs_ctl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> > index 35642de2a0fee..e0c978def9749 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> > @@ -1497,6 +1497,8 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
> >  	if (ret_hooks >= 0)
> >  		ip_vs_unregister_hooks(ipvs, u->af);
> >  	if (svc != NULL) {
> > +		if (!sched)
> > +			sched = rcu_dereference_protected(svc->scheduler, 1);
> 
> 	Good catch. But may be it should be enough if
> we just remove the sched = NULL after successful
> ip_vs_bind_scheduler(), what do you think? ip_vs_unbind_scheduler()
> already detects if the scheduler is installed.
> 
> >  		ip_vs_unbind_scheduler(svc, sched);
> >  		ip_vs_service_free(svc);
> 
> Regards
> 
> --
> Julian Anastasov <ja@ssi.bg>
> 

Hi Julian,

Thanks for the review. You're right, removing the sched = NULL is
simpler and sufficient

I'll send a v2 patch.

Best,
Weiming Shi

