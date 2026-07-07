Return-Path: <netdev+bounces-305530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wgl5HlosTWqLwAEAu9opvQ
	(envelope-from <netdev+bounces-305530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1271DF37
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:42:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sa1JGVJV;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305530-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305530-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96DB30AA7F4
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD67435A83;
	Tue,  7 Jul 2026 16:35:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A55435A82
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:35:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442128; cv=pass; b=ohyS7Q2lTSdIj56aFWVIW9awu7K6MA/4L2u3spFISFkmyewmOaWz78IomA3OjMYB0yy8dI7NtPa9Y2TTpK6IsztUARBDY/4VA+XncYx81KSXu9jZdvxfQujH92sKtEpfGF2Ynn0LgVDbmXqoc2KqNaTlk4xFn1ptmOv08vaQK1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442128; c=relaxed/simple;
	bh=47FgWmL0/sJ3EBkjYH8n2XCB0eNqC8ghlh81msiLbSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYmFeYaLfvGerq13tCdJVCY26SSHVLnLiirV0O87AjDPhG0PcuZ3FLrLjV/O52W7b59trHpCUcjWs/QYI3DGLZevOdAW29VhCfn1u6g5OpumtFUaRKjnThbaVVi4yIjkY4yj5xaSJftWDlgXXBk1r+dG5Tqdz3wA7+7u8gYxrrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa1JGVJV; arc=pass smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b9def622so64373766b.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783442125; cv=none;
        d=google.com; s=arc-20260327;
        b=hOkPArodNxXTneCRmHB53Gczl/KOFBPfFOJrTWCepN7KKiuK16qqVMJrz64CA+M9j6
         n4bIQGn/O6QXxB0umKBPGH82ilzWoZ87A0OZvA1nLE3n8MW69EkC0E359xzip2sQRgA+
         rUhSt/KBylp5XbLP+ENn7we1sMjcIycQQlBeIGs7a5NF2EPjzJ1JO4w3BZcjoY/WkE5I
         0Hd20TIX6d7vPEJUOrs/3o5W3Ebzk67k/7564KQ/4kf9B5Mfnxg7qkiw1tmRYQGMHe8P
         bdUyTl7uyWhErzdnA8RBvIbi8V3nI0IBsFapGlqMm8nAsh7/xi8sgFki3HGySlrsbNbu
         9FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eX0leblPThsG/mxI+RmYykiu1iq7KLEwPDU510RCSpY=;
        fh=KHpAAkit/vOqWvh/AvhZGLFbe2WX6eQ0U/Q0ZBANmeQ=;
        b=oWXBzG2UBm+1RzD3vUZ+C9fnGk1g2Pu1rrp5q2HZjq5mg47SfKUEmJD1EHJFQnlhxg
         IcL7o0mEnbpqobUJpS4i2Zw+u5dkU27dLoH3LZkHpglb5UzIMY8Sg/EzKQdyr341AX2E
         o2TmjnLcpcmtbb9O7BTwz32ojJEB8XM5hCyXKRXNQMDI68emv7qsd+OXzI4MzwmWyGbe
         60L4cebZZLl0p0ZWnIDRUjVFjBM2kt0X2DYlexFXZbBOMTXTa625a161TREJHc486+Vl
         84WLouTD33OcZtN9QZMf5NgL0seaMQdcXJsJtyVul6W3HsJjqam56lqQTBl6JS2VTDT0
         wqig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783442125; x=1784046925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eX0leblPThsG/mxI+RmYykiu1iq7KLEwPDU510RCSpY=;
        b=sa1JGVJV2QP5QAOcJ3q63TXKUoiGsUUuiXy12zyBYOoQjH+XmIuTgdmpIuSBGMeg0I
         ls/1/eULCoNkQjh8tplPsQRf1RVkc1HaC2ebgRAecxzxR6/fMnw3e/m19mmCUXLnOY6I
         t37rIKzdoUifcElq8tYmZwwo7fstNCnvJnZYddqEKdeKl0MeUv0tkhWdlb/A55I+fgwk
         gDOeE+XFVhxrfiBaKkdJ5pJs3s2MUNZa1qmn9S1nTFpQNs+5nTUwOSR58g7hX4YqycHu
         B/Xb+GznJW7LmqlEDEdJnOkkX4X3mUjbFz10xhmVTmD3wp0ilAlwmY14uytibBb/uG6O
         qQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442125; x=1784046925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eX0leblPThsG/mxI+RmYykiu1iq7KLEwPDU510RCSpY=;
        b=i6e6THxLcOpJqe23wWjNWrlX/OgWXoh7Y68MVpauAwPsFycLmuZ7HjtbzT0dl+3GuD
         ThKM6KUKeFPfW9yXBJoGk4L54rNmZaSL67KVTb6OCOJmJv0bjO+1WFKaBBrw4saiD/Ek
         U4baJIQKXe+LZUuhNl/YvfOENs8l+09N9T+ALHqI/+C/VIsnoaGbTEQDsfc2E8GtvCkm
         CseUx4DOxCGKS1gGnNy6rPHT96vr0cGwZR+WEOlh0zDxFXiQIH/1g8DUSnSxW6HGEZtp
         9ofmzHjEYhBxHt2pDY9fFNIdaqCXs4YfZXQIzu5kbHoCR0UVKJ93R9Ngetwg31x/N7fB
         ti2w==
X-Forwarded-Encrypted: i=1; AHgh+RoVpsMrYBNCVLmgw1dKDQqWwo3hOvpAjYZ9tp7QsBaPNX3mFVizW/dVnP4OQnHuWMMzUzcehIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0dcZv9sX6WU7/vzay+8hirfc0+MqajwFS+ZfT6eARNYiaREB
	SGD4hs/TlFvRlPa2UPYDKmYDSEcqhwwq+L/xC/FMmTaZHD8SYrpz+ePod56oNsnwQQA6gQUunKo
	rWOT8wZkoHZGf+HtrXfeiP7lo9k7GyWQ=
X-Gm-Gg: AfdE7clqCXtUHNMbY4u+5S2DiUdOWj8B/vesHUvtnYfNqrb8eYfHGeu1opTmGXYcAXo
	PofIc6zXBkbMgqaSnI2jHpbZVMcrXdMezsIKgeC+WZ0xfbBc4Ey0zWqBiia5WUW4Up6DCzVOZ7a
	Qq+Zw5AO3ZCnTg4YqPXVRavqEQtOlMD4fqvW+dqdlOun1AvkJPXSAjd6lL/fvZshyohHvH5jidw
	epweWYxpk4R5JEgUWrFDJ9O1VY8WQJsmHwBxCCLg9xQ7YtQ/qoho5GZaVBTliTQuuMwHoe4iwtR
	lnvUHGG5ullLRvnIXhYmkF9yPO80
X-Received: by 2002:a17:906:1754:b0:c12:9fb7:3e68 with SMTP id
 a640c23a62f3a-c15a67bd5ecmr244859066b.38.1783442124492; Tue, 07 Jul 2026
 09:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706134716.3879-2-bestswngs@gmail.com> <GV1P189MB1988C48DB0AA286E9DF62789C6F02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988C48DB0AA286E9DF62789C6F02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 8 Jul 2026 00:34:47 +0800
X-Gm-Features: AVVi8CdComON0MR6xWcmE3xdXWeZZPUdcAYQEQ0bPmJDHOFxhbmn34eaqbK-8ho
Message-ID: <CANgPUi2Keetyi7Vs1+c4QBhLq33RG-=sZBJmJyJTeZDTbLdt-w@mail.gmail.com>
Subject: Re: [PATCH net] tipc: serialize udp bearer replicast list updates
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, Xiang Mei <xmei5@asu.edu>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:xmei5@asu.edu,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305530-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFE1271DF37

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=BA=8C 21:21=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net] tipc: serialize udp bearer replicast list updates
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
> >Add a spinlock and take it around both list updates. Re-check for the pe=
er
> >under the lock in the add path so the check-then-add in
> >tipc_udp_rcast_disc() cannot insert a duplicate.
> >
> >Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> > net/tipc/udp_media.c | 19 ++++++++++++++++++-
> > 1 file changed, 18 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
> >62ae7f5b5840..601174297a16 100644
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
> > static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -301,=
7
> >+303,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer *b,  sta=
tic
> >int tipc_udp_rcast_add(struct tipc_bearer *b,
> >                             struct udp_media_addr *addr)
> > {
> >-      struct udp_replicast *rcast;
> >+      struct udp_replicast *rcast, *tmp;
> >       struct udp_bearer *ub;
> >
> >       ub =3D rcu_dereference_rtnl(b->media_ptr);
> >@@ -319,6 +321,17 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b=
,
> >
> >       memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
> >
> >+      /* tipc_udp_rcast_disc() adds from softirq without rtnl_lock(). *=
/
>
> Remove above comment because it is vague. Caller of tipc_udp_rcv() alread=
y holds rcu_read_lock().
>
> >+      spin_lock_bh(&ub->rcast_lock);
>
> Move 'spin_lock_bh(&ub->rcast_lock)' to above 'list_add_rcu(&rcast->list,=
 &ub->rcast.list);' because only 'ub->rcast.list' needs protection.
>
> >+      list_for_each_entry(tmp, &ub->rcast.list, list) {
> >+              if (!memcmp(&tmp->addr, addr, sizeof(struct
> >udp_media_addr))) {
> >+                      spin_unlock_bh(&ub->rcast_lock);
> >+                      dst_cache_destroy(&rcast->dst_cache);
> >+                      kfree(rcast);
> >+                      return 0;
> >+              }
> >+      }
>
> This is wrong because the code in the loop is never executed. tipc_udp_is=
_known_peer() already verifies address duplication.
> Please remove above code and fix tipc_udp_is_known_peer() as below:
>
> static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
>                                    struct udp_media_addr *addr)
>  {
> -       struct udp_replicast *rcast, *tmp;
> +       struct udp_replicast *rcast;
>         struct udp_bearer *ub;
>
>         ub =3D rcu_dereference_rtnl(b->media_ptr);
> @@ -292,7 +292,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer=
 *b,
>                 return false;
>         }
>
> -       list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> +       list_for_each_entry_rcu(rcast, &ub->rcast.list, list) {
>                 if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media_a=
ddr)))
>                         return true;
>         }
>
> >+
> >       if (ntohs(addr->proto) =3D=3D ETH_P_IP)
> >               pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);=
  #if
> >IS_ENABLED(CONFIG_IPV6) @@ -327,6 +340,7 @@ static int
> >tipc_udp_rcast_add(struct tipc_bearer *b,  #endif
> >       b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> >       list_add_rcu(&rcast->list, &ub->rcast.list);
> >+      spin_unlock_bh(&ub->rcast_lock);
> >       return 0;
> > }
> >
> >@@ -679,6 +693,7 @@ static int tipc_udp_enable(struct net *net, struct
> >tipc_bearer *b,
> >               return -ENOMEM;
> >
> >       INIT_LIST_HEAD(&ub->rcast.list);
> >+      spin_lock_init(&ub->rcast_lock);
> >
> >       if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> >               goto err;
> >@@ -819,10 +834,12 @@ static void cleanup_bearer(struct work_struct
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
> >
>

Thank you for the review. I will look into your suggestions and send out v2=
.

