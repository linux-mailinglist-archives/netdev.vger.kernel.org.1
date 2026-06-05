Return-Path: <netdev+bounces-295617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dy4BGidJImrEUgEAu9opvQ
	(envelope-from <netdev+bounces-295617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09E644F74
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=n8lZai3H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDCC3023E1D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F083D4128;
	Fri,  5 Jun 2026 03:57:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AD1FF7C7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 03:57:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631831; cv=pass; b=OdrGUwxR4PkcH19A9TKe4pDalMXU6fO9o2lakZjuxagPMHGfSdGFOSFDKRInsBSdx7gxhCvtFuHzNqqbHRETX7rGsMa+QETiLptKTu0DgJIaMNosgpUSgZwWSQH63iUc4aeYc5DOpjVV5GDfEt8fg2vN1tQfWSclCWYp0YVeYgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631831; c=relaxed/simple;
	bh=eVq2gnoXxl2DuLtBj8boz7pphOMQCCoquCQz50iid5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9OPcpKI7WUc7Pn3CDEFGK6kO27jR9lVlfiKnbkWVPewgmkvlw/g+VNwMb8BhuyvK7CdUSHVjXVAJ0RM+H0ThsV0LKa22ajcSd165ylWwLrDJ9C2/1WqcDLnRGZzlyu/Fj+e/hdmV7OnIiM0P1bXn4llkl3KwF6VfSyi5JkyndY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8lZai3H; arc=pass smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2d865383so43515ad.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 20:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780631829; cv=none;
        d=google.com; s=arc-20240605;
        b=iEsKVm+V2b849a2kuukboK2PZgZ3Eoqc1JG96mSOvJLEoCoz6tAW0jZSEjpjWHQeol
         0xJlFW68+cLXZMhrnm7t5q77f524qd0ime7rfmKFAwqkWzOx2SQsdS89bMNQIvpcMz+6
         9IpqNLBYkbkemkIjcmYhFEebIwgDhHI/LKdlnbV5Dc5wB+5591lqTOadfDmSSSVVd3Ve
         tVDox4ff3b5ukgaZYjioHaxzkDWf5rB+Du4zX4Jm9HXaLoLFDM72yJxVM3f5B+FdaIEe
         8qQ7fa5vyeZhTDbETwOFuDckyDjcafofG+b7B/mEYnGN14KijSab970uoYIbGpoRpmKS
         wEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iq7W9i9+xoLlnps1Syt0aIJ4mwxy1YJhpqJiWdE/ptE=;
        fh=Ef9lcZO4ZwrztREP42xReRHLmD9Hg2GQuFQd3HW9yBk=;
        b=LhQxDa1WiWMI5Sd/oL7pdUjEYdkv7/E+5m4RbeWZ2GzA/xYU60pm6tuTfGzEOV+zY1
         mHyNy1I7yWUrUhHQO6TtkHHPreLzLl3WOqkbdr209J3c8/Uv+swG9UAzjuTdFCeMj2Z9
         ZahNlLEaIPi7Nb08Ta3PExE/DC1YOx5CFNQx3tvyyUb4DKxmWwPbTHqR4TTtBwoUgYqh
         taR50X8XJdgqW/08F5xOpq4G3/YdajvMtfLA5a4sdu2T0Qdk4ZI97cHvVPi6DMom85fU
         EFfuYrH08z2YHEIQIcfQC4mMp5fSweXelyJUBeZVKBZiCQK+1VfVBBeMiP+bTMnAgu/J
         a0Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780631829; x=1781236629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq7W9i9+xoLlnps1Syt0aIJ4mwxy1YJhpqJiWdE/ptE=;
        b=n8lZai3H4v3BbVZA+3Oba6iuRKSNhymWHZrs8k6phs0Rj8J1C1lpFwwSkeGNU6nstv
         2zTypFSvZPIlwUTTFIpMBI52RWTNXKwkvquBJNG5aR4U0TQFPN3K9h4QFdXTq55oWFci
         3j6QDlBjc3jUvzj7PtIOvqG/yNoAX1CCier9Rq99R1MwJPVyjrJ53l5endyVWEhJiQHD
         xZoTp+mwtT9lzm24WfZ5yWntfOF9/qiqU6TT6tQThP+puq8yA6EBBV9k6gLwazCWiaT9
         LFKMByzt4W5PZznS+RSYcmbI7hhRTuzrOg8Smj3BaVkV5TYxrYf8+edQBpvmOAeZ3MeE
         KHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631829; x=1781236629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iq7W9i9+xoLlnps1Syt0aIJ4mwxy1YJhpqJiWdE/ptE=;
        b=LaPUxMKkL/hPFb+H+QCn1w7V25NX3YyXhGnZ4D2/B3HrbSkxYuAY4c0BirErR612g0
         egsB9n5zuI6/EUK+Sr/GHDVlJPGwZxQWxatjmpMRXak2Q5Wbs+qe594EQxo+ZooK8Ayb
         00jX/aD0dc8Q0OqkOqNhBpMW0HpIcENKX17rcYZc9/2EWia9CpY2GwkNnOyzF7s8sRzl
         njBuBumnUv5STsf6bIxA7P3B8/FiTxZDOJWbhfjzjprCM8Yx/OukUiQL7KF9L1HUuYnJ
         kq8xYjfwK5juKlZT6Hok6coFA/C4UOJ8oANdzVtCh6UTUhAuCMTiGM+1mUSoaTgJfBWr
         86Uw==
X-Gm-Message-State: AOJu0Yx9VWJysOHNVXH4eDOXbOhNabmNEx+gPwz7rZltkfHLPpwEoJvQ
	xx4dnJKqjwaSiMAofeROQATYhQOoRMUocZKCaKmHVqiLkqgNVbD+sgsLRCaYO82Nn2MniHrDUCr
	MHIWmGhrFdbKR8NAINGPJezDE1nwmvchekK+SEHallvnWYivMw9wm0N5hhFbytA==
X-Gm-Gg: Acq92OHf0X85rUMswKL+U/woeKnHjjeqxupdDj0uoLLDtrQ2y7P5JLxPc+0LyVgerAV
	oXuYukfnzZXaVy0wAf185VKz2ZrYH+7w/V+qiwYGIJwoYADxr5xdL+4QE0PGK5VkDGg6SoBeh/G
	tEsz7K2EQHFAa1xtwjPdWu7A2x9EDwax4Ai+udzpRjhXkn9xvOr4GUl0xIFOUyfSqxdc1dN/H7F
	IQV4opXkqvU0RIiTi6MQoxpk9q+BdCEer1cYpnFA57Amw5CNpbsfMVnCKAxZ/LNsb23BzwBEE5a
	6TIT8bKHzk+kefWrsFkVNrd2mfe5m/KpRREYixMmVibIe9MLi064l7CoNd/SnNLkjcmFv/Yb6lx
	3yEa5Amj6oW8ak/cOZlU=
X-Received: by 2002:a17:903:1aed:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2c1eb72a130mr645275ad.4.1780631828851; Thu, 04 Jun 2026
 20:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-15-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-15-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 4 Jun 2026 20:56:57 -0700
X-Gm-Features: AVHnY4LNyIXn-v77q7_757OSS5W3GEkr_HncoLwG4fOF5npzYI-WF-Xu3jhkP8U
Message-ID: <CAEAWyHedn-5QgbuiyPA2UkpyMH6Y7Bw35JhEUjLp+k7+-a9NGA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 14/15] gve: add ctrl ops to for queue operations
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295617-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE09E644F74

On Tue, Jun 2, 2026 at 4:59=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> Add the next few control ops to
>
> - create queues
> - destroy queues
>
> These changes are just moving existing code into ops, no functional
> change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v2:
> - Fixed typo in commit message (exisiting -> existing)
>
>  drivers/net/ethernet/google/gve/gve.h        |  4 ++
>  drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h |  3 +-
>  drivers/net/ethernet/google/gve/gve_main.c   | 41 ++++------------
>  4 files changed, 65 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index b2e578b3d450..4283cb9b49de 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -841,6 +841,8 @@ struct gve_device_info {
>   * @configure_rss: Set up default RSS configuration
>   * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
>   * @reset_flow_rules: Flush all flow rules from device
> + * @create_queues: Sends commands to the device to create TX/RX queues.
> + * @destroy_queues: Sends commands to the device to destroy TX/RX queues=
.
>   */
>  struct gve_ctrl_ops {
>         int (*map_db_bar)(struct gve_priv *priv);
> @@ -859,6 +861,8 @@ struct gve_ctrl_ops {
>                                   dma_addr_t stats_report_addr,
>                                   u64 interval_ms); /* AQ-specific */
>         int (*reset_flow_rules)(struct gve_priv *priv);
> +       int (*create_queues)(struct gve_priv *priv);
> +       int (*destroy_queues)(struct gve_priv *priv);
>  };
>
>  struct gve_priv {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 5dc5c63cee32..799381d24c71 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -941,6 +941,30 @@ static void gve_set_default_rss_sizes(struct gve_pri=
v *priv)
>         }
>  }
>
> +int gve_adminq_destroy_queues(struct gve_priv *priv)
> +{
> +       int num_tx_queues =3D gve_num_tx_queues(priv);
> +       int err;
> +
> +       err =3D gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev,
> +                         "failed to destroy tx queues\n");
> +               /* This failure will trigger a reset - no need to clean u=
p */
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
> +       err =3D gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queue=
s);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev,
> +                         "failed to destroy rx queues\n");
> +               /* This failure will trigger a reset - no need to clean u=
p */
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
> +       return err;
> +}
> +
>  static void gve_enable_supported_features(struct gve_priv *priv,
>                                           u32 supported_features_mask,
>                                           const struct gve_device_option_=
jumbo_frames
> @@ -1822,3 +1846,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv =
*priv)
>                 priv->mgmt_irq_requested =3D false;
>         }
>  }
> +
> +int gve_adminq_create_queues(struct gve_priv *priv)
> +{
> +       int num_tx_queues =3D gve_num_tx_queues(priv);
> +       int err;
> +
> +       err =3D gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev, "failed to create %d tx q=
ueues\n",
> +                         num_tx_queues);
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
> +                 num_tx_queues);
> +
> +       err =3D gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues=
);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev, "failed to create %d rx q=
ueues\n",
> +                         priv->rx_cfg.num_queues);
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
> +                 priv->rx_cfg.num_queues);
> +
> +       return err;
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index ff656fb4f113..03e8318f7327 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -628,6 +628,8 @@ int gve_adminq_configure_device_resources(struct gve_=
priv *priv,
>                                           dma_addr_t db_array_bus_addr,
>                                           u32 num_ntfy_blks);
>  int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
> +int gve_adminq_create_queues(struct gve_priv *priv);
> +int gve_adminq_destroy_queues(struct gve_priv *priv);
>  int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32=
 num_queues);
>  int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u3=
2 num_queues);
>  int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_i=
ndex);
> @@ -661,5 +663,4 @@ int gve_adminq_request_db_info(struct gve_priv *priv)=
;
>  void gve_adminq_free_db_resources(struct gve_priv *priv);
>  int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
>  void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
> -
>  #endif /* _GVE_ADMINQ_H */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 9d00093826e3..dfc734d8bec9 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -841,33 +841,18 @@ static int gve_unregister_qpls(struct gve_priv *pri=
v)
>
>  static int gve_create_rings(struct gve_priv *priv)
>  {
> -       int num_tx_queues =3D gve_num_tx_queues(priv);
>         int err;
>         int i;
>
> -       err =3D gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
> +       err =3D priv->ctrl_ops->create_queues(priv);
>         if (err) {
> -               netif_err(priv, drv, priv->dev, "failed to create %d tx q=
ueues\n",
> -                         num_tx_queues);
> -               /* This failure will trigger a reset - no need to clean
> -                * up
> -                */
> -               return err;
> -       }
> -       netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
> -                 num_tx_queues);
> -
> -       err =3D gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues=
);
> -       if (err) {
> -               netif_err(priv, drv, priv->dev, "failed to create %d rx q=
ueues\n",
> -                         priv->rx_cfg.num_queues);
> +               netif_err(priv, drv, priv->dev,
> +                         "failed to create queues\n");

Commenting on Sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602235900.3050782-=
1-hramamurthy%40google.com

"The commit message states "These changes are just moving existing code
into ops, no functional change." but on the failure path the driver now
emits two error messages instead of one. Is this intended?"

Will remove double logging in v3.

>                 /* This failure will trigger a reset - no need to clean
>                  * up
>                  */
>                 return err;
>         }
> -       netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
> -                 priv->rx_cfg.num_queues);
>
>         if (gve_is_gqi(priv)) {
>                 /* Rx data ring has been prefilled with packet buffers at=
 queue
> @@ -1022,26 +1007,16 @@ static int gve_queues_mem_alloc(struct gve_priv *=
priv,
>
>  static int gve_destroy_rings(struct gve_priv *priv)
>  {
> -       int num_tx_queues =3D gve_num_tx_queues(priv);
>         int err;
>
> -       err =3D gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +       err =3D priv->ctrl_ops->destroy_queues(priv);
> +
>         if (err) {
> -               netif_err(priv, drv, priv->dev,
> -                         "failed to destroy tx queues\n");
>                 /* This failure will trigger a reset - no need to clean u=
p */
> -               return err;
> -       }
> -       netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
> -       err =3D gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queue=
s);
> -       if (err) {
>                 netif_err(priv, drv, priv->dev,
> -                         "failed to destroy rx queues\n");
> -               /* This failure will trigger a reset - no need to clean u=
p */
> -               return err;
> +                         "failed to destroy queues\n");
>         }
> -       netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
> -       return 0;
> +       return err;
>  }
>
>  static void gve_queues_mem_free(struct gve_priv *priv,
> @@ -2450,6 +2425,8 @@ static const struct gve_ctrl_ops gve_adminq_ops =3D=
 {
>         .free_db_resources      =3D gve_adminq_free_db_resources,
>         .setup_mgmt_irq         =3D gve_adminq_setup_mgmt_irq,
>         .teardown_mgmt_irq      =3D gve_adminq_teardown_mgmt_irq,
> +       .create_queues          =3D gve_adminq_create_queues,
> +       .destroy_queues         =3D gve_adminq_destroy_queues,
>  };
>
>  static int gve_init_priv(struct gve_priv *priv)
> --
> 2.54.0.1013.g208068f2d8-goog
>

