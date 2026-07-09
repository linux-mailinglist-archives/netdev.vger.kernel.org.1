Return-Path: <netdev+bounces-306292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GKtvMom5T2pbnQIAu9opvQ
	(envelope-from <netdev+bounces-306292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF2732A55
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:08:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mbX4XKbG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306292-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306292-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDEFD30BB9C3
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB873469E0;
	Thu,  9 Jul 2026 14:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32231386550
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:57:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609042; cv=pass; b=i78vjeeE3/G1FHTc5++BnMLLxGy4mqi5bVpSRHIdgwwuwFEHCD5UaWsF97xldkXTkPfIVVBkQ4FgDZrOlgec9bK8K4HKTI2R6kiq4ajjX1mH4AgNtxdd8G0yy1KwL/sXFNm+V1aAMQsF7iv0EolRHCXvpxAvk36Wruwmf5Bb3TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609042; c=relaxed/simple;
	bh=JQZGzWiDlxue/nS0W3jVE5PlObWNSvBwiGBG4eCCjtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFUnlH4gGMqNpSEQkOTr+qVMbrROomAYdU78MchfchvuZXvwzDCRpbbGxmx3VUqZ4K04I26ID6VieTqsuGyIz/va0rwyCeTW4Mln8WK/CMpoSCMBLeHMe7Jlkz27d6WWm8AvF8JfBZ4ZwcpChsZwQULdLRHOL/kUmqln050YBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbX4XKbG; arc=pass smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso253041166b.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 07:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783609039; cv=none;
        d=google.com; s=arc-20260327;
        b=SVMbFqBARJ0G7IzilOForGzk6q2Z7gld9tp4emsB6uPcimYOIdxzzOu7daHYB9KFaZ
         q4oEJNfUTr0iGtiiO+iK6gZC1eNi+R+gLXzgaWY5d0es+KoUpRFc22QuI0IyMw7+840E
         2fL14YuGJkp0U9bxTlcFxxzN/oPRVkmcESFDk6y4ImVbDm2kDDK9vKUkNeM9bxMU56+j
         bBiZDHBdo5Q/dcv3aYnpFWKd/5+G/hGWNpJfcYAUja6zVCQPPht05JmB0LdO/4B8re6e
         3EPKl3f6ZWxr6Mgu1oBbcCdaQPZKcXZS6g1ba4jKK1FPKm5vdP6ryxLLpSpQ1ZXOsqsJ
         n27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X9MW4k5clkRbkMoN+TQ3L7d5cz0hqIpmdk4Pvf7ct/k=;
        fh=VUWXkPNmL+wfHqEO1RaLiEemSveP9a2XQtR6EEGt9wg=;
        b=CkK8mymJokadyUJ5rei/7KBDsAp7wiUamu9p4EFNwGAauR6GVMkrcpbMB+IQMCYlzR
         xV73E2OzLaMmpaZVd7e1sSK7IrX7BHApwpTfqSALSUa4XVIwXOCG11eivhRubm8zr1Ct
         U+UBJqKtBbj43P313Vb2WjkhYGqBCW5rboM40XAhD87o8hrkSnrLnyNjwieQSd6CxMYb
         mYUGBcv7Ox8yb4tJrOCOvQYoX4RtW0Vlx8ymWAkmOZvy5tVu903XQoHWdBIZ5KNtkmSN
         EKTl3p76aRNSVKlotozDY99+Im1J6kugp4kiyNyhzwuesiOpgyNaLfNrz/FRsTEHlk+j
         Gbeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609039; x=1784213839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X9MW4k5clkRbkMoN+TQ3L7d5cz0hqIpmdk4Pvf7ct/k=;
        b=mbX4XKbGZOSmgjYrX8NmerrngUSTfhmS0B7Adu7WsMrDunyHq6lMTSV/8IK96mxW99
         RFcHgZlJ4y2sY2JxuPJHNCJ60qdhEV9bVoKehprLojVOPr8gLvOJ5U9FBYZKjnEfjhTb
         UQq0g+tG8/FEYJ+bDR41HcG8lY3f7PBFs8zheBxcXtTmpzoKPX+SoVlNztTr6MoQCjLz
         HudSx1y4AJ0y7ak20sNUBZvInMvCPcT3B2ScLX03JMbWw/fxVQtBmyA/0AymVjVGJLqI
         JSYHNBc1AnxoHWBVm1ueRyUzSJanU9IAQRMuFLY0zWX1i+Dyi7Tdh3VXzyoGlt5w9rXP
         bdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609039; x=1784213839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9MW4k5clkRbkMoN+TQ3L7d5cz0hqIpmdk4Pvf7ct/k=;
        b=cNjD7A2aV+5sOZxk2jnUbZwPLyd0n9zdDVRGxdgdVlAhqpRKXmnaCCqcSL/RzlLWO4
         RvobB5jgjBTutYLmAWPKUxvkpmwP1CZHS7zK6RTE3wfK6UJ8ke49l/ObxrkVoVJnyqnt
         OPFYuCK7y8mryEVC9p0SH5XmtTXGAOt/7qqbdGO85cZzPegYmsgwuYqSCugIJhQKn2pz
         vN0KyfvXtJGlg29DP6AgQMqx2QQ9YLEnNeXRm++mt1RnPs/KZbq1OfH1e39Lpbx6z66m
         9lmB5oFnehHT/+IMtf0sYzBBrr2XTzNf+LXEgFBo9A5OzWMBdImIQIwkNgqW4GP15OYl
         1nPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5RXlmq3r05BfHFnK7lOOLcKD+TrAivW/q/p7Dg3q2O4ZVkQfyF1rDoEaOp5REnjYMdyxlbzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6M7ZikekLH2aAzo4d2eOQ3xwdtb38C9dyEXka0SPqTzyEkFzD
	byac7S/dQnXXvDj2tSMnz/+zTEnDI8Y5SD+IAAGojxFTZY7XU0QWAtLkfbJMYWuZoJv0viJJ2iF
	T0zlsU2RJpGTkQncvAO7nWt+oAFzkI/M=
X-Gm-Gg: AfdE7cnnip6zo+Zz2mj1XgiTrLOE8oQbR3t2TKgAmJydU53jZw4rYqM6cxkq6rMKFbM
	WSbzwWb17F8TA+x9OZc0A6H3VDUfEh6S8CD1hlBqUqCDm4VtjzjfZhJxjJpWdCK8Fq4imtLtPOP
	6/tQM4tdobcc06FMWJ3nn5m+0icK+INoCzs60o2Cmxjm7LHkSRxmvogOkBI/iaSO9Lzy75COC7f
	cF+LP8IxwXEUPiD70++OwphjXaa3c4fv5T4skUqX2EDs6WNQ+kC4hh0iqjEv1fX2ohZo1DqlOsC
	2XNNnuhW8AFunVoLBAsNgHmkK9pC
X-Received: by 2002:a17:907:ea8:b0:c12:3ccd:7d5 with SMTP id
 a640c23a62f3a-c15ce21e863mr390104766b.59.1783609039403; Thu, 09 Jul 2026
 07:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708161324.2954113-2-bestswngs@gmail.com> <GV1P189MB1988683F0940A1DC37094256C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988683F0940A1DC37094256C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Thu, 9 Jul 2026 22:56:41 +0800
X-Gm-Features: AUfX_mxV6r6CJZ3fI7nAC0kvD2uAEXJMdyDMiVJeI9XP2UxGqCuvKo6gss7Y_W0
Message-ID: <CANgPUi2eTumrC9O+zYZH8Av9ak3dNeULauh0-OWCr-3Nszr-3A@mail.gmail.com>
Subject: Re: [PATCH net] tipc: guard against empty buffer list in tipc_node_xmit()
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Xiang Mei <xmei5@asu.edu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, Jon Maloy <jmaloy@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306292-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,est.tech:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35CF2732A55

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 14:33=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net] tipc: guard against empty buffer list in tipc_node_=
xmit()
> >
> >tipc_node_xmit() dispatches a buffer list either to the bearer path via
> >tipc_link_xmit() or, when the destination node lives in a sibling networ=
k
> >namespace on the same host (n->peer_net set), to tipc_lxc_xmit(). The be=
arer
> >path returns early on an empty list, but tipc_node_xmit() does not, and
> >tipc_lxc_xmit() dereferences the first buffer without checking:
> >
> >       struct tipc_msg *hdr =3D buf_msg(skb_peek(list));
> >
> >named_distribute() can hand tipc_node_xmit() an empty list. It bails out=
 early
> >when named_prepare_buf() fails its GFP_ATOMIC allocation, leaving the qu=
eue
> >empty, and tipc_named_node_up() then calls tipc_node_xmit() on it
> >unconditionally. On the intra-host container path skb_peek() returns NUL=
L and
> >msg_user() reads through it.
> >
> >The TIPC configuration ops are flagged GENL_UNS_ADMIN_PERM, so an
> >unprivileged user can reach this via
> >unshare(CLONE_NEWUSER|CLONE_NEWNET).
> >
> >  Oops: general protection fault, probably for non-canonical address
> >0xdffffc000000001b
> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >  CPU: 0 Comm: ksoftirqd/0
> >  RIP: 0010:tipc_lxc_xmit (net/tipc/msg.h:202 net/tipc/node.c:1629)
> >  Call Trace:
> >   tipc_node_xmit (net/tipc/node.c:1721)
> >   tipc_named_node_up (net/tipc/name_distr.c:223)
> >   tipc_node_write_unlock (net/tipc/node.c:428)
> >   tipc_rcv (net/tipc/node.c:2189)
> >   tipc_l2_rcv_msg (net/tipc/bearer.c:670)
> >
> >Return early from tipc_node_xmit() when the list is empty.
> >
> >Fixes: f73b12812a3d ("tipc: improve throughput between nodes in netns")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> > net/tipc/node.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/net/tipc/node.c b/net/tipc/node.c index
> >8e4ef2630ae4..cd05269e5335 100644
> >--- a/net/tipc/node.c
> >+++ b/net/tipc/node.c
> >@@ -1695,6 +1695,9 @@ int tipc_node_xmit(struct net *net, struct
> >sk_buff_head *list,
> >       int bearer_id;
> >       int rc;
> >
> >+      if (skb_queue_empty(list))
> >+              return 0;
> >+
>
> Most callers of tipc_node_xmit() prepares=E5=87=86=E5=A4=87 a non-empty l=
ist before calling except tipc_named_node_up().
> So, it is not optimal to add this check in tipc_node_xmit().
> I can see this issue needs to be addressed as part of your existing commi=
t:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260706163024.12059=
30-2-bestswngs@gmail.com/
>
> Please update above patch.
>
> >       if (in_own_node(net, dnode)) {
> >               tipc_loopback_trace(net, list);
> >               spin_lock_init(&list->lock);
> >--
> >2.43.0
> >
>

Thanks for the review. I've updated the patches accordingly. I
accidentally changed the subject line in v3. It should have stayed the
same as v2:

v3: https://lore.kernel.org/all/20260709144718.64535-2-bestswngs@gmail.com/

