Return-Path: <netdev+bounces-303427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79CKFJhiRGrctwoAu9opvQ
	(envelope-from <netdev+bounces-303427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:43:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A62216E8F24
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bqZ6TaS6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E583053DFA
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5611CA9;
	Wed,  1 Jul 2026 00:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822D1FE471
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:42:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782866551; cv=pass; b=qmOMXb7KcWt7IcDGu2a92LgM9iP2W84dt0VxQMhhzchhmoCOVfz1XOwsk7Ba+TEMT+HUYLQF3yKgSNW42Tjh9TDau7Ds0LZxt3+8O4ncRA9KYXlPYUF7/AByxIWKWIEplA/tpeqhboE/wYMRopFtrzSGIbK+Ppp4hhOx3HJhFtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782866551; c=relaxed/simple;
	bh=TRZpMbXxvWIGuD0bc74Z+j+sksRDReMxCxEfFHCoq5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRKbZbxECDTYukK/R8p+c4i79HFTivonCo/Blh4K6hOK60XN/Y+mf8noUmeiGOhbG+Y28o0bFAC52C5FBeVMdnC5xqsEUkRzxMsqgZhs59EwDZfdDv2OxL2yvmRaglPXX+O92NZSrLqaeXKgQwSixuwCfLBWH2DclQrijOMp/cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqZ6TaS6; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10e86e52so70801cf.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782866549; cv=none;
        d=google.com; s=arc-20260327;
        b=B/6xl9bqrFiGzndGytUeYeL4ZaTLUaol1SWFsebW7bdL0fFKq7WxXdTbfCZafXDwQm
         TXQZi5WjdCaqcm1GQFDY/JkYL18EkayZlFDarK0wcFw/kUHjvvs243/gros/HoWQmpuc
         O6bkXfOwUQ5+FqLOBaiVjysBTasmvdSiqw1vROuAVLWrpvXgnf9LRexdlqmHSWYVwztw
         a/7ITJ8BxL7Gz7rBTuVKZ1MLVq3m0A/o1SqtehO6SCGYVD5RyC9A0g31phMXTA2Z+8C/
         lWUJe7j7OBUUIOQ9sRbxUSm73sCbS30ZDd9de/twBJSWxajjVff1XnGkAkX9Y5G4cmjj
         SVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VngOKqlNcuFoJfPyP6oUsU1l4CeneuTItZPhFh+5Klg=;
        fh=QfAcYiyeFY8XWAWMjQxrHotom0j9JBJrXWlkmSz/DJs=;
        b=HYJVPX4Q31Lqrl8pzm4H7o8cYrSE0y+c1piBjf8eBWMmW70d9wQTrhT7hFMq8Mr3Su
         Au6rfamuUNUiZOPB6Rxwy8lKvU5qvsG7kceUGvcouuxSSsAWB75vrzMqQax0fd001cH1
         QiNOEiIB2g8Xewh1MwrdhpJKRNnAc0egWHAN9JrY4PpFS7sWpxE5uvEvqm8vsjRj7dvy
         azob1nbpP/8ozjv3tz4PwkgUZ8oMRoF5roCWtt8dkxhG6nA6hQoFfQOSt4frKQZhY1TV
         usBJAtkHR02SfxMeCeJwP3UikFpihsnOGj0nf6/XuIBBcOYAvUOo86QzHMTbhUbTgStY
         iGIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782866549; x=1783471349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VngOKqlNcuFoJfPyP6oUsU1l4CeneuTItZPhFh+5Klg=;
        b=bqZ6TaS6qnIsJ3PV9zqIDmK+a0E5yZz5sl244hKuIlLtNQfTppFKL/04qmB/swwgfx
         Gm29NH1DE+cnqdvEif86yef49Cu0EhQZCZ13nmZk1QlfSzPaopg+6IFkj32n6VYgW+eF
         IyvYE6jv2q56Zu8G5KXSXRbP7QEBROuaVQwB5NVuvcZRAcxN0IXfza4hKSeAvXHTX6kt
         j5JuEqYHHwhYQuWsqDWtB7kqfmOFZElGFNBb0vmrif8F3hljmWX4hNaw5Zz8M80kIbRP
         SuqgFkOVnIp1DjtgXJ0kLncSitIIBu3S1ZJFQ/FgR8a63vZnVALAAelvOUY0ElPeGGh+
         eorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782866549; x=1783471349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VngOKqlNcuFoJfPyP6oUsU1l4CeneuTItZPhFh+5Klg=;
        b=FiTTI8jv5osAts+g1S1UMFqiz6EQ3nfPqnHQmN4vx4cJ3S+Rf1iAmERPL2Vu1UBqSc
         WUkChyVLdJjEFCiCOsfjTao+nUMpCoSeNNKjmG7T/RPOD0J7dwL19x70FKFuHIm10NoZ
         eNL7Bh2iymeyUOuK/jG+9OKY6frcVh0FqAN9RAgJbxVVk2UCQJ4bgbjY137F3g6c73XG
         hB98/OugCWpOHUNDShFD9hZ4LtkZXHT5z4ugxcf3tnXdRamNp3fwYGB+hTHFDfZfbg5F
         A0Ls4YF9YgowGkrI60lsX0088e4TNNZvoG0omzLHlg5Wa2AgiGYVqIGMRHu62AuEOpTH
         4SyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y8bqdmuoRIErqn2BxFV03inUaFIFHlieUg+2SsZsjMoqzDVSr2QrmwRAd+fhjOcKJk6IZOGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtyYaKc4tpi+8/8kK3bxTrZVjFdRraEZ2pGPfhGt2kTqL2j4U
	i2LsRooqk0gIHYNGnX7q04Ex9KT3IupA0Gs/9C64RxRHwOnpvJmJ9HBPCwlu49bGQ2Nhz0jcx3i
	bl1zS4xxbRu3MzjAj/61QZUANtkWkzIEvbLSLtJN/
X-Gm-Gg: AfdE7cmJkOHjMAS23VuBD+vJ4uAU2iqazWyMGtJlY/+ir6a26Jw2LhalJTnjZFe8S2Q
	ZNlzuRg4OoDrwfVzMb6e6k+XXiE+HnCC/BS1Td5tW5nCjUAAP9IEL//Fm3WCcaK+a02Ab/7UeSZ
	sEfYJKoO5q5G2J6h2N60zXCQMa2urafMkvWPlKcRf/A5rKQCiBUxvUYl3wAObkl170PFcGmoxCm
	yNO7XVjmzEOH26487cQvCBATp+wXibLD7Hgbn0Avj51CwnYb2jUe+Ex3yBO6H6nw5VZE3f2B3BB
	/61R42CU090GfJbBwGBf5F75jREgHEcrEmWOtmX3jFT1y1Yl6xbFQLU173wRGzK8NppzdQ==
X-Received: by 2002:a05:622a:15d3:b0:51c:523:953d with SMTP id
 d75a77b69052e-51c20699740mr5207251cf.14.1782866549002; Tue, 30 Jun 2026
 17:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630165934.GA1227354@shredder> <20260630211527.3365952-1-kuniyu@google.com>
In-Reply-To: <20260630211527.3365952-1-kuniyu@google.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 1 Jul 2026 09:41:53 +0900
X-Gm-Features: AVVi8CcuV7ilFgf3kVds2y1pkioC4Vy8LsyafWa8osyTqozvONdsETL6OG8mpJo
Message-ID: <CADXeF1HY0EGdFwe6DXu21BmpYUQebHLp89kQ0MpDgb_DDGSaqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: idosch@nvidia.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, jedrzej.jagielski@intel.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:idosch@nvidia.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:jedrzej.jagielski@intel.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:xiyou.wangcong@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,kernel.org,google.com,intel.com,vger.kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A62216E8F24

On Wed, Jul 1, 2026 at 6:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> From: Ido Schimmel <idosch@nvidia.com>
> Date: Tue, 30 Jun 2026 19:59:34 +0300
> > On Tue, Jun 30, 2026 at 04:55:22PM +0900, Yuyang Huang wrote:
> > > > Hi,
> > > >
> > > > why sending this to net-next not to net if that's a bug fix?
> > > >
> > > > In the v1 thread it was said
> > > > >This is a long-standing bug, not a recent regression.
> > > >
> > > > so why do not cc stable kernel to get rid of this bug from
> > > > stable kernels in such case?
> > >
> > > Thanks for the advise, will send this patch to stable kernel.
> >
> > Please target v3 at net and add a trace given you're claiming for a
> > use-after-free. That way we know that the problem is real and not a
> > false-positive from some tool. You can reproduce it by adding enough
> > delay in inetdev_destroy():
>
> I guess delay was added between ip_mc_destroy_dev() and
> RCU_INIT_POINTER(dev->ip_ptr, NULL) ?
>
> I feel like we should clear it first and destroy everything
> as done in IPv6 addrconf_ifdown().
>
>
> >
> > BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x2cc/0x500
> > Read of size 4 at addr ffff88810c571208 by task mausezahn/419
> >
> > CPU: 2 UID: 0 PID: 419 Comm: mausezahn Not tainted 7.1.0-virtme-g15d4a7=
c23bf6 #17 PREEMPT(lazy)
> > Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  dump_stack_lvl+0x4d/0x70
> >  print_report+0x153/0x4c2
> >  kasan_report+0xda/0x110
> >  ip_check_mc_rcu+0x2cc/0x500
> >  ip_route_input_rcu.part.0+0x13d/0xbc0
> >  ip_route_input_noref+0xb6/0x110
> >  ip_rcv_finish_core+0x41b/0x1d90
> >  ip_rcv_finish+0xea/0x1b0
> >  ip_rcv+0xb7/0x1b0
> >  __netif_receive_skb_one_core+0xfc/0x180
> >  process_backlog+0x1ea/0x5e0
> >  __napi_poll+0x97/0x480
> >  net_rx_action+0x97c/0xfa0
> >  handle_softirqs+0x18c/0x4f0
> >  do_softirq+0x42/0x60
> >  </IRQ>
> >

Thanks for the advise, I will try to add a trace in v3. For more
reference, the issue is pointed out in the following discussion:

https://lore.kernel.org/netdev/95adff35-ee56-49d3-8567-382ac17810b3@redhat.=
com/#t

