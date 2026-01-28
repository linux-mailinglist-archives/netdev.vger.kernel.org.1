Return-Path: <netdev+bounces-254309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGxDD+Ikemlj3QEAu9opvQ
	(envelope-from <netdev+bounces-254309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:01:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF54A36FC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D4230416E5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AD36402C;
	Wed, 28 Jan 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC3tV9df"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABD363C4B
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612199; cv=pass; b=jSfUr4/i8/bzteoLxvUG4DZpF1l9NdZgv/qcV6P2EcGnsfoJT5nm1Z9c8i/EJ6zhoEVbegGpyx/1ay1q9HYJ4OXjsobyR5jOO+FJcc48DiHSCjBz/fbrPby2J0lj8g0RjVqtR36sO4UIYG2tByXOYkLGtSIB3Ep8zJwH5tqzjt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612199; c=relaxed/simple;
	bh=VhnLL87gzkSOpFsdpHCiYbrFbNN15LELbJocs+mDb9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWEFozFNDBWEcsyc77s4okNgBwFwWmBhxu+lHvn4c5cdyUxRIQUqYnevjLGxa1ktXLwzEWeLz7iSFs+xqy0JuIJx80OYoUPpklg2Pfj0QNd6H3ewRxFGnOT7QZw8J5Qav9ZZUNzQRvKtaGTvm64lkzOKeb7zF2RAQSy1RAGDj5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC3tV9df; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790b7b3e594so73251787b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:56:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769612197; cv=none;
        d=google.com; s=arc-20240605;
        b=QsqIi7ZZZZbKon8WkO3gZK3beb0XrQ+zv5DOUHY8fULjPo1pCaxsM1UG+AZMliaP8K
         0syN+DYqNMe/yx0djsSPQ0gWErRQSjLfnClQ8EBFoSbzjQ+/lEaYE4MDMZR64lv4eLxV
         rBQFlo7HeTWtkBsOBCUDcCSk+NOh1CzBBH82d9vSYSLmZKiVXAJFGQbtIQJecy0oLQ5O
         w8P+gwwQtbwaUpUmEMGfVaPt+6nPNJTFHBj4a5m4DCCJYA/CvQW4d/d6bbFHUQB7XG0h
         kb3RE7wrOQprrMFg8ah2Jc8l4LOCKQw67vndcwRJSUcSj4PuVr9TggWMEmE6oSAwztrB
         waLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcegxdXTkZa9VAT+XBWMvALxKkXEciXZIco4sZUYbQ8=;
        fh=GG4ztfOnJk5Cd0c0fAIgQShhcB5h1Jfwa0rV+iWFgh8=;
        b=kpXpdNQ40yBnqZZzY0ogVN54jnhwIU1g2ODgqO/aII91D59r4fYs7slx4/Zv7m4uQu
         wjKUpnVlXBv+yX317uK04qZHi2kWj4y+FeeA+4DxEq8ppWBKklL5CX6meWNNcDhEVQM5
         8B0Q0VrsPfTR+nQ+oN6YZLQvbyoyOCb0yemeGwMDmiaTbsBXdWEgbSghcNKucOzVa/D0
         Rk0ahehJkrOkL9tmm+aLmap3yRcCDhObKeHcjDUI3Pt6poEIDxdIDPVXHugi/NfLm2e1
         f+wQMVWvTc53TR7UmvVP45lp02LL9rPRYqVko0qRyZGW+4xJJFdn/a2KEGY7+9mbH69S
         nwoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769612197; x=1770216997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcegxdXTkZa9VAT+XBWMvALxKkXEciXZIco4sZUYbQ8=;
        b=CC3tV9dfd5N/GSXn91MtTRaWZk7cZubd523+mOaAbkffHbz6tpHniZFhy67iy2WUi6
         HoWywGHXwTb252kUBIx1wL7GbqJF3f43Gax7Esws1tzluvtdJEAKhg7p9NeNsciWS3Ua
         C6+cnwrVdPM/YFFCQHTg7ZNusppxkUfJR33LuZSyP0cd///7IiZJYIHU/DdSeT1TyNeV
         4h7sJiG+qhYVlRxsogjHpbb76AfkWQypC0zYfgNfvouy0gNtbGB1deT0rJcl9kWZHer0
         YjXLQTUne9/BSg/ZucMZ/vKE+dHZcE5Kc6zeIOyNbk5Im05Y/gd91m/pMDCU38FRMD3L
         aNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612197; x=1770216997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcegxdXTkZa9VAT+XBWMvALxKkXEciXZIco4sZUYbQ8=;
        b=M1Igr9hdMWUGohYzlbxw5VvtKyn9DijzfUyNf4+YLaFMWTf/wA+2cZFeLD8VprmVY0
         jhaLeY57XazsQr037BOy+/EHYdVmmIm/reXo2d7a9B81WrzxZcjFlZY22ttVuUfoinrK
         TsHuXjv44GRPAmJOMGS6COlM3Jh+2HmqX0e9j3zIj46r9/A/nZFHlsyYYv1I8xPTGsqY
         8i3CZutmgkif/8SXKrgeU6HndCNAr4VXBD1MzQdsxjpPhh50O1lmkpTor0RdmcI9/3e3
         vCH0x7pN1i3Q/gu5t/N3/iporNgXieB0eCgT/bkKzp3uoVtPGYMP2er+zkJR15LxhIBz
         11wg==
X-Gm-Message-State: AOJu0Yx1S7rcw2vhhrfDUoSSULiCtBKHLLimmSdTmuDpvGr7el7R1KE9
	RAOj8KhhxHNHvEjcMJOUeIVPgcrk6fc+xWZcun/mROdvBkMueEkm7AMBb8MDi1wl4FdidWJWsqL
	5Z6tPqvPYd3xYQz/GpgZOoIrVv1TVyoM=
X-Gm-Gg: AZuq6aJ0GAmDvLDiyMdpwGcQXP56u+xDlSRLQoSdz1Aym9hevjdmb15rI2Ak79BDvbj
	VTFYLO/ajmofeGrWXnST/gEwsX97o+lyC7QIDxtmU1gQ6L9nXVP3f4RvSf0NZc61316oNTOQL/E
	wmeYZq/G39wen/D54XfGKhwIL/ge+B+MzlPI18RU18mQGipT+SA7QGKI4ZpaWy90ObJmH5fIxbs
	pv22fZBNHSWCZV4V9xZBuSYbEDYLWXrRRd8zcbWZnX5ekDhCuUNlTdlnmiZIJwHQjjA7dgpgw==
X-Received: by 2002:a05:690c:680c:b0:794:106b:9984 with SMTP id
 00721157ae682-7947ab51ee8mr45971057b3.18.1769612197276; Wed, 28 Jan 2026
 06:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070311.48892-1-mahdifrmx@gmail.com> <CANn89iKwmhmAOConHjNP7XxVLghaJJgU4gDSH+To8Q1V67Jv0Q@mail.gmail.com>
 <CA+KdSGPvcGrUGeMiguBZ_RcHQjXeik+DgqetWaGNW8aGK3LUZg@mail.gmail.com> <CANn89i+k+dB_9G+gvCpv+_8wWSxp71LxQTdbOZVm7LSugRK5+A@mail.gmail.com>
In-Reply-To: <CANn89i+k+dB_9G+gvCpv+_8wWSxp71LxQTdbOZVm7LSugRK5+A@mail.gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Wed, 28 Jan 2026 18:26:25 +0330
X-Gm-Features: AZwV_Qha4xYXHmrJgv6Kzp7ed1w-U1G18HFYw2aHIJgNA9gTCUGp3UMS3DggnLc
Message-ID: <CA+KdSGO9KV-15mPYkMPmi0bovbGng_ogC=kGXUjWt3-hsQU_qA@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kshitiz.bartariya@zohomail.in
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254309-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,zohomail.in];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAF54A36FC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 4:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jan 28, 2026 at 1:27=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx@gma=
il.com> wrote:
> >
> > On Wed, Jan 28, 2026 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 8:03=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx=
@gmail.com> wrote:
> > > >
> > > > This commit adds SNMP drop count increment for the packets in
> > > > per NUMA queues which were introduced in commit b650bf0977d3
> > > > ("udp: remove busylock and add per NUMA queues"). note that SNMP
> > > > counters are incremented currently by the caller for skb. And
> > > > that these skbs on the intermediate queue cannot be counted
> > > > there so need similar logic in their error path.
> > > >
> > > > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > > > ---
> > > > v6:
> > > >   - increasing a single counter based on socket family
> > > > v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx=
@gmail.com/
> > > >   - check if drop counts are non-zero before increasing countrers
> > > > v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx=
@gmail.com/
> > > >   - move all changes to unlikely(to_drop) branch
> > > > v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrm=
x@gmail.com/
> > > >   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> > > > v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx=
@gmail.com/
> > > >   - change ENOMEM to ENOBUFS
> > > > v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrm=
x@gmail.com/
> > > > ---
> > > >  net/ipv4/udp.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index ffe074cb5..dd302f5fb 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -1797,10 +1797,13 @@ int __udp_enqueue_schedule_skb(struct sock =
*sk, struct sk_buff *skb)
> > > >                         skb =3D to_drop;
> > > >                         to_drop =3D skb->next;
> > > >                         skb_mark_not_on_list(skb);
> > > > -                       /* TODO: update SNMP values. */
> > > >                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON=
_PROTO_MEM);
> > > >                 }
> > > >                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> > > > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D=
 PF_INET)),
> > > > +                              UDP_MIB_MEMERRORS, nb);
> > > > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D=
 PF_INET)),
> > > > +                              UDP_MIB_INERRORS, nb);
> > > >         }
> > >
> > > Hmm.. I have not followed your prior attempts, sorry for coming late.
> > >
> > > Note that an UDP AF_INET6 socket for which ipv6_only_sock(sk) is fals=
e
> > > can receive
> > > IPv4 and IPv6 UDP packets, if bound to any addresses.
> > >
> > > The to_drop list could contain a mix of IPv4 and IPv6 packets.
> > >
> > > Ideally we should track SNMP values in the proper space (Ipv4 , IPv6)=
.
> > >
> > > See IPV6_V6ONLY and /proc/sys/net/ipv6/bindv6only for reference.
> > This is the exact discussion I had with Willem de Bruijn:
> > https://lore.kernel.org/netdev/willemdebruijn.kernel.17f36003699cb@gmai=
l.com/
>
> I think Willem was wrong :)
>
> __udp_enqueue_schedule_skb() is called either from
> __udp_queue_rcv_skb() for IPv4 packets,
> or __udpv6_queue_rcv_skb() for IPv6 packets, and they both can feed
> packets to a single and shared UDP socket.
>
> An IPv4 packet will not go through __udpv6_queue_rcv_skb().
>
> It would be deceptive to increment IPV6 UDP counters if a host only
> receives IPv4 UDP packets.
Ok, in case other people wonder which logic is in fact true, refer to
net/core/dev.c in which
netif_receive_skb is defined that's called from device drivers. This
routine checks the packet
against a list of struct packet_types, ultimately finding the matched
type and calling its
registered func field, that are ip_rcv & ip6_rcv in case of the two
ipv4 & ipv6 types. So, the
appropriate routine is chosen based on packet type, not socket family.

That being said, I think the previous patch was just fine, unless
Willem wants the newline
after variable declarations:
https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@gmail.com/

