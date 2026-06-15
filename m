Return-Path: <netdev+bounces-299572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0eQGCWNPMGrIRAUAu9opvQ
	(envelope-from <netdev+bounces-299572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:15:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E8689675
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:15:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=psWTkrrQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299572-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299572-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D11309A43A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC73AE1B1;
	Mon, 15 Jun 2026 19:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382539023B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:13:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550834; cv=pass; b=gnmbe2NulyV3hV065w9Geq4immI5Z4RLFItbspex5UaH27elBSsLfTwqtnlyz6bVNR6AfiiPAoOHLK4PZDobVnr/qnRdtQy0WWq0xpPJOLcWTgYzc0VG/DxtH7s8pYvEin3cU7zbyn2iV8UsU00ZaU1PK+u1DBSOiv41rIIw4qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550834; c=relaxed/simple;
	bh=FMIy0BWD4uwx4DE9uPt1G90wX8oVWRsQ03tO8n7vnC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iF8Dl/89KW/IeGfT8fG1jYkAiyMPO5Rr+OTg1r3ibUbom1885YNTT3DPDcbDTdq19YljfJ2glhD3zhqnyJOAH8N5J1JsDvBzNwBtAyG6b67rrLdRnvOgh2hiG6YFm8SINf/RGJa3oCDTcKlZEUs9D+v5QkXtMVJcrWpnAFKE9OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psWTkrrQ; arc=pass smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8422f395a4aso2482325b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781550833; cv=none;
        d=google.com; s=arc-20240605;
        b=HLOgjqI9Hl4pgUwZzv180vlEA+/t0FP4zWW7XmCVjj/wG9ApiVhSNr+ALEQ74od1pu
         wjUyr74HVLyFVVGY1zYLhNezEy7md+n20smO0AVx/BOOcqgR3Xkoyi3/JTwJkE9sVJfs
         FIqIImB57r1QWat42moRTTInY5x/CEuYUOAYf/yVU/C+oGEzkVYAlztbS2MNnTe+uRus
         Zf3pgO2qKk8la1skKW7bMo4Zgxc9/WioIfe8e1r4kJ/ivQqa7ysf77oU1Ft1QaxOwgMX
         CA/d8w6yiFAXQM7kl8LfZAPG1T2n5VEhCKawkW/UZmZKj/RoPFvJQn1JpFcecZ+GAujz
         7UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQH+LHgUJKV6XFgUXUv/ZG7j4uae864ywW17BSCZubM=;
        fh=VUGsa/P7auRh8xXXlGRBVYBCk/gj8aM5RbHBAgIc/0U=;
        b=D4fvC0QfCm83gai0fdUtYwET4fqxalCcEZnk5R2qT24BCELIfflxCs3wZMo0y7iYQe
         rE1zfHMB0WAdq0Y26vMCPJVtV3SoW9QF5ynk4Vwr9fnlT4W6WAfsF3oG259QVVxF3mgG
         N+B80lbOPcZgC98W7gwpBDYUo3LCKbHKoo9gJ0w0qfH0p25Tt/Yz/iaApXzXB+rIlFr7
         fLKRrrReneY6kBb7NYNC65+rbf42GvtlMH3FmrNioto+/+GPBosQc9ykkMa8jZ/KM2oa
         nv4K/md7+myoJi1q3PqD96dZZxKL/pU+6pQGxpJJkXnJ/XfqBzivQ1LMtlE8JFYeB4Qm
         Mcyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781550833; x=1782155633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQH+LHgUJKV6XFgUXUv/ZG7j4uae864ywW17BSCZubM=;
        b=psWTkrrQStwCutsnUoKr0GYit8rE/dOxz9s92B0b1Ic9Wle9X8FZqV4hLHpMuEq+TV
         J5/eskn/dNLLCxExzFpaKdjKpTiFK7bLh0P6Cd3ZDkA8kkvewwuMxkqtC9eGIQI68yWB
         4y1QjBmYaTW6w7oWxuIsb39zzbhBDqMMB8L/P66o/mHVE4P5iOTMfBOpPMqllLH9y2JH
         Hwys0vVrTyJalkT8HM5moU8pY47IBAUJOTzbQuue3UAjJqNFTd2ouEHs8yiBXArEk0aS
         g+jMsSKORAdf/6wQ5fK9Az7TEDmTUnaDvMan1Hsb+H5kElGqeo58tS+M6KE0VbEU1dAR
         340Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781550833; x=1782155633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQH+LHgUJKV6XFgUXUv/ZG7j4uae864ywW17BSCZubM=;
        b=Z9BAlCpT2RbdtugENN9kiYTqpQjFtv2OBhP9KU6dWDpS1VyTtvSLl6wueESGzfxmzi
         JAxtUM3GvQO9x5jIXANqzX7TASZKSpudysfhYXv2rn8WxCAOvnXClSyoqXIq6r/baCZs
         OM+F/7Lvc019Z64hnUcvkW5fhGnKKxqbPm3AB+eLSG2j57OoSNLrbvGc4yZVLltnRTPr
         Lr+OtwVivnHHgZE00+2DGVbo1fab0/lLE+pwFPr2igSmLdtHpfhbtOnilVjElzR11rmm
         TIOTXgjSBQjVmYzCjoAPFuwDMfkOBwOjJY0pAw4nqTCL8sDJ650nr9r9r5PL+KyYLmKs
         FAyA==
X-Gm-Message-State: AOJu0YyRIjYodvmCLeh3zQxRpGHSElQIksUx8Ooqlx0oP65YXVOnay8H
	BlZXSwdV3mpVYsg7UBE/aTKrKY31Hsy5eeA8Q6CWu/MVSuIFrNjb/cbeV9USX+DAwu94spOTZLo
	5rS88fdtQiQT0R0ztHkpGbhwsMP+FbHQ=
X-Gm-Gg: Acq92OGbUlznS/1FvVNsnAhiLuOUnL2ssQ6y2+VM0gPhOOPNliD3q6GswwiB4/0CDhb
	tw0lN2mpaqk02IU4WZwOZxgB96TEwTFLzFk7CqsY6Z3zoxCfDxFM9TsR6UfI2Y825AHtz/sRiW4
	i4AYVaoexbmUsJbklwCRCBZZ4kjatcCBOcCQ99yDV/7bW/XIiduXR/TiujjdzojOiZ0+7Ku1+Zk
	g6dhKLQoVaEvNMrdBN4ZkiNjZzCHW/SvSOAA/qiZuXV5bWsBqgMmsbDD9+smkINj4Nh8lNs9x7/
	CIrDTmX3X0jIKVNOlMJfK5IVDT/Q70xwEJ7eauzSi41qIW04M/fduazuYrmZhysl9NtCDSiRkOM
	hacwqQQ==
X-Received: by 2002:a05:6a00:2d28:b0:842:68d3:e2ae with SMTP id
 d2e1a72fcca58-84513e89612mr587232b3a.15.1781550832786; Mon, 15 Jun 2026
 12:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
 <ai0CcdDCkhBO_RF2@1wt.eu>
In-Reply-To: <ai0CcdDCkhBO_RF2@1wt.eu>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 15 Jun 2026 15:13:41 -0400
X-Gm-Features: AVVi8CdklNEKVA42aHgn26YBVXjBqLw1tyWd6IaOgTyW2ZfCWi1hQciX77PBa5U
Message-ID: <CADvbK_dt0ripQmj6JrLDBmdpxZPSOcs1zuuNqJ39AnjjTi1JsA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: hold socket lock when dumping endpoints in sctp_diag
To: Willy Tarreau <w@1wt.eu>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299572-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,trendmicro.com];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:zdi-disclosures@trendmicro.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B1E8689675

On Sat, Jun 13, 2026 at 3:10=E2=80=AFAM Willy Tarreau <w@1wt.eu> wrote:
>
> Hi,
>
> On Fri, Jun 12, 2026 at 01:59:38PM -0400, Xin Long wrote:
> > SCTP_DIAG endpoint dumping currently walks the endpoint hash table
> > without taking the socket lock before calling inet_sctp_diag_fill().
> >
> > This is problematic because inet_sctp_diag_fill() eventually calls
> > inet_diag_msg_sctpladdrs_fill(), which traverses the endpoint's local
> > address list twice: once to count entries for nla_reserve(), and once
> > again to copy the addresses into the netlink buffer.
> >
> > Since these two traversals are protected only by separate RCU read-side
> > critical sections, concurrent socket operations such as
> > SCTP_SOCKOPT_BINDX_REM may remove entries from the address list between
> > them. In that case, the number of copied addresses becomes smaller than
> > the originally reserved buffer size, leaving part of the netlink payloa=
d
> > uninitialized and potentially leaking kernel memory to user space.
> >
> > Fix this by changing sctp_for_each_endpoint() to iterate with net and
> > position awareness while taking a reference on each socket, then releas=
e
> > the endpoint hash bucket read_lock_bh() before invoking the callback.
> >
> > A socket reference is required because the callback acquires lock_sock(=
),
> > which must be called outside of read_lock_bh() since lock_sock() may
> > sleep. Holding a socket reference ensures the socket remains valid afte=
r
> > dropping the bucket lock and before acquiring the socket lock.
> >
> > With the socket lock held, concurrent bind-address modifications are
> > serialized against the diagnostic dump, ensuring the local address list
> > remains stable during buffer sizing and initialization.
> >
> > This also simplifies endpoint traversal by removing the temporary
> > callback local position tracking args[4] and moving dump progress
> > tracking into sctp_for_each_endpoint() itself.
> >
> > While at it, fix the idiag_states check in sctp_ep_dump() and skip ep
> > dumping when non LISTEN|CLOSE states are also requested and the ep has
> > assocs, since such cases will be handled later by sctp_sock_dump().
> >
> > Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
>
> Please note that the original report suggested this reporter:
>
>    Nico Yip (@_cyeaa_) working with TrendAI Zero Day Initiative
>
I could find a public email for Nico Yip (@_cyeaa_), and I will
add this into the changelog as:

    This issue was reported by Nico Yip (@_cyeaa_) working with TrendAI Zer=
o
    Day Initiative.

Thanks.

> > Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  include/net/sctp/sctp.h |  3 +-
> >  net/sctp/diag.c         | 62 +++++++++++++++++++----------------------
> >  net/sctp/socket.c       | 34 +++++++++++++++++-----
> >  3 files changed, 57 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> > index 58242b37b47a..cd82b05354a3 100644
> > --- a/include/net/sctp/sctp.h
> > +++ b/include/net/sctp/sctp.h
> > @@ -111,7 +111,8 @@ int sctp_transport_lookup_process(sctp_callback_t c=
b, struct net *net,
> >                                 const union sctp_addr *paddr, void *p, =
int dif);
> >  int sctp_transport_traverse_process(sctp_callback_t cb, sctp_callback_=
t cb_done,
> >                                   struct net *net, int *pos, void *p);
> > -int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *), =
void *p);
> > +int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
> > +                        struct net *net, int *pos, void *p);
> >  int sctp_get_sctp_info(struct sock *sk, struct sctp_association *asoc,
> >                      struct sctp_info *info);
> >
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index d758f5c3e06e..9108272ca527 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -92,6 +92,7 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_bu=
ff *skb,
> >               if (!--addrcnt)
> >                       break;
> >       }
> > +     WARN_ON_ONCE(addrcnt);
> >       rcu_read_unlock();
> >
> >       return 0;
> > @@ -373,42 +374,36 @@ static int sctp_ep_dump(struct sctp_endpoint *ep,=
 void *p)
> >       struct sk_buff *skb =3D commp->skb;
> >       struct netlink_callback *cb =3D commp->cb;
> >       const struct inet_diag_req_v2 *r =3D commp->r;
> > -     struct net *net =3D sock_net(skb->sk);
> >       struct inet_sock *inet =3D inet_sk(sk);
> >       int err =3D 0;
> >
> > -     if (!net_eq(sock_net(sk), net))
> > +     lock_sock(sk);
> > +     if (sctp_sstate(sk, CLOSED))
> >               goto out;
> >
> > -     if (cb->args[4] < cb->args[1])
> > -             goto next;
> > -
> > -     if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
> > -             goto next;
> > +     if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
> > +         !list_empty(&ep->asocs))
> > +             goto out;
> >
> >       if (r->sdiag_family !=3D AF_UNSPEC &&
> >           sk->sk_family !=3D r->sdiag_family)
> > -             goto next;
> > +             goto out;
> >
> >       if (r->id.idiag_sport !=3D inet->inet_sport &&
> >           r->id.idiag_sport)
> > -             goto next;
> > +             goto out;
> >
> >       if (r->id.idiag_dport !=3D inet->inet_dport &&
> >           r->id.idiag_dport)
> > -             goto next;
> > -
> > -     if (inet_sctp_diag_fill(sk, NULL, skb, r,
> > -                             sk_user_ns(NETLINK_CB(cb->skb).sk),
> > -                             NETLINK_CB(cb->skb).portid,
> > -                             cb->nlh->nlmsg_seq, NLM_F_MULTI,
> > -                             cb->nlh, commp->net_admin) < 0) {
> > -             err =3D 2;
> >               goto out;
> > -     }
> > -next:
> > -     cb->args[4]++;
> > +
> > +     err =3D inet_sctp_diag_fill(sk, NULL, skb, r,
> > +                               sk_user_ns(NETLINK_CB(cb->skb).sk),
> > +                               NETLINK_CB(cb->skb).portid,
> > +                               cb->nlh->nlmsg_seq, NLM_F_MULTI,
> > +                               cb->nlh, commp->net_admin);
> >  out:
> > +     release_sock(sk);
> >       return err;
> >  }
> >
> > @@ -479,41 +474,40 @@ static void sctp_diag_dump(struct sk_buff *skb, s=
truct netlink_callback *cb,
> >               .r =3D r,
> >               .net_admin =3D netlink_net_capable(cb->skb, CAP_NET_ADMIN=
),
> >       };
> > -     int pos =3D cb->args[2];
> > +     int pos;
> >
> >       /* eps hashtable dumps
> >        * args:
> >        * 0 : if it will traversal listen sock
> >        * 1 : to record the sock pos of this time's traversal
> > -      * 4 : to work as a temporary variable to traversal list
> >        */
> >       if (cb->args[0] =3D=3D 0) {
> > -             if (!(idiag_states & TCPF_LISTEN))
> > -                     goto skip;
> > -             if (sctp_for_each_endpoint(sctp_ep_dump, &commp))
> > -                     goto done;
> > -skip:
> > +             if (idiag_states & TCPF_LISTEN) {
> > +                     pos =3D cb->args[1];
> > +                     if (sctp_for_each_endpoint(sctp_ep_dump, net, &po=
s,
> > +                                                &commp)) {
> > +                             cb->args[1] =3D pos;
> > +                             return;
> > +                     }
> > +             }
> >               cb->args[0] =3D 1;
> >               cb->args[1] =3D 0;
> > -             cb->args[4] =3D 0;
> >       }
> >
> > +     if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> > +             return;
> > +
> >       /* asocs by transport hashtable dump
> >        * args:
> >        * 1 : to record the assoc pos of this time's traversal
> >        * 2 : to record the transport pos of this time's traversal
> >        * 3 : to mark if we have dumped the ep info of the current asoc
> >        * 4 : to work as a temporary variable to traversal list
> > -      * 5 : to save the sk we get from travelsing the tsp list.
> >        */
> > -     if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> > -             goto done;
> > -
> > +     pos =3D cb->args[2];
> >       sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
> >                                       net, &pos, &commp);
> >       cb->args[2] =3D pos;
> > -
> > -done:
> >       cb->args[1] =3D cb->args[4];
> >       cb->args[4] =3D 0;
> >  }
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 66e12fb0c646..1ed405dedc01 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -5369,24 +5369,44 @@ struct sctp_transport *sctp_transport_get_idx(s=
truct net *net,
> >  }
> >
> >  int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
> > -                        void *p) {
> > -     int err =3D 0;
> > -     int hash =3D 0;
> > -     struct sctp_endpoint *ep;
> > +                        struct net *net, int *pos, void *p) {
> > +     int err, hash =3D 0, idx =3D 0, start;
> >       struct sctp_hashbucket *head;
> > +     struct sctp_endpoint *ep;
> > +     struct sock *sk;
> >
> >       for (head =3D sctp_ep_hashtable; hash < sctp_ep_hashsize;
> >            hash++, head++) {
> > +             start =3D idx;
> > +again:
> > +             sk =3D NULL;
> >               read_lock_bh(&head->lock);
> >               sctp_for_each_hentry(ep, &head->chain) {
> > -                     err =3D cb(ep, p);
> > -                     if (err)
> > +                     if (sock_net(ep->base.sk) !=3D net)
> > +                             continue;
> > +                     if (idx++ >=3D *pos) {
> > +                             sk =3D ep->base.sk;
> > +                             sock_hold(sk);
> >                               break;
> > +                     }
> >               }
> >               read_unlock_bh(&head->lock);
> > +
> > +             if (sk) {
> > +                     err =3D cb(ep, p);
> > +                     if (err) {
> > +                             sock_put(sk);
> > +                             return err;
> > +                     }
> > +                     sock_put(sk);
> > +                     (*pos)++;
> > +
> > +                     idx =3D start;
> > +                     goto again;
> > +             }
> >       }
> >
> > -     return err;
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(sctp_for_each_endpoint);
> >
> > --
> > 2.47.1

