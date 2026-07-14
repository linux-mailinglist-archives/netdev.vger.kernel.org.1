Return-Path: <netdev+bounces-307596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FqXZEZ2pVmqN/wAAu9opvQ
	(envelope-from <netdev+bounces-307596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:26:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3F8758FB5
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=kb768rMH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307596-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36933032075
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CC429CED;
	Tue, 14 Jul 2026 21:24:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AF427FB7
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 21:24:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064297; cv=pass; b=dmQEYLrwTcukEUExqcB/JIUiF03Nnp24372dxUMQmpCe7a+Yn+SFQotRKn3Spy6cNkNYUJZmGYTc+PJXXTKNWIWCfbllwkB4bvJk6xWmIpFcolw0CrfSNyhLOjYAacQpVje5UX8WnLp5pmuGN+RW4+CWos2osNE6LbxdkKVi77w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064297; c=relaxed/simple;
	bh=5lEL8ncm6HpX+/UGi6fEjiqgrC5SrckOfqT3dPhdPCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnZzK/fnYBBQbxrBa/zvafArRBSYGk++xPoF9miGEj6esh1YDaiT92fMOIosvGubGnn/d8+ytAYEYsGnRPlF/buoB2YLo1qiib9VehCJPvnJG6fl2vYi3bAJD/JM5vR6DNPsN1VPQqtLvAsxysuckFoodoUgsee4GC2qP/e1zBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kb768rMH; arc=pass smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2721064a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784064295; cv=none;
        d=google.com; s=arc-20260327;
        b=BsYqvKin9j3ZxGwXLaChwfQ7n6Y0epnKyze+Z4LIhrLWnyTB3hI4HozrMRkTLumf+p
         CY7vhPGKcA77AH6Tc4mcT8w1H50KxE2JPdlI5vHDiyzvAG+QiJCAMYVXByLeyEx1ovxK
         qZGj9zTdgEpl+CV12HYM8kxCcRDlYf1B4gYJh8cwwRH8eRZYcrqFLv+uD/fl0ajIJDaV
         3zphnaBZ27mZKUrNXPp4ILa5hx4yI4IyuMRJydQ+3jLIDZ9/MSM52vKVcFFO3bXtqi2f
         sBJM4IwZ9K6U+BeOlWq7fP6KnqSfREvIM7fIT+yEY6jv9lxsyHw82rcR4g+7iE5Q5x9g
         Wnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKdbGRuewpi7ZMpE9C7ytuL9gIr5Wnu61fkfFllAAco=;
        fh=gkrDyCMgRiSWs9uZ5agMK939RVJ6iCUxrawMJRg8d2E=;
        b=TzsD/6Ay32UT71Gk1fHzSYoQd12K+KwtIwahQSIRSnOGY+x2Xe5ips4O8MWixWPdeq
         W6+5AhSxwsgsE0NAEgkrrxLmX4701O+r6BjrFOWsfo6BcM5Eg5KyrDg3g/xVhgmb3BYE
         sZGbXpXOR8J0XVxsmxPJa23+piueZDNbEezbkkckauOZsjOythoHt9oS+v1OBoXf5ofd
         2YtqH1joWGW4AiweDp5C5+wvjPekMGL0CvoV/EYxbDvaf+BUF3IRNMQt/iZ5jnLLDdiU
         OHjI7j+F81gJaojlB4t9Px5ZQsRrxecy6dT8bvBpnsE4GlpfuHYeSxbn1XTQGjA0fkWm
         /Rqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784064295; x=1784669095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKdbGRuewpi7ZMpE9C7ytuL9gIr5Wnu61fkfFllAAco=;
        b=kb768rMHCzIUv3YNEOOpJvF5oYlMBPoXuR1ImlPI4kNsZDO8kZYAsakHK8s426roPt
         oUQAchpiX/CtEgZvWCGcA5NtixsdnHuuWc+nuWj64asQC1TxIV0eP32aa30LMvJuurah
         gY9TAQYhrvMVZEiiRc58RKUvyEF5Fz6RyZawX53maDMUt6xiLNYmZLH6b62pZZk9nJlK
         rwmxbn6rXxk8yGTvr9FEVxshOOZWnB/sGxrXGwTOavh67guQkm/GeYbzZp9BmRAfHsRm
         3beMgZD0SLy8kerKaOQEFV8YSt0jSJOBFb1qJljl2t05ppnD6cfXoIgySP06ZQRiPoJT
         32Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064295; x=1784669095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKdbGRuewpi7ZMpE9C7ytuL9gIr5Wnu61fkfFllAAco=;
        b=sFrDJI3YFMWRikqjQHI3dpVsqFJCLqMq6Kd035NaQSxvLl7jFBTm98FxPxOZ6lKdxQ
         gmS1HA16qQjdMNdadj48zSdkrpCeDk9qSN/9ZkLwEhX6aMbJrjkKeCyjouKDwiy5IykX
         5KJJjyG7zn402waa1uxt8SXP68jyP7uwywRMBy6+EJGVvZT2rtQttyM+C1ub2utA1dZe
         ZKDVdSvhcvFmWOTGT53EzZl9kbZqGbXp+2RYM0ZvUEGDC4BdGHG39QH7ZJ3PyvtvhLDW
         7DYqxPiZD1txOUSNSX7+6YPO6/+wekTFaXfpuuatn25zWjBMJeymbMlmEu3nmGzbEQ+9
         Psow==
X-Forwarded-Encrypted: i=1; AHgh+Ro2DBBDpU9isonBYOBILxX4ihaYFu/apeRAeaqFEeq5IQp05p3LbydBaK7MQ5d4Ke591wBYrjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVRLgzWRRg5OJUUvmzZ1JlYJTMvKEmqv8wy18/DIhlUnImyEM
	vF1vOTPg60zYTrvr1pteWzATMdo06STqhOqUXuA0jaqR07JPse136lb1OdrrEt/sBLfaBu1Dj6W
	jcq1Du7ZtoARHeaxH7y48dPpHJBen+zDknCgb8MHq
X-Gm-Gg: AfdE7cmHrb+N1Yok7+xbObnrb3D+7DIoBgEh+NmidMSbN4KT69jDnpLbduPY5G05vx/
	XpvHf8puZ6kjOvMyPq4PAeIK0FrjG4MuxxFoLi4bYpitCDozDuNBaVmPFI9vFLHeTj5Ti6eIDmz
	MRVvJFAxZ9cVOtcYz0BHmjuhGovkkooBd7LYoHeZ4W9211dHqcTzjr7N0+PTSyzN7O+vGQetUgv
	aAU6GKhLpdFUU+yrUgPlDiL+n16dX1GNpde19Sl5GUDRG9tBIJK2FzShwDXGvCj07FoaVKEhC5J
	4mzuaGHcNbhV3Jn/9d6vShbZAhIx6ug=
X-Received: by 2002:a17:90b:4a11:b0:37f:9ce1:cdb0 with SMTP id
 98e67ed59e1d1-38e2a0a78c1mr306534a91.30.1784064295348; Tue, 14 Jul 2026
 14:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710223029.1307043-1-xmei5@asu.edu> <f69ec0975481ad04dc7403834bbb6b93d1092ecb.camel@kernel.org>
In-Reply-To: <f69ec0975481ad04dc7403834bbb6b93d1092ecb.camel@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 14:24:43 -0700
X-Gm-Features: AUfX_my-bnGdv6WApj0EccK6Wy1KqN5vNEqE9wuIXjURuJDWYgC0SW6HQ5GQbGg
Message-ID: <CAPpSM+QU=3CwxRavThhaeoFbiqECzDdPvV9C5StCfRK6aMn3zQ@mail.gmail.com>
Subject: Re: [PATCH net v2] rds: tcp: hold the RCU lock across ipv6_chk_addr()
 in rds_tcp_laddr_check()
To: Allison Henderson <achender@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307596-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:santosh.shilimkar@oracle.com,m:ka-cheong.poon@oracle.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,oss.oracle.com,oracle.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E3F8758FB5

On Fri, Jul 10, 2026 at 8:53=E2=80=AFPM Allison Henderson <achender@kernel.=
org> wrote:
>
> On Fri, 2026-07-10 at 15:30 -0700, Xiang Mei wrote:
> > rds_tcp_laddr_check() looks up a scoped IPv6 interface with
> > dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
> > passes the bare struct net_device * into ipv6_chk_addr().
> >
> > dev_get_by_index_rcu() only keeps the device alive within the same RCU
> > read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK ca=
n
> > free the net_device; ipv6_chk_addr() then dereferences the stale pointe=
r
> > in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), readi=
ng
> > freed memory.
> >
> > Keep the RCU read-side lock held across the ipv6_chk_addr() call instea=
d
> > of dropping it right after the lookup, so the device cannot be freed
> > while it is in use.
> >
> >   BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net=
/ipv6/addrconf.c:1998)
> >   Read of size 8 at addr ffff8880106ec000 by task exploit/153
> >   Call Trace:
> >    ...
> >    kasan_report (mm/kasan/report.c:595)
> >    __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
> >    ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
> >    rds_tcp_laddr_check (net/rds/tcp.c:370)
> >    rds_bind (net/rds/bind.c:248)
> >    __sys_bind (net/socket.c:1920)
> >    __x64_sys_bind (net/socket.c:1956)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:63)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
>
>
>
> Thanks Xiang!  Just more thing to make sure your patches gets through. Ad=
d a change log here like this:
>
> Changes since v1:
>   Use rcu_read_locks instead of dev_hold/put
>   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when=
 IPv6 is disabled
>
> Changes since v2:
>   Add change log
>
>
> Otherwise, it might get bounced if they happen to try your patch first.
> With that fixed:
> Reviewed-by: Allison Henderson <achender@kernel.org>
>
> Thanks!
> Allison
>
Thanks for the tips; I learned it!

v3 is ready:
https://lore.kernel.org/netdev/20260714212239.1511269-1-xmei5@asu.edu/T/#u

Xiang
> > Thanks Xiang!  Just more thing to make sure your patches gets through. =
Add a change log here like this:
> >
> > Changes since v1:
> >   Use rcu_read_locks instead of dev_hold/put
> >   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference wh=
en IPv6 is disabled
> >
> > Changes since v2:
> >   Add change log
> >
> > Reviewed-by: Allison Henderson <achender@kernel.org>
> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/rds/tcp.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> > index 955d92277d5a..30cfb0087f2c 100644
> > --- a/net/rds/tcp.c
> > +++ b/net/rds/tcp.c
> > @@ -355,23 +355,25 @@ int rds_tcp_laddr_check(struct net *net, const st=
ruct in6_addr *addr,
> >       /* If the scope_id is specified, check only those addresses
> >        * hosted on the specified interface.
> >        */
> > +     rcu_read_lock();
> >       if (scope_id !=3D 0) {
> > -             rcu_read_lock();
> >               dev =3D dev_get_by_index_rcu(net, scope_id);
> >               /* scope_id is not valid... */
> >               if (!dev) {
> >                       rcu_read_unlock();
> >                       return -EADDRNOTAVAIL;
> >               }
> > -             rcu_read_unlock();
> >       }
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       if (ipv6_mod_enabled()) {
> >               ret =3D ipv6_chk_addr(net, addr, dev, 0);
> > -             if (ret)
> > +             if (ret) {
> > +                     rcu_read_unlock();
> >                       return 0;
> > +             }
> >       }
> >  #endif
> > +     rcu_read_unlock();
> >       return -EADDRNOTAVAIL;
> >  }
> >
>

