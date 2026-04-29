Return-Path: <netdev+bounces-282221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOJLFp9v8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD048E646
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40E1304F21E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896029D288;
	Wed, 29 Apr 2026 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2UT6JMC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C143845D2
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430363; cv=pass; b=QF7sAOKD4e9FbwWeBo1JYYVL43yDIQ9Y9RFKuzZhW2xUXIXH2qsnUBoxd/c9QazQp4UpeLpmPw48s8d4XwM/p3B5Nd3Rs6Bl75yLXvyScFyiaoZ9UP8S22f9uFxcFzMRNGSdLEeMiiEbom6sS8qPOAee/ZbLxdgg5GFmuR8pr4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430363; c=relaxed/simple;
	bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzFZRJVJRYpoUbyokEz+nryn4kBFJHUj7CRdKtVu9N4PLIlW38WR7io4fejM2SlHIHLDh10tMIy5YhKNXPUB8a+lwu5SsExC3r/VCbT9jRiS6Qoc1iLZiR6In9wyr0Tabgrcg0HASRZ3z6dPps6LigvkS3DRYqUl/2IpYayBGIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2UT6JMC; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso100171435e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777430360; cv=none;
        d=google.com; s=arc-20240605;
        b=Xlcg2F45hgvV/MjlYGL3s9uy2q6EdJ7S37/jrqgcUBdw47COjW0isq0AHoWOc6PoKC
         g4HgwdWUKsnsaKh/8LspIsqnSpxO2UAPnQxoIhMXbYiw9vl3fgRLyjcNY0kT0FEqIEGE
         AnuR7sMNM7dpg6Xk6OyhRD+O3HrfOlAzggBRsVrNGF3xKY0/5eWIvbY3UwGP2NvOBPK7
         xnAop0y7lAQap5X23pnHM9qL7OMafQk0EWAKHR3vHdQT8mLvgotqG2ux5Dx1958dtMlv
         TM90E90oWy4XTC8ZnYZGgoZx9fNtptx/NSxgOdf8Ax+iYDFjwkcWtcfjTzMdp1qAPlV6
         Wq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
        fh=7A7Lfp7XLKMK07LO//aJP/E3vpMbi/wF8o3aT9nBrGw=;
        b=hc0FwV8QB2IA3niUN8WRx+DfPIbdwGyV5BdGJ6hnUs4ET60OVaqf9Uo0jlK1mghqVJ
         o1EYqboFuTxPEM3HGZs+pYIT6uI7K3JRLUdDboe8NweFuBHrvgnMbhquaMGAZqkyN15O
         8w6kPnlfVaia+GYIGplKLRO7xdA3gKCBfp1o4nMaLRsd5i611Yo/ZKYkm4kcFnJerZEu
         SsxOVBGPwo9CQc3SdMC04X0fdaXs6PD/6T/DEqNmXXYgGJ+1FZKymdkIOvzuLzliJye8
         k3rf0A0FD/Q6s8VfwzBEjo0+NWp13M6mnE/OpCW7R2BOfMhxOR04yurO6fpnH/YZDHxE
         9uPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777430360; x=1778035160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
        b=F2UT6JMCDHS4+k+vhk3lJOGy45zJjEgLLedAFtnFRyIRCZABmmwHZLLtl6q41YOHUc
         4chDfd91aV9zWIb2MX3nOIOsGtt9JRzkIMHoKYS5mi8hRv5z0gr6ofqwUmfuZQ12vclr
         YpjYRd39q0r7sIXZTht8TedUL5n+f1uqoP75/OvYGm7kADaSOGI2fptkighbxxre9n0z
         ui3AsUkxjRueN8s4JuLRpr1xbxbSLJtLz0K0fuIy6KSrEt+6qlJL4eLJkamrlkwu7sCp
         ymhOLeRkIq71YQ+HqN5oDkK36HrDAPHwYxAUXEGV3+J9XVUMkQY3CwX/aCaA8+vnnwug
         kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777430360; x=1778035160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3j52Oha4K1noolQeb0YCiATzp5JEOQWzM8960MyAO7Y=;
        b=ePC5q76d6aCKSFZFGHdlo+oCfi2moFrOHiXG0LgX41b4wsCUpVAqAyMZVWSxu3i/2r
         45xgk2UySSW34lg5HYttvHCgopSUClB4ddcTK0fXtW7BxPnROTjiap+0Da4RGbjdFUtM
         dA0FQ610ZGDbo/TQlDid7yaz0Gee01V2/x+/taqG6pmDjFhwmzIc1npeDNxL89QvWGdu
         jDWmyQUEx2TYcMqF/NXcx0SYZ/ew5WUg3zCwWA+2Ev3TGjMOpGyz5wcoDkqFRUSSiQUd
         UK3u8cDsfVnkHjEd9D/0xYZjTpk77ch7RQU+JDVsg+w0cEvBD5uWzMlTgxTx1k/V6IQt
         OmTg==
X-Forwarded-Encrypted: i=1; AFNElJ/EQlbLH4x5aOcUvsHq81HBPNZonnIcdbwbF6AOUrmU6SWhcd2sIOS6SwEnmQa40i+uliukH+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0/uBP29WYAfTPmSodxBowb7zW9EnT16PkTvjq6pz+F3GFZWo
	A6WkGxGvd9WE8+cS2IbaonbZKllHhc78jnSMls/BgrM5gEk6ng3fCfaqQewBDysmr8XyB2wFCr8
	BrWV9m72vyPd5XEBS3sTiLBcIteH2RaM=
X-Gm-Gg: AeBDieuVmei9+mO0HL/oCI2eB8XXl6BJmGqs0rn0GyznHVfcF0YA5SfuTAG6jyGxIYo
	rWHiT+SttnGAxivyvRr+qU/usStrungevqjHP0sh+vBSAEzCUg7qJyS7iO1NPL6rMk3HaCLu2nY
	cmQxQgApGOMWy+2M8YwsZmmJUJN6AIefsmS4zuCMtqHN5T0I0UwByB9Cn0Kd9rLkdtH+F8xHJL0
	taz80zWGoPu/vrncWLjmWax4rJuDSeb4YftSx/QDwbM+WGBRzJJ9x7/wALp9BigylRsw/DZvQx3
	MGWwTPjhni34s0OSCC6OAdWgI5nDMOgQnMPVgp28UADzOe1C
X-Received: by 2002:a05:6000:2dc2:b0:43f:e791:a333 with SMTP id
 ffacd0b85a97d-446496d7a5fmr9453139f8f.29.1777430359955; Tue, 28 Apr 2026
 19:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
 <20260428110713.2550315-3-maoyixie.tju@gmail.com> <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
 <CANn89iJzu1zXpx5G-3jVDS0duLB_tbm+ULzLk1ZW68fayoF9qQ@mail.gmail.com>
In-Reply-To: <CANn89iJzu1zXpx5G-3jVDS0duLB_tbm+ULzLk1ZW68fayoF9qQ@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 29 Apr 2026 10:38:42 +0800
X-Gm-Features: AVHnY4LZocalNrJgv7vMB2vdTcn-atowI7erBu9gVSevVS-P9DwrltOsUKB23To
Message-ID: <CABAhCOSFvmxQjnxcdkJV8mx-d163tKz2ykgyciHSFOqs-yBrmg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Eric Dumazet <edumazet@google.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, netdev@vger.kernel.org, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A4AD048E646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282221-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ntu.edu.sg:email]

On Wed, Apr 29, 2026 at 10:00=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Apr 28, 2026 at 6:58=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> =
wrote:
> >
> > On Tue, Apr 28, 2026 at 7:07=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.c=
om> wrote:
> > >
> > > From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> > >
> > > After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> > > rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> > > ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> > > that series and still uses dev_net(dev), which diverges from the
> > > device's creation netns after IFLA_NET_NS_FD migration.
> > >
> > > This re-inserts the tunnel into the wrong per-netns hash, leaving a
> > > stale entry in the original creation netns. When that netns is later
> > > destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> > > slab-use-after-free reported by KASAN, followed by a kernel BUG at
> > > net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
> > >
> > > Reachable from an unprivileged user namespace ("unshare --user
> > > --map-root-user --net"); cross-tenant scope on container hosts.
> > >
> > > Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> > > file) already uses the cached t->net correctly. The bug is specific
> > > to ip6erspan_changelink() copying the wrong shape.
> > >
> > > Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_=
link_ops")
> >
> > The changes look good to me. But why is 5e72ce3e3980 mentioned
> > here? It neither introduced nor was intended to fix this bug.
>
> Which patch added the bug then in your opinion?

Maybe 2d665034f239 ("net: ip6_gre: Fix ip6erspan hlen calculation")
which initially introduced ip6erspan_changelink using the wrong
dev_net()?
And ab5098fa25b9 ("ip6_gre: fix tunnel list corruption for x-netns")
fixed this for ip6gre, but ip6erspan was left.
Anyway 5e72ce3e3980 doesn't exist before v6.15.

