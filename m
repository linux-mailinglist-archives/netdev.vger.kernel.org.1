Return-Path: <netdev+bounces-304781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JdKwAgRjSmq7CAEAu9opvQ
	(envelope-from <netdev+bounces-304781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 15:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742470A2DA
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 15:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=k2u3TQJb;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304781-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304781-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C61A30086D6
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D237D118;
	Sun,  5 Jul 2026 13:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC01433E99
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 13:58:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259905; cv=pass; b=JNzBe41GiEeDkEq1Iq2b4xWVLCkMSWldd9L1SPqb3QkuPE25Dr3XrDuc1QDusdQGdHCH138Q/idlSMQR88g+ELoU5a8Jez70tigl1W4JVgICH+TrnotrP423wKqatuOZ7akDX3TQfFP2MNiX9idi4Wivq7Fv139mIWJvZsx7lu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259905; c=relaxed/simple;
	bh=taHUh1hHLrd2qSCpsJRGmepsQC4N2+Hw8wpTPedr9wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h25vI54uHriDHh/NVDYBpe7UTR1DjnXf4mLAR9GOachp2RurjnK66gK3/RVpEOGNT25TIIIjt7dpt3igja6OKFcM1fgogQU1ky36Bb+S5ANUM+ObmLFSSonuYMGGqQOIotnNRXdlf1TWH1tvVkWEKWoxIf4xSAvENMGtfmz7G5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2u3TQJb; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c167c58f2so14181311cf.0
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 06:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783259903; cv=none;
        d=google.com; s=arc-20260327;
        b=iZu+1sKGZx79QVV0eRydwgGEnyvnqb5XXTCBrham/+iPs4vSpd+AMrsYI18N2UKS8x
         sHoEc9sTmVosxnDumuyNx8ETQRWtKSb1JaXpA6QS+gCIOWQseQvDADSUGHkcq/7dYFtj
         8A4w6DJcEtpibNbxmPPGNsjEji+Ugn5Op7GBqv5g817O0UYsQXnfdD40BTirHS2m3fAE
         n/LP3eQh7drzVHzgwjVM0bOewbNvJwT+Kfgk8pegHFddOHLJ5xdvmC0PWBwuy/z2yBo1
         XjFTuChriwYJrljoUJtHB4tGXZLAH+vYa/Apkges1haFiXQ47eBYX74aw0h/QX7fv9W/
         Hnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCIPxAb6Gr+1l6MFSudvUjGu8hC5RxOXu/HFF1TmXrQ=;
        fh=FIEFMVnWUk5CzzglZaz5QZJ8e1PWYqCmEpAYP8Fc08I=;
        b=Yk8T/+FYl2ANGA3fkkQaFBO52sGPP1uIsxB0L5jZ63M5sbZPa+O1sIlY9GbMcmehB9
         /WutrSFCMC+mwzpftIharuk4aM+VsHnd6ib9QmZOBBc5dLwcKFvrnAf5Hk1M1uuSgzOS
         OCfkEoIdYlHEUwqOF8ex1ZMG8LPjwck+sKz+7Iu7xuv/wlSBVJCCpmFsJkisCtq5FQyu
         TXeoWasqpE6R4tpnzpVDy0ZT6X106addtNPWdjUvpNff2IoiFgpkYcn4IupFklOjbB3f
         bWxjjGjIBiWYfOiP5eT1g2Kwo5VgiHYtyQISoSajT1zyqrVZkzEXP1uQr/tfy4S1udo5
         H8Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783259903; x=1783864703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCIPxAb6Gr+1l6MFSudvUjGu8hC5RxOXu/HFF1TmXrQ=;
        b=k2u3TQJbGuz28KfN+KxZcUJhPX35bPI7OWMp8N6ik/6kN7JGj58+L0beqwiEl4bW8y
         nc7NXDYn4BZ2Caj60GB89J5CzbTInFQvi53y4tMIhdr4tvvohvJQLcj50i+TSkAnMSFi
         Z1OpNtH0mRvJ5piV+FugKuVsqhDyDMoM5yj9wW36ZYKMfgDF0MorM5DCLXFwhTZ40aOq
         YB68k2p6Of4ou50MqJhRctowdgMAKbzJKRx1HYP5ZDhNV3C9LXB1rdM1lu7mgLTFj/tp
         OvYfb4g5kyMUP+h9NkwxNlaaEDezdAnJCxtzm73+cLzPcHpTSwlL1ctQSDPdhw/Bhitv
         QWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783259903; x=1783864703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCIPxAb6Gr+1l6MFSudvUjGu8hC5RxOXu/HFF1TmXrQ=;
        b=oIu0CpljRc7w/PDIXBuQrjHbrqf4V/nV4L3931ed8JtXD7lVtWuN9qFAhUAB2I1/U9
         pYIGsIhfqMXWUOIDZOuFI9HGi+RQZRVbme/zNaLu0kPL3ewVsGm0SHjrhIjxaQ7GFuRj
         m7+kuoDz7VZeyn/EZ2g+TV8f7KGwXPdzxgaCXA7fCau27dEGinc5uZY9Sr3b7NjqTPsq
         nVLr4sH2b0bxORw16+/gXdTRQ9Xnm8vpGUCCTJfZfh5fgfNX1cUrd6cGQmewsZyPkc2F
         afrA+mORBJws4XV2/4wSsmed+9cKrN3xPtHdh7K+7aPGETVcAMMhTTafd0bhH2OL4uwT
         Y4cQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ADgZslNPxDp9UGxsAWNUsNcqgrrBAAfXdPs84bU2hzDWcqHGp4SOywaQhqckdJdih3zJQ49o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/z3vET6BIzV0JtzN+Pd+ESBdVoLx7y+0MXeoRhq4uvR3E+OGG
	IFz4SgfHK5KAZnfgz0wr3g9B7sezhoqHZYRJ6Afb3b+TvTJx2edb5vFQe317Om3dm3E+emywqnI
	jMBvMUGhDAwD3lRqfg3LsGooAwDVkvkVRPG3cEyqK
X-Gm-Gg: AfdE7clzy+s7A7trDugKsZaQulgxszKkXCOWl6F1NgssMcLLePWkFuIGPmKC7pncokR
	p66vKalt2ZHj/OpWhTZjr2mpfrCMll4XKxmptAAizilTX2pmr5sccSNY8SMBYKRVPs7pSwpg/EV
	udwngEPTlghpobdy0OFI5Ist2VO3D1Tz/02I6M1UzmeixpNklDcdNISHg9LHVfGlp1Wgsxr5H35
	iRRU9Z4xzopsOGcMchJnC9PMur3UfumtoL4T+R1lLgc1+ECq2YcyVTo+s1ja33EkV+IPue4VgWu
	V7w0UqY3KnT9QNb5G6BPtDR1SUKx+gYB3icfgPR69WaFZ/6uim/61lrzYRzizcd9HJ3hsYWBDsh
	GGnmhgsY=
X-Received: by 2002:a05:622a:116:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-51c4c22b38bmr93623561cf.29.1783259902139; Sun, 05 Jul 2026
 06:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704194346.4065071-1-edumazet@google.com> <20260704194346.4065071-3-edumazet@google.com>
 <20260705105349.GA172278@shredder>
In-Reply-To: <20260705105349.GA172278@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jul 2026 06:58:11 -0700
X-Gm-Features: AVVi8CdUAIurNmhj_hWrR4DDPrYEIIOzYvHM2IG7VXFBlZ4TUi6vhY_5RizFN08
Message-ID: <CANn89iL9pWgVXVPEX+9vC6mCS+S7-8E0nGJ7e1cQf7tDNLuA7Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] ipv6: mcast: Fix potential UAF in MLD delayed work
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5742470A2DA

On Sun, Jul 5, 2026 at 3:54=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Sat, Jul 04, 2026 at 07:43:45PM +0000, Eric Dumazet wrote:
> > A race condition exists between device teardown and incoming MLD query
> > processing, leading to a Use-After-Free in the MLD delayed work.
> >
> > During device destruction, the primary reference to inet6_dev is droppe=
d,
> > which can drop its refcount to 0. The actual freeing of inet6_dev memor=
y
> > is deferred via RCU.
> >
> > Concurrently, the packet receive path runs under RCU read lock and obta=
ins
> > the inet6_dev pointer. Because the memory is RCU-protected, CPU-0 can
> > safely dereference inet6_dev even if its refcount has hit 0.
> >
> > However, if CPU-0 calls igmp6_event_query() and schedules delayed work,=
 it
> > attempts to acquire a reference using in6_dev_hold(). This increments t=
he
> > refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
> > Since the inet6_dev memory is still scheduled to be freed after the RCU
> > grace period, the device is freed while the work is still scheduled.
> > When the work runs, it accesses the freed memory, causing a kernel pani=
c.
> >
> > Fix this by using refcount_inc_not_zero() (via a new helper
> > in6_dev_hold_safe()) to prevent acquiring a reference if the device is
> > already being destroyed. If the refcount is 0, we do not schedule the w=
ork.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Eric, thanks for taking care of this!
>
> > ---
> >  include/net/addrconf.h |  5 +++++
> >  net/ipv6/mcast.c       | 38 ++++++++++++++++++++++++++++----------
> >  2 files changed, 33 insertions(+), 10 deletions(-)
>
> [...]
>
> > @@ -1395,6 +1401,7 @@ static void mld_process_v2(struct inet6_dev *idev=
, struct mld2_query *mld,
> >  void igmp6_event_query(struct sk_buff *skb)
> >  {
> >       struct inet6_dev *idev =3D __in6_dev_get(skb->dev);
> > +     bool put =3D false;
> >
> >       if (!idev || idev->dead)
> >               goto out;
> > @@ -1402,11 +1409,16 @@ void igmp6_event_query(struct sk_buff *skb)
> >       spin_lock_bh(&idev->mc_query_lock);
> >       if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS) {
> >               __skb_queue_tail(&idev->mc_query_queue, skb);
>
> Shouldn't we only enqueue the skb if we managed to take a reference?
> Something like [1] (on top of this patch).
>
> If we failed to take a reference, then ipv6_mc_destroy_dev() already ran
> and the queue will not be purged, thereby leaking this skb.
>
> > -             if (!mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
> > -                     in6_dev_hold(idev);
> > +             if (in6_dev_hold_safe(idev)) {
> > +                     if (mod_delayed_work(mld_wq, &idev->mc_query_work=
, 0))
> > +                             put =3D true;
> > +             }
> >               skb =3D NULL;
> >       }
> >       spin_unlock_bh(&idev->mc_query_lock);
> > +
> > +     if (put)
> > +             in6_dev_put(idev);
> >  out:
> >       kfree_skb(skb);
> >  }
> > @@ -1570,6 +1582,7 @@ static void mld_query_work(struct work_struct *wo=
rk)
> >  void igmp6_event_report(struct sk_buff *skb)
> >  {
> >       struct inet6_dev *idev =3D __in6_dev_get(skb->dev);
> > +     bool put =3D false;
> >
> >       if (!idev || idev->dead)
> >               goto out;
> > @@ -1577,11 +1590,16 @@ void igmp6_event_report(struct sk_buff *skb)
> >       spin_lock_bh(&idev->mc_report_lock);
> >       if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS) {
> >               __skb_queue_tail(&idev->mc_report_queue, skb);
>
> Same here
>
> > -             if (!mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
> > -                     in6_dev_hold(idev);
> > +             if (in6_dev_hold_safe(idev)) {
> > +                     if (mod_delayed_work(mld_wq, &idev->mc_report_wor=
k, 0))
> > +                             put =3D true;
> > +             }
> >               skb =3D NULL;
> >       }
> >       spin_unlock_bh(&idev->mc_report_lock);
> > +
> > +     if (put)
> > +             in6_dev_put(idev);
> >  out:
> >       kfree_skb(skb);
> >  }
>
> [1]
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 12d22de6f496..aaba4c2aae23 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -1408,12 +1408,11 @@ void igmp6_event_query(struct sk_buff *skb)
>                 goto out;
>
>         spin_lock_bh(&idev->mc_query_lock);
> -       if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS) {
> +       if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS &&
> +           in6_dev_hold_safe(idev)) {
>                 __skb_queue_tail(&idev->mc_query_queue, skb);
> -               if (in6_dev_hold_safe(idev)) {
> -                       if (mod_delayed_work(mld_wq, &idev->mc_query_work=
, 0))
> -                               put =3D true;
> -               }
> +               if (mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
> +                       put =3D true;
>                 skb =3D NULL;
>         }
>         spin_unlock_bh(&idev->mc_query_lock);
> @@ -1589,12 +1588,11 @@ void igmp6_event_report(struct sk_buff *skb)
>                 goto out;
>
>         spin_lock_bh(&idev->mc_report_lock);
> -       if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS) {
> +       if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS &&
> +           in6_dev_hold_safe(idev)) {
>                 __skb_queue_tail(&idev->mc_report_queue, skb);
> -               if (in6_dev_hold_safe(idev)) {
> -                       if (mod_delayed_work(mld_wq, &idev->mc_report_wor=
k, 0))
> -                               put =3D true;
> -               }
> +               if (mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
> +                       put =3D true;
>                 skb =3D NULL;
>         }
>         spin_unlock_bh(&idev->mc_report_lock);

Great catch, I will include this in V2.

Thanks.

