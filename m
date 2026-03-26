Return-Path: <netdev+bounces-271831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGhGO5q4xGlf2wQAu9opvQ
	(envelope-from <netdev+bounces-271831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:39:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A5232F202
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA6D3010D8E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051C364E88;
	Thu, 26 Mar 2026 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="CMRDupNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BD265606
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774499952; cv=pass; b=bLnMZXyp7WOh5fQ77YJpIbdzJpGnEo1jVOr5YPE3ogM76pbos9LvKKM/Fo0Dd0e3yPfTsmT+2RmacHnp1VOmscKkbGriw4tClRbnECaEsMBXTyXTuWQZPFyAMapl22Gk4GcXLCLKefdcnD659K0jhjC0LnnVE1jQz7sgMKdTbpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774499952; c=relaxed/simple;
	bh=StkBwsDqSGSwkGbRI0YLi+1dOKG2p0O2MPNJtbRuVoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMZin6wq1BAQ0XBKjALR+XUcxBcWFPMI5gwNYGyJffENo7Fx/Gaz7MLQgJX9GV9oCKl6VyYwyzoSerbWgzRU8CMgX1OCDWOwdqe40fjbt8R5AFAgyd/SuUVzmlI7UV8ll2Rk8/1HsqoWdY32FogVhwu89zi0HlDmcjQJyMmWexU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CMRDupNy; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so627764a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 21:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774499950; cv=none;
        d=google.com; s=arc-20240605;
        b=Zj4YrtwcY3hkQNGWPPw8Tg5e6Tm8SQ0eLtsfacIh1oK0/o+UtVS6jBf57N7E9X56jw
         kxkfZYO+sQ2RLJv+FmD9BL5UG/wy9117toc8HLV+x9i54PinmuIIeGUtVOi3R8+xVyKi
         coqn711eiInwvmp9tomcXCcY9/97HEGrgmtMeYGUvTtLwUC5zr8atrSzVZ/jT/i4zu/9
         87SeC2elXC1gy9TLiu8iLCKHVbTYD338Y8VNbmhkKHxOQQvpipEJFbFrH6oeK4v3K+g/
         kjG2qAQpQ4z1JI0qnNiq7suNqnB3/7lxtyJgti/cl3cfmoMyxyHHR/B8SLmga8NwV8ow
         vNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0U4Ndv23Ag9wsS8rTRD7UiIomM4+KloN1hRmhgvUAE=;
        fh=gi8njXbFZbXu+rnucODpybAVMPypsCwNPmIJbD03BXQ=;
        b=FnmGwuUgukEfS8dmauJo0aLtdb7UYwwf/wMry+GbtUnAQniZltZEU+L6FfNft1VEdg
         sDsFfboG+pd/T2AfiNkoPsPdAEFwJyx3Goz1jib2VWLyTJTuVaHdceMEqk1rQb+9naTG
         on8Wx7HM+r67Vww9iUmflRT8pieEXa8wotPqn5lGAE3wL6zmFmW7R0/J/ZuR7aFpdgWG
         29ViB/6QagyPjGsWyJp8IBI7OyzjA1sao/V398gSJoZgAUxbgLUMMO7WH6Y3FYahaFDW
         enOz39KEqOWM312EA7sdhpGvj5z6qhc23IuRPHZmTH6mOK9wNgMN5d/luaWooTD0FsMs
         /lVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774499950; x=1775104750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0U4Ndv23Ag9wsS8rTRD7UiIomM4+KloN1hRmhgvUAE=;
        b=CMRDupNyqhG74Qkgk/A5ii7BTt7lvDlmFgdJMnsfcvvMgA2pZkQpRFp1CcfWcCmt+4
         AFaCT8Q95IeqnGvLhvXLg3c0lBwmXsvt8FuUC1GJjZAoS2cNY84oIeOMHh0bxjbBxxra
         vy90AludCjcbTiyBOXE7No7rFx2h7z98VKG1mNiVpheGpHZIicnr8UG7quhDdq9dCyqK
         M5rcdoZfsGhX8o+DZhb6gnww+0LuR6f0JzbYbscfneB4lJ1lBFO+nkxQdsQhQJSi4lE7
         Ls8dxrm1yeVuu7mgKoMEdIEcEGDMYWdoPpI4AU81lxJP8SkfMhCEywgx7rUh55ny2kfx
         tdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774499950; x=1775104750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0U4Ndv23Ag9wsS8rTRD7UiIomM4+KloN1hRmhgvUAE=;
        b=eA9FZdfJJnahDAr746ISyeX09F352HgJegEaSBl/xZJx9yUKaNaA8nX8JBra0R2EXx
         juTb49L3AM28HgyURGJFr6edLU9F0Gd7lMdmobW5mVuf0jCxeKQI/+x/WVxDVb+LcVcl
         DoD0mFJQsL2uJX4jNg+XlGau4ZSzLjhIklRcvkrqueLWQ6i+8fJzPYCjMAB17htJxE0F
         pM3+vPJj4tW0STyiq21O9QhmPmOIFEQovT7rhQGnlcogaJTt/E8WQ6SkyPyWYCxhgRX+
         agFMlcSdoDdax7MZVxrTBI6kHtRWIIBbB+jOTA7B1jC/gEtwAPkUAtex5aAxdEYo/kmy
         +/cA==
X-Forwarded-Encrypted: i=1; AJvYcCVSuuPRAXsfJ5M0IU+Ny078cq7lVo1G9D2Th5GWKCIAPfrSnC3nA8sGniubdDmtL0EAoKpxN3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXG9quMOtSfohuxvdxF8m91FHKwS7rao0jnDIfnPgC+bBltdhH
	7xpWnPp6HveivOMSFh+RAvt6mHCZjRfo/A38t8XGK/ul5efWDghXY1QnkYNSiWpfFP6qtN5j2gv
	Ztve7dRI7e9qUt3OCeFCdTJACrJobQh1OgA4tKuyq
X-Gm-Gg: ATEYQzwQ/Zpf1PhmB2jrlcKI8eU+77pwzSveKj+kLP+6Io/xijYabo0n67wXr1uZ55p
	5EsEjHgg9aT/nDWbsmYqEehZuWfFSl6+8lpYH5tpRJRbjqu/eTbVhN6mBdKSF7Pjzyn8KxLdCw/
	7sugSQJkUmL1ieMHm8V9NtAAjDRr/PwvZdXfsHbeBk8GS0Ez3sZmynte6BffHQAsPhR68HaMrbV
	tW85E0sO1vAtsDJBDttIkYeXbzbCKcsFS8olWXtESm3QWihL3YPIk0tem3w7pA2JtmjfCTQEuzi
	rGNoE2y1
X-Received: by 2002:a17:903:1b6f:b0:2b0:6263:6a05 with SMTP id
 d9443c01a7336-2b0b0b1e31dmr65554445ad.51.1774499950265; Wed, 25 Mar 2026
 21:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318232332.3528647-1-xmei5@asu.edu> <df909719-aca7-432c-b381-fee45c6e3ed2@redhat.com>
In-Reply-To: <df909719-aca7-432c-b381-fee45c6e3ed2@redhat.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 25 Mar 2026 21:38:59 -0700
X-Gm-Features: AQROBzAPiSq19vCULcbQrPswA6ZKZdzpYnmJiSK6426Ldiq9YrngUA_J-ciNP6Q
Message-ID: <CAPpSM+T4_u=8Km1L-y5uwWJbGuR-oyQHFq+O6fkfOtVTv3wUsg@mail.gmail.com>
Subject: Re: [PATCH net] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Paolo Abeni <pabeni@redhat.com>
Cc: security@kernel.org, netdev@vger.kernel.org, jv@jvosburgh.net, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-271831-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56A5232F202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 2:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/19/26 12:23 AM, Xiang Mei wrote:
> > bond_xmit_broadcast() reuses the original skb for the last slave
> > (determined by bond_is_last_slave()) and clones it for others.
> > Concurrent slave enslave/release can mutate the slave list during
> > RCU-protected iteration, changing which slave is "last" mid-loop.
> > This causes the original skb to be either double-consumed or freed.
> >
> > Always clone the skb for every slave and unconditionally free the
> > original after the loop, removing the racy bond_is_last_slave()
> > optimization.
> >
> > The UAF can trigger the following crash:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in skb_clone
> > Read of size 8 at addr ffff888100ef8d40 by task exploit/147
> >
> > CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTL=
AZY
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl (lib/dump_stack.c:123)
> >  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> >  kasan_report (mm/kasan/report.c:597)
> >  skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 inc=
lude/linux/skbuff.h:3396 net/core/skbuff.c:2108)
> >  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
> >  bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bond=
ing/bond_main.c:5593)
> >  dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netd=
evice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
> >  __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
> >  ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.=
h:554 net/ipv6/ip6_output.c:136)
> >  ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219=
)
> >  ip6_output (net/ipv6/ip6_output.c:250)
> >  ip6_send_skb (net/ipv6/ip6_output.c:1985)
> >  udp_v6_send_skb (net/ipv6/udp.c:1442)
> >  udpv6_sendmsg (net/ipv6/udp.c:1733)
> >  __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
> >  __x64_sys_sendto (net/socket.c:2209)
> >  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_6=
4.c:94)
> >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >  </TASK>
> >
> > Allocated by task 147:
> >
> > Freed by task 147:
> >
> > The buggy address belongs to the object at ffff888100ef8c80
> >  which belongs to the cache skbuff_head_cache of size 224
> > The buggy address is located 192 bytes inside of
> >  freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)
> >
> > Memory state around the buggy address:
> >  ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >                                                     ^
> >  ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> >  ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return valu=
e error bug")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  drivers/net/bonding/bond_main.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index 33f414d03ab91..8e57bee13e4ad 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5310,7 +5310,6 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_=
buff *skb,
> >       struct bonding *bond =3D netdev_priv(bond_dev);
> >       struct bond_up_slave *slaves;
> >       bool xmit_suc =3D false;
> > -     bool skb_used =3D false;
> >       int slaves_count, i;
> >
> >       if (all_slaves)
> > @@ -5326,24 +5325,18 @@ static netdev_tx_t bond_xmit_broadcast(struct s=
k_buff *skb,
> >               if (!(bond_slave_is_up(slave) && slave->link =3D=3D BOND_=
LINK_UP))
> >                       continue;
> >
> > -             if (bond_is_last_slave(bond, slave)) {
> > -                     skb2 =3D skb;
> > -                     skb_used =3D true;
> > -             } else {
> > -                     skb2 =3D skb_clone(skb, GFP_ATOMIC);
> > -                     if (!skb2) {
> > -                             net_err_ratelimited("%s: Error: %s: skb_c=
lone() failed\n",
> > -                                                 bond_dev->name, __fun=
c__);
> > -                             continue;
> > -                     }
> > +             skb2 =3D skb_clone(skb, GFP_ATOMIC);
>
> The additional clone is prone allocation failure (atomic scope) and adds
> additional overhead. Is really needed? Would something alike the
> following work instead of the current bond_is_last_slave() check?
>
>                 if (i + 1 =3D=3D slaves_count)
>
Thanks so much for the advice. Your patch is a more elegant patch. V2
was sent based on your version.

Thanks,
Xiang
> /P
>

