Return-Path: <netdev+bounces-275658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBz/M5bp02n/ngcAu9opvQ
	(envelope-from <netdev+bounces-275658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:12:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A03A59A3
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFD78300E27A
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9438F930;
	Mon,  6 Apr 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="ZnXFG4Fp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128F38F243
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495570; cv=none; b=JNjo5oElGeL3i5jugMaFekENtcONVgQqm761C4RjLsf8FUnipOqeXedoXaMh6c2epIJWUqdZyYKT37hQJ/ow0SADTtzQJ4ty2ULmCe8S84ARjMM9N4NKpFY9mUI6mxBi+r1OH7PKj6bt/pNGakO9Slix+5OPZI2WshXifJC2NIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495570; c=relaxed/simple;
	bh=d42IIw+weYRwQ5HRi/h21uuLi5FFAQnCGKhreEp4H7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqwgXxFHsKrtI0Db1Eett4XDQikCgEqa2QBhyGlVhzG8/FvjtWzAEPN+kspZp3/Ym9x0B5Jwfri9SAjDAQ8HFwnKn7z4kgq3z6nn48ruwd+RCyLz4eFM9RlxQCKK4ljuqurrr9pvkkfwmXjKrawRKy1wz4wsm/zOdCPwnopqY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ZnXFG4Fp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296dabef74so3981059b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775495567; x=1776100367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSRY3MffZOgkoF8pneWM3oCokuMI5pTYVXcqEQr21cI=;
        b=ZnXFG4Fpz7uaNkM8Tph9oHHFcn2beygIBDweG31W+n2EMbSHIHVmpOhFdm59vQNp22
         koFJh9gFNRd01Vv32At8T1s4IDT8L55v/lZI6OXEQ7wXBExuF/YoAl7NkOazUjFnHMVk
         bMdcPB3gz6JGD1Dg5UE6PCVzwZBK2FdGP+nigC/BB1k7MtqW5lLl1MvmeLfd2Av/SFgu
         vWH0MKXXdXuQzABQ3rMiD3r4emFVpHxvVvVxhCDL/A5mK5KC5NfAj37zbBvixqEMFtDi
         8ql9zI3uT144f4mtIVY4MlOr2UZTLC6+qKRjTlWAtVpuGwEqKfr3z4TLEPtkJI/V7YAK
         BuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495567; x=1776100367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSRY3MffZOgkoF8pneWM3oCokuMI5pTYVXcqEQr21cI=;
        b=MneKtWMa+HqkzLUGKj/5/YrXYUEHOWG6qvg3m5NOzgLkgmjPVk3RJKQr9AU3kLEPFp
         eFMMnz8tVEVgkzBaXkirTeELjXgQcKAYD2PSAFoajcfY9d3uXdZxWXjBfDzKMyKreJT/
         zDE9eMmrDXz/6fNgC7gBxw2KP0p+su+kZ/KZE+1CR8TRltZvwmRWmgPOL1QoC0jEgzk6
         vSMEi+M8TU6e7SAlxGacGut/niWcz4lkZsn6JvQowWWmADSWIo4iAY8+n4eaOZZCdXNv
         rFL+pqyCBy18W/aXDxsgKOKthXLAqxsng6SRUQ1hN5r0UNTwpNljPdCFllv6sak2xZcd
         YMcA==
X-Forwarded-Encrypted: i=1; AJvYcCUnH/GKEaYEfFGIoQx19gjhPgWbsPZdqc/KdnyBz366TkOZMLZktBwdxm3tHFUAmIL1/tYlC2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jIhqC13uXg9prFzPdjr/Twq8+wqmbFRb2rV+Soq+S/ZFlshr
	R8VFsP5nWYhxWgKlTckTVCdxi7Q0feGafPqld7IJX36F/HP0N13fhY3lKdeb2GD7sqg=
X-Gm-Gg: AeBDietqgoODWxXObYtRzwFKqy8X8i42emRn+8RcbvploTDbYx/5f7oR10+H6TENLoB
	WQIH+E79XVj83KiILWFh0zu3ATrKlcbE9QpNcFPczder/TEGnHxkOAgSoQZk4+NTbhC4IwOHN8w
	R41x9KWGRvloYrt30U45wzHHxtzDXb7rV6eqX2Yuw9vU9c+dmzNBaxlSa+qDntKU5j8eyoU4fbk
	lSOLWp+VcM+0G5Yde1LbPvlPS/37GIkQp4WCt8VwGJ11T45MoJ6zgbpw6+NbQXI7Hi52jvnb6BB
	HY9Ycx8uVZQ/Cl2LNEUlHDby0wQgYLatmu6yqxYT2D98w4XsjLSBuQULgSodTS0Ro4z6YKKthHS
	PHbQYGZ/9wP8e/gvap0dJKtZ4iOKi6ErwWHF9gmc2DAZDzNA4N+2GJMBUieMmsFXVDgYcn2KF9G
	TNUYyyquwJAVwRtrru1GMoFi83w8lj4kmma/4=
X-Received: by 2002:a05:6a00:18a3:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82d0da90bc1mr13231550b3a.25.1775495567223;
        Mon, 06 Apr 2026 10:12:47 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261b6sm17721564b3a.3.2026.04.06.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:12:46 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:12:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 4/7] net/sched: netem: restructure dequeue to
 avoid re-entrancy with child qdisc
Message-ID: <20260406101238.2d106bfd@phoenix.local>
In-Reply-To: <20260406084133.47bcfc8f@kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
	<20260402202037.176299-5-stephen@networkplumber.org>
	<20260404094946.GU113102@horms.kernel.org>
	<20260406084133.47bcfc8f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275658-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 336A03A59A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 08:41:33 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat, 4 Apr 2026 10:49:46 +0100 Simon Horman wrote:
> > On Thu, Apr 02, 2026 at 01:19:32PM -0700, Stephen Hemminger wrote:  
> > > netem_dequeue() enqueues packets into its child qdisc while being
> > > called from the parent's dequeue path. This causes two problems:
> > > 
> > > - HFSC tracks class active/inactive state on qlen transitions.
> > >   A child enqueue during dequeue causes double-insertion into
> > >   the eltree (CVE-2025-37890, CVE-2025-38001).
> > > 
> > > - Non-work-conserving children like TBF may refuse to dequeue
> > >   packets just enqueued, causing netem to return NULL despite
> > >   having backlog. Parents like DRR then incorrectly deactivate
> > >   the class.
> > > 
> > > Split the dequeue into helpers:
> > > 
> > >   netem_pull_tfifo()    - remove head packet from tfifo
> > >   netem_slot_account()  - update slot pacing counters
> > >   netem_dequeue_child() - batch-transfer ready packets to the
> > >                           child, then dequeue from the child
> > >   netem_dequeue_direct()- dequeue from tfifo when no child
> > > 
> > > When a child qdisc is present, all time-ready packets are moved
> > > into the child before calling its dequeue. This separates the
> > > enqueue and dequeue phases so the parent sees consistent qlen
> > > transitions.
> > > 
> > > Fixes: 50612537e9ab ("netem: fix classful handling")
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > >  net/sched/sch_netem.c | 201 +++++++++++++++++++++++++++---------------
> > >  1 file changed, 128 insertions(+), 73 deletions(-)    
> > 
> > Hi Stephen,
> > 
> > As a fix this is a large and complex patch.
> > Could it be split up somehow to aid review?  
> 
> +1, FWIW it's perfectly fine to have refactoring patch in a net series
> (without a Fixes tag) if it makes the fix a lot easier to review.

I split it into refactoring followed by fix for next version

The fix alone just gets really confusing to look at;
I got more confused the pre-existing spaghetti code here..

