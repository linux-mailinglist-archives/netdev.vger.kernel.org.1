Return-Path: <netdev+bounces-284020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNvXGnLz+GkD3gIAu9opvQ
	(envelope-from <netdev+bounces-284020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B39284C33E3
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38905310F825
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291B3EF65F;
	Mon,  4 May 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="OY64UWml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64103EF649
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922024; cv=pass; b=Qw8wiszUcPDpPoUVebixOA5o0W6apcDzp2loQBd8YuiVZzoIuEgJcafTMVSxf3aXdN1eOFW9cYdPB8NwT8AQ7p7NIUpcJ00g0++R6omE9Yq+3pZ8A9ZoAzsuYP9StLJpSbRsIue7DFxH5j86fR+DwPAyZNIW/TiH1fPziRq5Oy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922024; c=relaxed/simple;
	bh=WQ7BlD6SD690XYItBp7SAo20zSQkk4a1yXKm5luYeKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqa5nwbTX5Oy/bTBb9HQuRXXdj1Z8Ms1dd2WJnFLQncFF+NGeVv4txXRnOVk0Jhst0P0ZT2VPPX1Z+mJ6E5iSB2Bst8VgOdEdxGArE+AoIQXg9NKe338b4APQht3QDY84zQUiLcg29LE/n6r77lRcba/uf85lgHHefvJRHrljNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=OY64UWml; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso3424931b3a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777922022; cv=none;
        d=google.com; s=arc-20240605;
        b=gDkfK5pWLdgpI0FcmagfSZkI7hSjkNQ18L/o7ibMP8LiDFcpK4KB88RCINCOokX7q4
         qS2vLCUX+hnMaqsMa0fsDHe6bZDr0NZf4p2GqUSXnh/CQfLgja7oovmCz7WgWYoT7f0u
         XTV75FmWUdmlONYK2/ug71rKEJ1KNqZvdLlny4AWOiT5Wdat9atGkGjKULdh4jXOKMic
         3vTLFk/be+CdtLk5I1boLNSYCX6rjprV+gyPT90y+17Lkk89EZA8EDPITXZ5SQ+5XBKj
         kh0RXMD+BlSx9K+KXoj8NNGmPY4qRVq2HXzD6+oexLzEy+k/eTZ4hT8TS6Mw4I8MhvC+
         KWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1diiQI7bFIoxd9pRIivot0UUi9jXrex+yi6sqsnQmE=;
        fh=HKhZnIal74SxUJwjuqW3+Wk29eFT/Ya9NQUhpT/X5y8=;
        b=kLs5EmFsG0KhwcS5seY4XqXLle5wYl5Otf+GLV0ZapH/byM3o1dVfQrlUgY5x7V+Tj
         neaZmn4XTUl1VEuNOpuXxVVTxQO9Tmxi5ghaWJZ8fSLcBMR4LSOZ7fliTHe0GsaOcdt5
         HIzVbT9SewUXt9snfVgr+f2+nmh2ArZB1hTAJXb2Zgf+JEHbpc7hQY4J7c3HXtH2PqKn
         z39vLZFm9SRAZAC5Zs6f4ezve91fCSiXTUgRLPjVmuBGI4s+YHOlaRkEe4yExPF2Olp8
         ZW8s+0d/L6gesC9l6xT8Z5+R3NVtSy/D7iw3rmIFCsTqcSabwkVg7FIUnqbrfNBL4IkN
         nr7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777922022; x=1778526822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1diiQI7bFIoxd9pRIivot0UUi9jXrex+yi6sqsnQmE=;
        b=OY64UWmlbfjZU4hohihPBE8ECkIzcWhg2ixYUuvDcOwKz0oHfWO7pDehfEkFm9gUXR
         iYeaWC7tRIfn4Oza/PkfoiRMi+uH0+7Muv8KQXcwZIibZUxD/m1MsDyCU2DxlM3wAEEZ
         2Lc82bEgLKNPXG6wFqRLjG/FNVfacozozEPv2799LW8yLW5wbGNsVICUZBTiC1tqfdVR
         eSCOMQPN2859+D2n8YFGlBNMYxl1+buefcVV9UHbsQ5ui2VpD5e1XHn8P43JjCqKHpGg
         fy6Y9WjONXD9q61NkvO1VstMjVtERJ3rvNZ/guEayzsWEgzZb2XIOAfIpDLnjkwCGJkQ
         XS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922022; x=1778526822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1diiQI7bFIoxd9pRIivot0UUi9jXrex+yi6sqsnQmE=;
        b=hetS6GiCyxT1vr8dO0MFQqLPixbYpVlzLsyRipOK+NMNoxFKIScCOSq8BtGML33+2O
         xeCNJLiKq5KFRlg7UDZRFZYQkapBEUavAj2vj/ucv54uLRquqm05Yk+0SDWTMp0iRMeV
         LAbgkO5xjkfI3f3N9+472D6HZzGOVXmzHpUkfEaiWaCv0RNf4vtVO6h7F151VHsrGymL
         x5UtG/htD3F7ZE3vnF+lHX1NILkroRRJ6LhkGg9APGiL8W/BYpFViYWgZMeUwvSSGPNX
         j+mBCSc+nukFGoaWycg+8LObW/gs7WtWTNJPZ3zSmMp4iqT985u0kmKnfEk32U5CLlR0
         zc5g==
X-Forwarded-Encrypted: i=1; AFNElJ+wksGnQwREnqETFeCFiwg1nr6kceN5gb/Z47vUviuiHe7ds8Z8kF7AN4ufbC5tp/rrvPa77yU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0/B8cqTZgKCPPkozqFys5wTUTciU1Ofn4Ztlo3E+ArnzpuHU
	kV3CnPYWn8If3QmKdygc9HcbH4dEZ/wPKgZxb7sNd5+Evp8DyBzGq+yT5c4p8yUQOkUIdcbVgxf
	6VU7/1VeRZrMxcv1ZgxOcn5J3gU/uWAc8mCpTNmzi
X-Gm-Gg: AeBDietNiAcfAj1zTW1TDaUC6cbzUDolDQmwDy+wDpsqOgJuBdS+VWo0ymHuyqLnIMr
	PSO4r9yd/02AXZ83fA2jPJqVCLE/EtExrH0Ji6jd10iab8ICPpJf1FUHA9EX5QIgFxblbJFMmLZ
	6SteJ+ttO8IF7jiMinsbJzeFF4gAtQvv61kBzociMOvmGwlVzy/WdZ2S1ou973EPy2Htcl6pe8R
	NypIFwBUTGIbXNAzGontUJo6R5i8jjSe+/OyeC3tqrhfaDuR6P2pP7CQSHmTJDqt166zaK+3iQF
	572uIHLHsRreqGP4JnPvkBECI2Aphg==
X-Received: by 2002:a05:6a00:2351:b0:837:27f4:ffe5 with SMTP id
 d2e1a72fcca58-83727f50a70mr5773113b3a.19.1777922022191; Mon, 04 May 2026
 12:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503114515.2460477-1-edumazet@google.com>
In-Reply-To: <20260503114515.2460477-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 May 2026 15:13:30 -0400
X-Gm-Features: AVHnY4I8Yaj5eI9NcpUPR_KnsSdUwpNtXIMZOyJMb4pzJrZxJ5-xQcmRlrJY4n8
Message-ID: <CAM0EoMkH-7jjV3Z=74yF4ZKbPsw5JCJo1RRjnt3fEVvzgNbRSg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: speedup tc_dump_qdisc() when
 tcm_handle is provided
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B39284C33E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284020-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]

On Sun, May 3, 2026 at 7:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> "tc qdisc show ... handle xxx" filtering can be done by the kernel.
>
> A followup patch can do the same for tcm_parent.
>
> iproute2/tc needs a small companion patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

If you ever redo this for whatever reason, showing the dump of before
and after will be good documentation.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_api.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index dd0edc9bd4610ec865fc97a81f801a7da020667b..6f7847c5536f16e6754954f0a=
606581e17257361 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -979,13 +979,17 @@ static int tc_fill_qdisc(struct sk_buff *skb, struc=
t Qdisc *q, u32 clid,
>         return -EMSGSIZE;
>  }
>
> -static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
> +static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible,
> +                                const struct tcmsg *tcm)
>  {
>         if (q->flags & TCQ_F_BUILTIN)
>                 return true;
>         if ((q->flags & TCQ_F_INVISIBLE) && !dump_invisible)
>                 return true;
> -
> +       if (tcm) {
> +               if (tcm->tcm_handle && tcm->tcm_handle !=3D q->handle)
> +                       return true;
> +       }
>         return false;
>  }
>
> @@ -1000,7 +1004,7 @@ static int qdisc_get_notify(struct net *net, struct=
 sk_buff *oskb,
>         if (!skb)
>                 return -ENOBUFS;
>
> -       if (!tc_qdisc_dump_ignore(q, false)) {
> +       if (!tc_qdisc_dump_ignore(q, false, NULL)) {
>                 if (tc_fill_qdisc(skb, q, clid, portid, n->nlmsg_seq, 0,
>                                   RTM_NEWQDISC, extack) < 0)
>                         goto err_out;
> @@ -1030,12 +1034,12 @@ static int qdisc_notify(struct net *net, struct s=
k_buff *oskb,
>         if (!skb)
>                 return -ENOBUFS;
>
> -       if (old && !tc_qdisc_dump_ignore(old, false)) {
> +       if (old && !tc_qdisc_dump_ignore(old, false, NULL)) {
>                 if (tc_fill_qdisc(skb, old, clid, portid, n->nlmsg_seq,
>                                   0, RTM_DELQDISC, extack) < 0)
>                         goto err_out;
>         }
> -       if (new && !tc_qdisc_dump_ignore(new, false)) {
> +       if (new && !tc_qdisc_dump_ignore(new, false, NULL)) {
>                 if (tc_fill_qdisc(skb, new, clid, portid, n->nlmsg_seq,
>                                   old ? NLM_F_REPLACE : 0, RTM_NEWQDISC, =
extack) < 0)
>                         goto err_out;
> @@ -1825,21 +1829,24 @@ static int tc_dump_qdisc_root(struct Qdisc *root,=
 struct sk_buff *skb,
>                               int *q_idx_p, int s_q_idx, bool recur,
>                               bool dump_invisible)
>  {
> +       const struct nlmsghdr *nlh =3D cb->nlh;
>         int ret =3D 0, q_idx =3D *q_idx_p;
> +       const struct tcmsg *tcm;
>         struct Qdisc *q;
>         int b;
>
>         if (!root)
>                 return 0;
>
> +       tcm =3D nlmsg_data(nlh);
>         q =3D root;
>         if (q_idx < s_q_idx) {
>                 q_idx++;
>         } else {
> -               if (!tc_qdisc_dump_ignore(q, dump_invisible))
> +               if (!tc_qdisc_dump_ignore(q, dump_invisible, tcm))
>                     ret =3D tc_fill_qdisc(skb, q, q->parent,
>                                         NETLINK_CB(cb->skb).portid,
> -                                       cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +                                       nlh->nlmsg_seq, NLM_F_MULTI,
>                                         RTM_NEWQDISC, NULL);
>                 if (ret < 0)
>                         goto out;
> @@ -1860,10 +1867,10 @@ static int tc_dump_qdisc_root(struct Qdisc *root,=
 struct sk_buff *skb,
>                         q_idx++;
>                         continue;
>                 }
> -               if (!tc_qdisc_dump_ignore(q, dump_invisible))
> +               if (!tc_qdisc_dump_ignore(q, dump_invisible, tcm))
>                         ret =3D tc_fill_qdisc(skb, q, q->parent,
>                                             NETLINK_CB(cb->skb).portid,
> -                                           cb->nlh->nlmsg_seq, NLM_F_MUL=
TI,
> +                                           nlh->nlmsg_seq, NLM_F_MULTI,
>                                             RTM_NEWQDISC, NULL);
>                 if (ret < 0)
>                         goto out;
> @@ -2341,7 +2348,7 @@ static int tc_dump_tclass_qdisc(struct Qdisc *q, st=
ruct sk_buff *skb,
>  {
>         struct qdisc_dump_args arg;
>
> -       if (tc_qdisc_dump_ignore(q, false) ||
> +       if (tc_qdisc_dump_ignore(q, false, NULL) ||
>             *t_p < s_t || !q->ops->cl_ops ||
>             (tcm->tcm_parent &&
>              TC_H_MAJ(tcm->tcm_parent) !=3D q->handle)) {
> --
> 2.54.0.545.g6539524ca2-goog
>

