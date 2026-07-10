Return-Path: <netdev+bounces-306414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AoCXK59nUGpSyQIAu9opvQ
	(envelope-from <netdev+bounces-306414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:31:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A951D736FBC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:31:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W1tVVrMu;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306414-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306414-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCBE43007206
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC234A797;
	Fri, 10 Jul 2026 03:31:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C9335566
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 03:31:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654298; cv=pass; b=L7WH8fYUgvtj1J1svOi+zBiZUsL5CLmFkQn6iRSACcBF8nOeUwPAQ/2PREUjCi9HuMUPmWoDpD5LMqCHvb4To5nZ5a/HvHgUjdX+F/Pq8csDu6OF2e3tIfd0KZXrE0UMO0K+jXW2IVK0jL+qNbp707X9mSRiYbGbz5ymi5m3m+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654298; c=relaxed/simple;
	bh=7qTrYtyb4uYCjddRxsmEaBTIKdjBwNl/4bmB47HPVDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5VkFVZ6ong0JrKSyONzuBF9qXQ5o6a7arbOcgphkeJp0xWIrCNmVNPvVEsR5MD7OJSzDVkY062oQiO8s3k+HScEtaz3LUu5Si4klGpSTQkLJ8K49Z+LZU8KReE6cvdOIArZPXC3Xaioze+UTliCTYSh7dPB370Ck68ZTqt478g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1tVVrMu; arc=pass smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e592da74so64085566b.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 20:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783654295; cv=none;
        d=google.com; s=arc-20260327;
        b=MdqRK7lniUZp3A5PkWBhGAl3Tm3bGtLauM7vuL2U0mhkg9syo5j1of9lRVUWp7trLE
         lyi63+L1ssOFgliZCmrWyVLp7WZdgx1BQPZvc8rUuyFrZ/jnRADsLxTyKGm/eAk8KY7n
         jNoAmI4VJF2Hl+lOJ6jRqolq6aFk6u9HFEMfQLyj4Kbb6YgDkAKwvEWz4if3ngh0l+VF
         yAbPmIc5uc6vhjcwLtXlzpjnts8pxkmOKncatQEvdkU923pK7e8EXQnjYKB26BWy8F99
         JTvtaanSWDOjb4pD4j0aAKLfb13+VoyxKpj73BxFZEbhBmxy3poSI9cZVWldA+IwNY7J
         AlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gCq+rIk8vt2f13kU9Q7xOWBXHO/FaeO2q0kuAbTG+ms=;
        fh=eIPXxe7t+LUagjKKyGS1ijf/vr+XBJo8tR29eNgawFE=;
        b=FHesvjedV9tplWZpvevb+BiyiMJCauW7CddQMNd2kHb+bHwhppFFgzTr/aowF8Gx56
         2n8cSR69IZTaO8qlAjU85WqbeVXnHhep79gzvSKPF5rrp+E/CSBBLlsg2xwKk3Ph4SC2
         CxWtIhEsX9PaloGTrhPcO4wvLV4/JlwopcDjDJ7tP3/b9dTFCe/VGDJ3xw2ufE/F18lD
         gU2VdZ9FrCBhQhHebgYdzvwB5IPL2U3jvnQjB6UwY/fQ0HQrvw6McogH/aIoawqmjERz
         ae5lhI38Cytx56YkrkVwPtR0w4vGUXQU/8Ngrx4g3g+Xl8SAK4ItGrof1tyu5bNaflOi
         74Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654295; x=1784259095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gCq+rIk8vt2f13kU9Q7xOWBXHO/FaeO2q0kuAbTG+ms=;
        b=W1tVVrMuq+kg6JuGQYnYCtiNa7cVAGYoeFQ5w+5bLrjMl9jN8PcKZFm/CZbKa28uNW
         OVgxQkw7Ttep1NdIw9kaaQOmS7ObXH6cOfMXWKmnfEl6D8KnpjeRsRX3rgRqcvnOhrEs
         Yx9xe3zjK8o0zeHtXc1Br2k7bDQufvGxHNX9CxQnQTZws6W0uUPgwHC5ukA7FycIGqv8
         oj/zZ/x3vZS+AIMCe40b+0Gl6+z6lozbz7DDxCkM/xJGY7fnZ23nKWjPq4X1F55VSgiR
         ejSordXNtYxFornh7AhAt+U2dWU9xAr1g+mPlkk8b1gRn5ECvDH8UnvoRr496roX3XUs
         u5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654295; x=1784259095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCq+rIk8vt2f13kU9Q7xOWBXHO/FaeO2q0kuAbTG+ms=;
        b=ZaPoEQ4wbNQ0uYpCeaH04aXrbKZz0M/BB+olK4TKLkQsTJwvjN9z+jCyr49dXZlITk
         A40X99dJFXtrU0bT/X+Z37NxMZmCqEP7SR74sWqWSapUUVYjgEtkuH38jA+UVdFw/eCH
         Y7vbpKKhUJKw5/a8TUo9q2pizQWQaTIbzSYZP7z4EL82btcwezGaVBWkugMFEArB2I2V
         CpLhPvJnTRHm6xYBCJbvH/mUax21wZT7xcnhrGUc/Sk9QaMSAdrCebABgV1Z54EA3fZY
         LCqhPliK481Dpt5iimoPxw79zeS8W9hDIa66f3Eeefiv/iV7btXybm7WTdBOBfCD4jYf
         efBg==
X-Gm-Message-State: AOJu0YzpzDKQAjxENfDoBwwgDZOhH99EvwZ4xPJWM38rn/DIttVmkLSu
	SF5+Wl+pd15/EdFLjKi7KMPkXjVhmRBLUIKfstWV4Zhkhp1g/yINk6AgyWL1l8P5ITy6JZSpInk
	Erg2eduUrFPErsOXEmXquw+sgJZ/Q2J8=
X-Gm-Gg: AfdE7cnxcOQ6kGgX9iFEoBT1xDRwjYt20FkvXVEcoQgmnBXzFi1Fwdxn5OaVlXlx4IQ
	r4a8sMgGAv91lVuj3itqJz7k1ebHu+4jY7lYL+KGIziBvR/P5Y+xSl+j3tTpBF/iruDAir9OtT4
	3EzVmVE5u/9XIAEdGG93KwElaBfbUPCrf/CH/fBhSGf3Z82c4qOVMnH3m9vuYWoanXnMhkfsWhK
	y5AkhBBis5PokaWitZNKfNun+vBahFc4KWQdkAr+MDbxz7hCoE08g3DfmCOjuDthjlkNIJ8CLWI
	CHmzSlZouLq2afQrD0MMWB9Iqxid
X-Received: by 2002:a17:906:c147:b0:c16:2a:3c7 with SMTP id
 a640c23a62f3a-c16002a35ebmr60536166b.11.1783654294700; Thu, 09 Jul 2026
 20:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707164248.821265-2-bestswngs@gmail.com> <GV1P189MB1988185B47AFAA9202408186C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988185B47AFAA9202408186C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Fri, 10 Jul 2026 11:30:57 +0800
X-Gm-Features: AUfX_mx5hb6WkD9DcopSOKQuKtBGIghrQBVbvxGhPe28oEimVODo5QPLirtvoRw
Message-ID: <CANgPUi10bb4xQ+GBrYyiG7AunNG2zUvpVizrb5QACj9GUSwZ2Q@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: serialize udp bearer replicast list updates
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>, 
	Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306414-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,est.tech:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A951D736FBC

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 14:42=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net v2] tipc: serialize udp bearer replicast list update=
s
> >
> >tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list wit=
h
> >list_add_rcu() / list_del_rcu(), but nothing serializes them. The add ru=
ns from
> >the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(=
), so it
> >can race the cleanup delete and corrupt the
> >list:
> >
> > list_del corruption. prev->next should be ffff8880298d7ab8,
> >   but was ffff88802449ad38. (prev=3Dffff888027e3ec98)  kernel BUG at
> >lib/list_debug.c:62!
> > RIP: __list_del_entry_valid_or_report+0x17a/0x200
> > Workqueue: events cleanup_bearer
> > Call Trace:
> >  cleanup_bearer (net/tipc/udp_media.c:811)
> >  process_one_work (kernel/workqueue.c:3302)
> >  worker_thread (kernel/workqueue.c:3466)
> >
> >The bearer can be enabled from an unprivileged user namespace, as the
> >TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
> >
> >Add a spinlock to struct udp_bearer and take it around the
> >list_add_rcu() in tipc_udp_rcast_add() and the list_del_rcu() loop in
> >cleanup_bearer() so the two writers can no longer corrupt the list.
> >
> >While here, switch the read-only walk in tipc_udp_is_known_peer() to
> >list_for_each_entry_rcu(); it never deletes, so list_for_each_entry_safe=
() was
> >misleading.
> >
> >Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> >v2: (per Tung's review)
> > - Narrow the lock to just list_add_rcu().
> > - Drop the under-lock dup re-check; serializing the writers is enough.
> > - Use list_for_each_entry_rcu() in tipc_udp_is_known_peer().
> >
> > net/tipc/udp_media.c | 11 +++++++++--
> > 1 file changed, 9 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
> >62ae7f5b5840..c6aa8c3c54ce 100644
> >--- a/net/tipc/udp_media.c
> >+++ b/net/tipc/udp_media.c
> >@@ -94,6 +94,7 @@ struct udp_replicast {
> >  * @ifindex:  local address scope
> >  * @work:     used to schedule deferred work on a bearer
> >  * @rcast:    associated udp_replicast container
> >+ * @rcast_lock:       serializes updates to @rcast.list
> >  */
> > struct udp_bearer {
> >       struct tipc_bearer __rcu *bearer;
> >@@ -101,6 +102,7 @@ struct udp_bearer {
> >       u32 ifindex;
> >       struct work_struct work;
> >       struct udp_replicast rcast;
> >+      spinlock_t rcast_lock; /* protects rcast.list */
> > };
> >
> > static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -281,=
7
> >+283,7 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *=
skb,
> >static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
> >                                  struct udp_media_addr *addr)
> > {
> >-      struct udp_replicast *rcast, *tmp;
> >+      struct udp_replicast *rcast;
> >       struct udp_bearer *ub;
> >
> >       ub =3D rcu_dereference_rtnl(b->media_ptr);
> >@@ -290,7 +292,7 @@ static bool tipc_udp_is_known_peer(struct tipc_beare=
r
> >*b,
> >               return false;
> >       }
> >
> >-      list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> >+      list_for_each_entry_rcu(rcast, &ub->rcast.list, list) {
> >               if (!memcmp(&rcast->addr, addr, sizeof(struct
> >udp_media_addr)))
> >                       return true;
> >       }
>
> sashiko reports:
>
> ...
> Is there a possibility of triggering a lockdep warning here?
> Since this function is called from tipc_udp_nl_bearer_add() during Netlin=
k
> configuration, rtnl_lock() is held but rcu_read_lock() is not.
> Without an explicit lockdep condition like lockdep_rtnl_is_held() passed =
to
> the list traversal macro, lockdep will complain about the RCU list being
> traversed outside a reader section.
> >                 if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media=
_addr)))
> >                         return true;
> >         }
> > @@ -326,7 +328,9 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b=
,
> >                 pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6=
);
> >  #endif
> >         b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> > +       spin_lock_bh(&ub->rcast_lock);
> >         list_add_rcu(&rcast->list, &ub->rcast.list);
> > +       spin_unlock_bh(&ub->rcast_lock);
> >         return 0;
> >  }
> Could this allow duplicate peers to be added to the list?
> The under-lock duplicate check was removed in this patch iteration. Since
> tipc_udp_is_known_peer() is checked locklessly earlier in
> tipc_udp_rcast_disc(), two concurrent packets from the same unknown peer
> could both see the peer as missing.
> They would then both acquire rcast_lock sequentially and add duplicate
> entries, leading to memory leaks and traffic amplification when broadcast=
ing.
> [ ... ]
> ...
>
> I think we have to check duplicate address in tipc_udp_rcast_add() before=
 adding and remove tipc_udp_is_known_peer().
>
> >@@ -326,7 +328,9 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
> >               pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
> >#endif
> >       b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> >+      spin_lock_bh(&ub->rcast_lock);
> >       list_add_rcu(&rcast->list, &ub->rcast.list);
> >+      spin_unlock_bh(&ub->rcast_lock);
> >       return 0;
> > }
> >
> >@@ -679,6 +683,7 @@ static int tipc_udp_enable(struct net *net, struct
> >tipc_bearer *b,
> >               return -ENOMEM;
> >
> >       INIT_LIST_HEAD(&ub->rcast.list);
> >+      spin_lock_init(&ub->rcast_lock);
> >
> >       if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> >               goto err;
> >@@ -819,10 +824,12 @@ static void cleanup_bearer(struct work_struct
> >*work)
> >       struct udp_replicast *rcast, *tmp;
> >       struct tipc_net *tn;
> >
> >+      spin_lock_bh(&ub->rcast_lock);
> >       list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> >               list_del_rcu(&rcast->list);
> >               call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
> >       }
> >+      spin_unlock_bh(&ub->rcast_lock);
> >
> >       tn =3D tipc_net(sock_net(ub->sk));
> >
> >--
> >2.43.0
>

Thanks for the review. v3 has been sent.

