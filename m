Return-Path: <netdev+bounces-280905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFz+HRPG6mkXDgAAu9opvQ
	(envelope-from <netdev+bounces-280905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B0458B35
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A95D30080B2
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB223E356;
	Fri, 24 Apr 2026 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZs77KMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E5221FB6
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993808; cv=pass; b=e4dQrAUF9IRYpm81fcyl/lnctOd9a5XCpvPeeivVYlXndS3cfA4rVGTNt5D8FDWpvnWGWtpYM59Pni3au/QPfZBOZqIb/XZCkH72vUNs3LY7jIkcTUBIUcahQUTwz+QU6K4Dyw6Fw3aDfgQbUutdNTJc0CiExZfjeUNIPwQIfIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993808; c=relaxed/simple;
	bh=LZxQiuYx4ox4RBl4n5ZTdHsqwDGgf72MBgrWCsmpZ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc59r7xr2WBosiZv24+ycSsxgmc+MX/Ijk7Fg2AwFBzs85YT5jx0b1XHoX+3On8ARArdOXA6sXngVinU3DtNFwWsRZHhisOL1lcjmPq/r9W/FINRZUSLIA1rCNpSWv+cgDBjXUKCPNdXfAX31wMq+OfwLDPz+bsWh3HQXa3gBGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZs77KMI; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fede2acso48306225ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776993807; cv=none;
        d=google.com; s=arc-20240605;
        b=VPGpGepeXJ/Mf7Z+MAB4+b7E65mZFGKJsWYQ60mrn9l71UTAnex7Kp+vt07NybsfCh
         uWIhfPpyhr6n9qrTltOVhm8n+MlmyA3SY8S0yS/ILmN0Stl2RBsQtrOOpbB2J/9yDsPK
         +I4CAgkBNXuRUF4IhYDJjor1fbEFs19ovvc32z0BlanqYdTVOF+qElD6zpsyosE5y+81
         KAUT7x4vS4ZsiBEhcgJwDKVpdfgtOnEFBz8hjY3lgS5j9nj691sCwI0BV7L6eYDV7wxm
         tG2Fv98YjCEjHzB204nZQA0pjXo4girO8DHWzMRTEUM7gXYXUcR3bzbXXglnmmfHd4uI
         bAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DGB0p6PEQGZngruRS3yAoXwqjvYFLn1cZjKZe/H0Wg=;
        fh=8onr+Mwm+zUT0MVk2ehMF+aL/XvS6qIvl1S/DvHicaA=;
        b=QexqMHBN7dAKXmICIYWfFHRc2YHK32oHK9M2j2wPjbAkaMa7SqcKu9+ca48T3J++oD
         Qfzdq8CWMeHIuwKTXFhEoyw8zz6EryOSH/w5RIulHZpQsOwKhv+gF4TjGJSqea7ze+PC
         2U3a05+zB/QVlD3ELFc0HSSjimH1JfcOWmn86Z8ebo9kfuoizckLFwK6e2W88S9tYFq1
         wqHIkb5WGvdax1/c57rD4TypoNk43a9nKhbADk8tUtr9YzAkGAfSKZjpLy8ygmNDQvmh
         Vx6Rjvp4KoQosl+TYwCdN3gu/N9ijgrvVHGcRDv5+72BxqSqpzywCES71y5qRXO9c5n3
         Hs5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776993807; x=1777598607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DGB0p6PEQGZngruRS3yAoXwqjvYFLn1cZjKZe/H0Wg=;
        b=RZs77KMI145HgJ+BiXtX909VDMni6Kq/0y4Zj1DvhLNg3ZMnoSMJwU0F8xeKSS8UMj
         k4HXK+R5IcAgQitlLrpGm9qzNN7mTnR0mp4TXAJdRpc+4YtJEsJ/vFrjw3K4H7Nrw3Qg
         RRCamprtqU+oKTaJE97VGJFZmX6EpYNfPz9WyVA/x/oHkH6ww+ElmbQQjT/opY5EoMB4
         x5edxHXdV3ysrgTi6ARbHxEl+FFfGnBSF5PJv+c2iXdCmwbG3qcjIT9mjt2Nfq0RZhrz
         ej8DfQoWURbe+NP+mV7iAXUfJo+9YJE4YXyLDrKH4ynto0/fDlCnLZSjGG2gWiebxs2M
         fxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993807; x=1777598607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DGB0p6PEQGZngruRS3yAoXwqjvYFLn1cZjKZe/H0Wg=;
        b=Ee4gjsxVt4tb+u3kMhWcM38tSYKOwHwsVVlJh6WP7EAk1vWHb8viLI0QQyJVWX9oTe
         Mkc/oV9oMAcrWK+IclkDcSNlowtQBQQA+C8GJb2sa54xrDNDp1Ddksk04JDZthFn2Z9J
         j9tT+i6zzMZ2w8BH1HkIJbrjx50mEG4qsI6WqZ6CoUXmFO7crPRW38DaN+NMjjcRg5kK
         Wmse1wefK5ySNRYsxHjti2sPwxuH9jQsObXbjwIGBHWazG4abKV0MJR4YqNPtD6BMlLj
         McqKb0qJisUOwEC/GANSEZpXPXYmuxnib/sS7ANbR6kb1XgsdYiVeXEqiafgy8LK9kJa
         yCHA==
X-Forwarded-Encrypted: i=1; AFNElJ9Qpe4F5l9F1FJA38frgXnN54S3stXChGPZR6CMAIL+nstiFQZd61EJX8uaXDahUrnWpoNZ7Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXovTj/4VKc+soiUMCEqvkAcPSqE8kFktg6XpSTSyH8L8yvOWt
	EKSLp+t6Yrxj7qwU7WSaMGklSlO3YeNLDtWjPv7phmzZVi/SVA8pW/cEoLM3xR7SC3xjDWleEXe
	AsCh26DO1FC+u4LGUxhmyyov1kJUQRVFakFkB+KP5gf9jJd0MXSblSWKNXR6/6A==
X-Gm-Gg: AeBDiet0Td/eJCLUJ84nITIY1Kekn7EGtWsTSqItkonhkKsgpSIovsNRUS1urlqEZ2C
	YZQdOuEOzIiNMh/1/8ka0gshJkSJGT7H2eKWCgZb0wf3TMX4cEEp759sUPJ05YQTzimhAvQe6Vd
	xP8LpG5GnNqvF4rJUjp0OhMWB/C7axzMxf5YIpznyznMJZhDP5GtxV77sEWb7oDDmcPLEjNBPXR
	rxNB/itMtfF88DhNr7quyNxul/b61/sn/PfLyaymg6qKKxIxo26KuKZNk3jnq0lePVPPhyXkaTc
	fWy9hc1/VbqHX5PM2ygofZMDYdYqAoYfkvLsaWwDE7biWFIOOCWLAWSDlw==
X-Received: by 2002:a17:902:b40e:b0:2b2:5203:acd3 with SMTP id
 d9443c01a7336-2b5f9f3d36bmr245167045ad.26.1776993806167; Thu, 23 Apr 2026
 18:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-5-hramamurthy@google.com> <d0981984-b55f-495e-848b-6e9611f0c2ff@redhat.com>
In-Reply-To: <d0981984-b55f-495e-848b-6e9611f0c2ff@redhat.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:23:13 -0700
X-Gm-Features: AQROBzAGcS2PjTs5swOOoaKfbZg2p-wqysByjPRmX2HYW5vKVn4V0GsCwsuCX18
Message-ID: <CAHwYsioVLVsHpUWbokBrzcbQ6BEYTWP9B+TYqZVbU04-EHqtgQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] gve: Make ethtool config changes synchronous
To: Paolo Abeni <pabeni@redhat.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, maolson@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, shailend@google.com, jordanrhee@google.com, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E14B0458B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280905-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url]

Hi Paolo,

On Thu, Apr 23, 2026 at 6:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> > From: Pin-yen Lin <treapking@google.com>
> >
> > When modifying device features via ethtool, the driver queues the
> > carrier status update to its workqueue (gve_wq). This leads to a
> > short link-down state after running the ethtool command.
> >
> > Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
> > `gve_queues_start()` to update the carrier status before returning to
> > the userspace.
> >
> > This was discovered by drivers/net/ping.py selftest. The test calls
> > ping command right after an ethtool configuration, but the interface
> > could be down without this fix.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
> > Reviewed-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Pin-yen Lin <treapking@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 8617782791e0..d3b4bec38de5 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1374,6 +1374,33 @@ static void gve_queues_mem_remove(struct gve_pri=
v *priv)
> >       priv->rx =3D NULL;
> >  }
> >
> > +static void gve_handle_link_status(struct gve_priv *priv, bool link_st=
atus)
> > +{
> > +     if (!gve_get_napi_enabled(priv))
> > +             return;
> > +
> > +     if (link_status =3D=3D netif_carrier_ok(priv->dev))
> > +             return;
> > +
> > +     if (link_status) {
> > +             netdev_info(priv->dev, "Device link is up.\n");
> > +             netif_carrier_on(priv->dev);
> > +     } else {
> > +             netdev_info(priv->dev, "Device link is down.\n");
> > +             netif_carrier_off(priv->dev);
> > +     }
> > +}
> > +
> > +static void gve_turnup_and_check_status(struct gve_priv *priv)
> > +{
> > +     u32 status;
> > +
> > +     gve_turnup(priv);
> > +     status =3D ioread32be(&priv->reg_bar0->device_status);
> > +     gve_handle_link_status(priv,
> > +                            GVE_DEVICE_STATUS_LINK_STATUS_MASK & statu=
s);
> > +}
> > +
> >  /* The passed-in queue memory is stored into priv and the queues are m=
ade live.
> >   * No memory is allocated. Passed-in memory is freed on errors.
> >   */
> > @@ -1434,8 +1461,7 @@ static int gve_queues_start(struct gve_priv *priv=
,
> >                         round_jiffies(jiffies +
> >                               msecs_to_jiffies(priv->stats_report_timer=
_period)));
> >
> > -     gve_turnup(priv);
> > -     queue_work(priv->gve_wq, &priv->service_task);
> > +     gve_turnup_and_check_status(priv);
>
> Sashiko says:
>
> Since gve_handle_link_status() can now be called from process context
> via gve_turnup_and_check_status(), while also being concurrently
> executed by gve_service_task() on the workqueue, could this create a
> time-of-check to time-of-use race?
> If the physical link toggles rapidly, could the workqueue thread sample
> the later hardware state (e.g. OFF) but see the software state is
> already OFF and return early, while the process context thread sampled
> the earlier state (e.g. ON), evaluated netif_carrier_ok() as OFF, and
> proceeded to call netif_carrier_on()?
> This might leave the software carrier state stuck ON when the most
> recent hardware state is OFF, because the condition check and update are
> no longer serialized by the workqueue.
>

This is a legitimate concern, but it is not introduced by this series.

gve_turnup_and_check_status() is an existing function. And, given that
there is no locking around gve_service_task(), there could be
concurrency issues on gve_handle_link_status().

We will upload a separate patch to fix this.

> Notes that there more comments:
>
> https://sashiko.dev/#/patchset/20260420171837.455487-1-hramamurthy%40goog=
le.com
>
> but I'm not sure if they are actual regressions introduced by this series=
.

Thanks for the pointers. I'll reply to all the Sashiko comments on the
mailing list.
>
> /P
>

Regards,
Pin-yen

