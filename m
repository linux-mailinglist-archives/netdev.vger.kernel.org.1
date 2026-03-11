Return-Path: <netdev+bounces-266696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGP0EeOWsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:22:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3AD26741A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 859423001BD4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685D238159;
	Wed, 11 Mar 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yFgxRSI/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96E31E82D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246176; cv=pass; b=EH/0ZYqtpsGvM3P+wKM3g7uuIjdIesBFsBhVGBnFsiNmjKSf5x1S5i32EKDA5q1DSz24ADipVDsg4j6JfSPOeq3ZOhjG3oF+n5U40LQ9dMcYZOmuwCFudROh6gMpFnzrBBXGc7Uuxr04KOW1tYd9Nar9Ru+xdU7uK3B5JkcEQEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246176; c=relaxed/simple;
	bh=/8jX/0nXFpkyhyrW+LSOBtcRnALE1ajFmbVXm3b0yVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLavDB25eKpXNRf77JxC7T9Qo78hxglfz51R9HjlAypPKIoVBl30MGYN2+FCFDgbUqQgT1AGvzpM1NXDt8HWS+96g/j7voo3ddboH+mfijPsdOC+UrYuxyyox5juFRw4er3GrLl6DnsR2UVQ4fYtYWE/qFNr+o89OlMvEhj2+wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=yFgxRSI/; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829ac4670c4so76041b3a.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246173; cv=none;
        d=google.com; s=arc-20240605;
        b=CSJbE18t3ydZNCPyxiaeXjpydi/vtQR0Yr3ZPrRXtvmu3S+jba+6wCrdVxYrX8A7FS
         Xp9QJB/e/7sXOsH/7S6q0sWyvzjnqm45DAKiINFjVQdwGUfXAFCh+DUPy83gY8w7y+Ey
         5iCBjCE3bA+eDhY+yMl5CGn9BFimedqoFMic7ZtSUhr4QKOHNgZvD/sa9wYCr/dOocwD
         LUSc+8SZqol61WF+bGst+tgv5h93N1StAkppdZnn7wXUTuNtLdvqDsTAImug0PYUACw3
         Dlu9XDQybPgSyFnkCAqhM9lrpECZSUh1oUsdCNslWKhrqmQsJNwYzpYP9lSVT1mPVgpB
         Nh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfY7z/mH1QCzKBvw7XY9whOUf9+5X6AiAqhhH3gD6M4=;
        fh=Mp2hs9P3BP/QKqpP8CsYi+NLBnHRzFu06/7QBJ/Qy/k=;
        b=SusuDhns7gVUTDKfCaNxyNYyg5Pivd7OUoN7RweWJE1jNIOCK4oMJBz98AEn5Xido/
         NVdrEV8ecK6UJF4UjeA9aDyPhGlQ7XlYC8XhJ2yMOxYEGfvfvXQA/jcGh8IA56Q7y2j/
         oxiTH3LUPbvUtzyJ5Ba9MXtj9TSFPGYmFqCJ4L2AKN4617FViZRCsjxKVvVw3jUVOlTb
         7KDN6r5NnAwQu1osppiPh6niBnFsLZ3QdZhmy8wXPumJalNJmbGSda/lLvCdJ6IC7OtX
         0XCtRKthfK2xUj5klfwJ7/bUKwWdv+Miq/SsjLEjKY8ZI6Hj/6h20MiqxovyyigNXQyV
         c4cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773246173; x=1773850973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfY7z/mH1QCzKBvw7XY9whOUf9+5X6AiAqhhH3gD6M4=;
        b=yFgxRSI/Zh6RIo4oRK2m59I1tVQFN3wpCh7/78HRUTkRQcFJHz1Krl52pltuaAfoJm
         zHBspXvHVt9uOVXy5AvbLLFy2tMgPOmlnDjCKawLT4D5b52rq2dvy/djjKszB7VTWF4o
         4jJWNMatb7YoUGHnwbdlFBz2Ff5HxySx639j57WalC7zam31UkDnLt9NtZ+HCU4TwC4q
         IJSYFhKgtzZ1Q3Sqxx8tnCuRaXuQqA5IjhBWicIja4E0WfV+8ujLjudWTylkbEJRI7Qi
         TYHUdRkuxgvGT3mft8Yc2qb3f6BP1xHB/VV/q6Kg+3oCXsOj7PhuuNRV6LjTQcdlLcDP
         0Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246173; x=1773850973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfY7z/mH1QCzKBvw7XY9whOUf9+5X6AiAqhhH3gD6M4=;
        b=GYfY5D2OJvqQqzZ02RXMK7C0ai/KP+pyxuOLzC63EarFXk4c4P6rM3FfC+iFdWd34h
         StozyL+62lTB9AyILa4ZdyV8Ecne/E2+QWAoAzM4vX7H17UThACAJzwzdZOgBR9xqIz0
         I0NcdtCfFILzKostHXAMpG8Eyo08TvvWInjI3YG8z2imLB4i5VOYfZ00XXAuTx1ecH9L
         oYoOEKEaWzMVqGQnQFykwi2GfRCv5FsMWgjkm+UZ+kMGljsh4S4JZPRuE+EkWuwGaGPV
         CC1g7vwwnCQwSLfSjrXy6GRwPCUXqw6IIwZO/P9Yw1HT1zPGbZC23hI9sARNTzJa8nN2
         nN0Q==
X-Gm-Message-State: AOJu0YyBqcYuJNi4x1Dbu20pN5H/39NZzeePHHiiUJJhYJpb0pFEbS72
	mn7aBXi5/W++0tDCSFH4kW0oIf9thcW8In56YqsAtaGm8aVQku5fKDcXscoxR/CwbgwGuS8ys70
	2tBPdzUUHo0G+MSS4jNXgc2GnQyClPXSWZ5msVcY4b5lYUww7ImA=
X-Gm-Gg: ATEYQzx+MasnsEhHrVwjEm6ihUZlhpAhCX+eRj40mh+ajOVM1TPegQRecSt9xgXTKk/
	823Imub2fHKruF252ER+t0+Z83lLYRO4NpJi5yBgrLMMGeG6hwLspnLa5tn4y8Keo6//p2X0XQF
	hVmrd9EtcVZGm7NLPy7UdU4qILmczKSmsPUoFiGtZ0IUvb4yUPxgm2pxPgb6KU0vPRuNB2vBCqJ
	YHb0D0w7ptO6GH/3dT8COWBlVi2Eg1oBFbpkhROPQNM4SkTbzA2YxnKJzChy9f7GExyGv9HvUO9
	9NOPTOl8NDq9QVphOfNmdYZhuw==
X-Received: by 2002:a05:6a00:7603:b0:829:9a7b:db84 with SMTP id
 d2e1a72fcca58-829f715d0c1mr2313680b3a.49.1773246172868; Wed, 11 Mar 2026
 09:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
In-Reply-To: <20260310184713.7e810431@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 11 Mar 2026 12:22:41 -0400
X-Gm-Features: AaiRm52amjkmnAH6dCMjUuecqHixg9RGz4S-GvYmjS08m4Y_7VN4P7VgDYfbo_8
Message-ID: <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266696-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8F3AD26741A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 9:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat,  7 Mar 2026 16:20:58 -0500 Jamal Hadi Salim wrote:
> > Note: We tried a couple of different approaches that had smaller code
> > footprint but were a bit fugly. The first approach was to use recursion
> > on the qdisc hash table to iterate the descendants of the qdisc; howeve=
r,
> > the challenge here is if the graph depth is "high" - we may overflow th=
e
> > stack. The second approach was to use a breadth first search to achieve
> > the same goal; the challenge here was it was a quadratic algorithm.
>
> Lots of complexity when realistically only ingress/clsact support
> the unlocked operations. Can we not just take rtnl before the
> references and not bother all the real qdiscs with this @#%$ ?
> (diff just to illustrate the point not even compiled)
>

Two of the several (I think 4!) patches we had took a similar path. I
am trying to remember at least one variant was bad for performance and
the other was unstable. Let's see if we can revive it and take a
closer look. BTW - none were pretty, it was maybe half the lines of
code but touched many things.

cheers,
jamal

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4829c27446e3..21b461f3323d 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2255,6 +2255,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>         int err;
>         int tp_created;
>         bool rtnl_held =3D false;
> +       bool rtnl_take =3D false
>         u32 flags;
>
>  replay:
> @@ -2290,11 +2291,17 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>                 }
>         }
>
> +       /* Realistically only INGRESS supports unlocked ops */
> +       if (parent !=3D TC_H_INGRESS) {
> +               rtnl_held =3D true;
> +               rtnl_lock();
> +       }
> +
>         /* Find head of filter chain. */
>
>         err =3D __tcf_qdisc_find(net, &q, &parent, t->tcm_ifindex, false,=
 extack);
>         if (err)
> -               return err;
> +               goto errout;
>
>         if (tcf_proto_check_kind(tca[TCA_KIND], name)) {
>                 NL_SET_ERR_MSG(extack, "Specified TC filter name too long=
");
> @@ -2306,11 +2313,12 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>          * block is shared (no qdisc found), qdisc is not unlocked, class=
ifier
>          * type is not specified, classifier is not unlocked.
>          */
> -       if (rtnl_held ||
> +       if (rtnl_take ||
>             (q && !(q->ops->cl_ops->flags & QDISC_CLASS_OPS_DOIT_UNLOCKED=
)) ||
>             !tcf_proto_is_unlocked(name)) {
> +               if (!rtnl_held)
> +                       rtnl_lock();
>                 rtnl_held =3D true;
> -               rtnl_lock();
>         }
>
>         err =3D __tcf_qdisc_cl_find(q, parent, &cl, t->tcm_ifindex, extac=
k);
> @@ -2451,17 +2459,16 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>         }
>         tcf_block_release(q, block, rtnl_held);
>
> -       if (rtnl_held)
> -               rtnl_unlock();
> -
>         if (err =3D=3D -EAGAIN) {
>                 /* Take rtnl lock in case EAGAIN is caused by concurrent =
flush
>                  * of target chain.
>                  */
> -               rtnl_held =3D true;
> +               rtnl_take =3D true;
>                 /* Replay the request. */
>                 goto replay;
>         }
> +       if (rtnl_held)
> +               rtnl_unlock();
>         return err;
>
>  errout_locked:

