Return-Path: <netdev+bounces-269761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BoAIZCuvGkv2AIAu9opvQ
	(envelope-from <netdev+bounces-269761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:18:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883932D5176
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F38D300BC65
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120130ACF6;
	Fri, 20 Mar 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVLZWkDw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E62DEA89
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973126; cv=pass; b=kMhVMfWeN6k4Nw/BHSPYffnn1CfchbijCBc99dHzI/XJ6PzJZKIETiTkHKXB82FGi5A1yi07YBhVvZIkc5wVaSfVP0BEkd1MGFh11p1V1iMfb0QTt/MDYXQxw+a9ThYkpBMcDnFytZU77h+GnoQhVs4UjM8DOFvXJ0HhA0ebTXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973126; c=relaxed/simple;
	bh=dRtRXKaaheGuQR3fLYdqQ2GU9EThQJpYsDsgyun79SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNXuaeYycWlSUAic7MEfZwQC3qze9tw4qiWazk/i3+k1voQdOWwlAHJDtt+PeHRs6qXQQd5kZXScWsNVQwXPqgI6DU3pR6XTsVeSQkZ2x8uSp3rjGaMyJxucht+H0C2RD48K0w708w71CZghPLpRprbZTN7i00iRpZfFNW5ZkU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVLZWkDw; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1274204434bso2127556c88.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 19:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773973123; cv=none;
        d=google.com; s=arc-20240605;
        b=F1xKY38Z/uIQDCUDAIXxd2jom8S5R53oENGRw2WjvqT+o6HLmzZJPFf1yjRNXEhDtR
         5nK9KmBtXr2C1M8Zpx0mMrByep2k+K/IurEZXT5/FHLSPcFG7xcKwrcYvaX4+ixLvX2N
         hbF2DRLD+BYgiWLEZQxtobKAp4o+18zQWCRQFPRLrUguzUIFx4I+3jUoEYpGrkbFGw9O
         x0jLCZvXBD/pR3Et89MUf2HG7LezosxSjw0gYpldG3GHPxoGS6j6LyX2qWapNVTUFwwJ
         NfOiuMiTIzVdqBwVJmiTyDmq24EuvCd1HmbAyC+yDqOCDHPEmnO5+nyoIypx7EBx8j49
         EBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yfc6/YeLfPsJ3XGknXx05OOtszrxxbhIywuJ9AyV3W4=;
        fh=EiynQQAv00I44i7a1Xym/s2+fD28klM96XXEd2hhTAI=;
        b=J2ZwcsrK0W3xvkSYzTxqcBg8yXF9zMcAI88ZJ6VcP5Tv9nCUdes61rRjYprT3LFR9M
         Jl+vxokxeMlu7CVZzhc0Ur5StiwuO3Swrx+FELzHrjWvqKzBJri6zisVPM6FXBLY0hEI
         R1biuLeGxP+WUykYlD5IpESlHduerrR0+EzKkmsR6JvowQrZTJXCENffI+JaheMhY/4n
         dLe5af0/a7M2lHutOtdvY0e7U4faU2SSmW2RXR3iea94XYAf0dSC1RNaGkifdddLTug3
         T/TzLDb8PPPht4uzfi5yXc3b0zj7py0NujtCQ3EOFbrowBtwL8J+QtlaFoiBjMbIGK5Q
         vMug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773973123; x=1774577923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfc6/YeLfPsJ3XGknXx05OOtszrxxbhIywuJ9AyV3W4=;
        b=wVLZWkDwrB2zKfVBLpGak4mk1XPpp2RZnOEkZaHgwBktOHfmxYdADCWReeitCGRigK
         J37gulJnso4NhjbktNp/1E+H5UyTf/945lnj3jhY0Gt2JPR4bgpnO3oiroijfM3Rlgo7
         0+8VB0Qxq7Ym9LkQzSxOCsIagjArqZVFUqAHshk3tcxB+FE/qg8rvyr0Un1J1X61qRzw
         kVmJH7qv7/drQQz7EXQvI7YdufddAarO5bti3dgaus1FnYwYJAEwvXdRh+2QssHKx2gL
         ljkI37x9aTu9uYJLRvtz109pWIj/tNRE+enOMrgwMqJA014CTAnQlrewYBjhXBAKGWHg
         3CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773973123; x=1774577923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yfc6/YeLfPsJ3XGknXx05OOtszrxxbhIywuJ9AyV3W4=;
        b=aLAbqhetoTER8d3mMSBuUpQXyHi+KcDeymtJ8W+aoAdsxBY7lLeoT2Gqm3noLdVVXa
         mthmCzUHPdjfTmq3Do3U8z3f+47sYoXfBi6YRQKY7Q9sMoZiujz8TLAXOGoFJnScBwI5
         D3fAuLqBP0G4Ozkhzo7w8uELfXr41zRfEhzzU7mPv3BKVn2BJOUjNaxk+akl09HADXW+
         lpjKO3jCx0W4tG9qJwiDPGkFCzfW6QtTkIdv69+qxd6YBDYmfLTni7PcpTVOBOjY3iul
         HQ3Hk5bv1jtKxh6XWBCEPLRLc5Qd/comUkFp4lAKGBFVQ/MBCqW9TJQWOWGX/vuM4Z8u
         xZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE3Nrd20cq4LZi5PRQq1/96v3xVj9RP9qUOMC9hny0GOrlSLWLeejD68gml9EWgsfQieT5/0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZb7oeKGjs+Fxo7Lgb8tSMjwFX7VSJIQyvQrw55Og+1VWfhUa
	U3bZN+L0BLugWcTv9VvbBGt10Wndso2htE97IOT1xDuZTd7Y1UTd4F5Wu/HpdjmXzO2s5gFHMDD
	nR86YrpDn21e5z2EyjYagEbc5YvduLsEjb1hti6E7
X-Gm-Gg: ATEYQzwVJpayjIGyOu1RBdS7SgHxiF1kSiE/XmNS7QC8SPX85FjO3msi9UYLVxbawYX
	/05GXw/Cy71Vrs1oi5B5L+POWrNsdYAZAVNqRJWoJ9+jW+z9yxWFZNpSWADZIi/iLeBKjZ+hvl+
	npAxluJa7EBPDCtGhnpeAZ4BMN3PtUln0bNgZYoHeSnzU71NPzbehtQkHzWtOrPmxNQpTUWIc6p
	Bq1X0BHShX6S0+IeYSOcedtCe6j+j+sHqaida2Np6JzfD9CWY53mCGM3fo4d5kWapr7qSFGWlJJ
	I4YVODxAYaU5y2TGhbWdtROuVWsUt9PU2su7kgDtao+WMX5anw==
X-Received: by 2002:a05:7022:2225:b0:128:ceac:6db4 with SMTP id
 a92af1059eb24-12a722b7c6emr766847c88.6.1773973122149; Thu, 19 Mar 2026
 19:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319041427.1528743-1-kuniyu@google.com> <20260319072857.4f96d143@kernel.org>
In-Reply-To: <20260319072857.4f96d143@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 19 Mar 2026 19:18:31 -0700
X-Gm-Features: AaiRm52rQ7rPdgeB6GStbchGCIpaKoSlrh0Ht-OCbFJJ9BjuzsIeHszHf8BLMjg
Message-ID: <CAAVpQUA66RULC9jHq7f3ShnhKbF_RDcQ860fxcOrazujKbJ5Vg@mail.gmail.com>
Subject: Re: [PATCH v5 net 0/3] ipv6: Fix two GC issues with permanent routes.
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269761-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 883932D5176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 7:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 19 Mar 2026 04:13:49 +0000 Kuniyuki Iwashima wrote:
> > Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
> > permanent routes whose exception routes have all expired.
> >
> > Patch 2 fixes an issue where exception routes tied to
> > permanent routes are not properly aged.
> >
> > Patch 3 is a selftest for the issue fixed by Patch 2.
>
> Hitting a RCU warning with this:

Ah, I should've run it with lockdep.  fib6_gc_all()
calls rcu_read_lock() indeed.

Will wrap fib6_age_exceptions() call in
fib6_may_remove_gc_list() with RCU.

Thanks !


>
> [ 1246.404735][T26812] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 1246.404892][T26812] WARNING: suspicious RCU usage
> [ 1246.405029][T26812] 7.0.0-rc3-virtme #1 Not tainted
> [ 1246.405170][T26812] -----------------------------
> [ 1246.405302][T26812] ./include/net/neighbour.h:312 suspicious rcu_deref=
erence_check() usage!
> [ 1246.405498][T26812]
> [ 1246.405498][T26812] other info that might help us debug this:
> [ 1246.405498][T26812]
> [ 1246.405786][T26812]
> [ 1246.405786][T26812] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [ 1246.405988][T26812] 3 locks held by ip/26812:
> [ 1246.406124][T26812]  #0: ff11000015e71a30 (&tb->tb6_lock){+.-.}-{3:3},=
 at: ip6_route_add+0x95/0x160
> [ 1246.406587][T26812]  #1: ffffffffbc58c900 (rcu_read_lock_bh){....}-{1:=
3}, at: fib6_nh_age_exceptions.part.0+0x24/0x200
> [ 1246.406873][T26812]  #2: ffffffffbcdafbd8 (rt6_exception_lock){+.-.}-{=
3:3}, at: fib6_nh_age_exceptions.part.0+0x66/0x200
> [ 1246.407143][T26812]
> [ 1246.407143][T26812] stack backtrace:
> [ 1246.407315][T26812] CPU: 3 UID: 0 PID: 26812 Comm: ip Not tainted 7.0.=
0-rc3-virtme #1 PREEMPT(full)
> [ 1246.407318][T26812] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 1246.407319][T26812] Call Trace:
> [ 1246.407321][T26812]  <TASK>
> [ 1246.407322][T26812]  dump_stack_lvl+0x6f/0xa0
> [ 1246.407328][T26812]  lockdep_rcu_suspicious.cold+0x4f/0xad
> [ 1246.407334][T26812]  ___neigh_lookup_noref.constprop.0+0x4d0/0x8e0
> [ 1246.407339][T26812]  rt6_age_examine_exception+0x209/0x510
> [ 1246.407343][T26812]  ? __ip6_del_rt+0x160/0x160
> [ 1246.407346][T26812]  ? fib6_nh_get_excptn_bucket+0x6e/0x150
> [ 1246.407348][T26812]  fib6_nh_age_exceptions.part.0+0xce/0x200
> [ 1246.407352][T26812]  rt6_age_exceptions+0xff/0x150
> [ 1246.407355][T26812]  ? rt6_flush_exceptions+0x1a0/0x1a0
> [ 1246.407357][T26812]  ? rcu_is_watching+0x15/0xd0
> [ 1246.407361][T26812]  ? rcu_is_watching+0x15/0xd0
> [ 1246.407363][T26812]  fib6_age_exceptions+0xc5/0x250
> [ 1246.407366][T26812]  fib6_add_rt2node+0x25c6/0x3f90
> [ 1246.407368][T26812]  ? pcpu_alloc_noprof+0x635/0xa60
> [ 1246.407376][T26812]  ? fib6_age_exceptions+0x250/0x250
> [ 1246.407379][T26812]  ? fib6_add_1.constprop.0+0x512/0x1620
> [ 1246.407385][T26812]  ? fib6_add+0x36a/0xe40
> [ 1246.407386][T26812]  fib6_add+0x36a/0xe40
> [ 1246.407389][T26812]  ? lock_acquire.part.0+0xbc/0x260
> [ 1246.407392][T26812]  ? fib6_add_rt2node+0x3f90/0x3f90
> [ 1246.407398][T26812]  ip6_route_add+0xa7/0x160
> [ 1246.407400][T26812]  ? ip6_route_multipath_add+0x13a0/0x13a0
> [ 1246.407402][T26812]  inet6_rtm_newroute+0x10a/0x120
> [ 1246.407404][T26812]  ? ip6_route_multipath_add+0x13a0/0x13a0
> [ 1246.407406][T26812]  ? lock_acquire.part.0+0xbc/0x260
> [ 1246.407407][T26812]  ? find_held_lock+0x2b/0x80
> [ 1246.407415][T26812]  ? __lock_release.isra.0+0x59/0x170
> [ 1246.407418][T26812]  ? rtnetlink_rcv_msg+0x6dc/0xb90
> [ 1246.407422][T26812]  ? ip6_route_multipath_add+0x13a0/0x13a0
> [ 1246.407424][T26812]  rtnetlink_rcv_msg+0x6fe/0xb90
> [ 1246.407427][T26812]  ? rtnl_fdb_dump+0x620/0x620
> [ 1246.407429][T26812]  ? __lock_acquire+0x577/0xc10
> [ 1246.407433][T26812]  ? lock_acquire.part.0+0xbc/0x260
> [ 1246.407434][T26812]  ? find_held_lock+0x2b/0x80
> [ 1246.407438][T26812]  netlink_rcv_skb+0x123/0x380
> [ 1246.407441][T26812]  ? rtnl_fdb_dump+0x620/0x620
> [ 1246.407444][T26812]  ? netlink_ack+0xce0/0xce0
> [ 1246.407450][T26812]  ? netlink_deliver_tap+0xc5/0x330
> [ 1246.407451][T26812]  ? netlink_deliver_tap+0x13f/0x330
> [ 1246.407455][T26812]  netlink_unicast+0x4a3/0x770
> [ 1246.407458][T26812]  ? netlink_attachskb+0x810/0x810
> [ 1246.407460][T26812]  ? __alloc_skb+0x4c4/0x5f0
> [ 1246.407463][T26812]  ? napi_skb_cache_get+0x7a0/0x7a0
> [ 1246.407465][T26812]  ? lock_acquire.part.0+0xbc/0x260
> [ 1246.407467][T26812]  ? __lock_acquire+0x577/0xc10
> [ 1246.407470][T26812]  netlink_sendmsg+0x735/0xc60
> [ 1246.407473][T26812]  ? netlink_unicast+0x770/0x770
> [ 1246.407477][T26812]  ? __might_fault+0x97/0x140
> [ 1246.407482][T26812]  ____sys_sendmsg+0x419/0x850
> [ 1246.407484][T26812]  ? copy_msghdr_from_user+0x270/0x430
> [ 1246.407486][T26812]  ? get_timestamp.constprop.0+0x390/0x390
> [ 1246.407488][T26812]  ? move_addr_to_kernel+0x40/0x40
> [ 1246.407491][T26812]  ? stack_depot_save_flags+0x30d/0x6e0
> [ 1246.407495][T26812]  ? rcu_read_lock_any_held+0x3c/0x90
> [ 1246.407500][T26812]  ___sys_sendmsg+0xfd/0x180
> [ 1246.407502][T26812]  ? __call_rcu_common.constprop.0+0xa6/0xa00
> [ 1246.407505][T26812]  ? copy_msghdr_from_user+0x430/0x430
> [ 1246.407520][T26812]  __sys_sendmsg+0x124/0x1c0
> [ 1246.407522][T26812]  ? __sys_sendmsg_sock+0x20/0x20
> [ 1246.407524][T26812]  ? lockdep_hardirqs_on+0x84/0x130
> [ 1246.407528][T26812]  ? __call_rcu_common.constprop.0+0x3bd/0xa00
> [ 1246.407533][T26812]  ? do_raw_spin_unlock+0x59/0x250
> [ 1246.407536][T26812]  ? rcu_is_watching+0x15/0xd0
> [ 1246.407539][T26812]  do_syscall_64+0x117/0xfc0
> [ 1246.407541][T26812]  ? exc_page_fault+0xaf/0xd0
> [ 1246.407544][T26812]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1246.407546][T26812] RIP: 0033:0x7f7fe0147c5e
> [ 1246.407549][T26812] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93=
 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10=
 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
> [ 1246.407551][T26812] RSP: 002b:00007ffce73c1500 EFLAGS: 00000202 ORIG_R=
AX: 000000000000002e
> [ 1246.407553][T26812] RAX: ffffffffffffffda RBX: 00007ffce73c3b10 RCX: 0=
0007f7fe0147c5e
> [ 1246.407555][T26812] RDX: 0000000000000000 RSI: 00007ffce73c15c0 RDI: 0=
000000000000005
> [ 1246.407556][T26812] RBP: 00007ffce73c1510 R08: 0000000000000000 R09: 0=
000000000000000
> [ 1246.407557][T26812] R10: 0000000000000000 R11: 0000000000000202 R12: 0=
000000000000000
> [ 1246.407557][T26812] R13: 0000000069bb982b R14: 00007ffce73c3b20 R15: 0=
00000000049c620
> [ 1246.407564][T26812]  </TASK>

