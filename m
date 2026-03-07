Return-Path: <netdev+bounces-265194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMvdI6earGmUrQEAu9opvQ
	(envelope-from <netdev+bounces-265194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:37:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF322DBB7
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 641C0300B289
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA749359A81;
	Sat,  7 Mar 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cTJlYEzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AD33A9C4
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919455; cv=pass; b=jBLWBxFoA3+uV9UxRZ/VFekFMz5WCdZOgR65ksX+0KoJLxfEeseaxgMgTi30GNuHMzJEz9W6Qiafvp0fUKHtCG0ApVwlYtPKFcFSUgDpnpkEZ2D8KC6emrBcNmRckRKlMLkXWfC+fsHhMVBbNFm0b30aE9ge8Dxl9ZL2EJqhr88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919455; c=relaxed/simple;
	bh=WDwWZdc9BnDjVU87cF0t+e1oCeBeoUzRFGAxWbMfhgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urskAAQf/yVvmvV9bpVkxEKfHWWM9j60d7VYxutQauzfVwhTBLXhHqBM7bVuDwgX40YStWtR4N8gSmWzRasPk9QeClXObdGGRQhuy+Q8wBCGXvVqHHZCwmu/8Ioq9ehiAQtnKt31aYhCxd4ZGzSFC5iHkPZwleXu2dwJSYdxEdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cTJlYEzM; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2213763b3a.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772919453; cv=none;
        d=google.com; s=arc-20240605;
        b=VTKkeFfSIRCHeOjSkJdIqwH5mZZS8vZ+aThq3J9Le8XrIN2NI0i5fE0vi9jhf0UeDc
         LzJlH3333pPRAmpcoSPCqp61fL2PrVno6PSFeKMVxloAKeFXO5zhtcesbxUp1yoNiC/6
         H2EP8tz+HkhV+ZAmsvRWpqnz3Zoz682/h/3amUZNk2rcJa8hG1CVCbbBBEauymJZPr9u
         t/01bn/b67qbj4ymIkR3Wya3b1dz/7hHtsEU0hkEmMnr2cknEVypNk/qauQY0AV2VTyC
         tEc5tyza8uedXNM8i+/NwW/x9/87eusciJMz3y7oBCHT2etvrmcrrmjsr8N8ZtFpvske
         yZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLekuXTpZCk/2xRsyir8NHL/C+qFDUmVruKtYYzpMrM=;
        fh=XbHPF5C6HPaMxzMDCunEGacfg98lbNTEx1C8FNIVCUM=;
        b=d42iDzjxXbqWfG5koejnPxlh9qDK0ohfUnAstWNAGUGZpdfSHY/Xfbsm9stKWS1Idp
         kqgVPY13TZxaE+/0Dlmn5dj28EiGh+Z33VIpEyXXwaM2ANcN/z5AXVUtxrdM/UV5ZObh
         0hQqmDIK/vnbkp6RU04wUABF7gDfaNkF9xAG9JnvaIt3KgxuOfoSxAMw76vRlGKWO4+T
         vGssB2xuxe7zRzYqlr5//g72IuHsTd5c394KDmkyLXTinBKDNN36LvjV3yAcgOuCNrYy
         BxDnt4xw/BVbA9xsYdtsakLAztte/RQ9ycDH7ogePU62G6Pd4U477V+wlRNEXnnr1vd0
         jDtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772919453; x=1773524253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLekuXTpZCk/2xRsyir8NHL/C+qFDUmVruKtYYzpMrM=;
        b=cTJlYEzMNqMeEKOqWBEEWI1B9nsRKuCGf7ckaNtc/AfFDK5oMqfcAJyYvVd6gfFTm+
         MHv3xcuHGqStLtqTEyqz9ss0/9Kmyd41w3Tvl3/DfViHsKAgfdSHBXoDZCoBodPRRTo9
         eWsrsQ2jKSjM1BVZ0HNFIfLc1BRMEDD99DzV9KkgqQ2Ydb9VgDnVOMcmO99dxtGvbvoS
         X/44a9ajJhp96nNthU8viQP1rNkTStB226iEZp2v7HAgIRc/BpMtHKuxT7Ylxz29MPLg
         b1vScf2/S4dtDhMNEqZZNlyqehRtMCsQRyLgCQr++zdnX+VVrPVJ7wmonW8Dd6YYo+tI
         CHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919453; x=1773524253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLekuXTpZCk/2xRsyir8NHL/C+qFDUmVruKtYYzpMrM=;
        b=S69yl8Gjxsyc1h1h7ANW2MGcBxnT+mvrwMOhNfvUQuH5l10BDe/AVt61GIHpQXbO6y
         Qc3VUeIEfbEvmkJ+Y3PV/nCxX7bBSqNWWUEw1+ClH+ixmRPZ7Z1GvgaH/Qi2O3tLCZes
         j8imOgrFvxL1pDc+IIoh4yZsrg6Kx0yIAM8bl4M5JFeZqH6DHOmJy76pPprpy1zFTiUD
         lZelyDPcd0pime6svJqdtY1D0IzdeRcE6A3JaTHj4O9TYBF0o5MWop2kXuyqkYcgxXM+
         d3+1dXO9IJ88/rDf4ohp5YGKA7td8Mk4UQT2kGxVSd7oM384rGIT5dVEaetZOT3Wai+Q
         YAWg==
X-Forwarded-Encrypted: i=1; AJvYcCWXdmz73zNY/X9r6NP7kq4pKwkr8Fqo+1AUfA0hB2cdARmHxYvLV4mKOx4Bz+Eip5j8tTRInTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkP89WZZ0ZmrhXxAaliobz1JPJ4SrUTTs2OyreOvAQjL9aP8D0
	2A26J/uV1FO7ijIoliSt0o1VWl6dtcnKAR3q3Gcu8KOf4q74/56rr8XCEJSmDpJeidwYVG5vrKi
	sAdpNL2S2IKk2bBSmuzwBmoJiGpZR2ENVg6bMv0OD
X-Gm-Gg: ATEYQzwG9qn6IG3Yk5xvez+lQR2sCmkuIl8Bp0cdnKzrKF4ZBaF5r96mrmvsuJ6scZy
	jS6NEPeHJrf3GExQRrJSbWR25pDFI7fIy9p8KH7uCeYxJM0tuBDXajWeiISfUe0eFD2mZbX2R42
	fnrRj4tTWHC7e5efcqnam+N0LIJd2MrNobK7clGZmNgYbgjMPIuN9RxRsTuFEHaOS1p364KC6bP
	mRgRof+BeoE6Ml1+gN304VKkcsBcq4/Z04CO8xe1Ov1b6dXnRXqaZqukF/5JVOIOdeUXE34FA7J
	RONZzWGcp9S3WCQ=
X-Received: by 2002:a05:6a00:ae07:b0:81f:50ea:5d96 with SMTP id
 d2e1a72fcca58-829a2e14ae7mr4663911b3a.18.1772919452679; Sat, 07 Mar 2026
 13:37:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307163430.470644-1-edumazet@google.com>
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Mar 2026 16:37:21 -0500
X-Gm-Features: AaiRm53IwD_HGBvn9iNu272U-Gw6uJDTj-k6DWnDVMwt6tHmJ6OrKak1uzeQbWc
Message-ID: <CAM0EoMkFfW2q=LN9s0hegFVd+cnc0hx2xp=CpoJHFVHx0D38xQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft operations
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94EF322DBB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265194-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,redhat.com,vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,huawei.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,mojatatu-com.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 11:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Following typical script is extremely disruptive,
> because each graft operation calls dev_deactivate()
> which resets all the queues of the device.
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
> done
>
> One can add "ip link set dev $ETH down/up" to reduce the disruption time:
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  ip link set dev $ETH down
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
>  ip link set dev $ETH up
> done
>
> Or we can add a @reset_needed flag to dev_deactivate() and
> dev_deactivate_many().
>
> This flag is set to true at device dismantle or linkwatch_do_dev(),
> and to false for graft operations.
>
> In the future, we might only stop one queue instead of the whole
> device, ie call dev_deactivate_queue() instead of dev_deactivate().
>
> I think the problem (quadratic behavior) was added in commit
> 2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
> for lockless qdisc") but this does not look serious enough to deserve
> risky backports.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Cc: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> v2: clarified the changelog
>     added kdoc missing part (kernel build bots)
>
>  include/net/sch_generic.h |  4 ++--
>  net/core/dev.c            |  2 +-
>  net/core/link_watch.c     |  2 +-
>  net/sched/sch_api.c       |  2 +-
>  net/sched/sch_generic.c   | 20 ++++++++++++--------
>  net/sched/sch_htb.c       |  4 ++--
>  net/sched/sch_mq.c        |  2 +-
>  net/sched/sch_mqprio.c    |  2 +-
>  net/sched/sch_taprio.c    |  2 +-
>  9 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index c355300893a3921740cf6b919cc58de953cd610c..16beba40914ee5a9454f9eec2=
ad6e600543c89f2 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -710,8 +710,8 @@ void dev_qdisc_change_real_num_tx(struct net_device *=
dev,
>  void dev_init_scheduler(struct net_device *dev);
>  void dev_shutdown(struct net_device *dev);
>  void dev_activate(struct net_device *dev);
> -void dev_deactivate(struct net_device *dev);
> -void dev_deactivate_many(struct list_head *head);
> +void dev_deactivate(struct net_device *dev, bool reset_needed);
> +void dev_deactivate_many(struct list_head *head, bool reset_needed);
>  struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
>                               struct Qdisc *qdisc);
>  void qdisc_reset(struct Qdisc *qdisc);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 203dc36aaed55e706f5d978ec02c6bf48201e3d4..6fc9350f0be8756ae849d5b0c=
a9b222055d96ced 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1756,7 +1756,7 @@ static void __dev_close_many(struct list_head *head=
)
>                 smp_mb__after_atomic(); /* Commit netif_running(). */
>         }
>
> -       dev_deactivate_many(head);
> +       dev_deactivate_many(head, true);
>
>         list_for_each_entry(dev, head, close_list) {
>                 const struct net_device_ops *ops =3D dev->netdev_ops;
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> index 25c455c10a01cf535d6a7d2952d51434fe462690..ff2c1d4538efbc89cd49d8d84=
77542a6e7bacbad 100644
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -181,7 +181,7 @@ static void linkwatch_do_dev(struct net_device *dev)
>                 if (netif_carrier_ok(dev))
>                         dev_activate(dev);
>                 else
> -                       dev_deactivate(dev);
> +                       dev_deactivate(dev, true);
>
>                 netif_state_change(dev);
>         }
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index cc43e3f7574fae203989f5c28b4934f0720e64c2..c0bab092ea809955b3a5aaa08=
c169bca55cfaf7f 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1120,7 +1120,7 @@ static int qdisc_graft(struct net_device *dev, stru=
ct Qdisc *parent,
>                 }
>
>                 if (dev->flags & IFF_UP)
> -                       dev_deactivate(dev);
> +                       dev_deactivate(dev, false);
>
>                 qdisc_offload_graft_root(dev, new, old, extack);
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 556e0d8003161d3dfe68e484f6349714cf989c0c..d4fe907c4ad5895b1dda5249c=
55e4c1e0168023e 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1370,11 +1370,12 @@ static bool some_qdisc_is_busy(struct net_device =
*dev)
>  /**
>   *     dev_deactivate_many - deactivate transmissions on several devices
>   *     @head: list of devices to deactivate
> + *     @reset_needed: qdisc should be reset if true.
>   *
>   *     This function returns only when all outstanding transmissions
>   *     have completed, unless all devices are in dismantle phase.
>   */
> -void dev_deactivate_many(struct list_head *head)
> +void dev_deactivate_many(struct list_head *head, bool reset_needed)
>  {
>         bool sync_needed =3D false;
>         struct net_device *dev;
> @@ -1393,11 +1394,14 @@ void dev_deactivate_many(struct list_head *head)
>         if (sync_needed)
>                 synchronize_net();
>
> -       list_for_each_entry(dev, head, close_list) {
> -               netdev_for_each_tx_queue(dev, dev_reset_queue, NULL);
> +       if (reset_needed) {
> +               list_for_each_entry(dev, head, close_list) {
> +                       netdev_for_each_tx_queue(dev, dev_reset_queue, NU=
LL);
>
> -               if (dev_ingress_queue(dev))
> -                       dev_reset_queue(dev, dev_ingress_queue(dev), NULL=
);
> +                       if (dev_ingress_queue(dev))
> +                               dev_reset_queue(dev, dev_ingress_queue(de=
v),
> +                                               NULL);
> +               }
>         }
>
>         /* Wait for outstanding qdisc_run calls. */
> @@ -1412,12 +1416,12 @@ void dev_deactivate_many(struct list_head *head)
>         }
>  }
>
> -void dev_deactivate(struct net_device *dev)
> +void dev_deactivate(struct net_device *dev, bool reset_needed)
>  {
>         LIST_HEAD(single);
>
>         list_add(&dev->close_list, &single);
> -       dev_deactivate_many(&single);
> +       dev_deactivate_many(&single, reset_needed);
>         list_del(&single);
>  }
>  EXPORT_SYMBOL(dev_deactivate);
> @@ -1473,7 +1477,7 @@ int dev_qdisc_change_tx_queue_len(struct net_device=
 *dev)
>         int ret =3D 0;
>
>         if (up)
> -               dev_deactivate(dev);
> +               dev_deactivate(dev, false);
>
>         for (i =3D 0; i < dev->num_tx_queues; i++) {
>                 ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index cf6cd4ccfa2029d9a45e35d6780520290690732d..eb12381795ce1bb0f3b8c5f50=
2e16ad64c4408c8 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -1387,7 +1387,7 @@ htb_graft_helper(struct netdev_queue *dev_queue, st=
ruct Qdisc *new_q)
>         struct Qdisc *old_q;
>
>         if (dev->flags & IFF_UP)
> -               dev_deactivate(dev);
> +               dev_deactivate(dev, false);
>         old_q =3D dev_graft_qdisc(dev_queue, new_q);
>         if (new_q)
>                 new_q->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> @@ -1421,7 +1421,7 @@ static void htb_offload_move_qdisc(struct Qdisc *sc=
h, struct htb_class *cl_old,
>                 struct Qdisc *qdisc;
>
>                 if (dev->flags & IFF_UP)
> -                       dev_deactivate(dev);
> +                       dev_deactivate(dev, false);
>                 qdisc =3D dev_graft_qdisc(queue_old, NULL);
>                 WARN_ON(qdisc !=3D cl_old->leaf.q);
>         }
> diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
> index 0ed199fa18f04a06197116b6ab64ff3647dbace9..a0133a7b9d3b09a0d2a606423=
4c8fdef60dbf955 100644
> --- a/net/sched/sch_mq.c
> +++ b/net/sched/sch_mq.c
> @@ -201,7 +201,7 @@ static int mq_graft(struct Qdisc *sch, unsigned long =
cl, struct Qdisc *new,
>         struct net_device *dev =3D qdisc_dev(sch);
>
>         if (dev->flags & IFF_UP)
> -               dev_deactivate(dev);
> +               dev_deactivate(dev, false);
>
>         *old =3D dev_graft_qdisc(dev_queue, new);
>         if (new)
> diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
> index b83276409416fabeccc441e5127211632ddcfedb..002add5ce9e0ab04a6260495d=
1bec02983c2a204 100644
> --- a/net/sched/sch_mqprio.c
> +++ b/net/sched/sch_mqprio.c
> @@ -469,7 +469,7 @@ static int mqprio_graft(struct Qdisc *sch, unsigned l=
ong cl, struct Qdisc *new,
>                 return -EINVAL;
>
>         if (dev->flags & IFF_UP)
> -               dev_deactivate(dev);
> +               dev_deactivate(dev, false);
>
>         *old =3D dev_graft_qdisc(dev_queue, new);
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f6008ecc59fe4c4ca4a082099dc125..8e375281195061da848fb2bfa=
f79cf125afccac0 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2184,7 +2184,7 @@ static int taprio_graft(struct Qdisc *sch, unsigned=
 long cl,
>                 return -EINVAL;
>
>         if (dev->flags & IFF_UP)
> -               dev_deactivate(dev);
> +               dev_deactivate(dev, false);
>
>         /* In offload mode, the child Qdisc is directly attached to the n=
etdev
>          * TX queue, and thus, we need to keep its refcount elevated in o=
rder
> --
> 2.53.0.473.g4a7958ca14-goog
>

