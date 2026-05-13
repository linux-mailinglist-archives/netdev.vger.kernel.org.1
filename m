Return-Path: <netdev+bounces-287699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOtpLNa/BGoeNgIAu9opvQ
	(envelope-from <netdev+bounces-287699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:15:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A204538B94
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C56030E472E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1443A48E0;
	Wed, 13 May 2026 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICPXJg3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93F39BFE0
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695740; cv=pass; b=EyvMqAvj/fNMk8F+EelKU7SafINFxiysEI4c/HvT1JcF6sEj38BYaI26d/AQ0Z2rRKglS1zKUEIE4ilw1j5zU0iCW64MnsCPnJZBZXuaMvheeRPAa1xJkhYuv163Leg6UbQzEVzw//VjVp9RP1IiCgWGliDovNfvK/Aptj1Was4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695740; c=relaxed/simple;
	bh=JBz5hRZaO48YGykwanGcb617O+zQ6qPKmJfZEMAHvYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc7PcrS7RJPmJbr5eZJ8KutZbZDEh8mtQ9iT+3e6I3XrCq8RndPhSQyaYSSRT7kn9n1sZcmzTbACawiLTHS2b775iJCdX3Lds9BV+RxyCeklaODvGJ2KuZoXrMmhzjtXsqWE9htYC8l/wYTd85A6L/JQ2DQ5enL/uV8zlRC2yeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICPXJg3V; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so117a12.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778695737; cv=none;
        d=google.com; s=arc-20240605;
        b=OOYVNkWE6coW87igEUZLzGXuG+t/To8+19UPUUdP5sAWyDZNDedplsebytX7+dAJJN
         Q3muDq2lZmFMRsoDNHd6D71N4s0eYBCLMi54iHLFN6m9w0l0ojH+GzFqQb5ghrUpJGAI
         zaRgg6opT+3Xfx5yu5jetnOK7gHp44Q62frM5EMTNFxeGO5q6XZ4i0GiMKm6YMvvxpzb
         PUfqivBTYAYKT8Chfy1mb33gCI3Aa1MZFkLUbnQi9cV7RmWcxnUBN5nnLStrxzqJnV6b
         Wl7UPOyPEPGnjVYq6iQRLrHitFKKa8gMdIbIMW1t5jzNGPK7OE6979098HIMbR6vKtQT
         bYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQcAbNb8QduVn2vdhkjV2C6X4voSnGaz7u3rXkMB2aY=;
        fh=Bfc10nBC5el2sJCkX7FMGl1VwglsxIjb1BNm9PzYUsE=;
        b=HWpmfcnOUBJ5Y00zy1HiaXsvWdKTlTFsNAuKzRBy1xq4bCdLnOcrR9wdp0QI0uFK61
         6K0URwtf2SZ5/myELu//23gqCgMmKGu3XVCZGT2Np3n54saFe7JD14Os3tzmPRHwyzkr
         8STvwtCKHOoeyndF/Au9eYU3hX5cwuA8L3UQeXOstR2NdZdx4f9a5M45IQb+dLsLmH9g
         jdmpZ8gV9wYGSUcaRpYMINb5Cl24uEs8phrHwJuwvwfPXXqyG3iAgf+EBjKkJKH4QwMU
         MUkoiqYLuFf2YEIKiigy6PSwT6Ivjq5RNy2rL9oI1q6QSYg2hZ3lu/5sJVuC7je8S3uX
         dRjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778695737; x=1779300537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQcAbNb8QduVn2vdhkjV2C6X4voSnGaz7u3rXkMB2aY=;
        b=ICPXJg3V4CGEuZ2pugy5YhkFPSHM3BDpIV5NLYdosltGmV3X/gaSGv5TvEudOy5GtA
         lIIoZmudHBoC0rtxpMpuwcRVz1Jkzx1+ZGbtdCamxRC3p4qyEHVwE1YjuH1pe6bbFYiw
         UsUtw/eZjVt+EGA57g4xFZUKBfEkVzasFgaBQX5Ppwg15tyH9g81Q7GLR41k6V685sMK
         h50JpSZVCLrCjGn+Rqk9+KIOyKkxinA8WbsRk+3U/IOH9U68Sa5L3glE8QaQBC92lvdx
         H1mgo20IkgXrcLtKHpH4h21J3VvnyTISLw5Fk8e+9xaAMaJOskbCazo+keYg4wElBII8
         Bs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695737; x=1779300537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQcAbNb8QduVn2vdhkjV2C6X4voSnGaz7u3rXkMB2aY=;
        b=N518UAL6nqx9sZ435TTo0WK1pF2hRMX5L6tAk0XOEuqUpROL6TAKtTrd/qyu+asPVC
         UExM2r9a4mTyk2FI+zG0NwRAkf31C77Ep1x9iKG8i/YXCMJVyT4WeLaudtxMb6ZXArjy
         XYLWFGLzwpqprRepZJLn2T9/lZNwUSnFhMwQGLJbYlKqJ6Gs+lisHtPxU15q8Q8zGxln
         tuVneTmgOBh/VFG7iYSo1d2XWskDmr+qHxnUs2Uv/zegYbbmsvCYSn542nBN1BpkMpJQ
         iVJive4LHoyrPyKvHxTHmdEaAdSWMZZTut7XMcf69HjIlYkVS/X9lrqWxC7hWZCXecC6
         rySg==
X-Gm-Message-State: AOJu0YwSbq02GGDKNaSctobrM2LpF8Nj9DcacbNRQvl1nac4y6VVa4kb
	gq2C+tjUp4wS1lpOtCtQ9oL9f8TZv3NEv/VtScA4/xd8umvtBkh3Xkh/AcUsP728bjtsJcTkhFx
	V4JYxfIwYyHpcWqE0HWk4FCYF1hNY+NdIIqMVridV
X-Gm-Gg: Acq92OHju1+/9gYBDZnaWN6lTtcNj9P7umLSK2x0ozobkwhibbDRG+8f3HRYzZ6r57S
	gXdCxKNDuezDHusJiKvDiI3n+2x0o8pw68KXL+VRTGCFaInH7KhNlWLF1QsX5CfwnE93wRIh+5f
	9Hcn9KTl30t33NHuDZ4DbLcTCAcMmDFK3AQmkZ5n3L6Upf23byg4NvoR3vgj3pCQ4SA+0GikN9z
	LdPPzuA9T2SpoEcBI+XsxS3ULr34ondnVIax2U5+/w2/K/MyISRivUKGOj9lWIElScuhO5PFUM+
	u755OZm2BNVUKNju8uQ=
X-Received: by 2002:a05:6402:448e:b0:671:dad9:8caf with SMTP id
 4fb4d7f45d1cf-6831022ff3cmr7106a12.5.1778695736137; Wed, 13 May 2026 11:08:56
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511231812.1801984-1-hramamurthy@google.com> <20260511231812.1801984-4-hramamurthy@google.com>
In-Reply-To: <20260511231812.1801984-4-hramamurthy@google.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Wed, 13 May 2026 11:08:42 -0700
X-Gm-Features: AVHnY4IXe9d91Z_n8__YjUNzaFgWLPQLLxPSXFlENJJiGBwYGU5m3CU_jMxRV2s
Message-ID: <CA+mzVttjGwhiQ8gLnNH-pQC=Ju9RFdoiTvZW6iciN8xXz4Xt=w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/3] gve: implement PTP gettimex64
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
X-Rspamd-Queue-Id: 0A204538B94
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287699-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,sashiko.dev:url,infradead.org:email]
X-Rspamd-Action: no action

From Sashiko review at
https://sashiko.dev/#/patchset/20260511231812.1801984-1-hramamurthy%40googl=
e.com

On Mon, May 11, 2026 at 4:18=E2=80=AFPM Harshitha Ramamurthy
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
>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Naman Gulati <namangulati@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v7:
> - Actually committed the stubs for adjtime and adjfine. (Sashiko)
> - Picked up Jake Keller's review tag
>
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
>  drivers/net/ethernet/google/gve/gve_ptp.c     | 249 +++++++++++++++++-
>  4 files changed, 255 insertions(+), 9 deletions(-)
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
> index ad15f1209a83..bc230e68eb1d 100644
> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> @@ -10,28 +10,261 @@
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
> +static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int gve_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +       return -EOPNOTSUPP;
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

Sashiko says:
---
Are these ethtool counter increments safe from data races? Since this
function is called via the PTP ioctl, multiple userspace processes could ca=
ll
it concurrently. Should these variables be updated using atomic types or
protected by a lock to prevent lost updates?
---

Yes, it is theoretically possible for .gettimex64 to be executed
concurrently, but this would require an unusual configuration as there
would need to be two entities accessing the PHC. This will not occur
in the typical Chrony or phc2sys configuration. The probability and impact =
of a
lost increment are negligible, so I don't think it's worth using an
expensive atomic increment here.

> +       }
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

Sashiko says
---
Will this inflate the PTP system timestamp uncertainty window for the
fallback path?
The ptp_read_system_prets() and postts() calls wrap gve_clock_nic_ts_read()=
,
which acquires a mutex and potentially sleeps in a retry loop using fsleep(=
):
gve_clock_nic_ts_read()
mutex_lock(&ptp->nic_ts_read_lock);
err =3D gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_cycles);
...
fsleep(delay_us);
mutex_unlock(&ptp->nic_ts_read_lock);
Could the system timestamps be moved inside the lock and retry loop to
tightly bound the actual hardware read instead of including mutex contentio=
n
and sleep delays?
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

Sashiko says:
---
Does this logic break PTP cross-timestamping for VMs running older firmware=
?
The decision to use the precise path is made strictly based on the host's
clocksource ID. If the older firmware does not populate the pre_cycles and
post_cycles fields in the AdminQ response, they will be zero. Since the hos=
t
cycles will be greater than zero, the order check will unconditionally fail
and return -EBADMSG.
Should the driver check if the firmware provided valid non-zero cycle count=
s
and gracefully fall back to the host timestamp path instead of returning an
error?
---

Firmware is not allowed to return 0 for pre/post cycles. This would
violate the API contract, so returning failure is the appropriate
response.

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
> @@ -50,7 +283,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info =
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
> @@ -65,6 +298,8 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info =
*info)
>  static const struct ptp_clock_info gve_ptp_caps =3D {
>         .owner          =3D THIS_MODULE,
>         .name           =3D "gve clock",
> +       .adjfine        =3D gve_ptp_adjfine,
> +       .adjtime        =3D gve_ptp_adjtime,
>         .gettimex64     =3D gve_ptp_gettimex64,
>         .settime64      =3D gve_ptp_settime64,
>         .do_aux_work    =3D gve_ptp_do_aux_work,
> @@ -93,7 +328,7 @@ int gve_init_clock(struct gve_priv *priv)
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
> 2.54.0.563.g4f69b47b94-goog
>

