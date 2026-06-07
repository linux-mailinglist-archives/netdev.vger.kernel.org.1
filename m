Return-Path: <netdev+bounces-296321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DaMJE5fyJWqPOwIAu9opvQ
	(envelope-from <netdev+bounces-296321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:37:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0A651D15
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rDWcLEYW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296321-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15760300FEF3
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF723822BE;
	Sun,  7 Jun 2026 22:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442F374178
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 22:36:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871775; cv=pass; b=jcYzhggRbv531khaivaEdPBcvof90nehrHCLJfnags8lOxOLja/f811aGAx/3Xf6hrs/LkkOySAVvT4UqY0zw6pP+BZ0KBU5TwY1NInBnaLEi+ftcP1bsFn8HgACIZyNTrMYN5tzeIJJDSKT1YIctPAgF+S6Sg/poVRsrPKEg5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871775; c=relaxed/simple;
	bh=TErFwJGEdkVdcJt/SQhCRv2bPnrAJ/KYIvGpDkzPPPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTY6y+Bh3t1NVN18+n6fvOaQk1RrHyS0mYgrrj6aPCHSoIU9jYVtMGpr/HO6sHBS/jpbhrXv0x+kQcDKXqWHSdC3Aw2Vh5Q2PN+Yr0nCCOVamksyCgVA8+vd9dSTF110xiini2U+mKPI9s6cQinIIfWlr6wTRjx4OSapC9iocJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDWcLEYW; arc=pass smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39676ff4674so33596061fa.0
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 15:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780871771; cv=none;
        d=google.com; s=arc-20240605;
        b=lWE4575JK2SPkd2btZ1Ki5lEOJKM/sut60LuZamBRNEhoy7w3MbGyjDWUSO7mbIytp
         fo79ZqVFyaslskS28Jxz9PuIE5vwUeafDdkUnQG+1uTQRhmWO4dO4l5jdl6I67ZRTeIN
         tMvslYk2ZqOtnUZ352WRS5Fdw6uH+pEmmWia1Nbnf/EnlhXtt2rb+k8X8HhyO69aYthI
         dgCpAzfSLXrarHO8+alusRmldx6GVlYxLGli8lW54r1ZEARLpVYwj4OO5Nb38oO6ECKu
         q4CBKqu4x1sQG5npQkvottXC0saRSdtUVmCcikUkQEJQs8KEZlJx0hZCvj1AoH2Aaa6b
         5dTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O47ygZEufdfHc/7nYC6/iSnyjoub4LFJHkzbkVgfsiU=;
        fh=+8eu1zxn6dzJPeKJi+J9GJyeu9j9o/OlXv1xkTsljAk=;
        b=TR3WQm/620W7AuqqonpzxfvCWhUZfEMZ2MbmvueUsZQ6VSPdEQQLPQcEQTLE94VGGF
         guhccFMpheFT/ZTLzI707+wDi0x7fpimbzGUJCemxWULzWG0FU3fK1bMFpL71I++GWyv
         yTeyejQyYvchmljJG8Cc03UxniseTUVpdzv1ChSbtA+flIJP9d3Ky87ONcwFL4qLyzwp
         +FjIFWOm63zaPZ2QBrcVUS1aRgsIBK+5eDO0EuEP2VkPIJYWAIWBvXeVz/HlxACP97Pl
         /PX579ANlQ7L4q2iGKCgSp0vJW1EX25Dwev82aQgvvXVCAE5NSe0RFeFismjqGAifxC4
         vNUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780871771; x=1781476571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O47ygZEufdfHc/7nYC6/iSnyjoub4LFJHkzbkVgfsiU=;
        b=rDWcLEYWWpSZUTbeZou8x1AX0Mxc8a6qJuKeX+34+n5iZ8hIlEHuQ8dPl+KBfAmGZl
         sltVVcFY//CWF+pZivzOUPM6xCdfeB8pcBZYG6vICsNefUjOA6Xh+MLY8nA4JKtU9t4f
         cM3KJgi8dPnsrpRCcG4EEdgbG3Xxi9f/6aESiUkhpvMCCqqT43lbr5Nrn+zChGbURd+P
         pum1gnyGJh23ws9ynMPHptIqZjoGRjJxl4CnJ/q2JZjDkw5zdUn0H/wNkJ3wafszKOtW
         puzvhGh8MyaOs7a/kvDhtSstRV+bfAZaMQy58sMyQgrl/FE7ZbIyUt6N21xiUYuoqmuU
         jJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780871771; x=1781476571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O47ygZEufdfHc/7nYC6/iSnyjoub4LFJHkzbkVgfsiU=;
        b=bvJqJ069z1ci4DVt5ialqHPDZdsD3Aull1zpgXDpzThQsQfSRUl+/JF7rAqxIVyH7i
         /rIWKTeLwHuI8ltXlWgQlRtYPCbFU9IyTRZO1GYFYvqd9XxNcSQ/pZ4Q6cHOShhBEUAK
         KI67+pu67YsTVEteDSRCF/PZJFYNRJKz42wY8RiGDMSga8pCCTlkYRdEI3a3qLu3l3i6
         ur/jdQRu3Q/WrlYmL+9U1fZulvjTlxZFg2qzP51s10WYy5hE0qnqADaWpmWpGGlR9ruv
         WES1mUCyh6BWHnkXCy3rsrQcTXN34sDtTPc8Jb2zMENHcemS+y3r+Rw1LTDkBEPhFw33
         LokQ==
X-Gm-Message-State: AOJu0YzzAPVdEXqZ/T/jzFw3xdwVRrOMmHhCCgGJ1jkHvtcZC56jR4kD
	n1i7NLhBH2AnUOgg50TXaWCz4UeOwAYAzq4UnSM8YEQ5gxpwzWCTYeCdFyNFBFMtzM3Khr59xkU
	wOxxtXz1Ug7kbNjHSOpkHlrMppg1gZ04WmFBQ6j4J
X-Gm-Gg: Acq92OFCuXJbEdh23Adz023CwEXyRB4feNhqWLlIkylpO0EJ+hiBCiBu4TFjVzMyxoG
	weRQwCed8/CT+dqnQgdnsVpUo2lwlyiL3ftIrvn6eK4bfAdrbvq/kGe0tkRqieu79ytyNZHaa6U
	Ed8xryPZmEK2jpr+r+jFVS0bXTps/iIg/SOC4y57H4UWhpRlUaFsjTWYETjy+1BEW1RITz37SL0
	vS5yQl8PpeB1w8xG0dbr54vijBI/xNC6WyUenHgpuSSo/+XWGB2TF8Ulhye1q+VI14Jc66c/h0q
	79q91Mvt9ebfVN37M65+IvjC+j4IvgVzC5nQJYSX55elQXJSDVE=
X-Received: by 2002:a05:651c:1502:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-396d07f065cmr35388801fa.6.1780871770106; Sun, 07 Jun 2026
 15:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-13-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-13-hramamurthy@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sun, 7 Jun 2026 15:35:57 -0700
X-Gm-Features: AVVi8Ce-xXcKIiAgjEf6lgnRSFRZ6j1BGweYWmWIZKAmmyuWIuP4El-35C8Kw54
Message-ID: <CALuQH+X3mbsWWfsRugySRXujY7f1uNAOzXmovRptGoq=wk6ELw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/15] gve: introduce new methods to handle
 IRQ doorbells
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:hramamurthy@google.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82A0A651D15

On Tue, Jun 2, 2026 at 4:59=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> Introduce `request_db_info` and `free_db_resources` to
> `struct gve_ctrl_ops`. These encapsulate the configuration of device
> resources (counter arrays and IRQ doorbell indices) which vary between
> Admin Queue and Mailbox modes. All behaviors related to the IRQ doorbell
> indices will be managed by these new methods instead of occurring
> directly in notify_block setup/teardown methods. Similarly, GQ ring
> counters will be managed in `request_db_info`.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        | 12 ++++
>  drivers/net/ethernet/google/gve/gve_adminq.c | 71 ++++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
>  drivers/net/ethernet/google/gve/gve_main.c   | 70 +++++--------------
>  4 files changed, 103 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index e173c14bdc08..6db5fbc0b321 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -833,6 +833,8 @@ struct gve_device_info {
>   *                  structures stored in @priv to be used during initial=
ization.
>   * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
>   *                     initialization.
> + * @request_db_info: Request and store doorbell information into @priv
> + * @free_db_resources: Free DMA memory holding doorbell info (AdminQ onl=
y)
>   * @get_ptype_map: Learn packet type map from device and store it in @pr=
iv
>   * @configure_rss: Set up default RSS configuration
>   * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
> @@ -843,6 +845,8 @@ struct gve_ctrl_ops {
>         void (*unmap_db_bar)(struct gve_priv *priv);
>         void (*set_num_queues)(struct gve_priv *priv);
>         int (*set_num_ntfy_blks)(struct gve_priv *priv);
> +       int (*request_db_info)(struct gve_priv *priv);
> +       void (*free_db_resources)(struct gve_priv *priv);
>         int (*get_ptype_map)(struct gve_priv *priv);
>         int (*configure_rss)(struct gve_priv *priv,
>                              struct ethtool_rxfh_param *param);
> @@ -1163,6 +1167,11 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_pr=
iv *priv, u32 queue_idx)
>         return (priv->num_ntfy_blks / 2) + queue_idx;
>  }
>
> +static inline u32 gve_ntfy_to_msix_idx(struct gve_priv *priv, u32 ntfy_b=
lk_idx)
> +{
> +       return ntfy_blk_idx;
> +}
> +
>  static inline bool gve_is_qpl(struct gve_priv *priv)
>  {
>         return priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT ||
> @@ -1375,6 +1384,9 @@ int gve_adjust_queues(struct gve_priv *priv,
>                       struct gve_rx_queue_config new_rx_config,
>                       struct gve_tx_queue_config new_tx_config,
>                       bool reset_rss);
> +/* Initialization sequence */
> +int gve_alloc_counter_array(struct gve_priv *priv);
> +void gve_free_counter_array(struct gve_priv *priv);
>  /* flow steering rule */
>  int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc =
*cmd);
>  int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *c=
md, u32 *rule_locs);
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index d814108deeef..259dcd617216 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1719,3 +1719,74 @@ void gve_adminq_set_num_queues(struct gve_priv *pr=
iv)
>                                                 device_info->default_rx_q=
ueues,
>                                                 priv->rx_cfg.num_queues);
>  }
> +
> +int gve_adminq_request_db_info(struct gve_priv *priv)
> +{
> +       int err;
> +       int i;
> +
> +       /* Alloc dma addrs needed for shm regions */
> +       err =3D gve_alloc_counter_array(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Failed to alloc db counter array.");
> +               return err;
> +       }
> +
> +       priv->irq_db_indices =3D
> +               dma_alloc_coherent(&priv->pdev->dev,
> +                                  priv->num_ntfy_blks *
> +                                  sizeof(*priv->irq_db_indices),
> +                                  &priv->irq_db_indices_bus, GFP_KERNEL)=
;
> +       if (!priv->irq_db_indices) {
> +               err =3D -ENOMEM;
> +               goto abort_with_counter_array;
> +       }
> +
> +       err =3D gve_adminq_configure_device_resources(priv,
> +                                                   priv->counter_array_b=
us,
> +                                                   priv->num_event_count=
ers,
> +                                                   priv->irq_db_indices_=
bus,
> +                                                   priv->num_ntfy_blks);
> +       if (unlikely(err)) {
> +               dev_err(&priv->pdev->dev,
> +                       "could not setup device_resources: err=3D%d\n", e=
rr);
> +               err =3D -ENXIO;
> +               goto abort_with_irq_db_indices;
> +       }
> +
> +       for (i =3D 0; i < priv->num_ntfy_blks; i++)
> +               priv->ntfy_blocks[i].irq_db_index =3D
> +                       &priv->irq_db_indices[i].index;
> +       return 0;
> +
> +abort_with_irq_db_indices:
> +       dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> +                         sizeof(*priv->irq_db_indices),
> +                         priv->irq_db_indices, priv->irq_db_indices_bus)=
;
> +       priv->irq_db_indices =3D NULL;
> +abort_with_counter_array:
> +       gve_free_counter_array(priv);
> +       return err;
> +}

Sashiko says:
Does this error path introduce a use-after-free window?
If the configure command in gve_adminq_configure_device_resources() times
out (e.g. returns -ETIME), the hardware might still be running and attempti=
ng
to access the memory.
Since we immediately free the DMA memory via dma_free_coherent() and
gve_free_counter_array() before the hardware is guaranteed to be stopped, c=
an
the hardware overwrite reallocated kernel memory?

Will move the allocation/free to alloc/free_control_plane_resources.
See the separate concern regarding performing the freeing in
`free_db_resources`.

> +
> +void gve_adminq_free_db_resources(struct gve_priv *priv)
> +{
> +       int err;
> +
> +       /* Log error in deconfigure device, but don't fail. This is only =
ever
> +        * called as a reset is about to be triggered, so it would be red=
undant
> +        * to trigger a reset.
> +        */
> +       err =3D gve_adminq_deconfigure_device_resources(priv);
> +       if (err)
> +               dev_err(&priv->pdev->dev,
> +                       "Could not deconfigure device resources: err=3D%d=
\n",
> +                       err);
> +
> +       dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> +                         sizeof(*priv->irq_db_indices),
> +                         priv->irq_db_indices, priv->irq_db_indices_bus)=
;
> +       priv->irq_db_indices =3D NULL;
> +       gve_free_counter_array(priv);
> +}

Sashiko says:
Could freeing the DMA memory here cause memory corruption?
In an earlier patch in this series ('gve: simplify reset logic'), the teard=
own
logic was explicitly fixed to delay freeing shared resources until after
gve_adminq_free() triggers a device reset.
However, gve_teardown_device() executes gve_teardown_control_plane_resource=
s()
(which now calls ops->free_db_resources()) before gve_adminq_free().
If the deconfigure command in gve_adminq_deconfigure_device_resources() tim=
es
out or fails, the active hardware might continue writing to the freed DMA
memory since the device hasn't been reset yet.

This is a tricky problem. It looks like there is no real choice but to
re-introduce admin queue-specific allocation paths back into
`alloc_control_plane_resources` :/

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index d5f98a80be46..985b1aefea6e 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -657,5 +657,7 @@ int gve_adminq_map_db_bar(struct gve_priv *priv);
>  void gve_adminq_unmap_db_bar(struct gve_priv *priv);
>  int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
>  void gve_adminq_set_num_queues(struct gve_priv *priv);
> +int gve_adminq_request_db_info(struct gve_priv *priv);
> +void gve_adminq_free_db_resources(struct gve_priv *priv);
>
>  #endif /* _GVE_ADMINQ_H */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 98970508ae54..55f48aee125e 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -179,7 +179,7 @@ static void gve_free_rss_config_cache(struct gve_priv=
 *priv)
>         memset(rss_config, 0, sizeof(*rss_config));
>  }
>
> -static int gve_alloc_counter_array(struct gve_priv *priv)
> +int gve_alloc_counter_array(struct gve_priv *priv)
>  {
>         priv->counter_array =3D
>                 dma_alloc_coherent(&priv->pdev->dev,
> @@ -192,7 +192,7 @@ static int gve_alloc_counter_array(struct gve_priv *p=
riv)
>         return 0;
>  }
>
> -static void gve_free_counter_array(struct gve_priv *priv)
> +void gve_free_counter_array(struct gve_priv *priv)
>  {
>         if (!priv->counter_array)
>                 return;
> @@ -428,15 +428,6 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int =
budget)
>  static void gve_free_notify_blocks(struct gve_priv *priv)
>  {
>         pci_disable_msix(priv->pdev);
> -       if (priv->irq_db_indices) {
> -               dma_free_coherent(&priv->pdev->dev,
> -                                 priv->num_ntfy_blks *
> -                                 sizeof(*priv->irq_db_indices),
> -                                 priv->irq_db_indices,
> -                                 priv->irq_db_indices_bus);
> -               priv->irq_db_indices =3D NULL;
> -       }
> -
>         kvfree(priv->ntfy_blocks);
>         priv->ntfy_blocks =3D NULL;
>         kvfree(priv->msix_vectors);
> @@ -493,24 +484,14 @@ static int gve_alloc_notify_blocks(struct gve_priv =
*priv)
>                         priv->rx_cfg.num_queues =3D priv->rx_cfg.max_queu=
es;
>         }
>
> -       priv->irq_db_indices =3D
> -               dma_alloc_coherent(&priv->pdev->dev,
> -                                  priv->num_ntfy_blks *
> -                                  sizeof(*priv->irq_db_indices),
> -                                  &priv->irq_db_indices_bus, GFP_KERNEL)=
;
> -       if (!priv->irq_db_indices) {
> -               err =3D -ENOMEM;
> -               goto abort;
> -       }
> -
>         priv->ntfy_blocks =3D kvzalloc(priv->num_ntfy_blks *
>                                      sizeof(*priv->ntfy_blocks), GFP_KERN=
EL);
>         if (!priv->ntfy_blocks) {
>                 err =3D -ENOMEM;
>                 goto abort;
>         }
> -       return 0;
>
> +       return 0;
>  abort:
>         gve_free_notify_blocks(priv);
>         return err;
> @@ -525,13 +506,14 @@ static void gve_teardown_notify_blocks(struct gve_p=
riv *priv)
>
>         for (i =3D 0; i < priv->num_ntfy_blks; i++) {
>                 struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> +               int msix_idx =3D gve_ntfy_to_msix_idx(priv, i);
>
>                 if (!block->irq_requested)
>                         continue;
>
> -               irq_set_affinity_hint(priv->msix_vectors[i].vector,
> +               irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector=
,
>                                       NULL);
> -               free_irq(priv->msix_vectors[i].vector, block);
> +               free_irq(priv->msix_vectors[msix_idx].vector, block);
>                 block->irq =3D 0;
>                 block->irq_requested =3D false;
>         }
> @@ -560,12 +542,11 @@ static int gve_setup_notify_blocks(struct gve_priv =
*priv)
>         }
>         priv->mgmt_irq_requested =3D true;
>
> -       /* Setup the other blocks - the first n-1 vectors */
>         node_mask =3D gve_get_node_mask(priv);
>         cur_cpu =3D cpumask_first(node_mask);
>         for (i =3D 0; i < priv->num_ntfy_blks; i++) {
>                 struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> -               int msix_idx =3D i;
> +               int msix_idx =3D gve_ntfy_to_msix_idx(priv, i);
>
>                 snprintf(block->name, sizeof(block->name), "gve-ntfy-blk%=
d@pci:%s",
>                          i, pci_name(priv->pdev));
> @@ -575,14 +556,13 @@ static int gve_setup_notify_blocks(struct gve_priv =
*priv)
>                                   IRQF_NO_AUTOEN, block->name, block);
>                 if (err) {
>                         dev_err(&priv->pdev->dev,
> -                               "Failed to receive msix vector %d\n", i);
> +                               "Failed to receive msix vector %d\n", msi=
x_idx);
>                         goto abort;
>                 }
>                 block->irq =3D priv->msix_vectors[msix_idx].vector;
>                 block->irq_requested =3D true;
>                 irq_set_affinity_and_hint(block->irq,
>                                           cpumask_of(cur_cpu));
> -               block->irq_db_index =3D &priv->irq_db_indices[i].index;
>
>                 cur_cpu =3D cpumask_next(cur_cpu, node_mask);
>                 /* Wrap once CPUs in the node have been exhausted, or whe=
n
> @@ -599,7 +579,6 @@ static int gve_setup_notify_blocks(struct gve_priv *p=
riv)
>         return err;
>  }
>
> -
>  static void gve_free_control_plane_resources(struct gve_priv *priv)
>  {
>         bitmap_free(priv->xsk_pools);
> @@ -608,9 +587,8 @@ static void gve_free_control_plane_resources(struct g=
ve_priv *priv)
>         kvfree(priv->ptype_lut_dqo);
>         priv->ptype_lut_dqo =3D NULL;
>
> -       gve_free_stats_report(priv);
>         gve_free_notify_blocks(priv);
> -       gve_free_counter_array(priv);
> +       gve_free_stats_report(priv);
>         gve_free_rss_config_cache(priv);
>         gve_free_flow_rule_caches(priv);
>  }
> @@ -623,9 +601,6 @@ static int gve_alloc_control_plane_resources(struct g=
ve_priv *priv)
>         if (err)
>                 return err;
>         err =3D gve_alloc_rss_config_cache(priv);
> -       if (err)
> -               goto abort;
> -       err =3D gve_alloc_counter_array(priv);
>         if (err)
>                 goto abort;
>         err =3D gve_alloc_notify_blocks(priv);
> @@ -661,15 +636,9 @@ static int gve_setup_control_plane_resources(struct =
gve_priv *priv)
>         const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>         int err;
>
> -       err =3D gve_adminq_configure_device_resources(priv,
> -                                                   priv->counter_array_b=
us,
> -                                                   priv->num_event_count=
ers,
> -                                                   priv->irq_db_indices_=
bus,
> -                                                   priv->num_ntfy_blks);
> -       if (unlikely(err)) {
> -               dev_err(&priv->pdev->dev,
> -                       "could not setup device_resources: err=3D%d\n", e=
rr);
> -               err =3D -ENXIO;
> +       err =3D ops->request_db_info(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev, "Failed to get db info");
>                 return err;
>         }
>
> @@ -678,7 +647,7 @@ static int gve_setup_control_plane_resources(struct g=
ve_priv *priv)
>                 if (err) {
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to get ptype map: err=3D%d\n", er=
r);
> -                       goto deconfigure_device;
> +                       goto free_db_resources;
>                 }
>         }
>
> @@ -708,8 +677,8 @@ static int gve_setup_control_plane_resources(struct g=
ve_priv *priv)
>
>  teardown_clock:
>         gve_teardown_clock(priv);
> -deconfigure_device:
> -       gve_adminq_deconfigure_device_resources(priv);
> +free_db_resources:
> +       ops->free_db_resources(priv);
>         return err;
>  }
>
> @@ -739,12 +708,7 @@ static void gve_teardown_control_plane_resources(str=
uct gve_priv *priv)
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to detach stats report: err=3D%d\=
n", err);
>                 gve_teardown_clock(priv);
> -
> -               err =3D gve_adminq_deconfigure_device_resources(priv);
> -               if (err)
> -                       dev_err(&priv->pdev->dev,
> -                               "Could not deconfigure device resources: =
err=3D%d\n",
> -                               err);
> +               ops->free_db_resources(priv);
>         }
>
>         gve_clear_device_resources_ok(priv);
> @@ -2494,6 +2458,8 @@ static const struct gve_ctrl_ops gve_adminq_ops =3D=
 {
>         .reset_flow_rules       =3D gve_adminq_reset_flow_rules,
>         .setup_stats_report     =3D gve_adminq_report_stats,
>         .configure_rss          =3D gve_adminq_configure_rss,
> +       .request_db_info        =3D gve_adminq_request_db_info,
> +       .free_db_resources      =3D gve_adminq_free_db_resources,
>  };
>
>  static int gve_init_priv(struct gve_priv *priv)
> --
> 2.54.0.1013.g208068f2d8-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

