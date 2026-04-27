Return-Path: <netdev+bounces-281490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MhaItTJ72knGAEAu9opvQ
	(envelope-from <netdev+bounces-281490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEED747A26F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BE0430DFDEE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89073371881;
	Mon, 27 Apr 2026 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyoAQSF4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E136167F
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322070; cv=pass; b=AWgE3ZLqJ64+XSvKdQpIUsH8ZHavvaLFufSSSDfwfk0fArFA0kquSag3gdlhnFR1X8tdBw+Bgm7bcedTU2UQ+ast5bCo7YKddjZeIlo/CR89kwmCM9NZ+DVFpekIC8NObjGcFaxbkDxQBZwAcbDwb+0J16OvQSZpmvPCFWj/LSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322070; c=relaxed/simple;
	bh=kwy89Iqv8OdEWQx8A5fdRS6NGhOJulrdk+r9Qn4GC2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEt9ZzvtAuuIY4osD9X5rSUYfsWj0m+lz915d1i/TVu3h6qSSqS0BwMBfRwmeyRIfh8+i9loZz4jrIE0nUSl6DxtTMlCPOrO5054CkDcMIO4Qgp/Ph2fCuwBb9fJ/dX1CVBDsjc2wawticB4SzE4KWJJqtwlBvYl64ijCB7GZbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyoAQSF4; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56f75445470so6119321e0c.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777322068; cv=none;
        d=google.com; s=arc-20240605;
        b=MM9WFcECtYRF/buEuGwH3qceNmhJ84MifLTrl3e0YZ5QVNV3P+OIQs6ZXhYHIqAkWJ
         r9dq2v7kUiaP+WtjAVc1S5wc3o7ZJX+Bq+LPws1coqRPzEihlCEUJ3ak3T2XDmjincAf
         O0UBXJylImbhiTJDckS47S+w00qlXrKYP5e4nf6g94KFeoFUUV2W6JnzjPSoMkoMlRFP
         oWOlbZIvLu7/AIo7NVPJt4DBb3PRPANz/kCG5PwskFwN/Wi1Zpo6r0ulwZzkCN+NLQ/N
         TJjPXKlR5vW/t9kx1aaZklaWdf3/syq7g7smgl7qxbYw7Re1WVVWpR1f579ih9ko2QbQ
         2ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IDhJwqGGs3mH225QoSzcTra69KJK7gVbTJiK2QceQtk=;
        fh=qtqsRlrOWpeKlb56AuyeLkeJLKMqQPRrK38puJF23Ko=;
        b=AtWj6RGxY1R+SpK4UbCBB5pD29iLXoNePu1sG+id3FSrc4A6B5bc4301jeEe+vvfG3
         fTs0+Z8SKtZReUCKjszTYiI3+ApjJ5su5ntzSrrRIvEiHiZmJcchafp0I9MA8ahPjPWM
         dQBl8btaTTsEyVwlqMSkMzP6QoVVpwqNlQzs13puBjQNpIRbEInbfj9rRvGHnGH+Cay8
         dpr0Eohv2p2GEA8rJAP7aP8BlP+xL6D8GfEOAHeKRLtbFGSyxk9chSYVFCWHYku5KyPg
         gnXyIXx7ejunoqkPETtVKd0dSdwLxlx2oiqnzNdy4dVvOaBBsGLOATyJFk77vL5d1mgw
         FsOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322068; x=1777926868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDhJwqGGs3mH225QoSzcTra69KJK7gVbTJiK2QceQtk=;
        b=EyoAQSF4GyKO6q3czEDpoxo6YmQ2qoiaCZ3R/BWtnYfYgDrMAEXI1RxGvvGNa1ZmOa
         Io0mSBHEd3hEUCd03o8vXHWdxiTnIyFH1KzuzuxCVPkg4R3AaCu9uRpQv7Ap/b/NkQPI
         MDfjCdAECzxqaauL9wfnfO6dJX4QOP/KD/Ov3qLccuFlu4FigNcppqrbg76qIFwfmkS6
         HKO2MlSAir5pJF/Ra8sWb3SaUa/7/eXEiyP+LJdqI1GZdU6SC1tVl7r8akv3mlmd8zlw
         0uBjZjdLqCa3FRqFxuaC6W3+lF701ApTOGQ69sG95H4JF4snh9wqcuThNZfEeQPC4YBl
         AUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322068; x=1777926868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDhJwqGGs3mH225QoSzcTra69KJK7gVbTJiK2QceQtk=;
        b=qlnEsUmyuT62pAFx77VsQut570DenRNB2BGSkZaF/LndxCskcJaAS0u2vl71M/M7cv
         8hQXO9o7BTnoYYqkBoKBnp8ISITNFs13WP2zzThw/NgnxAcaFr4VD8SrVNODYoGMgK7I
         00LTEHMBgXARCt/N0M+iQ4BE6TCb7oCzvUqILsy8Ry5hXc6+IuBMhzl2iBC34pME/eLP
         L/ro+ovKQJisRw2Fikw4DNQmgX83uOWzGvdYqI++QEBWR3JrxyKqXXeKpS4lI52Z8Sq7
         vUk3pWr3EXVszBdVPS2by7tk5CrQn6SFZOzrPRla2JPkW2LGW9uP76oW80kovRdMxkXL
         enWg==
X-Gm-Message-State: AOJu0YyM7AU2CpCDgxxClWRUjVOjXtZECsMfumerlP9XNJ6aLwFKNPHx
	08mlqVN6WH77WZo0pzR3qQL9rd8CRQ70stHRqdx7WNJnwP5lXwsEhqgEqGw0ViFWu0ieohl14NA
	A6g2GMgkMKl5N4Sny6Tfvq2Ym7Cl9Uz2+7qAxea9jTTnSRQlpF4c4N0xQ9SNBrg==
X-Gm-Gg: AeBDietI5PyELVi/Z07fH0BJaAIeOIiOYSvIn9hEpdAeJBEGgzi/7GxygT+idZOLQmH
	f+qP8lTNqzzcx0dg14KBBpahDQt4o/uEsDWUNPb+Yuiidht6b8opX4hSEZo6/1nNTvbAZRva5P8
	IVU8mzIOkrcx6Rn2Wche3prhAqEh600dm3qT85B+bIFWWs0Uu6ZHrvZywnxEYebvfDqS7MyR+0M
	/+1pwixRPd0Hu1/kYAZeNfFKn5N5Q8rLSfJhnS1kvaPy4dC+WvJUjI9MOHgKKAGD5+XW1T/70vr
	yW44x6pjETe3gkvZOvmhPJavRF8q/RoRe22VcvNjxpHA1cKx0CZG8ZNQLoA=
X-Received: by 2002:a05:6122:e272:b0:570:2ace:c14a with SMTP id
 71dfb90a1353d-573a52ed088mr218565e0c.0.1777322067450; Mon, 27 Apr 2026
 13:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com> <20260425002450.163421-5-hramamurthy@google.com>
In-Reply-To: <20260425002450.163421-5-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 27 Apr 2026 13:34:14 -0700
X-Gm-Features: AVHnY4Jn5PJ26wDuxL6XOxBc41tW0ndGpiH2_vXXGP_iU1dvcZuimxB-Abspnqs
Message-ID: <CAHwYsiqM0EkCQCYCk9LwEojUKCNr7zO-0iwSTyA5Mku9T3k_3g@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] gve: Make ethtool config changes synchronous
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DEED747A26F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 5:25=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Pin-yen Lin <treapking@google.com>
>
> When modifying device features via ethtool, the driver queues the
> carrier status update to its workqueue (gve_wq). This leads to a
> short link-down state after running the ethtool command.
>
> Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
> `gve_queues_start()` to update the carrier status before returning to
> the userspace.
>
> This was discovered by drivers/net/ping.py selftest. The test calls
> ping command right after an ethtool configuration, but the interface
> could be down without this fix.
>
> Cc: stable@vger.kernel.org
> Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 1fec8e1e4821..2c461be12a75 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1424,6 +1424,33 @@ static void gve_queues_mem_remove(struct gve_priv =
*priv)
>         priv->rx =3D NULL;
>  }

Sashiko says:

This isn't a bug introduced by this patch, but is there a pre-existing
use-after-free risk here involving stats_report_task?
Looking at gve_stats_report_task(), it iterates over priv->tx and priv->rx
to collect statistics without holding the rtnl_lock. During teardown,
gve_queues_stop() deletes the timer via timer_delete_sync(), but it does
not appear to explicitly cancel the work item with
cancel_work_sync(&priv->stats_report_task).
If the timer queues the work item just before timer_delete_sync() executes,
could the task remain pending on the workqueue?
When gve_close() then calls gve_queues_mem_remove(), the memory for
priv->tx and priv->rx is freed and the pointers are set to NULL. If the
pending stats_report_task runs concurrently and evaluates if (priv->tx)
right before the memory is freed, could it dereference stale pointers and
cause a use-after-free?
Additionally, during module removal, gve_teardown_priv_resources() frees
priv->stats_report and sets it to NULL. Since destroy_workqueue() is
called immediately after, could this flush and execute the pending task,
leading to a NULL pointer dereference?

Sashiko pointed out the same issue at patch 1/4. We will address this in v3=
.
>
> +static void gve_handle_link_status(struct gve_priv *priv, bool link_stat=
us)
> +{
> +       if (!gve_get_napi_enabled(priv))
> +               return;
> +
> +       if (link_status =3D=3D netif_carrier_ok(priv->dev))
> +               return;
> +
> +       if (link_status) {
> +               netdev_info(priv->dev, "Device link is up.\n");
> +               netif_carrier_on(priv->dev);
> +       } else {
> +               netdev_info(priv->dev, "Device link is down.\n");
> +               netif_carrier_off(priv->dev);
> +       }
> +}
> +
> +static void gve_turnup_and_check_status(struct gve_priv *priv)
> +{
> +       u32 status;
> +
> +       gve_turnup(priv);
> +       status =3D ioread32be(&priv->reg_bar0->device_status);
> +       gve_handle_link_status(priv,
> +                              GVE_DEVICE_STATUS_LINK_STATUS_MASK & statu=
s);
> +}
> +
>  /* The passed-in queue memory is stored into priv and the queues are mad=
e live.
>   * No memory is allocated. Passed-in memory is freed on errors.
>   */
> @@ -1486,8 +1513,7 @@ static int gve_queues_start(struct gve_priv *priv,
>                           round_jiffies(jiffies +
>                                 msecs_to_jiffies(priv->stats_report_timer=
_period)));
>
> -       gve_turnup(priv);
> -       queue_work(priv->gve_wq, &priv->service_task);
> +       gve_turnup_and_check_status(priv);
>         priv->interface_up_cnt++;
>         return 0;
>
> @@ -1608,23 +1634,6 @@ static int gve_close(struct net_device *dev)
>         return 0;
>  }
>
> -static void gve_handle_link_status(struct gve_priv *priv, bool link_stat=
us)
> -{
> -       if (!gve_get_napi_enabled(priv))
> -               return;
> -
> -       if (link_status =3D=3D netif_carrier_ok(priv->dev))
> -               return;
> -
> -       if (link_status) {
> -               netdev_info(priv->dev, "Device link is up.\n");
> -               netif_carrier_on(priv->dev);
> -       } else {
> -               netdev_info(priv->dev, "Device link is down.\n");
> -               netif_carrier_off(priv->dev);
> -       }
> -}
> -
>  static int gve_configure_rings_xdp(struct gve_priv *priv,
>                                    u16 num_xdp_rings)
>  {
> @@ -2099,15 +2108,6 @@ static void gve_turnup(struct gve_priv *priv)
>         gve_set_napi_enabled(priv);
>  }
>
> -static void gve_turnup_and_check_status(struct gve_priv *priv)
> -{
> -       u32 status;
> -
> -       gve_turnup(priv);
> -       status =3D ioread32be(&priv->reg_bar0->device_status);
> -       gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK &=
 status);
> -}
> -
>  static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv =
*priv,
>                                                         unsigned int txqu=
eue)
>  {
> --
> 2.54.0.545.g6539524ca2-goog
>

Regards,
Pin-yen

