Return-Path: <netdev+bounces-304442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VxYXCdZxR2pOYQAAu9opvQ
	(envelope-from <netdev+bounces-304442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:24:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95104700057
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:24:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="XSuMI/yQ";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304442-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304442-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E2DC30C7E8A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB63793BD;
	Fri,  3 Jul 2026 08:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075D372B3D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:03:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065817; cv=pass; b=ag/I7FTYHzDvkTmlK57NwFX0rx/7/93llVW6TnBd2276yTmAY+usR13btyAgMlQIZIAGhku01vYaJaGUQvgr43/jH/jNCNdnpHbKMfGKs49tDRtyLSWA+3wvswfHX7Z0D1Ma++3W/julUtGHQtr2E69qyxmAXNhdWCvTS24XYME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065817; c=relaxed/simple;
	bh=nsrm07UydNikITMgTVAU6koo5bDjbCYqa6h5AOzaPIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZLNICAsefrxRlX5HQwJacDnJxKkHxyLKg/t/hASh1kUbw1NsUe9bAaf14Vysxg7YE3rYJD6mIvWTiCbtv8oL1i5riTnSagAYD+NRGteaydu9v/BqykbVZOz3u18D7VdQ05cM0HTJHUyn9627JAEkOShkjPVeaOIx3X3g2qUfug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSuMI/yQ; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-695a3842230so40199a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 01:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783065813; cv=none;
        d=google.com; s=arc-20260327;
        b=nhqcPS34Ge6G12OnVC7VJgR5b9lvRUucZ8MRCmibBefXcGYaIKVu2TIQbshgvhTdG5
         2eOGXE5VOvbvEEyWTqWdn3ZPoT3jSLHkQFl8Fq/LByFHSLlQLJtGIzo+Cx/TVrrZ7Zu6
         apAMoDvMGkDQTkfjlf3rmpjfZRlLHIIoIkH0sog2zDatXwWkT6XDMia7VjsSEi8UoUj9
         8hkL2OcwJrCJYjeBuwUrak27pcijOHLQJQ7iB2PfLYCWCAVPwz3P0QAZBl66ZLEMuYts
         1Hq3eH0yF8oswF7o3DXK9872twNAZVYn+Gx+HL3khlBtISubwjxov+kTW01e/86yQump
         069Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeKM6E3ikqLN6XP3NncyHeU2nWvurVANKF6w+ddq690=;
        fh=kW3l5PeYBxb5aiCvq68G0ID+4j650Y64QXh7D0Sb/dU=;
        b=BPPxaZq5y/Ct6ndBuD732dhzD2U6zVg9q6g9BJ1HaBzKPSSfVkFEO1EsoF1VLtd/fP
         ta/jJcrBdSGfPLTtEZADet9EUjGEiwMqTIiJ6GRcx8R+rIRWHeNuxZAnJ7B4HtmwbpgD
         VNleSnZ732jZITtwMOXgEDqwKsRKP7fmUvwDAb8Dj+KwGEGgL6FX9VzDv5DgcJnOEQbu
         Tg7Ptz5dapBpld4sa+epz5UmgeZB/ZhpEwcrwkhINYrtR9on2Go5A1KeKMRMliPEAPXg
         f5kGt2plL881TrCa1X1gnlhj2khBuZObDq/sWRKorolBF6jYUsXJHOOqZy5rQabxEBVj
         e+hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783065813; x=1783670613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HeKM6E3ikqLN6XP3NncyHeU2nWvurVANKF6w+ddq690=;
        b=XSuMI/yQT3IFP0Hj3kSpmQYLANGAfmwfG4a7T2Ek+cm0nKvGtzelftHlEVkrgMfCy1
         cLqvGQbgep3UoF19L/5gvAf6DC6yKE62lEQXCvmS8CmAnHMNNjdYNU3v2wz6WLqIPsvs
         aFO1Zolv9YL+uMu93qANTwW8Ncmp5wtPzoqxQOVN2AUW83WygpRruKIJJaU7ZGL2/aDd
         CTBbkHvoRL8N7U5TsUNRD8dK4C/U1koE9mRC3wkurq2IeKL6HubyFHYvyb6s1oz7W59W
         zvqiDp5GZYuKrVlnwj4BnC2KzR/SVM41YAwf53+9bKAw2MioMnbsfGCM6jwJsMi4dYaj
         PmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065813; x=1783670613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HeKM6E3ikqLN6XP3NncyHeU2nWvurVANKF6w+ddq690=;
        b=Eo7lkudWN4q1s22phcjP8JKDMwN3sBWqsAn/sYQ/JBppNmnGPBqlfnrcFMI+YXz3jo
         yMEwFbF8aJ7xPljhuYH9/O2bpStBJSUUc4cSU8bey95nzXuTDApUrAcIknhgJk0HCSo0
         858QHZjgryYNv6K7svgZ/ue/kiHg8UEIgrmA0ZZCYH2DwBQ35rCcMb2SMFLeoM6toFAO
         WEZWcOHwFe8YJCWHmHxOoilYlcq3CHUzKXMUHfs47WlYNdn2xTDk50v5UM6XVBeeQrGK
         WeVfo9xZ2799YAeR+WvepI+kRDn1yX+Loh/wFOM0+qd212OhT5lOogVsux9YfGhBzea+
         4vUw==
X-Forwarded-Encrypted: i=1; AHgh+RqWbdBSsIZk2HGj8tXZiENpr3dpyJGJ+oZqiHFN30qsM8dQHbIf8yr/RQQEmzl247YKO+7mN0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQ/zpBcovgfFj5BOGJCMImaGisXRUSYMKWkicXhSoVHz9hZY6
	xazMoWErF718DtAHumui7J3NhPa3n40Hc+r4RKIdzBvC5IL3WOp8ayQCvdpt7k00RKjoABuMqBB
	BmJhAdC5/l3vUIDZrxub0fdkKpuc3TXkUQ+SBDus4
X-Gm-Gg: AfdE7cndyaGQGXzE5zGGvrU7BS6jxteAJd1/2CA0VnyglS+EvGPfKIC9BA5qdrq3F67
	/5N2FaYgC0sa3H1X6IQosCJFBNOTFALF2Na5jJFJcOrOcPotUXDBBmbpx7F5RLi49HA3b+XgR09
	WqqrISOLcZfbCYw5uCKSyNmfdwM3Q5c4jKdKi6csA8W67y58BCBrUiYwoau1RZj2Z7DPpSLKH48
	m/CEH8wleQXBKqZzL0gfn/MyGkb950bgv5Kvh3YACiePHxvvXKlPoOF6KUUsfOCcyE5AOKyPTRH
	0wZ2qGV31IQz+gnfTSO3Gmad5xakxM2xXHqfRnYumlS8cSdtUHAbqAzHhSFuzVo=
X-Received: by 2002:aa7:d04f:0:b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-698ad313987mr90294a12.0.1783065812576; Fri, 03 Jul 2026
 01:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701005341.3699161-1-hramamurthy@google.com> <akUUXT6UwTTD2yOs@boxer>
In-Reply-To: <akUUXT6UwTTD2yOs@boxer>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 3 Jul 2026 01:03:20 -0700
X-Gm-Features: AVVi8CfMg_UmMCbmPDneAQPVpYdoK3tz-RuErvKHVuxcH7xgCNjKG9yXtl3SgO8
Message-ID: <CAPBb8HmE6q0VPa5PooFP3VFF27GU3B4622Xww6MHRT-9i4zTxA@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix Rx queue stall on alloc failure
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	sdf@fomichev.me, willemb@google.com, jordanrhee@google.com, nktgrg@google.com, 
	maolson@google.com, jacob.e.keller@intel.com, thostet@google.com, 
	csully@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:hramamurthy@google.com,m:netdev@vger.kernel.org,m:joshwash@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bpf@vger.kernel.org,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:nktgrg@google.com,m:maolson@google.com,m:jacob.e.keller@intel.com,m:thostet@google.com,m:csully@google.com,m:bcf@google.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eddiephillips@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddiephillips@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,intel.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95104700057

> I think this deserves to be pulled out of the timer logic?

If by this you mean pull the stats into a separate patch, I agree.

> - couldn't you detect this case within napi poll loop?

It can only be detected after attempting to refill the queue and finding
that we are still below the critical threshold.

> - if not, does it have to be per-q timer? wouldn't one global per pf time=
r
>   satisfy your needs?

There are a few ways a global timer could be implemented,
 - The global timer could queue napi for *all* queues, which would
result in a lot of unnecessary work.
 - The global timer could iterate over each queue and try to detect
the critical low buffer condition, however this would require
introducing synchronization between the timer and the napis, which
would introduce expensive locking into the hot path.
 - The global timer could be paired with a bitmap that stores which
queues need to be serviced.

A `struct timer_list` is only 40 bytes, so the current implemention is
not expensive. Though a global timer is valid, it's not strictly better.

That said, I agree that we can clean up the structure=E2=80=94I will move t=
he
timer state from the individual RX rings to the `gve_priv` structure.

On Wed, Jul 1, 2026 at 6:22=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jul 01, 2026 at 12:53:41AM +0000, Harshitha Ramamurthy wrote:
> > From: Eddie Phillips <eddiephillips@google.com>
> >
> > When the system is under extreme memory pressure, page allocations can
> > fail during the Rx buffer refill loop. If the number of buffers posted
> > to hardware falls below a critical low threshold and the refill loop
> > exits due to allocation failures, the queue can stall:
> >
> > 1. The device drops incoming packets because there are no descriptors.
> > 2. Since no packets are processed, no Rx completions are generated.
> > 3. Because no completions occur, NAPI is never scheduled, preventing
> >    the refill loop from running again even after memory is freed.
> >
> > This results in a permanent queue stall.
> >
> > Resolve this by introducing a starvation recovery timer for each Rx que=
ue.
> > If the number of buffers posted to hardware falls below a critical low
> > threshold, start a timer to periodically reschedule NAPI. Once NAPI run=
s
> > and successfully refills the queue above the threshold, the timer is
> > not rescheduled.
> >
> > Also add a new ethtool statistic "rx_critical_low_bufs" to track the
> > number of times the starvation recovery timer is triggered.
>
> I think this deserves to be pulled out of the timer logic?
>
> Two questions tho:
> - couldn't you detect this case within napi poll loop?
> - if not, does it have to be per-q timer? wouldn't one global per pf time=
r
>   satisfy your needs?
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h         |  4 ++++
> >  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 +++++++++++++++++++=
+++++++++++++
> >  3 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 2f7bd330..8378bef2 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/net_tstamp.h>
> >  #include <linux/pci.h>
> > +#include <linux/timer.h>
> >  #include <linux/ptp_clock_kernel.h>
> >  #include <linux/u64_stats_sync.h>
> >  #include <net/page_pool/helpers.h>
> > @@ -41,6 +42,7 @@
> >
> >  /* Interval to schedule a stats report update, 20000ms. */
> >  #define GVE_STATS_REPORT_TIMER_PERIOD        20000
> > +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
> >
> >  /* Numbers of NIC tx/rx stats in stats report. */
> >  #define NIC_TX_STATS_REPORT_NUM      0
> > @@ -318,6 +320,7 @@ struct gve_rx_ring {
> >       u64 rx_copied_pkt; /* free-running total number of copied packets=
 */
> >       u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails *=
/
> >       u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fail=
s */
> > +     u64 rx_critical_low_bufs; /* count of critical low buffer events =
*/
> >       u64 rx_desc_err_dropped_pkt; /* free-running count of packets dro=
pped by descriptor error */
> >       /* free-running count of unsplit packets due to header buffer ove=
rflow or hdr_len is 0 */
> >       u64 rx_hsplit_unsplit_pkt;
> > @@ -334,6 +337,7 @@ struct gve_rx_ring {
> >       struct gve_queue_resources *q_resources; /* head and tail pointer=
 idx */
> >       dma_addr_t q_resources_bus; /* dma address for the queue resource=
s */
> >       struct u64_stats_sync statss; /* sync stats for 32bit archs */
> > +     struct timer_list starvation_timer; /* for queue starvation recov=
ery */
> >
> >       struct gve_rx_ctx ctx; /* Info for packet currently being process=
ed in this ring. */
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/ne=
t/ethernet/google/gve/gve_ethtool.c
> > index a0e0472b..71b6efbf 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRI=
NG_LEN] =3D {
> >       "rx_hsplit_unsplit_pkt",
> >       "interface_up_cnt", "interface_down_cnt", "reset_cnt",
> >       "page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt=
",
> > +     "rx_critical_low_bufs",
> >  };
> >
> >  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] =3D {
> > @@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING=
_LEN] =3D {
> >       "rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
> >       "rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
> >       "rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_all=
oc_fails[%u]",
> > +     "rx_critical_low_bufs[%u]",
> >  };
> >
> >  static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] =3D {
> > @@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >  {
> >       u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_b=
ytes,
> >               tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
> > +             tmp_rx_critical_low_bufs,
> >               tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
> >               tmp_tx_pkts, tmp_tx_bytes,
> >               tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
> >       u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit=
_pkt,
> >               rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_p=
kts, tx_bytes,
> > -             tx_dropped, xdp_tx_errors, xdp_redirect_errors;
> > +             rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
> > +             xdp_redirect_errors;
> >       int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
> >       int stats_idx, stats_region_len, nic_stats_len;
> >       struct stats *report_stats;
> > @@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >
> >       for (rx_pkts =3D 0, rx_bytes =3D 0, rx_hsplit_pkt =3D 0,
> >            rx_skb_alloc_fail =3D 0, rx_buf_alloc_fail =3D 0,
> > +          rx_critical_low_bufs =3D 0,
> >            rx_desc_err_dropped_pkt =3D 0, rx_hsplit_unsplit_pkt =3D 0,
> >            xdp_tx_errors =3D 0, xdp_redirect_errors =3D 0,
> >            ring =3D 0;
> > @@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                               tmp_rx_bytes =3D rx->rbytes;
> >                               tmp_rx_skb_alloc_fail =3D rx->rx_skb_allo=
c_fail;
> >                               tmp_rx_buf_alloc_fail =3D rx->rx_buf_allo=
c_fail;
> > +                             tmp_rx_critical_low_bufs =3D
> > +                                     rx->rx_critical_low_bufs;
> >                               tmp_rx_desc_err_dropped_pkt =3D
> >                                       rx->rx_desc_err_dropped_pkt;
> >                               tmp_rx_hsplit_unsplit_pkt =3D
> > @@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                       rx_bytes +=3D tmp_rx_bytes;
> >                       rx_skb_alloc_fail +=3D tmp_rx_skb_alloc_fail;
> >                       rx_buf_alloc_fail +=3D tmp_rx_buf_alloc_fail;
> > +                     rx_critical_low_bufs +=3D tmp_rx_critical_low_buf=
s;
> >                       rx_desc_err_dropped_pkt +=3D tmp_rx_desc_err_drop=
ped_pkt;
> >                       rx_hsplit_unsplit_pkt +=3D tmp_rx_hsplit_unsplit_=
pkt;
> >                       xdp_tx_errors +=3D tmp_xdp_tx_errors;
> > @@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >       data[i++] =3D priv->page_alloc_fail;
> >       data[i++] =3D priv->dma_mapping_error;
> >       data[i++] =3D priv->stats_report_trigger_cnt;
> > +     data[i++] =3D rx_critical_low_bufs;
> >       i =3D GVE_MAIN_STATS_LEN;
> >
> >       rx_base_stats_idx =3D 0;
> > @@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                               tmp_rx_hsplit_bytes =3D rx->rx_hsplit_byt=
es;
> >                               tmp_rx_skb_alloc_fail =3D rx->rx_skb_allo=
c_fail;
> >                               tmp_rx_buf_alloc_fail =3D rx->rx_buf_allo=
c_fail;
> > +                             tmp_rx_critical_low_bufs =3D
> > +                                     rx->rx_critical_low_bufs;
> >                               tmp_rx_desc_err_dropped_pkt =3D
> >                                       rx->rx_desc_err_dropped_pkt;
> >                               tmp_xdp_tx_errors =3D rx->xdp_tx_errors;
> > @@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                       } while (u64_stats_fetch_retry(&priv->rx[ring].st=
atss,
> >                                                      start));
> >                       i +=3D GVE_XDP_ACTIONS + 3; /* XDP rx counters */
> > +                     data[i++] =3D tmp_rx_critical_low_bufs;
> >               }
> >       } else {
> >               i +=3D priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index 02cba280..303db4fa 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -18,6 +18,16 @@
> >  #include <net/tcp.h>
> >  #include <net/xdp_sock_drv.h>
> >
> > +static void gve_rx_starvation_timer(struct timer_list *t)
> > +{
> > +     struct gve_rx_ring *rx =3D timer_container_of(rx, t, starvation_t=
imer);
> > +     struct gve_priv *priv =3D rx->gve;
> > +     struct gve_notify_block *block;
> > +
> > +     block =3D &priv->ntfy_blocks[rx->ntfy_id];
> > +     napi_schedule(&block->napi);
> > +}
> > +
> >  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_=
ring *rx)
> >  {
> >       struct device *hdev =3D &priv->pdev->dev;
> > @@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, in=
t idx)
> >
> >       if (rx->dqo.page_pool)
> >               page_pool_disable_direct_recycling(rx->dqo.page_pool);
> > +     timer_delete_sync(&rx->starvation_timer);
> >       gve_remove_napi(priv, ntfy_idx);
> >       gve_rx_remove_from_block(priv, idx);
> >       gve_rx_reset_ring_dqo(priv, idx);
> > @@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, st=
ruct gve_rx_ring *rx,
> >       u32 qpl_id;
> >       int i;
> >
> > +     timer_shutdown_sync(&rx->starvation_timer);
> > +
> >       completion_queue_slots =3D rx->dqo.complq.mask + 1;
> >       buffer_queue_slots =3D rx->dqo.bufq.mask + 1;
> >
> > @@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> >       rx->gve =3D priv;
> >       rx->q_num =3D idx;
> >       rx->packet_buffer_size =3D cfg->packet_buffer_size;
> > +     timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
> >
> >       if (cfg->xdp) {
> >               rx->packet_buffer_truesize =3D GVE_XDP_RX_BUFFER_SIZE_DQO=
;
> > @@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx=
)
> >       struct gve_rx_compl_queue_dqo *complq =3D &rx->dqo.complq;
> >       struct gve_rx_buf_queue_dqo *bufq =3D &rx->dqo.bufq;
> >       struct gve_priv *priv =3D rx->gve;
> > +     u32 num_bufs_avail_to_hw;
> >       u32 num_avail_slots;
> >       u32 num_full_slots;
> >       u32 num_posted =3D 0;
> > @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *r=
x)
> >       }
> >
> >       rx->fill_cnt +=3D num_posted;
> > +
> > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> > +      * visible to the hardware, and no doorbell was written, the hard=
ware
> > +      * is in danger of starving and cannot trigger interrupts. Start =
the
> > +      * timer to periodically reschedule NAPI and recover from starvat=
ion.
> > +      */
> > +     num_bufs_avail_to_hw =3D
> > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > +              bufq->head) & bufq->mask;
> > +
> > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> > +             u64_stats_update_begin(&rx->statss);
> > +             rx->rx_critical_low_bufs++;
> > +             u64_stats_update_end(&rx->statss);
> > +             mod_timer(&rx->starvation_timer,
> > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_=
MS));
> > +     }
> >  }
> >
> >  static void gve_rx_skb_csum(struct sk_buff *skb,
> > --
> > 2.55.0.rc2.803.g1fd1e6609c-goog
> >
> >

