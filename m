Return-Path: <netdev+bounces-295611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h2PPKtNGImp6UgEAu9opvQ
	(envelope-from <netdev+bounces-295611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:47:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07243644F00
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:47:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MACYrUUN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295611-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295611-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDC33034B37
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B53D7D77;
	Fri,  5 Jun 2026 03:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8833ADB1
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 03:41:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630915; cv=pass; b=e3CkeaVifFuFx/nidtSLCo6+2VBdtwCS9wUl59YqnEv145oapsEyvAOrSvzxr+3eeK+vXGwoKiO1Xsw+EiLqdIHVDnj1w9SiZotP+ynHHHOtKx3ilw4YhxvHQOTYowDXN+WYo+Syjn7UE73Qz/rD1OVqQF3xzGCKWt+DqHUmQck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630915; c=relaxed/simple;
	bh=eGCEm9OPC7WdXzEUoowen9BuZuShye6xTxIjLk/tTLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld8D/BMux8tBl2+Q2MwgiOCmdeqiP7e1jgbG7wBbsiw9t1LdRAuAIjx+oNzmveB8jQmmLqxO+ESxKL+xUvFlApMWFrrpPyIj0vfPhpbPBLYbmHusEZBEtk1IZcV1AkiEUvtpNp2j20CC6+nb7hjiGMMvIg+U7ZgN17NOoynaCsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MACYrUUN; arc=pass smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b1a48855so68415ad.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 20:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780630913; cv=none;
        d=google.com; s=arc-20240605;
        b=fqBILLBxeHuao18gpZRplrrcfyEyJzY0mFcEKMMZRyF7SfepdS864U4l8LLL26PxgT
         Mpyj41mZ8ofXhfMpdEF8ngFusedp+HqZGxjWA0lewLQUuHmDhWZi9Z4Qqkmtb8JRpYBO
         2diSypZ8qSF/qs0vViW84AyR5erdAGOKcf8xhiQWzXUJKdXPqcRrTnQ07IBwBF/VQvcB
         WP1B6Mki5qa/3Wm9xSxqZriF8TTJRJKyM5tYg02S4+PJ3kRjrbMjRbZZCly4NXEOiXT6
         50NleF0vJuonoUe+xhKFVl49Jy3iczHGpRI1d2Mh+7Wbvs7wkkDU5vcp7rWVB5OOsoE7
         4Tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ceuq4fqgPta3jeOPTygEvNTBZ1gtxFFoAFHP7IeAjCg=;
        fh=Ef9lcZO4ZwrztREP42xReRHLmD9Hg2GQuFQd3HW9yBk=;
        b=fgLqJunYnov4orE6D8qK5hgZ+P2t5+BN33VhCpw/1/6Jc1omYKyFmgW8i9+VMog2mj
         GddMUafv3zwBwJ0ZpgjajsLWFckQAXfxql0hZ+GTtndW9umLX0BQqxwLqeq7KrEDLpu0
         llJyw3fmknVYq9w3GNbgCkxJpXoTr3CLJ5xzM3OqCiEXu5zhtPXePFSXHkgg83pMUuOH
         juQiJ8hwcvRDhhkZzf98Yt4H/lwCx5Gxm1kaKbEfxlX3jHPISkbmzDr6x8HE9JkKWf2q
         OhaLynCfFhSgyoCnSyWimdFu2ixJooAZ3zVp0m0k3XjC9eMlwsWfOHQxn3I127EsFKw0
         mGDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780630913; x=1781235713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ceuq4fqgPta3jeOPTygEvNTBZ1gtxFFoAFHP7IeAjCg=;
        b=MACYrUUNZFez4jZ/lXozDCvCtMIDtEdL1hitaPfGTqHGeSn8VnSLrD76j0vGFz05Bw
         E1JJXScj9e4XAOPkzZxapMRlzV4aB7Jcln4p9+/M8+cKuSyTWOW9VdjRYjSlaksm0kyA
         3j4EZF7nU93kROoDwXUclk1gAMjQ7AwMpItcA/KN+PGS1L/k5KRqwuGs4ZMXsAph5CJt
         hbqHWLUJwqRT86PhQ1/qC1y9o0aW9FktnLLCN9Ki5ASohtrWjLL1IWuLTxla8vBewu8o
         udVAbJGTIKr03uwkqnCOOasIEXbhxybFrSXGA339bMs5DIhPI4SjX0TX2PmOy2/lP5b7
         QLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630913; x=1781235713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ceuq4fqgPta3jeOPTygEvNTBZ1gtxFFoAFHP7IeAjCg=;
        b=HrhKrvnbi4jII5+5ZBt53xQU1aC8kWbtDnbeie2Klr5To+ojBjKBH7Zs9C3+YJNr/s
         sxk/G/FStvm26pZ1RGNdeomKelqsZAJzgo703MjrywEShJhyB4R3goaYKtRoIc1SiPNa
         eHv3ycEKRR3xTv4ODVTGnTR1ran3YoL/xydy1ExXj4qysSpWGv6FE3WWo60oWTepYUs6
         XA+iqGCfJ9RKCHFK7+0nDhKO9IT1TnvtqLrW1cqgsUX16iheFI4AOQObiHvV1a+UKEiN
         fBCG/o1ImKZ06HoH4F6/dhqpgSAEqk41PxCha1TBUTBS8dnPeEuQPjWa0Gbd2ZDKnr7d
         lpMQ==
X-Gm-Message-State: AOJu0YwnFAfNizDmrz9Jij2BQsfi0v8AArn+0f2gNP2n4d4grSALIBlM
	GC42dVaf/gpHh0q8BuiLWgdibIGUoQKW7fJd9qoteGEUr0PQIQ/a8TKzpdu1mL3hBC1VxQ4U/za
	Kx/b1EnQg/Dn3fwkDEPPqAlEhulkPyussPS5Pve2sdMwwZRirZbx4ZMwrt/87nA==
X-Gm-Gg: Acq92OFCtNYgSQMrJqxkOBC3MlG3udZ8A0Py933gXOlp7wO90bzjnuZYKkfTTz12qgM
	9R1xEQO2er+Ha0DDQZoGtkrg12UwIUH/+YofnZ5nXcsQv+nP6xzJo5HONM6epn9TYFYxtnxL2v9
	vYal0btISEzwswIPQ2Z/FPjU2QNSb44jtslS/qjqQLplbI1kjN+YtzqnzRFH4u+E8vXw4o7HOJQ
	1OSb+5UGe1oar8tANHri/uZBPJlNaJ/+Gr3UYR3m1w/MRKLe02JA8aqug8wGLwtmC350C8kdQMB
	4AO8UXykeTgnyiGWuLxmBfpIJ9Xpfz2Tq0jvXeeJ7k1dZAbUpMfddLd57AbWuHTvthRnmUokLei
	PMvMT/Jv6nxffmRuQ9Mc=
X-Received: by 2002:a17:903:41d0:b0:2c0:c877:8095 with SMTP id
 d9443c01a7336-2c1eb72a55emr574515ad.2.1780630912554; Thu, 04 Jun 2026
 20:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-3-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-3-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 4 Jun 2026 20:41:40 -0700
X-Gm-Features: AVHnY4KtZ1UUobwVDAvmG8aRjJ3MDRoZKzyGvXpEAt-RDwCE67_lbB7xedj11ko
Message-ID: <CAEAWyHeiBGH46U_bz82rzoZ7ig0+2B0K-h9qpDmfLZ-zHjHV+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/15] gve: refactor initialization with
 helper functions
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, willemb@google.com, jordanrhee@google.com, 
	jfraker@google.com, nktgrg@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295611-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07243644F00

On Tue, Jun 2, 2026 at 4:59=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> In the interest of commonizing code, refactor gve_probe()
> and gve_init_priv() with a few helper functions that can
> be expanded and utilized in upcoming patches that add the
> mailbox ABI to the driver. The helper functions are:
>
> - gve_set_num_ntfy_blks()
> - gve_set_num_queues()
>
> Reorder code to combine lines that accomplish a similar objective
> like setting defaults. Move setting HW-GRO and UDP GSO support out
> of an Adminq method into gve_init_priv().
>
> These changes are just code movement, no functional change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c |   8 --
>  drivers/net/ethernet/google/gve/gve_main.c   | 108 +++++++++++--------
>  2 files changed, 65 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 70ffed8b52c3..dfeabddfb396 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1117,14 +1117,6 @@ int gve_adminq_describe_device(struct gve_priv *pr=
iv)
>
>         gve_set_default_rss_sizes(priv);
>
> -       /* DQO supports HW-GRO and UDP_GSO */
> -       if (gve_is_dqo(priv)) {
> -               u64 additional_features =3D NETIF_F_GRO_HW | NETIF_F_GSO_=
UDP_L4;
> -
> -               priv->dev->hw_features |=3D additional_features;
> -               priv->dev->features |=3D additional_features;
> -       }
> -
>         priv->max_registered_pages =3D
>                                 be64_to_cpu(descriptor->max_registered_pa=
ges);
>         mtu =3D be16_to_cpu(descriptor->mtu);
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 30bf6df4ebc5..b9542ef36b29 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2398,65 +2398,32 @@ static const struct xdp_metadata_ops gve_xdp_meta=
data_ops =3D {
>         .xmo_rx_timestamp       =3D gve_xdp_rx_timestamp,
>  };
>
> -static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> +static int gve_set_num_ntfy_blks(struct gve_priv *priv)
>  {
>         int num_ntfy;
> -       int err;
> -
> -       /* Set up the adminq */
> -       err =3D gve_adminq_alloc(&priv->pdev->dev, priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Failed to alloc admin queue: err=3D%d\n", err);
> -               return err;
> -       }
> -
> -       err =3D gve_verify_driver_compatibility(priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Could not verify driver compatibility: err=3D%d\=
n", err);
> -               goto err;
> -       }
> -
> -       priv->num_registered_pages =3D 0;
> -
> -       if (skip_describe_device)
> -               goto setup_device;
>
> -       priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> -       /* Get the initial information we need from the device */
> -       err =3D gve_adminq_describe_device(priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Could not get device information: err=3D%d\n", e=
rr);
> -               goto err;
> -       }
> -       priv->dev->mtu =3D priv->dev->max_mtu;
>         num_ntfy =3D pci_msix_vec_count(priv->pdev);
>         if (num_ntfy <=3D 0) {
>                 dev_err(&priv->pdev->dev,
>                         "could not count MSI-x vectors: err=3D%d\n", num_=
ntfy);
> -               err =3D num_ntfy;
> -               goto err;
> +               return num_ntfy;
>         } else if (num_ntfy < GVE_MIN_MSIX) {
>                 dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x ve=
ctors, but only has %d\n",
>                         GVE_MIN_MSIX, num_ntfy);
> -               err =3D -EINVAL;
> -               goto err;
> +               return -EINVAL;
>         }
>
> -       /* Big TCP is only supported on DQO */
> -       if (!gve_is_gqi(priv))
> -               netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
> -
> -       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
>         /* gvnic has one Notification Block per MSI-x vector, except for =
the
>          * management vector
>          */
>         priv->num_ntfy_blks =3D (num_ntfy - 1) & ~0x1;
>         priv->mgmt_msix_idx =3D priv->num_ntfy_blks;
> -       priv->numa_node =3D dev_to_node(&priv->pdev->dev);
>
> +       return 0;
> +}
> +
> +static void gve_set_num_queues(struct gve_priv *priv)
> +{
>         priv->tx_cfg.max_queues =3D
>                 min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks /=
 2);
>         priv->rx_cfg.max_queues =3D
> @@ -2470,18 +2437,73 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
>                 priv->rx_cfg.num_queues =3D min_t(int, priv->default_num_=
queues,
>                                                 priv->rx_cfg.num_queues);
>         }
> -       priv->tx_cfg.num_xdp_queues =3D 0;
>
>         dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
>                  priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
>         dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n"=
,
>                  priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
> +}
> +
> +static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> +{
> +       int err;
> +
> +       /* Set up the adminq */
> +       err =3D gve_adminq_alloc(&priv->pdev->dev, priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Failed to alloc admin queue: err=3D%d\n", err);
> +               return err;
> +       }
> +
> +       priv->num_registered_pages =3D 0;
> +
> +       if (skip_describe_device)
> +               goto setup_device;
> +
> +       err =3D gve_verify_driver_compatibility(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not verify driver compatibility: err=3D%d\=
n", err);
> +               goto err;
> +       }

Addressing Sashiko's report:
https://sashiko.dev/#/patchset/20260602235900.3050782-1-hramamurthy%40googl=
e.com

"Does moving this driver compatibility check below the early-exit bypass th=
e
critical capability handshake during reset recovery?"

Yes, this needs to also be called in the reset path. Will fix in v3.


> +
> +       /* Get the initial information we need from the device */
> +       priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> +       err =3D gve_adminq_describe_device(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not get device information: err=3D%d\n", e=
rr);
> +               goto err;
> +       }
> +
> +       err =3D gve_set_num_ntfy_blks(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not setup notify blocks: err=3D%d\n", err)=
;
> +               goto err;
> +       }
> +
> +       gve_set_num_queues(priv);
> +
> +       if (gve_is_dqo(priv)) {
> +               /* DQO supports HW-GRO and UDP_GSO */
> +               u64 additional_features =3D NETIF_F_GRO_HW | NETIF_F_GSO_=
UDP_L4;
> +
> +               priv->dev->hw_features |=3D additional_features;
> +               priv->dev->features |=3D additional_features;
>
> -       if (!gve_is_gqi(priv)) {
>                 priv->tx_coalesce_usecs =3D GVE_TX_IRQ_RATELIMIT_US_DQO;
>                 priv->rx_coalesce_usecs =3D GVE_RX_IRQ_RATELIMIT_US_DQO;
> +
> +               /* Big TCP is only supported on DQO */
> +               netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>         }
>
> +       priv->dev->mtu =3D priv->dev->max_mtu;
> +       priv->numa_node =3D dev_to_node(&priv->pdev->dev);
> +       priv->tx_cfg.num_xdp_queues =3D 0;
> +       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
>         priv->ts_config.tx_type =3D HWTSTAMP_TX_OFF;
>         priv->ts_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
>
> --
> 2.54.0.1013.g208068f2d8-goog
>

