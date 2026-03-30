Return-Path: <netdev+bounces-273259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJIICkihymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B135E8B9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D47D63068058
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A837754C;
	Mon, 30 Mar 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rfJBQrA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253E377031
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886704; cv=pass; b=uEGOqjHT5N486XtsFXbE5Z0SNWA2gNVV5S8fRQoGFKmhT4sGQkuhxXRg0XiKeczGAsVjvxpdTNzC3o9lKbmL33XnXFagWwXOb7msEbo0otkwhV+bdLzqK5B94wMS388q8312hsA9hSbyzUNr5gy3pr8xmAyII/qOEQy0aY4B7kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886704; c=relaxed/simple;
	bh=yD5WNY57sl0Hu167Bd0mIuYylVQGI9Q6JpwQ+zdqvKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZSQDyqpFuoJ/bk4AlCdgczpXsWKnLjg7ZiQf+QqnZ9MpRwpdpyQQbeijFG2XBAIebmsMCxuLN+AL9rgqia4Q2QSCisLMHl69Cui8fBQJJB74v/fbYVJSTjbIkuszNrDdxtnJYQMstUbWWkej1uW6Qf785HYZetCK3E+eJjceAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rfJBQrA2; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a9d08644so2449668b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774886703; cv=none;
        d=google.com; s=arc-20240605;
        b=kw/TgD/+r4xkkAMukGwyBOZ7Sz5Z6fmKU5iIbQ2o+LHk2j2Nro49IXYtqmYzLIgPth
         1Yp2/Mi9BTMuxG1ii6hUz1sdwzEzupA20993e3zc0TMzvbLC4n9v96E5ptRI/okzpMQq
         VZGMVv2mu+Y5plNsGVAXH0DZ6/z7gZ3S4D27F4Cq4dEAsEe4JHyhWlB0U9DmI2aMgsEl
         HHixVn0tj57+Rfq0vtVIbWsaHoMFyRSdEDxXSgPC9t1AbU1mQce2h+HT37pMkI8T4j75
         Hg14WKxH7RfUvGuru4lWDxOK9ZLP6rgOEE6izMwz5uelTRbgTJP2MFG59DLlLPNJoskP
         FHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZwWEc5Kclv1nlXPkFE0bGZ81BqiisRa6te9kYDtGwlg=;
        fh=eGhqYjJSCo7m5oEldZF+wxi6aJtnT0A8E2sA5uFmuv4=;
        b=Hd4IDZCB4MbQW8iBbNQoqRp2+DqQEbAj1lh/SQuo1xvlEREGcFlQyiH7Jd+gwMWJ1U
         cHodpmZURS3qSh93qkiqZHGQWB8RZwBLj1WYbyjZQ1XaQu06LYrGpst9MD4MzvEDLLHN
         roa51QJJoMheeuU53Bjuxd71qDXNj7QLNwNssDbSMBfiNXHze97IzwnGRchhposWN9Qh
         MUl8UDFPuqz5jdlJyTLZ1QzBUonjdi4+jRERvsorOhMVCRrgWdg5NafRuRz7PuEi0WEH
         YfoiareG1rawibD3HM0rh4jXV9AWZZQIgxAaep+aKY/0vuA93EuP58NoHiGzk+BNpbCc
         ssmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774886703; x=1775491503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwWEc5Kclv1nlXPkFE0bGZ81BqiisRa6te9kYDtGwlg=;
        b=rfJBQrA2AWeAlb3yny5IeU3mRLPqjQrpEekxElFfrfwCL8dNN6i/Exp8GLP+ZMvP4M
         EpRMJHi04I/iwKQVL+7OVridUFMVkmFLhvMYnx2FkhbG94TLu4DAeNBOx1vDPSEWA3YO
         X30wYELbehRFWQoyX68aikkaalAHD1esgQ3sqDyHHATyBug0VJ5g2njye8IGuRLWJ0hG
         sYgj1PqPF4uk7u1S/hIv/6kJ26138N1/JXLh4wpMfjnkyloq4BDsapsqifKdzTN8uYFl
         2Isr0ZjnfJUIsckOGMzfIH5VR/2l3qfsu6bh/F/+DZj1AJ/nmooQEh4DATFMfgVeVR7g
         FJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774886703; x=1775491503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZwWEc5Kclv1nlXPkFE0bGZ81BqiisRa6te9kYDtGwlg=;
        b=G9x/ZnXc/BKPm0zu9/vkJalKSTZGJYOr43d/MppowvQBiPhx07bnowBWmwPzZyO6ej
         tqaPVbyzSNSCPC99c3l4Ydf6MTPvGaDJ9/oa1cJ1vn1272fLzYXPsWgyLniRN/LJtIhG
         9fiQN/F+WIUQl0HUAKtknNxXL9n49PRaoJucHiEKFqEbI2iLzBpVdGv92XaQ47bu7I0O
         eZOik/xkAcMLrlBENcaF+EKprjnM8mzjVUtcckcpEKOn+3X66TRkEE1qYRCzQbrYO2V7
         fd8Kpj/exvvHhc6OjreRsGbnCrfgg3W1yVWWb3IJivKfx/f9opHUtfet/+mK4T8paBU4
         03zg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ETTI5MA1WM2znIU0sG1lQ+m64KQKcAdvmeKE6L1VvHTe+cDfump3X5H5YOXS438qrcxiRvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtpFteZmRvk6k3GDIlfECQqULxJJkfP7/nO2LdO/qPn/qXMXd
	wXgFYD8TUj8nP0H+B5vI5T06U8G0sMUfd6l8sbmut2RY/M3mx3qDBgJhmez1p6G9HHx2PCkBsx2
	1Ffm0KBPBFde2umfGHjOB46G8QwK/zbSN5WH59BtaxUp8onmuuKLNQg==
X-Gm-Gg: ATEYQzy/IJWDpIDzDQeM6knU2+edJspWMM302zTMu3Oc2rpVkHjHJZAEX0A12rWhpSh
	q2Le1fQkEaHiLnnLbe5GvOIRtWsWZ+2+ZjCNKqTLtpMd3LgIDYCH2DciRntx/nKpSxF6rFRzam4
	Ucvn9D3PfRf68h7YlYny0h0O35Q5fe5wcz/G+vE3AUDhnGnQQWtb+tqcB2GhlshmuA2KEuVBcoP
	POnkdjbB0viWuezW36YukyJiqaKXts7EtZDHxGLMfhUOVqMYL7iovl7C0q9f5wpZVA0fmttj1QT
	LWcasFdldpa9jIdNC/Kpr+CYwxYTOg==
X-Received: by 2002:a05:6a00:299a:b0:829:7fff:eb7b with SMTP id
 d2e1a72fcca58-82c960841f8mr12268167b3a.51.1774886702568; Mon, 30 Mar 2026
 09:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330102904.2677818-5-bestswngs@gmail.com>
In-Reply-To: <20260330102904.2677818-5-bestswngs@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Mar 2026 12:04:51 -0400
X-Gm-Features: AQROBzB1iQwvP1iw3epeCfixEup-rv5l79UnSI3tNWU7NHe04Qkch4KJfH-REVY
Message-ID: <CAM0EoMkFVKfcQ=PN1J_4JL3Cvqiz2Zfaismp79hGiYouD+yZ7w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: taprio: fix NULL pointer dereference in
 class dump
To: Weiming Shi <bestswngs@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-273259-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AE4B135E8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 6:43=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> is called with new =3D=3D NULL and stores NULL into q->qdiscs[cl - 1].
> Subsequent RTM_GETTCLASS dump operations walk all classes via
> taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> returning the NULL pointer, then dereferences it to read child->handle,
> causing a kernel NULL pointer dereference.
>
> The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> namespaces enabled, an unprivileged local user can trigger a kernel
> panic by creating a taprio qdisc inside a new network namespace,
> grafting an explicit child qdisc, deleting it, and requesting a class
> dump. The RTM_GETTCLASS dump itself requires no capability.
>
>  Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000007: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
>  Call Trace:
>   <TASK>
>   tc_fill_tclass (net/sched/sch_api.c:1966)
>   qdisc_class_dump (net/sched/sch_api.c:2329)
>   taprio_walk (net/sched/sch_taprio.c:2510)
>   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
>   tc_dump_tclass_root (net/sched/sch_api.c:2370)
>   tc_dump_tclass (net/sched/sch_api.c:2431)
>   rtnl_dumpit (net/core/rtnetlink.c:6827)
>   netlink_dump (net/netlink/af_netlink.c:2325)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
>
> Fix this by substituting &noop_qdisc when new is NULL in
> taprio_graft(), following the same pattern used by multiq_graft() and
> prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> all consumer paths (dump, enqueue, dequeue) safe. The noop_qdisc is a
> kernel-global builtin qdisc that drops all packets, which is
> functionally equivalent to a NULL child for data path purposes. The
> refcount increment and flag modification are guarded with
> !=3D &noop_qdisc to avoid modifying the global singleton.
>
> Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual =
q->qdiscs[]")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

You forgot to Cc the author of the commit (Vladimir) now on Cc.
I have also removed @stable from the list; it is not your
responsibility to decide what goes to stable, lets leave that to the
netdev maintainers.

cheers,
jamal

> ---
>  net/sched/sch_taprio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f60..cecaef16c0dd1 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned=
 long cl,
>         if (!dev_queue)
>                 return -EINVAL;
>
> +       if (!new)
> +               new =3D &noop_qdisc;
> +
>         if (dev->flags & IFF_UP)
>                 dev_deactivate(dev);
>
> @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsign=
ed long cl,
>         *old =3D q->qdiscs[cl - 1];
>         if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
>                 WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) !=3D *old);
> -               if (new)
> +               if (new !=3D &noop_qdisc)
>                         qdisc_refcount_inc(new);
>                 if (*old)
>                         qdisc_put(*old);
>         }
>
>         q->qdiscs[cl - 1] =3D new;
> -       if (new)
> +       if (new !=3D &noop_qdisc)
>                 new->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
>
>         if (dev->flags & IFF_UP)
> --
> 2.43.0
>

