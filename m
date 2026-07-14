Return-Path: <netdev+bounces-307574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXVMMp2MVmqQ8wAAu9opvQ
	(envelope-from <netdev+bounces-307574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DFC75834C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:23:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HukgR57S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307574-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307574-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 458003039A3F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756C41B8C2;
	Tue, 14 Jul 2026 19:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDE3002D8
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:23:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056987; cv=pass; b=TYuOlSxNFJkSUgOB1AqzpaM+sIU2XK6REWEJ/mrgVpKwybtveZoKgaUx96dApHgw1z6KAqgzln8U+ehJ5HuSfDXvQ5YUgurPvcr6BkFGc12hJujcP9bLWTgjNmq5jDcWeGchZbJVmmpm2zdWxLvNzJOhjcQ+l4Ct5CclK/I+mns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056987; c=relaxed/simple;
	bh=bMQP3PPyICyOc070fIn4mMQpbzIMj2Mr7DJSKEUAshE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtpgsyGgCSF/47MRm/3vJUA7lDNxGHlYfSvIm/I9WHzbbUAAyitSd2JSjSfBnBdju+DidOQ7KwbRKBktFkB7MQ2J++ZGxLpj4etDO+GQNTb62n6WmX+qoZ/Egb9IH6hawJjOJ0lVXPGrKcCPyPixoN21VWVH63IIpGAEI1JNDJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HukgR57S; arc=pass smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15f360851aso220714366b.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784056984; cv=none;
        d=google.com; s=arc-20260327;
        b=JAPHpXk/WzCAF8fdiYkwtN/sOD3ezUauX1tEw17pc6Z5l6DxLIckpTuPJcllThEtgp
         CmwM6IoDhUAq6ou9n+gKTmLF0wvlbGFOzm/D98atalbFRaAylshfwq58oWyV85DFcYm4
         aE9e/Oi0E96MtJTBmccwulRI55RutsPzVX5Gby/5JisvRYsFGPsHSaAW4HkqQdtrXjuA
         VFcvSN0Q2t4Bb2adJILpVcUJ6McriVsTZkEzSZNPHn1t1EfZRzgsFwfZb04gqNC0hA+9
         XXM+ZCVCAnrUjSJ/l69c0HusVbspoGY6ddPoUrvFreWFwe/gmXI2kAYwfLWYcEzfmpSy
         +jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FXBHlNKwuIa7aGX7ZPFIURhQkWOBdmY3pojBLb5bI6w=;
        fh=m7VR74eUURRG4a3kkxCpuPyIkXT0WZw+o1nhYgOzoVo=;
        b=jbd0vKM62cI12nvYFLzbPZdQTXoJ07qbEQlmSflOilMl8yKaHzN1grh8pxonbKW3qo
         3zQWdWwrHEXNVjg9xUMd/TMSxr4nLnUVMJ5AENy74QHiZlcD/RuK0IZ7UhkH0oOk1OsE
         uULAQN/bOk5i+mVjrWSzP9tGQmTvkdSTwDbIHdSM7BQ4IDFIDTg3c3sJXJw7M0H0LPVL
         bEH5q5OVABjXbGo3wgqwiywqAZsrwfqt0z91SiyeIyFqXHkn+pviUJmWDbqWHmhNFqvE
         LGvjN/okA1uAoMrmMAn+eI9E1ir75n3WNu+w1QFTiqdJW8Dj+CEHLXhwoSo2V4tABtFW
         +0RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056984; x=1784661784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FXBHlNKwuIa7aGX7ZPFIURhQkWOBdmY3pojBLb5bI6w=;
        b=HukgR57SrCopP6ot1IlL3ypcGsWjmZpycirJ9N9KffT1LurbHZzagRy3idwxp/ZrNz
         c/dIGN/qQJI2uggkc9bNFJOTYKNpmnPt4YpPpAKWNJ+zC/MgUktdLTWap93oFRfkrNdn
         KmlKUGiwXTBZdisIAAtIgoE89jZ1BTLZKrYk2HLQF1u4DBQKucLnj7pE330IKggAfXWD
         l4nZp/o3ykpu9E6rtnV8KltRhkkiA8BeH6UMCp8Tbp10NWGk9rP9QQwbC0YXtEsT4wNO
         x8bTmUGTYErQ+2JGeBsi5kZxBFzjX1yymwyYPlDTue1BRdJdNfSZSaAXoG6fto9tITt4
         j2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056984; x=1784661784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FXBHlNKwuIa7aGX7ZPFIURhQkWOBdmY3pojBLb5bI6w=;
        b=cjm/2vjVMMhF10OMAkQLv+8Xs9lQO38BDxRKGYwyi7VyBv2qtw8eyqE+s9Aj8ew325
         p+pVbHdiO/ZuaZtZ7bxy1D4nESzHs8zxy7u1kWPs3mouSuxqXP7XIAN5L7hq61CsPpVI
         P8DG3JFB2ObXs/sGBnFb8rBO1NrIYvLZ/a4dinOMTzq57shsp+l9RPxy0VnjZApwrXBE
         svid13DdScVc/RMusV7/IryBw9IMEAdiI2OX98jHIri0XvLXE0vnEUkVUN1El1rmfbk6
         gtdYJ+PnSYwvSBJP4o1I694s9YgFZbWhclzP1dqyiaSvWnKJvWbhPllnKXemCkLwLDJ5
         yquQ==
X-Gm-Message-State: AOJu0YzD/WjiLNCsVe5ZQQYea4pVZ9Jq/tt+rmQG57ZvMOKC5ij5kLOx
	XicqqcvKMFZUPXJ3tB7SvifoERkm0gHAAzCluh81K0DhnXzZ9k4AZ1kbLTA7dYx1Ng7IWWbsy95
	JZje9pFeG4zsGlfrt4RtOz3KGb3VSJeQ=
X-Gm-Gg: AfdE7ckWoNJvLYnM1sAgaK0GgBd/2SyCAVfr7qnYVmkC1liHIUqSQyHtpw88Yc0wLi/
	4BGyD4fjzfSgd+YHEEdyKxVIwrfgTNRHr1F3+gr6E1KTCcpHYOUcLxm52L4PhOgd5i+XwWNqXuJ
	RlwjqInbw2bfEampRopQIRZsjyOXjpCMYQW+6Ifhv52es6FSn7rdknXxQxi2JfsmCc5dJKs781L
	sGieX+7d2yg14jjB5WnggF+uDaC195xuX6vt5AlGa1nqdtz+dIROJL6MPluqmoHhiD6Ffpr0yB5
	bbwn9oYN6qYK1qDPHnCk64x/2GIG
X-Received: by 2002:a17:907:cf87:b0:c16:1120:8e63 with SMTP id
 a640c23a62f3a-c161e9c2baamr825531566b.21.1784056983454; Tue, 14 Jul 2026
 12:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710174718.1969789-2-bestswngs@gmail.com> <GV1P189MB1988266AEFCF1F992E0F50D3C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988266AEFCF1F992E0F50D3C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 15 Jul 2026 03:22:26 +0800
X-Gm-Features: AUfX_my7g5QdTWQuYCx-jpzYSubmdLo4XZTuoSoJnDv-b0fXk7L7peilPHNJadE
Message-ID: <CANgPUi3i0f4-dGNRK0gOMunxAHabK0t+habiC9LEBsCpNmVkPg@mail.gmail.com>
Subject: Re: [PATCH net v4] tipc: serialize udp bearer replicast list updates
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "xmei5@asu.edu" <xmei5@asu.edu>, 
	Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307574-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,est.tech:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41DFC75834C

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 20:06=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net v4] tipc: serialize udp bearer replicast list update=
s
> >
> >tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list wit=
h
> >list_add_rcu() / list_del_rcu(), but nothing serializes them. The add ru=
ns from
> >the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(=
), so it
> >can race the cleanup delete and corrupt the list:
> >
> >  list_del corruption. prev->next should be ffff8880298d7ab8,
> >    but was ffff88802449ad38. (prev=3Dffff888027e3ec98)
> >  kernel BUG at lib/list_debug.c:62!
> >  RIP: __list_del_entry_valid_or_report+0x17a/0x200
> >  Workqueue: events cleanup_bearer
> >  Call Trace:
> >   cleanup_bearer (net/tipc/udp_media.c:811)
> >   process_one_work (kernel/workqueue.c:3302)
> >   worker_thread (kernel/workqueue.c:3466)
> >
> >The bearer can be enabled from an unprivileged user namespace, as the
> >TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
> >
> >Add a spinlock to struct udp_bearer and take it around the list_add_rcu(=
) in
> >tipc_udp_rcast_add() and the list_del_rcu() loop in cleanup_bearer() so =
the
> >two writers can no longer corrupt the list.
> >
> >Reject a duplicate peer under the same lock before allocating, and remov=
e
> >tipc_udp_is_known_peer(). The old lockless pre-check in
> >tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer c=
ould
> >both find it absent and add it twice. Doing the check under rcast_lock i=
n
> >tipc_udp_rcast_add(), before the allocation, makes it the single point o=
f truth
> >for both the discovery and the netlink add paths and keeps a flood of th=
e same
> >address from churning the allocator.
> >
> >Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> >v4: (per Tung's review)
> > - Reject a duplicate under rcast_lock before allocating rcast, so a
> >   flood of the same address can't churn the allocator.
> >v3:
> > - Check for a duplicate peer in tipc_udp_rcast_add() under rcast_lock
> >   and remove tipc_udp_is_known_peer().
> >v2:
> > - Narrow the lock to the list mutation.
> >
> > net/tipc/udp_media.c | 53 ++++++++++++++++++++------------------------
> > 1 file changed, 24 insertions(+), 29 deletions(-)
> >
> >diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
> >62ae7f5b5..3f0d75d72 100644
> >--- a/net/tipc/udp_media.c
> >+++ b/net/tipc/udp_media.c
> >@@ -94,6 +94,7 @@ struct udp_replicast {
> >  * @ifindex:  local address scope
> >  * @work:     used to schedule deferred work on a bearer
> >  * @rcast:    associated udp_replicast container
> >+ * @rcast_lock:       serialize updates to @rcast.list against concurre=
nt
> >updaters
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
> > static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -278,=
26
> >+280,6 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *=
skb,
> >       return err;
> > }
> >
> >-static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
> >-                                 struct udp_media_addr *addr)
> >-{
> >-      struct udp_replicast *rcast, *tmp;
> >-      struct udp_bearer *ub;
> >-
> >-      ub =3D rcu_dereference_rtnl(b->media_ptr);
> >-      if (!ub) {
> >-              pr_err_ratelimited("UDP bearer instance not found\n");
> >-              return false;
> >-      }
> >-
> >-      list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> >-              if (!memcmp(&rcast->addr, addr, sizeof(struct
> >udp_media_addr)))
> >-                      return true;
> >-      }
> >-
> >-      return false;
> >-}
> >-
> > static int tipc_udp_rcast_add(struct tipc_bearer *b,
> >                             struct udp_media_addr *addr)
> > {
> >@@ -308,16 +290,34 @@ static int tipc_udp_rcast_add(struct tipc_bearer *=
b,
> >       if (!ub)
> >               return -ENODEV;
> >
> >+      /* Serialize with other updaters and reject a duplicate before
> >+       * allocating, so a flood of the same address can't churn the
> >+       * allocator.
> >+       */
> >+      spin_lock_bh(&ub->rcast_lock);
> >+      list_for_each_entry(rcast, &ub->rcast.list, list) {
> >+              if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
> >+                      spin_unlock_bh(&ub->rcast_lock);
> >+                      return 0;
> >+              }
> >+      }
> >+
> >       rcast =3D kmalloc_obj(*rcast, GFP_ATOMIC);
> >-      if (!rcast)
> >+      if (!rcast) {
> >+              spin_unlock_bh(&ub->rcast_lock);
> >               return -ENOMEM;
> >+      }
> >
> >       if (dst_cache_init(&rcast->dst_cache, GFP_ATOMIC)) {
> >+              spin_unlock_bh(&ub->rcast_lock);
> >               kfree(rcast);
> >               return -ENOMEM;
> >       }
> >
> >       memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
> >+      list_add_rcu(&rcast->list, &ub->rcast.list);
> >+      b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> >+      spin_unlock_bh(&ub->rcast_lock);
>
> sashiko reports potential memory leak when tipc_udp_nl_bearer_add() adds =
an element to the list right after cleanup_bearer() frees all element in th=
e list.
> I think we need to add more code to handle this case as below:
>
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -95,6 +95,7 @@ struct udp_replicast {
>   * @work:      used to schedule deferred work on a bearer
>   * @rcast:     associated udp_replicast container
>   * @rcast_lock:        serialize updates to @rcast.list against concurre=
nt updaters
> + * @bearer_disabled: flag to not add rcast to rcast.list if bearer was d=
isabled
>   */
>  struct udp_bearer {
>         struct tipc_bearer __rcu *bearer;
> @@ -103,6 +104,7 @@ struct udp_bearer {
>         struct work_struct work;
>         struct udp_replicast rcast;
>         spinlock_t rcast_lock; /* protects rcast.list */
> +       bool bearer_disabled;
>  };
>
>  static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr)
> @@ -295,6 +297,10 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
>          * allocator.
>          */
>         spin_lock_bh(&ub->rcast_lock);
> +       if (ub->bearer_disabled) {
> +               spin_unlock_bh(&ub->rcast_lock);
> +               return 0;
> +       }
>         list_for_each_entry(rcast, &ub->rcast.list, list) {
>                 if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
>                         spin_unlock_bh(&ub->rcast_lock);
> @@ -817,6 +823,7 @@ static void cleanup_bearer(struct work_struct *work)
>                 list_del_rcu(&rcast->list);
>                 call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
>         }
> +       ub->bearer_disabled =3D true;
>         spin_unlock_bh(&ub->rcast_lock);
>
>         tn =3D tipc_net(sock_net(ub->sk));
>
> >
> >       if (ntohs(addr->proto) =3D=3D ETH_P_IP)
> >               pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);=
 @@
> >-325,8 +325,6 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
> >       else if (ntohs(addr->proto) =3D=3D ETH_P_IPV6)
> >               pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
> >#endif
> >-      b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> >-      list_add_rcu(&rcast->list, &ub->rcast.list);
> >       return 0;
> > }
> >
> >@@ -361,9 +359,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b=
,
> >struct sk_buff *skb)
> >               return 0;
> >       }
> >
> >-      if (likely(tipc_udp_is_known_peer(b, &src)))
> >-              return 0;
> >-
> >       return tipc_udp_rcast_add(b, &src);
> > }
> >
> >@@ -644,9 +639,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b,
> >struct nlattr *attr)
> >               return -EINVAL;
> >       }
> >
> >-      if (tipc_udp_is_known_peer(b, &addr))
> >-              return 0;
> >-
> >       return tipc_udp_rcast_add(b, &addr);
> > }
> >
> >@@ -679,6 +671,7 @@ static int tipc_udp_enable(struct net *net, struct
> >tipc_bearer *b,
> >               return -ENOMEM;
> >
> >       INIT_LIST_HEAD(&ub->rcast.list);
> >+      spin_lock_init(&ub->rcast_lock);
> >
> >       if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> >               goto err;
> >@@ -819,10 +812,12 @@ static void cleanup_bearer(struct work_struct
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

v5 sent. Thanks.

