Return-Path: <netdev+bounces-305144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BcnWBKHyS2omdgEAu9opvQ
	(envelope-from <netdev+bounces-305144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:23:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7671475C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:23:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dcSOGnMt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305144-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305144-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E708030B8B59
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A13BC68D;
	Mon,  6 Jul 2026 16:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84902390230
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:31:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355515; cv=pass; b=IIPeRlDFIySgk9pTlKbAGdtlXS1kbdSIxWd0KCnsKIAkU6Eq0obL/VkWEb/5/iI59ZN1brXcevDxeb5OTWfkY9VDxbAORTuu+yw3rTj4WIdlop1w1f1284SrgLF/rDgtjdmAuJMvvkDzYrSu0sv0SEfUOBVDGPFqb5VnW61S5GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355515; c=relaxed/simple;
	bh=lqoPBkIq3W0sabOZWJMpyMpW6mOwndvq30EuSsJzlHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsGcUoVNQLl0vUytgo9tF7N/QiI8GtFGZloRZiEjknnSZmURkGwtg6YjyUhcXdUVTArcsh5aboekwurjTt3SqoKEdlVX+MsHYZ11nBoW43GABByYCBhiWb7UU3TWoCFkJs6CdQBfpP+734C05cI6sHtDrgeb+5ii/xn9kLnNzRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcSOGnMt; arc=pass smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c12620ed112so437836566b.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355512; cv=none;
        d=google.com; s=arc-20260327;
        b=Vce1ni3I+J9jMj93REQFpXXoPPIV7Z6sHQoLCdmHi1gkkGvT+3CsZMdbXuCT29sNFC
         0V4n1DgmI1OSAKg2s59KINCkVT07FaPaL1BD3aGC7tHko77ra7Vb+DXXFC/ktlgD2XlJ
         KlLQaAHIHu2dL9mNotkHuJdUoQtGXxwblo11sKYXHh50D3obrFAOioQE2ydxRndZTNBi
         mB6DdriWQE/0Jw1nK3Cy3j8jpXhcS8mX8xXiBCsmDSgf4XJQ/yiB9L0S5+fXAkOVTdBJ
         /0IrwSR8V8z2ejNjPaL72JOTzzM23Rd+stIcQpzupsyezmRJtESMgv5hB52RequXLR+u
         bDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QY+0YF9aBkKbmabgt7Z1MPUNmFAKLk+tE30jkQDU2bs=;
        fh=y3n7+kZEeYU0kiGUIhz14NPZTnRhpNOjfpuZnvI2ZbM=;
        b=HOPfm7HS+hahGWJBn9bbxQ1X9XyV+vohwRD/DDPZCXE9aGHNNlSP1VVpOeFOPiRxeq
         B6Uaw7tjmOA4/tKnyc8f1fxcUAjqsZS1jWyEx28GBAkVsVfJg/H5743yjx/19dRfI9BL
         SDLcIN4yhMg9d0hdK+mldEVg63hYo51DYKQOFcUl5ASfl+YBmFYQOF+HkY4WxREHKszA
         cD7A17ojgUHxcFBXq3XeTcJy5E4kxShY06ksRJOawmf6pZ2UFD5Y1VSmLaux2yxwg43h
         pMXhcsslHno3LT7jMHOQngOUMXJWXtkM84j2xuNSFqnuCmgDuyQOFYFQXdvCcvjx8O2i
         8bvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355512; x=1783960312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY+0YF9aBkKbmabgt7Z1MPUNmFAKLk+tE30jkQDU2bs=;
        b=dcSOGnMt2EEQ6Z/bhJGy1me9M/PsmUetnX06nZK4P7oWF9dBCeKerJcSaL3GGhvVis
         Yv06SnjNUCyoLvR7AYwu4dOzJcDQU4dTfiXYx7fQ+16wJfWdpv+0PbkCfO/GA/jyQYEE
         dicuhvAIQGarCKaO6M8x5GZdB0Bs9Yp1LPU6rFFSGP7wx9vEHmc95kpgnpm5Eyd2vIll
         m2NqFJU9H5bcEQfGqw6SrtTyGtqWXXjemJ+rP8JOqmuwkOSxEd46ocZehk4OPiC0ciu9
         8evAMeGCHpOc0CSALuW19mAs1TjEDzoA/Xef0xAObJkpJ4uhu3o03ZDuOJNQnPmlAG/r
         Qd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355512; x=1783960312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QY+0YF9aBkKbmabgt7Z1MPUNmFAKLk+tE30jkQDU2bs=;
        b=XnVbSsXEwgl4lZX75HNs2TN8yDKDlCyzZn+BR8mGNn9aTXK9ZgnawxUJ3Xr47I69JC
         EoEEpWMjzdIb8z5WzFQddidULSgZrp5S5HYCbL2RBpovmeL1UtP2r4fud/vPiu68Bzok
         khYLRIdGPBZSa4t00kmttxChO2I/aZAf74g9MZb8Qs1+qOXSufFJTRW7Sh3gXLUZz9c2
         p6QMtRQEkTAgz9INbnaQsKvJBc2pHWrGwc1sW1TDG4C8NvXwL4PNOWs/kVwAzPdHgZvr
         aBHX8DmEFMUIup9pDTu7P8rsiAsQ0bCnvxCphR3Yv5wc7QNcDFkEJQhDsXoAmXHdk04r
         xLLA==
X-Forwarded-Encrypted: i=1; AHgh+RoyTgfUEH/66XkdynkweAGBQU+LtHP8O9m9YgLYoNgwCdwVEdLFs1CCV0biNHA5xad8J1dbqes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRx37alQD29Wi5s6JpMJO4WfbicfWL+iDvA43AmtidvZBNx2w
	fnmzt+Ad5LKbGMWtbnUCEao3G5XDrONyeAlo97OSnnIMTnkmZTnRuXxmTUSKYcvA9NYH+Kbt/6Q
	FpxyHReHfCe3wyAts/zy6ZNj0Eim1zOQ=
X-Gm-Gg: AfdE7ckaYSLINzwnF8ZOMvDW7fbDLNw8JvjM9qMCyQra63WKRXXOtzuhxKYvKl1TUR0
	fd+xhgyTRp0vIdlNSxdPu/0Hu5X3EpdKHkNlrsIAPWu7X2qziXuNeZNMTsM8xSySLgcpd6FLyit
	Ku7RPRseWARGKdEjBC/nePWFhfOvSz8CHO+fqOXbJMYTH3b08yo89TsuhPsxqoJiosH2x9fFml4
	KiRBxODLC+pjNVn88F6mGjZV0tObP2Sw3GbsGlNYU3sLOran15kuKfBLaVS3YnglTKrt3LqQy7b
	4QEYzM5PjBu8E8dNXIWs4IqkKuTQ
X-Received: by 2002:a05:6938:a092:10b0:c12:696b:dd8c with SMTP id
 a640c23a62f3a-c15a6920f0dmr58113766b.49.1783355511529; Mon, 06 Jul 2026
 09:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705115958.1066751-1-bestswngs@gmail.com> <GV1P189MB198844ED09B014636A8EB7C8C6F12@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB198844ED09B014636A8EB7C8C6F12@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 7 Jul 2026 00:31:14 +0800
X-Gm-Features: AVVi8CdxYFUI8HZ80-wgrW4i7zu37UHb2l_Dq0MuDfzWtDhJgUssXRJGJ5N7ja4
Message-ID: <CANgPUi2Oaa3-UjxzQdgyzAfXAjoNd8Xr1AWw4p3sqXmKHdRPog@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix NULL deref in tipc_named_node_up() on empty
 publication list
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xiang Mei <xmei5@asu.edu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305144-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,est.tech:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65E7671475C

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net] tipc: fix NULL deref in tipc_named_node_up() on emp=
ty
> >publication list
> >
> >named_distribute() builds the bulk messages for @pls into @list and then
> >dereferences the tail skb:
> >
> >       hdr =3D buf_msg(skb_peek_tail(list));
> >       msg_set_last_bulk(hdr);
> >
> >If @pls is empty no skb is enqueued, skb_peek_tail() returns NULL, and
> >msg_set_last_bulk() writes through buf_msg(NULL).
> >
> >tipc_named_node_up() passes &nt->cluster_scope. With a node-id
> >configuration the TIPC_NODE_STATE name is published by tipc_net_finalize=
()
> >from a work item, which sets the node address before publishing the name=
.
> >The node accepts links once the address is set, so a link that comes up =
before
> >the publish runs named_distribute() on an empty cluster_scope:
> >
> > KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> > RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
> >  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:22=
1)
> >  tipc_node_write_unlock (net/tipc/node.c:428)
> >  tipc_rcv (net/tipc/node.c:2185)
> >  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing: =
Fatal
> >exception in interrupt
> >
> >TIPC genl ops use GENL_UNS_ADMIN_PERM, so an unprivileged user can reach
> >this from a user+net namespace.
> >
> >Return early from named_distribute() when the list is empty, and skip
> >tipc_node_xmit() for an empty chain. The empty chain would otherwise hit
> >tipc_lxc_xmit() -> buf_msg(skb_peek(list)), the same zero-skb case fixed=
 for
> >tipc_link_xmit() in commit b77413446408 ("tipc: fix NULL deref in
> >tipc_link_xmit()").
>
> It needs to return earlier in tipc_named_node_up() like this:
>
> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b..60ccaa862162 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -218,6 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, =
u16 capabilities)
>         spin_unlock_bh(&tn->nametbl_lock);
>
>         read_lock_bh(&nt->cluster_scope_lock);
> +       if (list_empty(&nt->cluster_scope)) {
> +               read_unlock_bh(&nt->cluster_scope_lock);
> +               return;
> +       }
>         named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
>         tipc_node_xmit(net, &head, dnode, 0);
>         read_unlock_bh(&nt->cluster_scope_lock);
>
> >
> >Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> > net/tipc/name_distr.c | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
> >ba4f4906e13b..c04fea4650a5 100644
> >--- a/net/tipc/name_distr.c
> >+++ b/net/tipc/name_distr.c
> >@@ -192,7 +192,10 @@ static void named_distribute(struct net *net, struc=
t
> >sk_buff_head *list,
> >               skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> >               __skb_queue_tail(list, skb);
> >       }
> >-      hdr =3D buf_msg(skb_peek_tail(list));
> >+      skb =3D skb_peek_tail(list);
> >+      if (!skb)
> >+              return;
> >+      hdr =3D buf_msg(skb);
> >       msg_set_last_bulk(hdr);
> >       msg_set_named_seqno(hdr, seqno);
> > }
> >@@ -219,7 +222,8 @@ void tipc_named_node_up(struct net *net, u32 dnode,
> >u16 capabilities)
> >
> >       read_lock_bh(&nt->cluster_scope_lock);
> >       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
> >-      tipc_node_xmit(net, &head, dnode, 0);
> >+      if (!skb_queue_empty(&head))
> >+              tipc_node_xmit(net, &head, dnode, 0);
> >       read_unlock_bh(&nt->cluster_scope_lock);
> > }
> >
> >--
> >2.43.0
> >
>

Thanks for your review.  v2 sent.

