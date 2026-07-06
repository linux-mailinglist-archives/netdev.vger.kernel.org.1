Return-Path: <netdev+bounces-305220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MLj0C4UTTGoSgAEAu9opvQ
	(envelope-from <netdev+bounces-305220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4D715841
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:43:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mCBN0EUb;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305220-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305220-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A16302AE19
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 20:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D33DEAC1;
	Mon,  6 Jul 2026 20:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852873DE439
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 20:21:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369297; cv=pass; b=GfGXGPRiTtPsA3qNHwDrPb31UfGJAL89coP5zEiqOk0OVgHpvWxf6APnAUGNbC42qA0zGS+rI7OgVUARX/3wH03zmJBLLWkXbjuc1nzjNnNMUnfX+LurJmQjUZzgXiHOnXVgQOhFU/tgfOaPZUsIXH526iWVV2w2VJ4M3poZpwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369297; c=relaxed/simple;
	bh=prmM21//B9sPKYo5WgVpAv0RCpCNoPqxT9f76VlMleI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+UvjLPMfOMz9XBHavsoGXjIQgvFGW/A0zCG6ZpAcEN21KdOcNDqaNNJKTjluMQ7YcrLx0o1tCA5MfBl12Ft8AVTxZklg6Eik27scK84py+lgUS86wthM1zY2ZpISURCAOV2R7DjyFcbN9pHs8UtMj34Wl2v76WaLX6s7O/2JOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCBN0EUb; arc=pass smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66780d9d901so773053d50.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 13:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369295; cv=none;
        d=google.com; s=arc-20260327;
        b=XQju20WR6Yr84SSSKfpHS6qAQJ9KRWCA/AbkITPzh3hRbeMwV0gYYsHzn0P8Npub9c
         eliKHyQZp7ta7snjrhbO1hbwRWKwQM3cWTZQ7Hl99uE0I49dlPSLRyKOvZOILr1nD0IF
         0q0F7D3GxDZ9p7ry9fTNw3iQUuZH0cPfdWOc03y2trv8jSQep44Xfcok6irVqgC3qjLf
         WzhBygB/SBZNeeDhcO3QZgBh2ufsu6MchNo9ZqMf9IQXf2nhQUyrarBU8Vn7j3xSoQTc
         fMG21RzOgSRBLKexp8Z5k+Zw6kBG6iP/4j7gjaQGIygXg2rNpg8oquRcsM/s2DEt9snT
         CG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4bzkzQjedlM/WHqa+XHjmbIeat2b4Ekopu5HBj7jW+I=;
        fh=G/3bCH/i5VorMmL+fyTYbuBvx5virqlE9PlfsU/q3XU=;
        b=aTAeC+b5spNW8lhkb/bx25w3WVrdgRKUBWYhaE67eB8VEmibv7KEdjCb24j19UUCJ0
         93xc35qXEz5HFmmEuKbJkKnhkdnxjGOdnAEJgMGjdXKxDtt4X0n5bfQPRW/yHv0H41i5
         IOspUkGtJwE6rpBnre9jqKs8H6pSzKtJTG5MGrErQfaKA3W1qUvH6LM3ZFEPSD2I4cEV
         gCfEo5vj8E2hrAtPq+HSQnJ9S7G7pN9gRH019Q5IWZ6veky47v4omKJfsLo8vTUW8PDz
         A2FeJxHHsP7T3b1KfVRwbtQQFIWPBimXFLeKk0fwt6PGQEBnF8X4DaoqG+2AkNe9GIgU
         bb0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783369295; x=1783974095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bzkzQjedlM/WHqa+XHjmbIeat2b4Ekopu5HBj7jW+I=;
        b=mCBN0EUbn33fcF6zK8G6OvRRr9Y0DlwJaBcOzQS+88PUsanPJsfSISJsOGgOjfuDwu
         dq/3Fowg3PZrVCtELtw6QfLJ1lgb0zfvuq02RBqR8jD7k0/RuwBbXXC61YfFc6ez18og
         gGVBqzUbKyTGMbsGeurRbRDqc0bhBHP0wfG1dOtuhTz3kQqoCWJqmEJ8ZLET6cMGO9tv
         qHsVmN8+L4PMMc3jkuvgE0ignf7G4ytIGNHOIws35nyhOmOTLE9um+RMNmcJXUPYG/S0
         JJOFRmkZci49ugpfADS+ySdKUxYi9+Xfxk0+Yxe0YJEeAS+jMquJG8OFkcy30Hzyvd13
         E3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783369295; x=1783974095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4bzkzQjedlM/WHqa+XHjmbIeat2b4Ekopu5HBj7jW+I=;
        b=nirT0fjfJXFtuNEex4M5aGtn9+4jiJ6lUibXYsUyzrCRSRVV/1Ua18Reyp8LJeDeE7
         6skbZrsPKJYajhR8pHPvjj250AdM5LooWXScp5H5iBoiU2tUXi+lYWNfQMbiUyv6hcbf
         +JFGast9c4iEDWTdkZlxXx+Y4BdQ9pfYwc0kNIS7DKXDzBZylNM4PV6x8coa/zw+OC/V
         XpjYN3SyOtQV8IpwxUSE1L8O+IYDt6EqAnjGzDTeDKM1IHSAsM+WMYHAgr07rXCRW0gw
         0JMVCThm2KqUBgmGul8Tv5ltPjajrz+69ayUEa2yGi5W1DmcfyPjc7w5VlLWjRTkXuhZ
         RcqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpj9qbBnXXM5tsBYsDA1JYf2pVi55kaC9X2i/mZaecOqyvcz+4Wfe8ys/3RS+FeHx3ZqCTdgJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5nu0dMQNOUdwfnQNb80V8f03nDF38OR+O+qdSIGoNOkgsc/m
	MuCwD8oxxX9KlMmVW9Y0QFSZDUOHq3s//50fyNnJSAWq8e7THZJzpOMBEx/Wt7JtsT4XvZED/Yp
	h1AMu+AIW8HiE9sofGjzWbIC0+FA7KsI=
X-Gm-Gg: AfdE7cm3TkK0EaGLIl8JSvUtLKR8B8M0Lsvfu8Ci+cAAZudNlrJEwowycjLJeTqWdBL
	DdXh09Au1CPz/nD/ZbyyTSk8sNl52DMb/n3/XjxHfEe6CQ3AzfkDqwiB1Qge7AW/SUMokPUpTiZ
	UYHZlKKTVrWH+sqUmJrCLYc3yjU/s0ru4mU67cS85KL3qIV7fNK0vbPVvBzsngQytdkqbFD1PHQ
	3YGZvw5l4CpQxB0RNbgySxOST+M7aulw89mdek+X24S8wdw53KcGxFbQKGkcquZUsOxoCLv
X-Received: by 2002:a05:690e:4842:b0:665:6f1e:cad2 with SMTP id
 956f58d0204a3-6677fc26633mr1331309d50.56.1783369295329; Mon, 06 Jul 2026
 13:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706093525.13030-1-mahe.tardy@gmail.com> <20260706093525.13030-3-mahe.tardy@gmail.com>
 <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com> <akvlWB6AkP6kQ7xO@gmail.com>
In-Reply-To: <akvlWB6AkP6kQ7xO@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 13:21:21 -0700
X-Gm-Features: AVVi8CfZRlGTvWxUUfHSVDzobBUdmJmQJRm0dIoZ7u2Wc5w-j_dRvm0qI4-zD7w
Message-ID: <CAMB2axPrEo0uwRkLr1fw+ycCJMGckbo4j27+_it7qqARs-9BzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev, 
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahetardy@gmail.com,m:sdfkernel@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305220-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,kernel.org,iogearbox.net,davemloft.net,google.com,meta.com,linux.dev,redhat.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DB4D715841

On Mon, Jul 6, 2026 at 12:04=E2=80=AFPM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > On 07/06, Mahe Tardy wrote:
> > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets =
for
> > > sending data. This provides a mechanism for BPF programs to emit
> > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > socket types with IPPROTO_UDP protocol but could be easily extended t=
o
> > > SOCK_STREAM and IPPROTO_TCP in the future.
> > >
> > > The API consists of six kfuncs:
> > >
> > >   bpf_ksock_create()   - Create a socket (sleepable)
> >
> > [..]
> >
> > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> >
> > Since you're doing only UDP for now, maybe you don't need bind/connect?=
 The
> > kernel should autobind (by default) when you sendmsg over UDP socket (I=
IRC).
>
> Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> and mostly added the args checks. Another thing is that send is simpler
> since only used on connected sockets, so you just pass the struct
> bpf_ksock and data. So on one side it would simplify the current
> UDP-only API for now by removing the kfuncs but we might need a more
> complex send kfunc (something like sendto).

I also have the same question about the necessity of bind(), but
connect() + send() make sense to me. In the stated use case, the dst
addr probably doesn't change often and I think avoiding route lookup
everytime should be a good thing.

>
> >
> > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > >   bpf_ksock_release()  - Release a reference (cleanup via
> > >                          queue_rcu_work since sock_release sleeps)
> > >
> > > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and L=
SM
> > > programs.
> > >
> > > The implementation follows the established kfunc lifecycle pattern
> > > (create/acquire/release with refcounting, kptr map storage, dtor
> > > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > > struct. Cleanup is deferred via queue_rcu_work() because sock_release=
()
> > > may sleep.
> > >
> > > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > > specifically support AF_INET and AF_INET6 sockets.
> > >
> > > The socket operations go through the expected LSM hooks instead of
> > > by-passing them like many kernel sockets since those are created by B=
PF
> > > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > > exposed to LSM progs, has a re-entering protection to avoid recursion=
.
> > > Also, because of the LSM checks, we prevent the use of the kfuncs fro=
m
> > > asynchronous workqueue as the current value would then be invalid.
> >
> > [..]
> >
> > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > kernel sockets that may exist in each network namespace. Out of
> > > simplicity for now, the settings is host wide but the counters are pe=
r
> > > network namespace.
> >
> > What is this guarding against? Rogue bpf programs creating too many soc=
kets?
>
> Yes. AI review raised this because users are prevented from creating too
> many sockets by bumping against the max number of fd and this would
> allow them to create way more sockets. I kind of agreed that having "a
> limit" on resource creation would make sense but maybe it doesn't and we
> can simplify this!
>
>

