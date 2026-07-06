Return-Path: <netdev+bounces-305241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H8G+CoI5TGq7hwEAu9opvQ
	(envelope-from <netdev+bounces-305241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:25:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C8B7164C5
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eIgPFhOi;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305241-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305241-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 846A830306E3
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD103F660F;
	Mon,  6 Jul 2026 23:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46633E92B5
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:25:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380346; cv=pass; b=k1FKfRVDOjiCERNG6KB6bJujmVlIk1J74JXil3o9SJygiBqIqDSZHPBERjc5r2xUmvylKEEZ2BBxTtT+BG1tLxVUTe388RehW0GZjQ3UumY2x7JZzfogMW/B4eFVL2+Qzv3frSReSuwoHgJeEipKF38wPxe65AkQ86A0Oqc9MJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380346; c=relaxed/simple;
	bh=7kwepPL4rpt8ve6G9vcz81cEyGKYWJfBN35fbxbTaCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BASkJIVIH3g3ODvBkVsIWOl81jVEW7wt7l6JuxbJVVgzQpWleld8GRmO+WuSIIRj82GWxXQwlis0l0/awRawyNC+IUAjNKXsAQQN5mDER6XeqP7Q1UB38nOfuDEmrfkKQTUxpPBJ18YOAzhYDUbU8ZO/0fB66VAhMowqppHZD1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIgPFhOi; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so5828256a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783380343; cv=none;
        d=google.com; s=arc-20260327;
        b=bTAIWqcvM8yyuXQ+dZTE/hsxvEK9oX5CZL4F7PNGXlmYdDwgkqiXXYSg3L4He/B7LU
         HQSdkXlBWyUWx+XfVy7SAbjeyv0SSNgGe5p8iC4VzApaQHxBYYlWFJRFzcYcHakbXNSq
         qAoyhelORpZdAGjOFbFopPz1DqhcEHtsz2MhKlTh0fgt2kQUDn9kP8XjHwjROPftmIoS
         dzd93yOsmI70Qo6z8naBwQS0KwME/QsXLs+7fzb8xHQg1Ky+MCG9Nj8TfBdmFigTUONd
         pheebxoknwfvP9hnmveNcNxCf/TR0DqXNNR7YdVoolTwLXAk6Q0kLFBMi5v/tiVQVZbM
         kgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Pc7JiAuHxF+QuGXrXMQLosfJrzpael4+1ktB61Wlvc=;
        fh=CMi251digb5A7g8ZLPFImfLlU+ZX7NkjdHItNDFWRWw=;
        b=ZMOdAQLz5+YGiXaR6OlvxUwTP4vG7FJk0iWGNIcPCsaZRg91L1GxN87IADe7vVr8/V
         dRxKQl2PelZoj4cicZmEafqejYmAwfxBh1GW/rcjLctUSdZ6wl4einVUbqSRHyz90AkR
         vb+zN+yneNLwb1Nd0hn2PZ5AlJ5c0FPxOyk5XXofmAVt/owv0Hx/Lnrs7BDzAHEHu17D
         Iwmbj/kZ21ANWYhTlGHE9nkF4Sl9hsJo0VAbf8KU/b8/OnIdbbJzuDebdUgWk8Q4/C9l
         j2sX+eKt2JgU6ecvRpaW9aa/ylBZvUpFTxyN5Pxa4Wwp1muhTS4qq20zw+Ir/ZUHgxTk
         +jFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783380343; x=1783985143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Pc7JiAuHxF+QuGXrXMQLosfJrzpael4+1ktB61Wlvc=;
        b=eIgPFhOibS4zKK993zyBHGZpGCPJMR+SNNKz1vnMuhgI+OBVSyld5fs/nOQwp5GtPE
         bVF4SoQFnSzGfZ7/Juro7Uxv4zMSKRfu1qmOyWfHyfqIb4G9Zcnyp7tzsCAZnhkbCQse
         OeW2GZRyaro0+7Qj/G0PgZ21pVhPAIpWCYhJxtIkH1ekFFSPt4zRe/A/11kcFS6uA311
         mKkMrN/ZWSa8Be0uWcBg7DiNNJS9zS5s8vAlJ+gAO4hhUM53VcG0oTixSLZriORKungj
         i+bA/Py7B0LXFP/uAwes9SwVYIWxkDiH9VtzSagCZvTjte0pPEV0OL0JQQW6+4YVkeeV
         OofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783380343; x=1783985143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Pc7JiAuHxF+QuGXrXMQLosfJrzpael4+1ktB61Wlvc=;
        b=MPb5jhibsiP2CT2TVyuCK83rmfeNWogi1CKDIT1tCeQztIjRFskDWPuIzbVzYnKKC4
         2jM7hE1hWNbFCrbavP9P7oBLAm0SabRL2CORttFFTUdKHUL0p8m4dBpyhJQEmaHdZPo+
         L9NLzR8VypdcU32w4DqTX3el3GYmp8sTlalrX8lDCedHFzJgdITj2qsNp3XO5zUPckwj
         U4LWE30mz5UzAlGFWDJrgPjS90V5qs6Gtf+Y9HvEB6GcABJVwiUDoyqQIuViNvjEihMU
         ELxRCJB+ZTT4zRscoGkeqAirDxR4U8lzgWtIvBq/+luW7u93UX0EJFTpGuPM8IiOR5rD
         AEiA==
X-Gm-Message-State: AOJu0YwoDV83hYDJXlWw6j2kq1qrNLVEhdgmEqYFtCVTT2Og59v0UYoF
	0sZL0glHwY6lWEIJDKniuvP2ZMupNV0iVLCGQYxQYL/pFOe7CmwP7SiCAi9L0aqCzh6ZBV49g5X
	VwxaeWK4t6+mTq6BYi9Pv+1Q+JQnjjt8=
X-Gm-Gg: AfdE7clFAgD4KLTRUDjsypjQHheB8vVTgQgedwIAiTUO4yBj4zTBuLGmBqtN1SkSpwc
	D4ufJ3itccFKjDNZ+eOesNSBQwR2fD3Fs8JT1wEGh8LtINGLXvNLVXxDdLhJzpJF+djtQqwMSEh
	mAzlPTudUv8aybNauhedr7z4CJeBOZ007IQDoe8Nfriyv1zSK309mA/KlvfQRIGb6mpEjdrRS32
	IQEW8ogu9UIH2UslqpqHvX/4a8TN6i+UOqTz8YaDyfcp/DxsTP8KglSpmEyhKASv5BSMRWUkRts
	FVT9bu5+srHLpuVSEl3hBxwbA3b4BURtrNMQKDkQcMx9iS5eF0Uk/ow3XXB5pj25y3SmvPiwKMr
	5xQXMmElQS7GE8/QwNkyEbHDOCB4=
X-Received: by 2002:aa7:df82:0:b0:699:6415:751b with SMTP id
 4fb4d7f45d1cf-69a85c3de25mr981520a12.24.1783380342854; Mon, 06 Jul 2026
 16:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706030632.1826810-1-rosenp@gmail.com> <20260706083906.5oxmr47vbnaztfu2@skbuf>
In-Reply-To: <20260706083906.5oxmr47vbnaztfu2@skbuf>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 6 Jul 2026 16:25:31 -0700
X-Gm-Features: AVVi8CemyiGNdzRWaCCx8GUz2vzlQv5JEx0FZ7uEOcNvze3gpNIF4xu3V61ZCc8
Message-ID: <CAKxU2N-6Msn+WciepQ3rnP64fUE6s_jviWfy8no_-qorPoyJEw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dpaa_eth: convert to napi_gro_receive
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305241-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88C8B7164C5

On Mon, Jul 6, 2026 at 1:39=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> Hi Rosen,
>
> On Sun, Jul 05, 2026 at 08:06:32PM -0700, Rosen Penev wrote:
> > Replace netif_receive_skb() with napi_gro_receive() to improve receive
> > performance for this driver. It has rx checksum support so routing spee=
d
> > shouldn't suffer.
> >
> > Tested on a WatchGuard Firebox M300.
> >
> > iperf3 bidir speed test:
> >
> > [ ID][Role]   Interval         Transfer      Bitrate        Retr
> > [  5][TX-C]   0.00-60.01  sec  5.35 GBytes   766 Mbits/sec  184    send=
er
> > [  5][TX-C]   0.00-60.02  sec  5.35 GBytes   766 Mbits/sec         rece=
iver
> > [  7][RX-C]   0.00-60.01  sec  5.50 GBytes   787 Mbits/sec  124    send=
er
> > [  7][RX-C]   0.00-60.02  sec  5.49 GBytes   786 Mbits/sec         rece=
iver
> >
> > After:
> >
> > [ ID][Role]   Interval         Transfer      Bitrate        Retr
> > [  5][TX-C]   0.00-60.01  sec  6.49 GBytes   929 Mbits/sec    0    send=
er
> > [  5][TX-C]   0.00-60.02  sec  6.49 GBytes   928 Mbits/sec         rece=
iver
> > [  7][RX-C]   0.00-60.01  sec  6.55 GBytes   938 Mbits/sec    0    send=
er
> > [  7][RX-C]   0.00-60.02  sec  6.55 GBytes   937 Mbits/sec         rece=
iver
> >
> > Assisted-by: Opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/n=
et/ethernet/freescale/dpaa/dpaa_eth.c
> > index ad2d8256eb8d..83191f636ec7 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -2824,10 +2824,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(=
struct qman_portal *portal,
> >
> >       skb_len =3D skb->len;
> >
> > -     if (unlikely(netif_receive_skb(skb) =3D=3D NET_RX_DROP)) {
> > -             percpu_stats->rx_dropped++;
> > -             return qman_cb_dqrr_consume;
> > -     }
> > +     napi_gro_receive(&np->napi, skb);
> >
> >       percpu_stats->rx_packets++;
> >       percpu_stats->rx_bytes +=3D skb_len;
> > --
> > 2.55.0
> >
> >
>
> (thanks to Madalin for pointing out this change to me)
>
> I do not have time this week to test this patch, but in premise, you are
> creating exactly the conditions for this bug to occur:
> https://github.com/nxp-qoriq/linux/commit/d0ebec2092d6c5fe327513cb66e02d8=
c2c1a8f87
>
> In sdk_dpaa we already do GRO for TCP flows and it has the problems
> pointed out in the above commit. With your change to use GRO for all
> capable flows, I currently have no reason to believe that without
> similar countermeasures as those taken by sdk_dpaa (napi_gro_receive()
> global to the entire QMan portal) the outcome would be different.
>
> Have you tested traffic in mixed scenarios, where flows from multiple
> interfaces land on the same CPU?
Just iperf3 --bidir.
>
> Until further evidence comes in:
Maybe netif_receive_skb_list is a better fit here.
>
> pw-bot: cr

