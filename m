Return-Path: <netdev+bounces-286235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KbyTOZMPAGqUCgEAu9opvQ
	(envelope-from <netdev+bounces-286235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 06:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C655029C5
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 06:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BBBC300B3EF
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94021D6DA9;
	Sun, 10 May 2026 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAOdT0vz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5126AE5
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778388879; cv=pass; b=AEcu6vReRWl41AvWUBguBcAUNOSN4yP/bwqV4B+0uAZCa5zvescQpCLJ2zTO1QGDsy89ebCFBOf5BZuzSkMY1mbYOgvAO1zchfLqbpHEadNF4xY7ls814b5G+dfzpDFew9iU9Et383rp16D1BDp90ZtoLya0MJpHXf96G149LSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778388879; c=relaxed/simple;
	bh=+SGf3VlOdse8HlHNjc81PdbxU9Rr+eN0hxpoSY3mB8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv37dRtr1bSwRAZn0RcRZu3dig3/Pv7zSMpAoX+Ds1h9VazTpicjgFSeoDMokt4fpOAzcfUhNSTtPmeRv5X3PQ0B/QPwS4R3HHBQlXZb6DNig/YiB+euM5yhrBVD8uUm0RVdmOo8dPgt+JcIGMG9x5o/gnWL9huo6i0sJElrfro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAOdT0vz; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso9a12.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 21:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778388875; cv=none;
        d=google.com; s=arc-20240605;
        b=jktpiWsMbGmRJBuDiGViLh6Y7j7rgB/OXMky8A3UggxpZt4BAHZlwP9UgxJh7a6auO
         d7PQ7Ws0iO1qBJ+6E4yHdaJuauw85sTSdaHZ9HvE/6kNunrGRFuF57V6MbUrHlHsuhzG
         ElQjOV2UqXGQWy/k7BvC1ZydfU+pWu3I3ZP12rAyb7wzdMx/igm46cH3SUxjYrEBJoW/
         8cmcT8tDGOMrY10OFVFoElJfPh3to5LpGoIC1wIVKPSBWZVSr3k74D7H3HnsT9uCB9h5
         tn4EYF5HP4h45cpF/xTZ0bMeOZ7xV7oaySdCLu2SeAOyZQQyRNCaDlBC9jmxGFb+cVWt
         j2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ckIHRL/DeuBiBiDv+o0hqCjt5+jqLQ6/Mf/cXn6Yhi4=;
        fh=Bfc10nBC5el2sJCkX7FMGl1VwglsxIjb1BNm9PzYUsE=;
        b=MjpfTIJVRxRl8MhQQRQY4csyiVC5vOOo+zzKpZQJGO8RSVx2wBVzJ+7LdElctRT9xE
         tYbz7RecWk+wmyD+nCA12LhxbiBM8K+QjI5JdzODr9JLWsyi2yZ0kPdL+EVx5xDSnkuf
         SuVPORton5nYsVVLMS1CGKenfnyCHFzM+sumKtX+1jGYhDrTaFoDdneOTayXovdT2vES
         cUiyDx1lca9ZdBpdPGsuF9Ai6+4CUnhptuJhr+UH9tZTX3tm5AzuCfnQimrXvtOdzig+
         vKbLaIysk+1s+KUo926lvffl6wTgRPVxELbaD4FDB5UC763ZRpMSRprCUy0yO0BMM4J0
         znHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778388875; x=1778993675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckIHRL/DeuBiBiDv+o0hqCjt5+jqLQ6/Mf/cXn6Yhi4=;
        b=eAOdT0vzue0UBROsB1f8mC8TAumy4b0KDfm5ROvayXaZFx0wMrcwwOCDuy7dJSd6tw
         WiYKogbBz2tiyisy/Yx1l6heJqrF/GkobFOa8luRqP1uueawm9k5m5RXmbMXYg0KHZbA
         sGmP23alDsjSyvfpR1PzV76NkGQlrx2EYBiLkQHYtVmX3Q+p2KcdMIAdUvmosC4b/Wq/
         h834z6DeTzvcekx6oXxPMttEbDayCvoNLMmiDzEZv4YWfQonR50fmoXOJsEq1Sc1N2gI
         e+29adtjLf/wXKtbxJF/6mtjO5Sj+mmE9jyYFQxWpPHtdoNKGbAgBrVjT7VldBWcv/4v
         +1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778388875; x=1778993675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckIHRL/DeuBiBiDv+o0hqCjt5+jqLQ6/Mf/cXn6Yhi4=;
        b=sJj6cDt7/X37/8ZcrdKBYIUeGlS7GxABeniY+/jLxd2Q9W3nHi2N6gbrmufsXYxOlk
         8J5e4T5RvukPPp3Bn6R0JguImBD9Gc3Wjym5/1GuqMu2r5UdnTXqBbMV9txNCHb+yrS9
         hZYDxaD0sFPgj/MIvyvG6sVUA7wmLNFxubcFA2zIXTQRVI+rjsT4xfx5F3xrkTLyvyCA
         eA+mDB5TNTbuQZ1ZGzkVVplcCeEA/F5hVrayHCT3rVmxJETJuh8LoAIaLtp/E8qT+K9P
         A2OKSYQWS34MLtxZvDeS6LTukNgcOMy6GqvJFys9gXJ4IilptPUcPUmHnsxjAD9cB53/
         oADA==
X-Gm-Message-State: AOJu0YzNs1cx5Y/hG1tkPUbzEkUVx58FqaVvfYcpbwjdL87XZyMPOYiy
	ZdCDBB+3OnHXlKQvWsqtIuZ86kBoOpm6SzpCyKd/WMpkhL6UR8BWWAwnXwgwjmDhTXzk+AbFhAS
	OZF/G5nhzRopFmJdhQyLKgF7FgHCyucC07tmx5+hS
X-Gm-Gg: Acq92OEnAzxaKkYxDD7VM0J3uT2RVcymZio7LP4z5FUdHZ0wrxiqzpvbvGpZVeUt4UV
	j1eqsJMVRXhE1Bs2enmuVMfymmrJLRBkLcD/HFtHb2TCTqJO4VF3R9E119wlg/lT1RKYA0zbjia
	8XTZS9msGOxq4L3sRb167ZHfIzkgDnGATsn+ajTgSxK8/UWN0jXyumZhePOt9uS+rl3J8/0qwcb
	lGKUnGk5UbfPkD3jPeiz6MtcmcSPdS3+NFzn4jSCZbLJGc5tI0VHU0Fs3vAHQcZr9O1DNqCr2Zz
	lVS3QH0Q7IzncaoT+EA=
X-Received: by 2002:aa7:c58c:0:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-67f599902f1mr39253a12.2.1778388874680; Sat, 09 May 2026
 21:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507211304.3046526-1-hramamurthy@google.com> <20260507211304.3046526-4-hramamurthy@google.com>
In-Reply-To: <20260507211304.3046526-4-hramamurthy@google.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Sat, 9 May 2026 21:54:23 -0700
X-Gm-Features: AVHnY4LXvOuH9LvFA4xqaFtQGRaQEXk5I01lnbQ_g8ilFbdwh1KZaRqI1F0KhwI
Message-ID: <CA+mzVts_7OTjcVh2ae-XboeaBKwQeYaj8daRYRf33nrbDnFrVw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] gve: implement PTP gettimex64
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org, 
	dwmw2@infradead.org, jacob.e.keller@intel.com, yyd@google.com, 
	jefrogers@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 59C655029C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286235-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 2:13=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Jordan Rhee <jordanrhee@google.com>
>
> Enable chrony and phc2sys to synchronize system clock to NIC clock.
>
> Two paths are implemented: a precise path using system counter values
> sampled by the device, and a fallback path using system counter values
> sampled in the driver using ptp_read_system_prets()/postts().
>
> To use the precise path, the current system clocksource must match the
> units returned by the device, which on x86 is X86_TSC and on ARM64 is
> ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
> be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
> by default on GCP VMs using Chrony, so we expect the precise path to be
> used the vast majority of the time. If the system clocksource is changed
> to kvm-clock, it activates the fallback path. Ethtool counters have been
> added to count how many times each path is used.
>
> The uncertainty window in the precise path is typically around 1-2us,
> while in the fallback path is around 60-80us.
>
> Stub implementions of adjfine and adjtime are added to avoid NULL
> dereference when phc2sys tries to adjust the clock.

Sashiko says:
---
Is this description accurate? The patch only implements gve_ptp_settime64
and fails to include the adjtime and adjfine callbacks.

When userspace tools like phc2sys attempt to adjust the PTP clock frequency
or offset, the PTP subsystem core (ptp_clock_adjtime) will invoke these
missing callbacks unconditionally. Could this lead to a NULL pointer
dereference and kernel panic?
---

I made a mistake and did not commit my local changes. I will send a v7.

>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Naman Gulati <namangulati@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v6:
> - Added a fallback to driver-sampled time sandwich that is used when
>   the following conditions are not met:
>   - The system clock source is X86_TSC or ARM_ARCH_COUNTER
>   - The requested clockid is CLOCK_REALTIME or CLOCK_MONOTONIC_RAW
>   - The architecture is x86 or ARM64
> - Added ethtool statistics to count how many cross-timestamps used the
>   precise path versus fallback path.
> - Fixed printf format specifier.
> - Added stub implementions of adjtime and adjfine to prevent NULL
>   dereference when phc2sys tries to adjust clock.
> - Moved system time snapshot back to gve_ptp_gettimex64() so we can get t=
he
>   current system clock source from it. It is OK for it to not be inside
>   the mutex or retry loop because lock contention and retries should be
>   extremely rare, and chrony filters out bad samples.
>
> Changes in v5:
> - Reformulate retry loop in terms of total timeout (Jakub Kicinski)
>
> Changes in v3:
> - Take system time snapshot inside the mutex
> - Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
>   than x86 or arm64
>
> Changes in v2:
>  - fix compilation warning on ARM by casting cycles_t to u64
> ---
>  drivers/net/ethernet/google/gve/gve.h         |   8 +
>  drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +
>  drivers/net/ethernet/google/gve/gve_ptp.c     | 237 +++++++++++++++++-
>  4 files changed, 243 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 7b69d0cfc0d5..4de3ce60060e 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -880,6 +880,14 @@ struct gve_priv {
>         u32 stats_report_trigger_cnt; /* count of device-requested stats-=
reports since last reset */
>         u32 suspend_cnt; /* count of times suspended */
>         u32 resume_cnt; /* count of times resumed */
> +       /* count of cross-timestamps attempted using system timestamps
> +        * from the AQ command
> +        */
> +       u32 ptp_precise_xtstamps;
> +       /* count of cross-timestamps attempted using system timestamps sa=
mpled
> +        * by the driver
> +        */
> +       u32 ptp_fallback_xtstamps;
>         struct workqueue_struct *gve_wq;
>         struct work_struct service_task;
>         struct work_struct stats_report_task;
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index 22a74b6aa17e..e6dcf6da9091 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -411,8 +411,8 @@ static_assert(sizeof(struct gve_adminq_report_nic_ts)=
 =3D=3D 16);
>
>  struct gve_nic_ts_report {
>         __be64 nic_timestamp; /* NIC clock in nanoseconds */
> -       __be64 reserved1;
> -       __be64 reserved2;
> +       __be64 pre_cycles; /* System cycle counter before NIC clock read =
*/
> +       __be64 post_cycles; /* System cycle counter after NIC clock read =
*/
>         __be64 reserved3;
>         __be64 reserved4;
>  };
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index 4fd7e8a442c5..8a088dcc3603 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING=
_LEN] =3D {
>         "rx_hsplit_unsplit_pkt",
>         "interface_up_cnt", "interface_down_cnt", "reset_cnt",
>         "page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt=
",
> +       "ptp_precise_xtstamps", "ptp_fallback_xtstamps",
>  };
>
>  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] =3D {
> @@ -269,6 +270,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>         data[i++] =3D priv->page_alloc_fail;
>         data[i++] =3D priv->dma_mapping_error;
>         data[i++] =3D priv->stats_report_trigger_cnt;
> +       data[i++] =3D priv->ptp_precise_xtstamps;
> +       data[i++] =3D priv->ptp_fallback_xtstamps;
>         i =3D GVE_MAIN_STATS_LEN;
>
>         rx_base_stats_idx =3D 0;
> diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethe=
rnet/google/gve/gve_ptp.c
> index ad15f1209a83..9711521ce1d0 100644
> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> @@ -10,28 +10,251 @@
>  /* Interval to schedule a nic timestamp calibration, 250ms. */
>  #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
>
> +/*
> + * Stores cycle counter samples in get_cycles() units from a
> + * sandwiched NIC clock read
> + */
> +struct gve_sysclock_sample {
> +       /* Cycle counter from NIC before clock read */
> +       u64 nic_pre_cycles;
> +       /* Cycle counter from NIC after clock read */
> +       u64 nic_post_cycles;
> +       /* Cycle counter from host before issuing AQ command */
> +       cycles_t host_pre_cycles;
> +       /* Cycle counter from host after AQ command returns */
> +       cycles_t host_post_cycles;
> +};
> +
> +/*
> + * Read NIC clock by issuing the AQ command. The command is subject to
> + * rate limiting and may need to be retried. Requires nic_ts_read_lock
> + * to be held.
> + */
> +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_cyc=
les,
> +                                 cycles_t *post_cycles)
> +{
> +       unsigned long deadline =3D jiffies + msecs_to_jiffies(100);
> +       unsigned long delay_us =3D 1000;
> +       int err;
> +
> +       lockdep_assert_held(&ptp->nic_ts_read_lock);
> +
> +       do {
> +               *pre_cycles =3D get_cycles();
> +               err =3D gve_adminq_report_nic_ts(ptp->priv,
> +                                              ptp->nic_ts_report_bus);
> +
> +               /* Prevent get_cycles() from being speculatively executed
> +                * before the AdminQ command
> +                */
> +               rmb();
> +               *post_cycles =3D get_cycles();

Sashiko says:
---
Is rmb() sufficient here to prevent speculative execution on ARM64?
Since rmb() maps to dmb ishld, it only orders memory load instructions.
Because get_cycles() reads the CPU virtual counter register (cntvct_el0),
is an instruction synchronization barrier (isb()) required to halt
speculative execution?
Without it, could the CPU read the timer too early, violating the
nic_post_cycles <=3D host_post_cycles invariant and causing valid samples
to be falsely rejected with -EBADMSG?
---

The AdminQ command causes a VM Exit which is a serializing event. The
compiler barrier is sufficient to prevent the compiler from reordering
the get_cyles() call before the AdminQ command is issued.

> +               if (likely(err !=3D -EAGAIN))
> +                       return err;
> +
> +               fsleep(delay_us);
> +
> +               /* Exponential backoff */
> +               delay_us *=3D 2;
> +       } while (time_before(jiffies, deadline));
> +
> +       return -ETIMEDOUT;
> +}
> +
>  /* Read the nic timestamp from hardware via the admin queue. */
> -static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
> +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
> +                                struct gve_sysclock_sample *sysclock)
>  {
> +       cycles_t host_pre_cycles, host_post_cycles;
> +       struct gve_nic_ts_report *ts_report;
>         int err;
>
>         mutex_lock(&ptp->nic_ts_read_lock);
> -       err =3D gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bu=
s);
> -       if (err)
> +       err =3D gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_=
cycles);
> +       if (err) {
> +               dev_err_ratelimited(&ptp->priv->pdev->dev,
> +                                   "AdminQ timestamp read failed: %d\n",=
 err);
>                 goto out;
> +       }
> +
> +       ts_report =3D ptp->nic_ts_report;
> +       *nic_raw =3D be64_to_cpu(ts_report->nic_timestamp);
>
> -       *nic_raw =3D be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
> +       if (sysclock) {
> +               sysclock->nic_pre_cycles =3D be64_to_cpu(ts_report->pre_c=
ycles);
> +               sysclock->nic_post_cycles =3D be64_to_cpu(ts_report->post=
_cycles);
> +               sysclock->host_pre_cycles =3D host_pre_cycles;
> +               sysclock->host_post_cycles =3D host_post_cycles;
> +       }
>
>  out:
>         mutex_unlock(&ptp->nic_ts_read_lock);
>         return err;
>  }
>
> +struct gve_cycles_to_clock_callback_ctx {
> +       u64 cycles;
> +};
> +
> +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> +                                 struct system_counterval_t *system_coun=
terval,
> +                                 void *ctx)
> +{
> +       struct gve_cycles_to_clock_callback_ctx *context =3D ctx;
> +
> +       *device_time =3D 0;
> +
> +       system_counterval->cycles =3D context->cycles;
> +       system_counterval->use_nsecs =3D false;
> +
> +       if (IS_ENABLED(CONFIG_X86))
> +               system_counterval->cs_id =3D CSID_X86_TSC;
> +       else if (IS_ENABLED(CONFIG_ARM64))
> +               system_counterval->cs_id =3D CSID_ARM_ARCH_COUNTER;
> +       else
> +               return -EOPNOTSUPP;
> +
> +       return 0;
> +}
> +
> +/*
> + * Convert a raw cycle count (e.g. from get_cycles()) to the system cloc=
k
> + * type specified by clockid. The system_time_snapshot must be taken bef=
ore
> + * the cycle counter is sampled.
> + */
> +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t clo=
ckid,
> +                                   struct system_time_snapshot *snap,
> +                                   u64 cycles, struct timespec64 *ts)
> +{
> +       struct gve_cycles_to_clock_callback_ctx ctx =3D {0};
> +       struct system_device_crosststamp xtstamp;
> +       int err;
> +
> +       ctx.cycles =3D cycles;
> +       err =3D get_device_system_crosststamp(gve_cycles_to_clock_fn, &ct=
x, snap,
> +                                           &xtstamp);
> +       if (err) {
> +               dev_err_ratelimited(&priv->pdev->dev,
> +                                   "get_device_system_crosststamp() fail=
ed to convert %llu cycles to system time: %d\n",
> +                                   cycles,
> +                                   err);
> +               return err;
> +       }
> +
> +       switch (clockid) {
> +       case CLOCK_REALTIME:
> +               *ts =3D ktime_to_timespec64(xtstamp.sys_realtime);
> +               break;
> +       case CLOCK_MONOTONIC_RAW:
> +               *ts =3D ktime_to_timespec64(xtstamp.sys_monoraw);
> +               break;
> +       default:
> +               dev_err_ratelimited(&priv->pdev->dev,
> +                                   "Cycle count conversion to clockid %d=
 not supported\n",
> +                                   clockid);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static bool
> +gve_can_use_system_ts_from_device(enum clocksource_ids system_clock_sour=
ce,
> +                                 clockid_t clockid)
> +{
> +       if (clockid !=3D CLOCK_REALTIME && clockid !=3D CLOCK_MONOTONIC_R=
AW)
> +               return false;
> +
> +       /* If the system clock source matches the system clock
> +        * returned by the AdminQ command, we can use the system
> +        * timestamps returned by the device, otherwise we have to
> +        * fall back to sampling system time from the host which
> +        * is less accurate.
> +        */
> +       if (IS_ENABLED(CONFIG_X86))
> +               return system_clock_source =3D=3D CSID_X86_TSC;
> +       else if (IS_ENABLED(CONFIG_ARM64))
> +               return system_clock_source =3D=3D CSID_ARM_ARCH_COUNTER;
> +
> +       return false;
> +}
> +
>  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
>                               struct timespec64 *ts,
>                               struct ptp_system_timestamp *sts)
>  {
> -       return -EOPNOTSUPP;
> +       struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info);
> +       struct gve_sysclock_sample sysclock =3D {0};
> +       bool use_system_ts_from_device =3D false;
> +       struct gve_priv *priv =3D ptp->priv;

Sashiko says:
---
Does this function need to check the device active state before proceeding?
The asynchronous worker gve_ptp_do_aux_work() carefully checks
if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
before issuing hardware reads.
Since this function handles the PTP ioctl, if a user queries the PTP clock
while the device is suspended or undergoing reset, could it trigger hardwar=
e
faults or access freed AdminQ structures?
---

The AdminQ layer is responsible for checking whether it's in good
state to send commands. These checks need to be synchronized properly
with the threads that reset adminQ. Specifically, these checks need to
be performed under priv->adminq_lock. Will fix gve_ptp_do_aux_work()
in a separate patch.

> +       struct system_time_snapshot snap;
> +       u64 nic_ts;
> +       int err;
> +
> +       if (sts) {
> +               /* This snapshot is used both to query the current system
> +                * clocksource and to convert the cycle counts returned
> +                * by the AdminQ command to ktime. It does not need to be
> +                * taken inside the retry loop because retries and lock
> +                * contention are expected to be extremely rare.
> +                *
> +                * If the system clock source changes between here and
> +                * when get_device_system_crosststamp() is called,
> +                * get_device_system_crosststamp() will fail which will
> +                * cause one failed sample, and the next one will succeed=
.
> +                */
> +               ktime_get_snapshot(&snap);
> +               use_system_ts_from_device =3D
> +                       gve_can_use_system_ts_from_device(snap.cs_id,
> +                                                         sts->clockid);
> +               if (use_system_ts_from_device)
> +                       priv->ptp_precise_xtstamps++;
> +               else
> +                       priv->ptp_fallback_xtstamps++;
> +       }

Sashiko says:
---
Can these increments cause read-modify-write data races?
Because this function can be executed concurrently by multiple userspace
threads without driver-level serialization, plain u32 increments could resu=
lt
in lost updates. Should these be atomic_t or moved inside the
nic_ts_read_lock critical section?
---

Yes, it is theoretically possible for .gettimex64 to be executed
concurrently, but this would require an unusual configuration as there
would need to be two entities accessing the PHC. This will not occur
in the typical Chrony configuration. The probability and impact of a
lost increment are negligible, so I don't think it's worth using an
expensive atomic increment here.

> +
> +       if (unlikely(!use_system_ts_from_device))
> +               ptp_read_system_prets(sts);
> +
> +       err =3D gve_clock_nic_ts_read(ptp, &nic_ts, sts ? &sysclock : NUL=
L);
> +       if (err)
> +               return err;
> +
> +       if (unlikely(!use_system_ts_from_device))
> +               ptp_read_system_postts(sts);

Sashiko says:
---
Does wrapping gve_clock_nic_ts_read() with ptp_read_system_prets() and
ptp_read_system_postts() cause massive clock skew in the fallback path?
gve_clock_nic_ts_read() acquires nic_ts_read_lock, which may block. It also
executes gve_ptp_read_timestamp(), which can sleep for up to 100ms during
AdminQ retries.
Injecting lock contention delays and sleeps between pre_ts and post_ts coul=
d
invalidate the cross-timestamping window, causing the PTP core to calculate
highly skewed system timestamps.
---

I provided a detailed analysis to this question in my response to
Jacob. The short answer is no, it will not cause significant
inaccuracy unless the clock is very unstable. Cycle counters are
sufficiently stable on the cloud platforms of interest for the
timescales we are working with. Lock contention and retries are
extremely unlikely, and Chrony mitigates the occasional bad read by
issuing bursts of 25 reads and discarding the outliers.

> +
> +       if (sts && likely(use_system_ts_from_device)) {
> +               /* Reject samples with out of order system clock values.
> +                * Firmware must return valid non-zero cycle counts.
> +                */
> +               if (!(sysclock.host_pre_cycles <=3D sysclock.nic_pre_cycl=
es &&
> +                     sysclock.nic_pre_cycles  <=3D sysclock.nic_post_cyc=
les &&
> +                     sysclock.nic_post_cycles <=3D sysclock.host_post_cy=
cles)) {
> +                       dev_err_ratelimited(&priv->pdev->dev,
> +                                           "AdminQ system clock cycle co=
unts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n",
> +                                           (u64)sysclock.host_pre_cycles=
,
> +                                           sysclock.nic_pre_cycles,
> +                                           sysclock.nic_post_cycles,
> +                                           (u64)sysclock.host_post_cycle=
s);
> +                       return -EBADMSG;
> +               }
> +
> +               err =3D gve_cycles_to_timespec64(priv, sts->clockid, &sna=
p,
> +                                              sysclock.nic_pre_cycles,
> +                                              &sts->pre_ts);
> +               if (err)
> +                       return err;
> +
> +               err =3D gve_cycles_to_timespec64(priv, sts->clockid, &sna=
p,
> +                                              sysclock.nic_post_cycles,
> +                                              &sts->post_ts);
> +               if (err)
> +                       return err;
> +       }
> +
> +       *ts =3D ns_to_timespec64(nic_ts);
> +
> +       return 0;
>  }
>
>  static int gve_ptp_settime64(struct ptp_clock_info *info,
> @@ -50,7 +273,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info =
*info)
>         if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(pr=
iv))
>                 goto out;
>
> -       err =3D gve_clock_nic_ts_read(ptp, &nic_raw);
> +       err =3D gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
>         if (err) {
>                 dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
>                                     __func__, err);
> @@ -93,7 +316,7 @@ int gve_init_clock(struct gve_priv *priv)
>                 goto free_ptp;
>         }
>
> -       err =3D gve_clock_nic_ts_read(ptp, &nic_raw);
> +       err =3D gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
>         if (err) {
>                 dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n"=
, err);
>                 goto free_dma_mem;
> --
> 2.54.0.545.g6539524ca2-goog
>

