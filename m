Return-Path: <netdev+bounces-296320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S2ncEujwJWq6OQIAu9opvQ
	(envelope-from <netdev+bounces-296320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:30:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED6651D01
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lmRaanGO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296320-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3ABA300D45A
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EA3655EE;
	Sun,  7 Jun 2026 22:29:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDC33B6DC
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 22:29:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871392; cv=pass; b=jmtRL5xI+S1HL4Qyj2Wln1Oj/Lv7yruBPy3MoIbmZovJcvW1l9HJd1Cn9UioS5RUAD6uwOQcX60dE6Gt22I6+AaR/lmuN7SSd8e7XM598raom035w2AzjGelGnX072oivWL1aIWuYl8yllgDgysRTOrPuNMajRXfq0hutjfn5Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871392; c=relaxed/simple;
	bh=bwU2wJi6+s4So0DKvsJXr/g5IEZ/zUTklWmD227eNa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qob8z6C6CXWyf5dAIS2fMuALLRuiqmhc/qjCFf9SHOoY8aZgD03P4FPz+JgnI6hlC8wXVZ00ruhwWWgJbrR9XdM5svxGBUhZracHP9AEl99F2L6GNXqqwGe4WD4X8Vmn2ykIqynTBqOjFtqDEtIRTO2S6uRfxkBDhZRJxC/cWro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmRaanGO; arc=pass smtp.client-ip=209.85.208.171
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39677c80386so39956251fa.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 15:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780871389; cv=none;
        d=google.com; s=arc-20240605;
        b=cv2fv5qyLYrlAIbC2GUkMxVRWlldjzCocLRWFqk8BtftyhIYhN7qTpsdSdmN1edJRM
         /pYO+P44YYgT8g4n3fE+qGikLXueY+TcOiqpeONdHijy8Daidm2PrYYCNUI8Mu67Oz9o
         JC39EL8tqjnC3UctuR32owjk+YttZ8xIaEoc+/gttbMfKCRb2RHSJ8koB9wNsISOyFnp
         VNe9/inoqxYyX5Lxsn/AyQQX8FEv5rLch+qmyXg+I+kEEgfEXx71PAeoufw6JgqoAOvK
         70y94IquVlEcKXqJPLGr79fEEMO9ASezo3alpHRGhsALM8FiBnBwJJ2I3BbGCRXF/YAX
         Zmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iQO6jFNS2s7fAuLZXtMklLeueanAFJEP8trKvyAlT4=;
        fh=+8eu1zxn6dzJPeKJi+J9GJyeu9j9o/OlXv1xkTsljAk=;
        b=B8tsfuCp2m3FDlHbrD3cN6Wr0CS3CZxOTdwrN6XUTlFNyyKVErhVA20JWuC+ZKfL2Y
         15SHlJK7EySWMwj9DHSuIi8dBY35oyDOrZ0DX7S4R6YQsXXNi0HOlHPYhKuVpDgqN5Id
         5VjWT6HLI8nWxGB/2VmCjYecUc+lqTfJZIEvzFwbmJ3tzFfoZ9tgN2im7EOHgHjcAkve
         rdVVd4iVsi1hbbs0nXbqtnKn0Fz1XUDLa+41xXxs0SvhRhfv+cLr3UkzzBDEgez+7+cV
         JXzs1JEVYD5VPU4DEmmWas7V0Nx2T5Ly+KZoyEAHRZmpHTswsCyS6qEiFJla/SETzT32
         NyGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780871389; x=1781476189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iQO6jFNS2s7fAuLZXtMklLeueanAFJEP8trKvyAlT4=;
        b=lmRaanGO6gKfgs314zfwJDi4eE37c1WY+D20QFNy/mz26WRyCq9e0Qi65aMmZ7Ezxy
         3TcaWIsbH41PoKwVwOfdxh7Jf1CpT/UPGI2h3aq2nLCh4FoV7CqmPtcAP2H+MtdObM6E
         4QHxZfY8iBOhENoicLRcq6jmoxApnS1KqZKwZALilcI1S6XZCtOHSYZqJMZ3UoQCcAee
         eyt1vnbNC+sToHBpmgwBOCbIM1yvNEO8X6qZ2NTI1r1HavGG0sTrsrO3TYycyJprWCSs
         ebpcdnw4vdWs5CdnMMi+PrZNVgdWBoY9rBkmeenoBPfOFbFKyle7M9Vs8IpRxgmFaIcu
         XoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780871389; x=1781476189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iQO6jFNS2s7fAuLZXtMklLeueanAFJEP8trKvyAlT4=;
        b=agFD+/MCtOoUPsK8coqC1TEvOn25vsJ8bijjJcjz6cXlgDPlX/EOxqq3/dyUeQodVw
         km7X7e/B2VRjiosrp3qZvmioeWlbcOeB8izZJhZnD2YG1LNhm8Y8nrV9w282U2chqiq+
         afvwrYOK3NvpN0HxB5rhEo3PQiPUrOP7GnIis0kcuC4pOoFs3TIIclCaEXX4hFPjyHcN
         BDOuv83ETHm6jPdyqPK2EjabkPGus9GieiN1F+E9pU1lCwCDON9rQjtFeSrBpOpEsKji
         mbBx8Egs5FkRk+IqwcKSkZarjYguTeUaQ0mWKE44yK7C39nbWJsuonUvfmFRLtpIMX1I
         qbyQ==
X-Gm-Message-State: AOJu0YzJ3+RLkHclLS7QBDM3hBeDF80NPjFngxhUOza51rENxdv0hIGS
	JEZY7iiEfzqiTmlbgri+VZd7b9M8nxViAd6PqY67aUjMDS4x5vQAcEJ2SGgnsByC9sReE+jPslV
	kqOnYeUC1KePLp923qYrlG7IwX0rZR3EYTUn74nnj
X-Gm-Gg: Acq92OF8RaJ3uujZZ9eYIHmJJXrY1BdQg5J7hxl8MLqq5VaEvHJx5u3Bgo8N7gMY2Ao
	rweABxqLsQ6w7V5ixO++XTl6u4KjO42suEUotCt1ZybzUHoz0fU6RtLVsxbIeYKreXjQYFIB58R
	giQwXPkmxzd7GaN9HmMgCRknlnu7l9+ckl8M/7XfuZdaLxGrnNzrpyCdb9FAIRjyTS7ZnitdzQK
	UjO5VwqN+/jyFUKbzIL+6tu5E6FpI9IkptCqUlkn09yuoRdgIR1lCcZg3SPiDE0tE/h+d0xGIx3
	LTuE46EhzGMoXpm/HYIMhssowEGrxIrEnZcKJ4ZaP8IubVPQP9M=
X-Received: by 2002:a2e:bc87:0:b0:396:8029:e2e5 with SMTP id
 38308e7fff4ca-396d0a29fe6mr33570011fa.18.1780871388353; Sun, 07 Jun 2026
 15:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-12-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-12-hramamurthy@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sun, 7 Jun 2026 15:29:36 -0700
X-Gm-Features: AVVi8CcnDHB_jYDkuIWCgxnY-uGZ_dRpZ-qj0F5MZzE6jNQTIx2gxTcbBZVRQqU
Message-ID: <CALuQH+W=ZeKk9Z55Hd6FdhG3+uyad1T3y+ZKXbe+oxpOO2u6pQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/15] gve: split up notify block allocation
 and setup paths
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
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
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hramamurthy@google.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FED6651D01

On Tue, Jun 2, 2026 at 4:59=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> Before this patch, notify block allocation and setup occurred in the same
> method. This all occurred before gve_adminq_configure_device_resources,
> which populates the irq_db_indicies array, a DMA region with BAR offsets
> for MSI-X vectors.
>
> The coming mailbox mode will require notify blocks to be set up only
> after receiving the IRQ doorbell offsets, as the request does not work
> with a supplied DMA buffer in the way that admin queue mode does. The
> intended flow in that case would be:
>
> 1) allocate notify blocks
> 2) request doorbell information
> 3) set up MSI-X vectors based on doorbell info
>
> This ordering also works for admin queue mode, so it will be updated to
> match.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h      |   2 +
>  drivers/net/ethernet/google/gve/gve_main.c | 158 ++++++++++++---------
>  2 files changed, 89 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 939b245ed562..e173c14bdc08 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -673,6 +673,7 @@ struct gve_notify_block {
>         struct gve_tx_ring *tx; /* tx rings on this block */
>         struct gve_rx_ring *rx; /* rx rings on this block */
>         u32 irq;
> +       bool irq_requested;
>  };
>
>  /* Tracks allowed and current rx queue settings */
> @@ -953,6 +954,7 @@ struct gve_priv {
>         u64 link_speed;
>         bool up_before_suspend; /* True if dev was up before suspend */
>
> +       bool mgmt_irq_requested;
>         struct gve_ptype_lut *ptype_lut_dqo;
>
>         /* Must be a power of two. */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 06df6d8ad429..98970508ae54 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -425,6 +425,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int =
budget)
>         return work_done;
>  }
>
> +static void gve_free_notify_blocks(struct gve_priv *priv)
> +{
> +       pci_disable_msix(priv->pdev);
> +       if (priv->irq_db_indices) {
> +               dma_free_coherent(&priv->pdev->dev,
> +                                 priv->num_ntfy_blks *
> +                                 sizeof(*priv->irq_db_indices),
> +                                 priv->irq_db_indices,
> +                                 priv->irq_db_indices_bus);
> +               priv->irq_db_indices =3D NULL;
> +       }
> +
> +       kvfree(priv->ntfy_blocks);
> +       priv->ntfy_blocks =3D NULL;
> +       kvfree(priv->msix_vectors);
> +       priv->msix_vectors =3D NULL;
> +}
> +
>  static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
>  {
>         if (priv->numa_node =3D=3D NUMA_NO_NODE)
> @@ -436,11 +454,9 @@ static const struct cpumask *gve_get_node_mask(struc=
t gve_priv *priv)
>  static int gve_alloc_notify_blocks(struct gve_priv *priv)
>  {
>         int num_vecs_requested =3D priv->num_ntfy_blks + 1;
> -       const struct cpumask *node_mask;
> -       unsigned int cur_cpu;
>         int vecs_enabled;
> -       int i, j;
>         int err;
> +       int i;
>
>         priv->msix_vectors =3D kvzalloc_objs(*priv->msix_vectors,
>                                            num_vecs_requested);
> @@ -454,7 +470,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *p=
riv)
>                 dev_err(&priv->pdev->dev, "Could not enable min msix %d/%=
d\n",
>                         GVE_MIN_MSIX, vecs_enabled);
>                 err =3D vecs_enabled;
> -               goto abort_with_msix_vectors;
> +               goto abort;
>         }
>         if (vecs_enabled !=3D num_vecs_requested) {
>                 int new_num_ntfy_blks =3D (vecs_enabled - 1) & ~0x1;
> @@ -477,15 +493,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *=
priv)
>                         priv->rx_cfg.num_queues =3D priv->rx_cfg.max_queu=
es;
>         }
>
> -       /* Setup Management Vector  - the last vector */
> -       snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name), "gve=
-mgmnt@pci:%s",
> -                pci_name(priv->pdev));
> -       err =3D request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vecto=
r,
> -                         gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev, "Did not receive management vec=
tor.\n");
> -               goto abort_with_msix_enabled;
> -       }
>         priv->irq_db_indices =3D
>                 dma_alloc_coherent(&priv->pdev->dev,
>                                    priv->num_ntfy_blks *
> @@ -493,15 +500,65 @@ static int gve_alloc_notify_blocks(struct gve_priv =
*priv)
>                                    &priv->irq_db_indices_bus, GFP_KERNEL)=
;
>         if (!priv->irq_db_indices) {
>                 err =3D -ENOMEM;
> -               goto abort_with_mgmt_vector;
> +               goto abort;
>         }
>
>         priv->ntfy_blocks =3D kvzalloc(priv->num_ntfy_blks *
>                                      sizeof(*priv->ntfy_blocks), GFP_KERN=
EL);
>         if (!priv->ntfy_blocks) {
>                 err =3D -ENOMEM;
> -               goto abort_with_irq_db_indices;
> +               goto abort;
> +       }
> +       return 0;
> +
> +abort:
> +       gve_free_notify_blocks(priv);
> +       return err;
> +}
> +
> +static void gve_teardown_notify_blocks(struct gve_priv *priv)
> +{
> +       int i;
> +
> +       if (!priv->ntfy_blocks)
> +               return;
> +
> +       for (i =3D 0; i < priv->num_ntfy_blks; i++) {
> +               struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> +
> +               if (!block->irq_requested)
> +                       continue;
> +
> +               irq_set_affinity_hint(priv->msix_vectors[i].vector,
> +                                     NULL);
> +               free_irq(priv->msix_vectors[i].vector, block);
> +               block->irq =3D 0;
> +               block->irq_requested =3D false;
> +       }
> +
> +       if (priv->mgmt_irq_requested) {
> +               free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, =
priv);
> +               priv->mgmt_irq_requested =3D false;
> +       }
> +}
> +
> +static int gve_setup_notify_blocks(struct gve_priv *priv)
> +{
> +       const struct cpumask *node_mask;
> +       unsigned int cur_cpu;
> +       int i;
> +       int err;
> +
> +       /* Setup Management Vector  - the last vector */
> +       snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
> +                "gve-mgmnt@pci:%s", pci_name(priv->pdev));
> +       err =3D request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vecto=
r,
> +                         gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev, "Did not receive management vec=
tor.\n");
> +               return err;
>         }
> +       priv->mgmt_irq_requested =3D true;
>
>         /* Setup the other blocks - the first n-1 vectors */
>         node_mask =3D gve_get_node_mask(priv);
> @@ -519,9 +576,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *=
priv)
>                 if (err) {
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to receive msix vector %d\n", i);
> -                       goto abort_with_some_ntfy_blocks;
> +                       goto abort;
>                 }
>                 block->irq =3D priv->msix_vectors[msix_idx].vector;
> +               block->irq_requested =3D true;
>                 irq_set_affinity_and_hint(block->irq,
>                                           cpumask_of(cur_cpu));
>                 block->irq_db_index =3D &priv->irq_db_indices[i].index;
> @@ -535,61 +593,12 @@ static int gve_alloc_notify_blocks(struct gve_priv =
*priv)
>                         cur_cpu =3D cpumask_first(node_mask);
>         }
>         return 0;
> -abort_with_some_ntfy_blocks:
> -       for (j =3D 0; j < i; j++) {
> -               struct gve_notify_block *block =3D &priv->ntfy_blocks[j];
> -               int msix_idx =3D j;
>
> -               irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector=
,
> -                                     NULL);
> -               free_irq(priv->msix_vectors[msix_idx].vector, block);
> -               block->irq =3D 0;
> -       }
> -       kvfree(priv->ntfy_blocks);
> -       priv->ntfy_blocks =3D NULL;
> -abort_with_irq_db_indices:
> -       dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> -                         sizeof(*priv->irq_db_indices),
> -                         priv->irq_db_indices, priv->irq_db_indices_bus)=
;
> -       priv->irq_db_indices =3D NULL;
> -abort_with_mgmt_vector:
> -       free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
> -abort_with_msix_enabled:
> -       pci_disable_msix(priv->pdev);
> -abort_with_msix_vectors:
> -       kvfree(priv->msix_vectors);
> -       priv->msix_vectors =3D NULL;
> +abort:
> +       gve_teardown_notify_blocks(priv);
>         return err;
>  }
>
> -static void gve_free_notify_blocks(struct gve_priv *priv)
> -{
> -       int i;
> -
> -       if (!priv->msix_vectors)
> -               return;
> -
> -       /* Free the irqs */
> -       for (i =3D 0; i < priv->num_ntfy_blks; i++) {
> -               struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> -               int msix_idx =3D i;
> -
> -               irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector=
,
> -                                     NULL);
> -               free_irq(priv->msix_vectors[msix_idx].vector, block);
> -               block->irq =3D 0;
> -       }
> -       free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
> -       kvfree(priv->ntfy_blocks);
> -       priv->ntfy_blocks =3D NULL;
> -       dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> -                         sizeof(*priv->irq_db_indices),
> -                         priv->irq_db_indices, priv->irq_db_indices_bus)=
;
> -       priv->irq_db_indices =3D NULL;
> -       pci_disable_msix(priv->pdev);
> -       kvfree(priv->msix_vectors);
> -       priv->msix_vectors =3D NULL;
> -}
>
>  static void gve_free_control_plane_resources(struct gve_priv *priv)
>  {
> @@ -743,6 +752,7 @@ static void gve_teardown_control_plane_resources(stru=
ct gve_priv *priv)
>
>  static void gve_teardown_device(struct gve_priv *priv)
>  {
> +       gve_teardown_notify_blocks(priv);

Sashiko says:
In gve_remove(), the patch series reordered the teardown sequence to call
destroy_workqueue() before gve_teardown_device().
Because gve_teardown_device() (via gve_teardown_notify_blocks()) is what
calls free_irq() to release the management interrupt, the interrupt remains
active while and after the workqueue is destroyed.
If a management interrupt fires during this window, gve_mgmnt_intr() will
[queue the service task on the work queue].
Can this sequence trigger a use-after-free by enqueuing work on the destroy=
ed
workqueue?

This will be fixed by the disable_work() change in patch 9.


>         gve_teardown_control_plane_resources(priv);
>         gve_adminq_free(priv);
>         /*
> @@ -2463,13 +2473,16 @@ static int gve_setup_device(struct gve_priv *priv=
)
>
>         err =3D gve_alloc_control_plane_resources(priv);
>         if (err)
> -               goto err;
> +               return err;
> +
>         err =3D gve_setup_control_plane_resources(priv);
>         if (err)
> -               goto err;
> +               return err;
> +
> +       err =3D gve_setup_notify_blocks(priv);
> +       if (err)
> +               return err;
>         return 0;
> -err:
> -       return err;
>  }
>
>  static const struct gve_ctrl_ops gve_adminq_ops =3D {
> @@ -2591,6 +2604,9 @@ int gve_reset(struct gve_priv *priv, bool skip_queu=
e_setup)
>                 gve_unregister_qpls(priv);
>         }
>
> +       gve_teardown_notify_blocks(priv);
> +       gve_teardown_control_plane_resources(priv);
> +

Sashiko says:
...
The newly added gve_teardown_control_plane_resources(priv) call already
invokes gve_teardown_clock() internally when device_resources_ok is
set, so is the standalone gve_teardown_clock(priv) call further down
now redundant?

Will remove the redundant call.

>         /* Reset the device by releasing the AQ. Rings and other resource=
s
>          * within the NIC are implicitly destroyed if commands fail.
>          */
> --
> 2.54.0.1013.g208068f2d8-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

