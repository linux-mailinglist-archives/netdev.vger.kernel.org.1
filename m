Return-Path: <netdev+bounces-284585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id awntGmxj+mloOgMAu9opvQ
	(envelope-from <netdev+bounces-284585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:38:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D26224D3F51
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F28BB300C815
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE448BD3B;
	Tue,  5 May 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvFquWNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B848A2C3
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017128; cv=pass; b=QB0eyWawPW6HXJWxrFQJ8o4Iy1JC5LB+7HyazumJ1DJ/tzbDdVTrePIncR6AZ/i2alAPIB0pATGnMBuaeeJKLcXJr49OlJf/6n3i4vDcXV79qwWLgHVaTe/hofrpEhwN9hKWbA1ej9XajwKkos4m95o02aj+nsvGkG2cjhcxJWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017128; c=relaxed/simple;
	bh=o56SsozYLnBS7QqkJg3mhCPwcci7VSGnHl+GaSefSOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srN1lc5uyUR4TtYWreKqXQbk0WYZG6KFlCVQIro4fczUYXKvPgVtW9VTPGukQepc4XnEJbdUbQu3PjR9/yR1KW6fg+7lc9D9UVgTMKETh5ZkjtZ7NlK+vnsVFrd1qN8JaedI+1T/dsulk6310Kn+mexuk768vovEZ0sQ7bSQxyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvFquWNc; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso1775a12.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 14:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778017125; cv=none;
        d=google.com; s=arc-20240605;
        b=Ehhl4JeNvQxYetnIm/O+KVz6BsqMk+/ZM0KXccFHfgjMbvcup8JOWIdicw/6dWGpzG
         fqtEwj7K4grSfDWap/avdF2BgvrcepkBehxHn0IPqP3Qql1e6lgit0lf6Bzbflf5OIC+
         GlRIQOVoUuToEZPtpRP/a/F8IzVM0owka1jUtM9Xnlq2Ejak5o4COYQtZmMCxFFWRSvC
         pPMQOuXTCGsYuh4cbVFWgePgTN9NZX8FzDhR+3AlAdlwDz1fROSXRt9iFCuIGt8zkerm
         k+pxz2nFR/p1vXK5bEL6Cshu34LeD063q7o5YlZ3V9DH29JykJchzVkaVJ/QRJpKYhqG
         4lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ntym9XPdCphsxs/UpnBC2AeoVeU6VBD8C2hfcG8Y55Y=;
        fh=HrsTciLZ9igq3iV4DW5Hkp2zEA16WVIS/uA+qy8yIp0=;
        b=OOB1QxvQI9VlugDPkwfnNEYFB0ohAEVzWvynJuOz8he9O+RCkR4KChx4vPpMkO1Udn
         +RjCGJb4fMBPuY1eDhpMYzDyqIGbCqWxK8PSBy59wGBXowJe2HvXbv/PsG9Wwsy4q7Vo
         vUiLek0jLYam/9c8hnfLoHn9u4JZ+gq/tMllAy0XIEmnCJzookFIa6oLxzDuMmft0J5r
         4WMAThQwbGIYrOlX9Tjv/tAmDn0SMFMxk08NCaLXnHgycC5FMRPzr/P8kab1zEzIbIhv
         btLQ4ljs+EN4TH+ICCBdKXmmZ/TEgvERj7YY7fQ7zi0ZoFlhqNuCA6mZA9l3qWey38UM
         zT0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778017125; x=1778621925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ntym9XPdCphsxs/UpnBC2AeoVeU6VBD8C2hfcG8Y55Y=;
        b=dvFquWNc+gVKqUBrDG0qLZoRBgvZMuSObmH7QlROHF9yMqzRe1yoeqk3GfxHj9cWvm
         DAik8v47xcF3WXmoWAmGRD47tJ0O6lAU083T5QhHZwZPWQlNFUw9UmZTEfT9hQuKiZcW
         QJMATzWavGxN1t4sQ4U9ukL5EqLaT6N8v+qZlmpfbE7YkBBfTp8JLP8tvek8bgyinyjW
         FlkDey1JhdVKI+tC3v0uoZClMizMuXh8ylED1UZPDQpjUy2ozZWyhutvic6VATHxj/BA
         iS4tpFt5y7vjL912iYfpA4QkESNArcnqij0TD1GytatX/TfFF0prAFScwxJNRzyrt5pP
         Q9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778017125; x=1778621925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ntym9XPdCphsxs/UpnBC2AeoVeU6VBD8C2hfcG8Y55Y=;
        b=NH/sfjd477OB0I1YqA0BLLkKNePo3m/i58+fgcWo4cbQ640pXoAiiMbH3XzQsH02V2
         J0Er5qnxqGxn1B/MMZSSP4txngmHqNRzk2nChnEbmgng171h6riLCIsa15ASZ4P/BkEF
         xYpjZMQ5xzuNbh4CUzlrA7m5sqxijS3og/RtQRkuQjOrTDPNPvdzCRUqXgjfjFmiP2Wj
         NVZXp0gEE1Ey5rTZ0+gQiqMA3ROiVTYC3BnTgYdBnho3JAR8t6v0qVCXPpaKL/RcNBkZ
         c4G1+cwGi+JgbpfNnJtDpRjKtTwSdA9yezbI6bTOlZQyXyq8tB1WTSP3YdhTcsJ3XjdL
         N73g==
X-Gm-Message-State: AOJu0YzdAc+itq1gPZXr+Gptu6cXV4dRM2Rp49gQcEVTtR32TO2HOEAl
	65I+tKdbSET6gNVmMsSrh7FiBRa75UpK+t7yId/FcaN1RXCYsCjcPyUHC1hKKJhzxzssnV4AAUX
	E1v9iDMl51cfZKq4Z/Q4GIlqmNHdv9u8S4fi60rGt
X-Gm-Gg: AeBDieuNDz0wUhv02RkAvf5DUtc1ReOU9fvI0o0fTXdMmEeWLZ+qLAIxuFg0cvlXkO9
	Nnsa4kqyePlK0VXkeCzuiYdeX+8B+qr/fqb3/LVOTv6AkqCg5x1IarUQDymufimjsK24XQMc/Tg
	9xRcj4NQ0OjhdNBM4sg7S4Y2thtG7i1g8vYLPbRV337ry4YBwC2KF4H2eTHM+m4Zjs3gvZwer3S
	muoLSgOPl55/D/SFo2Ss7U7cTiInDzuL1RYNcmu8mrOWIXsgmq3vcBPPCxQfoSJkWsWQOghngs0
	RxlayHG7nbxRjuuzsnuL2z9X+vF4Uw==
X-Received: by 2002:a05:6402:14c2:b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-67d4f79adc7mr14739a12.10.1778017124722; Tue, 05 May 2026
 14:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429012819.3102675-1-hramamurthy@google.com> <20260429012819.3102675-3-hramamurthy@google.com>
In-Reply-To: <20260429012819.3102675-3-hramamurthy@google.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Tue, 5 May 2026 14:38:32 -0700
X-Gm-Features: AVHnY4IzXqRsbLyrcwRvn4L_VCtj33qDtr_lxAL5f8zMnGyTN3xb_8qBMi64ag4
Message-ID: <CA+mzVttAv=EYEiLaJnijdVQMyMK8LrCKCszwPcDh7uoV+niYcw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] gve: make nic clock reads thread safe
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org, 
	dwmw2@infradead.org, jacob.e.keller@intel.com, yyd@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D26224D3F51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 6:28=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Ankit Garg <nktgrg@google.com>
>
> Add a mutex to protect the shared DMA buffer that receives NIC
> timestamp reports. The NIC timestamp will be read from two different
> threads: the periodic worker and upcoming `gettimex64`.
>
> Move clock registration to the last step of initialization to ensure
> that all data needed by the clock module is initialized before
> the clock is exposed to usermode.
>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v3:
> - Reorder init/teardown to register PTP clock last, and simplify code
> - Move ptp-related members from gve_priv to gve_ptp
> - Only assign priv->ptp after ptp module is successfully initialized
> ---
>  drivers/net/ethernet/google/gve/gve.h         |  12 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +-
>  drivers/net/ethernet/google/gve/gve_ptp.c     | 134 ++++++++----------
>  3 files changed, 63 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 1d66d3834f7e..7b69d0cfc0d5 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -792,6 +792,9 @@ struct gve_ptp {
>         struct ptp_clock_info info;
>         struct ptp_clock *clock;
>         struct gve_priv *priv;
> +       struct mutex nic_ts_read_lock; /* Protects nic_ts_report */
> +       struct gve_nic_ts_report *nic_ts_report;
> +       dma_addr_t nic_ts_report_bus;
>  };
>
>  struct gve_priv {
> @@ -923,8 +926,6 @@ struct gve_priv {
>         bool nic_timestamp_supported;
>         struct gve_ptp *ptp;
>         struct kernel_hwtstamp_config ts_config;
> -       struct gve_nic_ts_report *nic_ts_report;
> -       dma_addr_t nic_ts_report_bus;
>         u64 last_sync_nic_counter; /* Clock counter from last NIC TS repo=
rt */
>  };
>
> @@ -1201,7 +1202,7 @@ static inline bool gve_supports_xdp_xmit(struct gve=
_priv *priv)
>
>  static inline bool gve_is_clock_enabled(struct gve_priv *priv)
>  {
> -       return priv->nic_ts_report;
> +       return priv->ptp;
>  }
>
>  /* gqi napi handler defined in gve_main.c */
> @@ -1321,14 +1322,9 @@ int gve_flow_rules_reset(struct gve_priv *priv);
>  int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
>  /* PTP and timestamping */
>  #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
> -int gve_clock_nic_ts_read(struct gve_priv *priv);
>  int gve_init_clock(struct gve_priv *priv);
>  void gve_teardown_clock(struct gve_priv *priv);
>  #else /* CONFIG_PTP_1588_CLOCK */
> -static inline int gve_clock_nic_ts_read(struct gve_priv *priv)
> -{
> -       return -EOPNOTSUPP;
> -}
>
>  static inline int gve_init_clock(struct gve_priv *priv)
>  {
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index dc2213b5ce24..4fd7e8a442c5 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -972,8 +972,7 @@ static int gve_get_ts_info(struct net_device *netdev,
>                 info->rx_filters |=3D BIT(HWTSTAMP_FILTER_NONE) |
>                                     BIT(HWTSTAMP_FILTER_ALL);
>
> -               if (priv->ptp)
> -                       info->phc_index =3D ptp_clock_index(priv->ptp->cl=
ock);
> +               info->phc_index =3D ptp_clock_index(priv->ptp->clock);
>         }
>
>         return 0;
> diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethe=
rnet/google/gve/gve_ptp.c
> index 06b1cf4a5efc..ad15f1209a83 100644
> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> @@ -11,19 +11,20 @@
>  #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
>
>  /* Read the nic timestamp from hardware via the admin queue. */
> -int gve_clock_nic_ts_read(struct gve_priv *priv)
> +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
>  {
> -       u64 nic_raw;
>         int err;
>
> -       err =3D gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
> +       mutex_lock(&ptp->nic_ts_read_lock);
> +       err =3D gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bu=
s);
>         if (err)
> -               return err;
> +               goto out;
>
> -       nic_raw =3D be64_to_cpu(priv->nic_ts_report->nic_timestamp);
> -       WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
> +       *nic_raw =3D be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
>
> -       return 0;
> +out:
> +       mutex_unlock(&ptp->nic_ts_read_lock);
> +       return err;
>  }
>
>  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> @@ -41,17 +42,21 @@ static int gve_ptp_settime64(struct ptp_clock_info *i=
nfo,
>
>  static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
>  {
> -       const struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, =
info);
> +       struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info);
>         struct gve_priv *priv =3D ptp->priv;
> +       u64 nic_raw;
>         int err;
>
>         if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(pr=
iv))
>                 goto out;
>
> -       err =3D gve_clock_nic_ts_read(priv);
> -       if (err && net_ratelimit())
> -               dev_err(&priv->pdev->dev,
> -                       "%s read err %d\n", __func__, err);
> +       err =3D gve_clock_nic_ts_read(ptp, &nic_raw);
> +       if (err) {
> +               dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
> +                                   __func__, err);
> +               goto out;
> +       }
> +       WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);

Sashiko says:
---
This problem wasn't introduced by this patch, but since the patch moves
the WRITE_ONCE() operation, does it cause a torn read on 32-bit
architectures?

The 64-bit variable last_sync_nic_counter is updated in process context (by
the PTP worker thread) using WRITE_ONCE() and read concurrently in NAPI
softirq context (gve_rx_get_hwtstamp()) using READ_ONCE().

On 32-bit architectures, READ_ONCE() and WRITE_ONCE() on 64-bit variables
do not guarantee atomicity and will compile into two separate 32-bit memory
accesses.

If a softirq interrupts the worker thread exactly between the two 32-bit
writes, could it read a corrupted 64-bit value combining halves of the old
and new timestamps?

Because the upper 32 bits wrap roughly every 4.3 seconds, a torn read will
cause a multi-second jump in the calculated packet timestamps, corrupting
PTP synchronization and packet captures.

Would it be better to use a seqcount, u64_stats_sync, or atomic64_t to
synchronize these accesses?
---

GVE only runs on x86_64 and ARM64, so this won't hit in the wild. It
might be good to fix from a code correctness perspective, but I
believe it's beyond the scope of this patch which is to introduce
thread safety to gve_clock_nic_ts_read().

>
>  out:
>         return msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS);
> @@ -65,94 +70,71 @@ static const struct ptp_clock_info gve_ptp_caps =3D {
>         .do_aux_work    =3D gve_ptp_do_aux_work,
>  };
>
> -static int gve_ptp_init(struct gve_priv *priv)
> +int gve_init_clock(struct gve_priv *priv)
>  {
>         struct gve_ptp *ptp;
> +       u64 nic_raw;
>         int err;
>
> -       priv->ptp =3D kzalloc_obj(*priv->ptp);
> -       if (!priv->ptp)
> +       ptp =3D kzalloc_obj(*priv->ptp);
> +       if (!ptp)
>                 return -ENOMEM;
>
> -       ptp =3D priv->ptp;
>         ptp->info =3D gve_ptp_caps;
> -       ptp->clock =3D ptp_clock_register(&ptp->info, &priv->pdev->dev);
> -
> -       if (IS_ERR(ptp->clock)) {
> -               dev_err(&priv->pdev->dev, "PTP clock registration failed\=
n");
> -               err  =3D PTR_ERR(ptp->clock);
> -               goto free_ptp;
> -       }
> -
>         ptp->priv =3D priv;
> -       return 0;
> -
> -free_ptp:
> -       kfree(ptp);
> -       priv->ptp =3D NULL;
> -       return err;
> -}
> -
> -static void gve_ptp_release(struct gve_priv *priv)
> -{
> -       struct gve_ptp *ptp =3D priv->ptp;
> -
> -       if (!ptp)
> -               return;
> -
> -       if (ptp->clock)
> -               ptp_clock_unregister(ptp->clock);
> -
> -       kfree(ptp);
> -       priv->ptp =3D NULL;
> -}
> -
> -int gve_init_clock(struct gve_priv *priv)
> -{
> -       int err;
> -
> -       err =3D gve_ptp_init(priv);
> -       if (err)
> -               return err;
> -
> -       priv->nic_ts_report =3D
> +       mutex_init(&ptp->nic_ts_read_lock);
> +       ptp->nic_ts_report =3D
>                 dma_alloc_coherent(&priv->pdev->dev,
>                                    sizeof(struct gve_nic_ts_report),
> -                                  &priv->nic_ts_report_bus,
> -                                  GFP_KERNEL);
> -       if (!priv->nic_ts_report) {
> +                                  &ptp->nic_ts_report_bus, GFP_KERNEL);
> +       if (!ptp->nic_ts_report) {
>                 dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func_=
_);
>                 err =3D -ENOMEM;
> -               goto release_ptp;
> +               goto free_ptp;
>         }
> -       err =3D gve_clock_nic_ts_read(priv);
> +
> +       err =3D gve_clock_nic_ts_read(ptp, &nic_raw);
>         if (err) {
>                 dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n"=
, err);
> -               goto release_nic_ts_report;
> +               goto free_dma_mem;
>         }
> -       ptp_schedule_worker(priv->ptp->clock,
> +       WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
> +
> +       ptp->clock =3D ptp_clock_register(&ptp->info, &priv->pdev->dev);
> +       if (IS_ERR(ptp->clock)) {
> +               dev_err(&priv->pdev->dev, "PTP clock registration failed\=
n");
> +               err =3D PTR_ERR(ptp->clock);
> +               goto free_dma_mem;
> +       }
> +
> +       priv->ptp =3D ptp;

Sashiko says:
---
This problem wasn't introduced by this patch, but since the patch attempts
to fix a related publication race by moving the clock registration, could
this priv->ptp assignment be reordered before ptp->clock is fully
initialized?

If gve_get_ts_info() reads priv->ptp locklessly (for example, when called
from sock_timestamping_bind_phc()), could it see an uninitialized
ptp->clock because smp_store_release() wasn't used here?
---

The only place that priv->ptp is accessed is from
gve_is_clock_enabled(), which is called from the following places:
 - gve_get_ts_info() ethtool op
   - No risk of race with gve_init_clock() when called from probe()
because it runs *before* netdev is registered. The ethool operation
cannot be dispatched before the netdev is registered.
   - No risk of race with gve_init_clock() when called in reset
recovery path because rtnl and netdev locks are held across
gve_reset(), and ethtool operations also take the rtnl/netdev locks.
 - gve_set_ts_config() ndo op and gve_xdp_rx_timestamp()
   - No risk of race because gve_init_clock() runs before netdev is registe=
red


> +       ptp_schedule_worker(ptp->clock,
>                             msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS)=
);
>
>         return 0;
>
> -release_nic_ts_report:
> -       dma_free_coherent(&priv->pdev->dev,
> -                         sizeof(struct gve_nic_ts_report),
> -                         priv->nic_ts_report, priv->nic_ts_report_bus);
> -       priv->nic_ts_report =3D NULL;
> -release_ptp:
> -       gve_ptp_release(priv);
> +free_dma_mem:
> +       dma_free_coherent(&priv->pdev->dev, sizeof(struct gve_nic_ts_repo=
rt),
> +                         ptp->nic_ts_report, ptp->nic_ts_report_bus);
> +       ptp->nic_ts_report =3D NULL;
> +free_ptp:
> +       mutex_destroy(&ptp->nic_ts_read_lock);
> +       kfree(ptp);
>         return err;
>  }
>
>  void gve_teardown_clock(struct gve_priv *priv)
>  {
> -       gve_ptp_release(priv);
> +       struct gve_ptp *ptp =3D priv->ptp;
>
> -       if (priv->nic_ts_report) {
> -               dma_free_coherent(&priv->pdev->dev,
> -                                 sizeof(struct gve_nic_ts_report),
> -                                 priv->nic_ts_report, priv->nic_ts_repor=
t_bus);
> -               priv->nic_ts_report =3D NULL;
> -       }
> +       if (!ptp)
> +               return;
> +
> +       priv->ptp =3D NULL;
> +       ptp_clock_unregister(ptp->clock);
> +       dma_free_coherent(&priv->pdev->dev, sizeof(struct gve_nic_ts_repo=
rt),
> +                         ptp->nic_ts_report, ptp->nic_ts_report_bus);
> +       ptp->nic_ts_report =3D NULL;
> +       mutex_destroy(&ptp->nic_ts_read_lock);
> +       kfree(ptp);

Sashiko says:
---
Can this synchronous kfree() cause a use-after-free or a NULL pointer
dereference?

If a concurrent device reset executes gve_teardown_clock(), it sets
priv->ptp =3D NULL and frees ptp synchronously without an RCU grace period
(such as using kfree_rcu() or synchronize_rcu()).

If gve_get_ts_info() reads priv->ptp locklessly, could it dereference
priv->ptp->clock while it is being freed, leading to a Time-Of-Check to
Time-Of-Use (TOCTOU) bug?
---

Reset cannot race against the gve_get_ts_info() ethtool op because of
the netdev/rtnl locks.

>  }
> --
> 2.54.0.545.g6539524ca2-goog
>

