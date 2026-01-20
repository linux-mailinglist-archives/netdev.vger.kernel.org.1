Return-Path: <netdev+bounces-251526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHqWNCXOb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:49:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7440C49C74
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68069E7643
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570A2580E1;
	Tue, 20 Jan 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+R+UBtl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE631AA99
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923286; cv=pass; b=WpVnQZnLRQ1Pl8qydUSX7aSkQbsHSdnmipU19taypu3b5RTRrYF/bM2Gce+gip9qAoPrqFkC0Rb6HcHildzB1dXvCH32b3hJw2HRNLu+a+4+Y9jITn16prb37nf+HZ9d2rxj5oBVnXeprS+jaHpPEbpQGdLEd/hkrDrTOSZW2aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923286; c=relaxed/simple;
	bh=1yN6HAEO40QcoyUmpcQZqYl18nEWpx0GzR2VbJpP/3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCemAQb+oDEQ7lF3yW+NQk97e9nrzOJQO1Jgb/SzMycqST8PXLNzdTFQn4sxnrdJAMgeFhfmVJXnbe7PHfmgWOZN+oZLv6cG73czEnbI1+74kD0G3PVGYQ5LV6iNKsGnoeIkmUGFlbRvSXyYJHmVRqUuwsIfWAHCpJ75EEhV9Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+R+UBtl; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f4a1a3181so2998366b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:34:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768923284; cv=none;
        d=google.com; s=arc-20240605;
        b=jMBuc31FupgJce6NU8Rqwez7ue7K0W0+S+78GbgCyi+ssKYqFn6G988mfS/lJtbwF6
         dxNuu82F2bGPs7+RHhDfM1MHofygZG3eGotpKwb945clYtU2LsTwqMowLfZiOy74IRmF
         Vd8MxP0QTdTs9dxKSo/nzBPsz3f+in45RlbhTfzCNAJCe2s2VQc2B5HeKG/fCcQMgIM+
         FHmE6yqRl6OeGQZdj7GwxH8ax9T5fON/eK+c+FasHqxy+tiKctAfQtdWTOwIT0Ivro6W
         ZOexEFQqHAexumeTI6ax0FqdkLsEVEmkvKR9+2oY2RRBouEHdjz8KJrmRCBSOZHJZ5Ct
         ZnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2NmNela4GRw6AQkwyD5Rk7RKIpCKu04jdsKYK8kc2M=;
        fh=fDbUfIcx4Ncec9AV4wxOHXS/c8ilfxJ4Jm8OWBj8/eg=;
        b=ThYXx8NdIEkbE653OSd7kRM9hIEK4gxZsvVTIFAP552U3aO8/eXcIHiF9qMPjgEU/w
         TGPJEDzmVOGzAIiyyOQ/kNLBr6hFsKMdZgppS7CMMLBfn7PmgQ6MqjelR6zapXk7jzbV
         LJ7mr/1SdsU+uLc6sPPFEnzOIllrk100FQX+H/dbElWz184Pn3WImvRAej+JZDSyMKlI
         0gvn0ijAX6JgoYDE9c7T0bNGCXTZp/FBV8DMx7T2HwkZM2qxxQdXghM2loNJdPxsVprB
         F049+X8AtA46sed40SJOjVbiH2uwPZDHWVOz5dqfkChHm7KT974TP5oLjPiuovVJ+xSK
         J91w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768923284; x=1769528084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2NmNela4GRw6AQkwyD5Rk7RKIpCKu04jdsKYK8kc2M=;
        b=G+R+UBtlydBQVVO2eq7SJyphEixE7YnJUt9J9M5iJlBf+qydvWP7oHuwlnS199qoZH
         +ziFM3VW84z4V+PaANii7+gTOY8FBSkpXepUGXivvwXMKYazNfRYgonSNJtzX1tBDvx3
         A/rsYc8poIKmv8cgGNgMYdc6iJjSF1Klw9KYvrCo/8jKC84eIgRY5lWlHEQ3/LLIHmqc
         d/P0eBkD/kCgp+knHMoQjYNlA8fLwEXnnJ41BjguPFATNq8IZaVoh4CuXNvAFJAlyBPv
         X/UgFl8Hx/pkxr0H/j5BETIwzENnQ6YRH7yJvbozWisBdTRetyz1h0w+Th2DG3+buuCc
         EEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923284; x=1769528084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2NmNela4GRw6AQkwyD5Rk7RKIpCKu04jdsKYK8kc2M=;
        b=VL86mcin4k3jXY6/ATDrtejT2Y5qxx/H1mgNpm2Mm/LM14vXF1mUDQRnhkKrEfMA7o
         CB5Va4kGEc1hA4uiz4C/5tPPG5PqCK8EZeSLpCWDrt4zbIM55gXDAJiFwULsd6vi0XsE
         aTqI/NWpginGEQfg0i9K8HGlBFNdrXHKkx3AS3HKQy71vmjQyuZCQXSFPL3IUMewNB7H
         6xcYgWtgCrz4rGQj2asJMnX3L5qv57DCB71gf7kSdEeuXQl+FhDS3qAZClIxw0AgwCgk
         zXebnARCmmkBhhElW9X3kiLRAYnuYpcYomm904tta34Rhl/cnlfeYLdLRlV0bXJhCioT
         gVmQ==
X-Gm-Message-State: AOJu0YySJoz44sN1Jahh/3nQpTgH4IiFYcwL3VdEVhNn0jBkKdpXPi7t
	HJavpSG3Ja2W9SzDza10KbtSw1MixSw21F6x3hGQ5GcUAV9OOY2dvMKLT2ld7DCmThbcTN4XEvI
	0s2p9eaqyXrSONIWm4rt8LeJjbLHmGRk=
X-Gm-Gg: AZuq6aINGNeK88HfVT0iPe+foTNd2AJ4DyAXR2YbceyhSzyaeDZ79M2A+6p5Awbx9So
	ZKtivvCKGkCybub/idHpayM6cae2FBaORJLhZ/P0vBAhaNVox2kOZu1CzoB0Xr4tt8JyhKm/xBQ
	8vaLRldjNZJtnoYBhyXeWz2P6w185/RAhp0k11/znBZDKTDj5LpfcBHkLmcIu3C6TAGLPafblpw
	KpBYqlaJzrDzwl2ODeay8btGhhpHvJjr7cZMZPwcPZBArpvkEzObCw4UnN3+YBlXsyoT3YzLLG2
	j+OmI1VZNuXHYAqPbhsbeGwz+JNF
X-Received: by 2002:a05:6a00:138d:b0:81f:9907:e503 with SMTP id
 d2e1a72fcca58-81f9f6ab90emr15585317b3a.16.1768923284205; Tue, 20 Jan 2026
 07:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768489876.git.lucien.xin@gmail.com> <3771dfc211626a9f0c603c90113e38f325ceb456.1768489876.git.lucien.xin@gmail.com>
 <71705484-46fc-469f-9357-07a076ee0e73@redhat.com>
In-Reply-To: <71705484-46fc-469f-9357-07a076ee0e73@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Jan 2026 10:34:32 -0500
X-Gm-Features: AZwV_Qh1cQDFjcFB0vVqm1_VmBk3f4OEQi8_hpHzwrIYtAE_UmESsrIJnbspVXo
Message-ID: <CADvbK_dYbMa-nVi_8M-XS1QcVUw25t4CZdvcq_HcACx38bH86g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/16] quic: add path management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7440C49C74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 9:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/15/26 4:11 PM, Xin Long wrote:
> > @@ -0,0 +1,524 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* QUIC kernel implementation
> > + * (C) Copyright Red Hat Corp. 2023
> > + *
> > + * This file is part of the QUIC kernel implementation
> > + *
> > + * Initialization/cleanup for QUIC protocol support.
> > + *
> > + * Written or modified by:
> > + *    Xin Long <lucien.xin@gmail.com>
> > + */
> > +
> > +#include <net/udp_tunnel.h>
> > +#include <linux/quic.h>
> > +
> > +#include "common.h"
> > +#include "family.h"
> > +#include "path.h"
> > +
> > +static int (*quic_path_rcv)(struct sock *sk, struct sk_buff *skb, u8 e=
rr);
>
> It's unclear why an indirect call is needed here. At least some
> explanation is needed in the commit message, possibly you could call
> directly a static function.
>
This patchset makes the path subcomponent more independent from the core
implementation. Aside from a few shared helper functions, it doesn't
rely on code outside the subcomponent, in particular socket.c and
packet.c.

Other subcomponents, such as stream, connid, pnspace, cong,
crypto, common, and family follow the same approach. They expose
APIs to the core QUIC logic and don=E2=80=99t see the main process.

Will leave an explanation here.

> > +
> > +static int quic_udp_rcv(struct sock *sk, struct sk_buff *skb)
> > +{
> > +     memset(skb->cb, 0, sizeof(skb->cb));
> > +     QUIC_SKB_CB(skb)->seqno =3D -1;
> > +     QUIC_SKB_CB(skb)->time =3D quic_ktime_get_us();
> > +
> > +     skb_pull(skb, sizeof(struct udphdr));
> > +     skb_dst_force(skb);
> > +     quic_path_rcv(sk, skb, 0);
> > +     return 0;
>
> Why not:
>         return quic_path_rcv(sk, skb, 0);
> ?
I checked the udp tunnel users:

- bareudp: bareudp_udp_encap_recv()
- vxlan: vxlan_rcv()
- geneve: geneve_udp_encap_recv()
- tipc: tipc_udp_recv()
- sctp: sctp_udp_rcv()

they all are returning 0 in .encap_udp(), I think because they all
take care of the
skb freeing in their err path already.

is it safe to return error to UDP stack if the skb is already freed?
Do you know?

>
> > +static struct quic_udp_sock *quic_udp_sock_create(struct sock *sk, uni=
on quic_addr *a)
> > +{
> > +     struct udp_tunnel_sock_cfg tuncfg =3D {};
> > +     struct udp_port_cfg udp_conf =3D {};
> > +     struct net *net =3D sock_net(sk);
> > +     struct quic_uhash_head *head;
> > +     struct quic_udp_sock *us;
> > +     struct socket *sock;
> > +
> > +     us =3D kzalloc(sizeof(*us), GFP_KERNEL);
> > +     if (!us)
> > +             return NULL;
> > +
> > +     quic_udp_conf_init(sk, &udp_conf, a);
> > +     if (udp_sock_create(net, &udp_conf, &sock)) {
> > +             pr_debug("%s: failed to create udp sock\n", __func__);
> > +             kfree(us);
> > +             return NULL;
> > +     }
> > +
> > +     tuncfg.encap_type =3D 1;
> > +     tuncfg.encap_rcv =3D quic_udp_rcv;
> > +     tuncfg.encap_err_lookup =3D quic_udp_err;
> > +     setup_udp_tunnel_sock(net, sock, &tuncfg);
> > +
> > +     refcount_set(&us->refcnt, 1);
> > +     us->sk =3D sock->sk;
> > +     memcpy(&us->addr, a, sizeof(*a));
> > +     us->bind_ifindex =3D sk->sk_bound_dev_if;
> > +
> > +     head =3D quic_udp_sock_head(net, ntohs(a->v4.sin_port));
> > +     hlist_add_head(&us->node, &head->head);
> > +     INIT_WORK(&us->work, quic_udp_sock_put_work);
> > +
> > +     return us;
> > +}
> > +
> > +static bool quic_udp_sock_get(struct quic_udp_sock *us)
> > +{
> > +     return refcount_inc_not_zero(&us->refcnt);
> > +}
> > +
> > +static void quic_udp_sock_put(struct quic_udp_sock *us)
> > +{
> > +     if (refcount_dec_and_test(&us->refcnt))
> > +             queue_work(quic_wq, &us->work);
>
> Why using a workqueue here? AFAICS all the caller are in process
> context. Is that to break a possible deadlock due to nested mutex?
> Likely a comment on the refcount/locking scheme would help.
>
quic_udp_sock_put() will also be called in the RX path via
quic_path_unbind() for the connection migration (after changing
to a new path.), which is in the patchset-2.

I will leave a comment for an explanation here.

Thanks.

