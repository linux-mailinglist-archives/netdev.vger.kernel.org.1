Return-Path: <netdev+bounces-252915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP9SDBq5c2n/yAAAu9opvQ
	(envelope-from <netdev+bounces-252915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:08:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81540795E4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE2A30067A6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9402652B0;
	Fri, 23 Jan 2026 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CvV7FTAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D176202F71
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191584; cv=pass; b=R2E0qnhIEaNuBqGsUySdBHHN6pW4lVxCqOym1cZmBfoYYGKm13lc6SqS6CsQHTpeP6sF+Llo6jhMeqcVXnGcDS+DvIeV32U1qfG9+Dz6k0hJqksCZPGSNMEu69yrs97a0pJlT4tvjBhvMRCcS2op8LSjz/AH2jvVx0n0BK/OeAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191584; c=relaxed/simple;
	bh=p5q3Aur6M2FupZ96yuxwDe6RYzKoiKQJNMqMpUvR2dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCGQM8sG3gyeuZ2fOlJwoFy//8cpJckZsyYT6PDbVECNEpJJsjz6w79u/QIcZTllKG0GU0ClgCBG5NdP2X/gepXN/l8OjagA06jrF8ZAOTPGlUo2XHvHSy8OG0Hav5fBOclzhpZ8vmTQly7vF7UNfuwe81bwnoQl9jsb8MPu27g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CvV7FTAh; arc=pass smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-50145cede6eso24059261cf.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 10:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191581; x=1769796381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I798OjJKLtAEcBq3nYnoZ1YYNl4dedpS0OyLzVzVpmY=;
        b=ACAuriooyYNwqUHeQ8CIwn6YlqA6eD9Y7UBHs1ARejqGt6Yq33xEcxpGPbb0LUJRe3
         noCm0nBrtGR7zsDudPgB1YPGfPS/P6HSYl7qKhY3iZxH0BRHCqen9oJZYYXV2+QDFf8H
         Wt52nvA+uzW791siGX+vjNKXcc8hEB2d7gE/duwFucO+9xodyIRRpNe/XXs7DSzShs34
         HKKnBg59zUiyuJaTEIYwvmVIk4a4ZpWhhXN7V6bFP7VaEEOz+zJSrcA/R+PrSM2OLRnl
         UeHMxf1KT5KiNuLL5vQ9J10Mvludc/OXB078+vBRfOqpxN9F/kAI2nohp5AVC2r65E6P
         REHg==
X-Forwarded-Encrypted: i=2; AJvYcCXY1k3RNYezzYrGpYN7y8ND8eS3cRvhvDM1SgwPRz03Mz6vMnT59jtq30nvwZC/IeDGXpHeUT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkBLj7xHNs1Q4afmLA/4ZFxC64/C1OonCrGlo5yfsZQTbR0Vv
	LOeW0L4c0ml0+w3zvkSZ1CiNbBARYqj33oNUJWGX1XE5Qwjp2AYaG4Dw3XLVJV4HDXWo79iiH4B
	LxGJ7TAznsrL1i6bvA2/2BaktitXjYdYbM9ldfbHMaVYkZ2M6Spwgwr1VdpCWGhRhTOhfka66B7
	LcHdBrrW7XGxbhy1OQYurJYaWYmlbcRZisfyyLZnC+wMu/ip6QaQTSUNjmNoh5ygAS9xDphaiVf
	O4drScUqo0dbSxboA==
X-Gm-Gg: AZuq6aIN5QV0zzpmBRR9SrGzRaA7OpI5MV+3sSub1ZKd2MRb2lcUuv8QaNhl7q8IWzK
	64lTO8t57LJ3xJDE4snPNxGFL8FAz0gNM9ruEVbmL+S/YgtTS6MGoQspsKkPtFem6wnIoJtvJiA
	qTvQ9avjJAkoqUT6VAe/nw9fR8cNb7uGeQrLB2o3IHxJUmBB0glK3jFoi5dXhmuUuoDDcnl2IaQ
	xoDx6EzAZUM6FSP0qy9mqz6g/aafZcNYoehuuxoX1VklOR1BROKQOM+vFAj7jUmjWWWQpJ5dVoq
	T2RWsJf7Dq0ykpb0EjVyjm8ONbh8LzH/fgKeiV/x3o3iJS1G+WXI+cjOqdt8FbZNg11xKLPONyk
	r6l+7Rh/UerdCpKR0osFjdEtezumMtCILhpcd5vWSOUy/KKvaM9Uvro7TedJjrgtC1clZsfN/FV
	LXfnnJquM7v8gHs3vlaT/qPBmvJ+3TQVM5rDVSEF4duB5easwu9W6NtQ==
X-Received: by 2002:ac8:584d:0:b0:501:4bb5:51a2 with SMTP id d75a77b69052e-502f77d2ddemr56572571cf.53.1769191581314;
        Fri, 23 Jan 2026 10:06:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8949182fd5esm3548506d6.14.2026.01.23.10.06.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 10:06:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b708fa4093so8565435eec.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 10:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769191580; cv=none;
        d=google.com; s=arc-20240605;
        b=gqI33L1AU/MH3uGqWSIbf95K82MsmCbUyrRqvFpLnDMzJiVvxfrCytaL7repEb1hSv
         b+lQXTytpl41gFzjyrxpzygHI1LBzpfZWaO6fnjN5ovyxUX96U51OWKtx7kEkRLgFuQD
         6TcfOcl37Hs8TXt/W7wBsX4aDFHEnOvPYrv2H3zUhjUA33mgxGWBZXqjLGI1q03ixrGd
         D9JWQw8zjwga31qK4QtktrmbNW+42gbmOjftMC2E6KWzplimXJ1NDCqrkh4GxnzX0TJm
         N8anmYZzO4jjK3hyz//ttQ1OjBpAbJFRkw375I4yQxh/nbfcG6AnpMYlwMWMjZHdLjWY
         e95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I798OjJKLtAEcBq3nYnoZ1YYNl4dedpS0OyLzVzVpmY=;
        fh=omnKvQPOwyov2HcBvcza19uvSVf5gNA+/jRzz/lbg68=;
        b=BB5MFqkybBBvqy4Sd8S49zMx5YgmHZA/KRoJ8wsSBGvioqnrOLyEiGZl0xXHDX4BZC
         6d8zKd+eQgpeCbl8948Ef+TT6KDvA44KJ1eF3sBCI4YlqOPdia5FibbtGAmAjdey6VYG
         fnHMTmKCJelDse/h7+VJrRfdatOZ1yxw0G4OV8ZvwFRX3uE98QU7LCzY/KF/XmUUQFD1
         fV0XcqwbsPSOqtRHzXjvr7mko35i7TfKsQ4UfJAxOAk+ragxVCmLJdxZC+A3m2MD2X0Q
         mFFySIPK0Uk8Lojx0VrwrdrHnZ7AsaFTKZ2GUgDET8f1ECBdVf9z2AUTJKHEvl/FDb7h
         XfPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769191580; x=1769796380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I798OjJKLtAEcBq3nYnoZ1YYNl4dedpS0OyLzVzVpmY=;
        b=CvV7FTAhrKQPxJhPsGqsDnlRz7k5hjxTeIQJosKYC6wgogLpXCyi/hxvsooZ23LCTk
         RorQFM06K3JgpA8c6gqnHGGvW6JvdfQY8XkcGtsLQoL2/c+22G7evtZVPx70pg30VVU6
         l9E9qi3o75TghdPUDlpavq6lBVzGowfQSPkD0=
X-Forwarded-Encrypted: i=1; AJvYcCXxxzzRmfahtstNqTBb7WoO5Gq1MRaxlCTYtJ6sxTmd9x4wIbEHsQZfsr1jDAefE8OMIi3y1Ts=@vger.kernel.org
X-Received: by 2002:a05:7300:ed0e:b0:2b7:2bbd:95ae with SMTP id 5a478bee46e88-2b739be9717mr1776133eec.37.1769191579659;
        Fri, 23 Jan 2026 10:06:19 -0800 (PST)
X-Received: by 2002:a05:7300:ed0e:b0:2b7:2bbd:95ae with SMTP id
 5a478bee46e88-2b739be9717mr1776113eec.37.1769191579166; Fri, 23 Jan 2026
 10:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116193732.157898-9-bhargava.marreddy@broadcom.com> <20260119194553.1264793-1-kuba@kernel.org>
In-Reply-To: <20260119194553.1264793-1-kuba@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 23 Jan 2026 23:36:04 +0530
X-Gm-Features: AZwV_Qh-t-7Pl8T3fJHRQz7aYh9yYSLC7fEG1-egFdmJGyndEHzzGDQ199QwWUM
Message-ID: <CANXQDtY0AVH7gH1fEUa7OtJPpawi6MVBNkuXDCdPQY5Z7j6J3A@mail.gmail.com>
Subject: Re: [v5,net-next,8/8] bng_en: Add support for TPA events
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, vikas.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, pabeni@redhat.com, 
	rajashekar.hudumula@broadcom.com, rahul-rg.gupta@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, pavan.chebbi@broadcom.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org, 
	ajit.khaparde@broadcom.com, michael.chan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac3e4006491203c4"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252915-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 81540795E4
X-Rspamd-Action: no action

--000000000000ac3e4006491203c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 1:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bng_en: Add support for TPA events
>
> This patch enables TPA (Transparent Packet Aggregation) functionality
> in the VNIC and adds functions to handle TPA events for LRO/GRO
> processing.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers=
/net/ethernet/broadcom/bnge/bnge_netdev.h
>
> [ ... ]
>
> > @@ -159,10 +159,9 @@ enum {
> >  #define MAX_TPA_MASK (MAX_TPA - 1)
> >  #define MAX_TPA_SEGS 0x3f
> >
> > -#define BNGE_AGG_IDX_BMAP_SIZE       (MAX_TPA / BITS_PER_LONG)
> >  struct bnge_tpa_idx_map {
> >       u16             agg_id_tbl[1024];
> > -     unsigned long   agg_idx_bmap[BNGE_AGG_IDX_BMAP_SIZE];
> > +     DECLARE_BITMAP(agg_idx_bmap, MAX_TPA);
> >  };
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_txrx.c
>
> [ ... ]
>
> > +static u16 bnge_tpa_alloc_agg_idx(struct bnge_rx_ring_info *rxr, u16 a=
gg_id)
> > +{
> > +     struct bnge_tpa_idx_map *map =3D rxr->rx_tpa_idx_map;
> > +     u16 idx =3D agg_id & MAX_TPA_MASK;
> > +
> > +     if (test_bit(idx, map->agg_idx_bmap)) {
> > +             idx =3D find_first_zero_bit(map->agg_idx_bmap, MAX_TPA);
> > +             if (idx >=3D MAX_TPA)
> > +                     return INVALID_HW_RING_ID;
> > +     }
> > +     __set_bit(idx, map->agg_idx_bmap);
> > +     map->agg_id_tbl[agg_id] =3D idx;
>                         ^^^^^^
>
> The agg_id_tbl array is 1024 elements, but agg_id comes from hardware via
> TPA_START_AGG_ID() which uses mask RX_TPA_START_CMP_AGG_ID_P5 (0xffff << =
16),
> allowing values up to 65535. Can this write out of bounds when
> agg_id >=3D 1024?
>
> For reference, the bnxt driver uses a different mask (0x0fff << 16),
> limiting agg_id to 0-4095.

Ack. Will update the macro to (0x3ff << 16) to match the 0-1023 TPA ID
range in the next revision.

>
> > +     return idx;
> > +}
>
> [ ... ]
>
> > +static u16 bnge_lookup_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_=
id)
> > +{
> > +     struct bnge_tpa_idx_map *map =3D rxr->rx_tpa_idx_map;
> > +
> > +     return map->agg_id_tbl[agg_id];
>                              ^^^^^^
>
> Same concern here - the array lookup has no bounds check on agg_id.

Ack.

>
> > +}
>
> [ ... ]
>
> > +static void bnge_tpa_start(struct bnge_net *bn, struct bnge_rx_ring_in=
fo *rxr,
> > +                        u8 cmp_type, struct rx_tpa_start_cmp *tpa_star=
t,
> > +                        struct rx_tpa_start_cmp_ext *tpa_start1)
> > +{
> > +     struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
> > +     struct bnge_tpa_info *tpa_info;
> > +     u16 cons, prod, agg_id;
> > +     struct rx_bd *prod_bd;
> > +     dma_addr_t mapping;
> > +
> > +     agg_id =3D TPA_START_AGG_ID(tpa_start);
> > +     agg_id =3D bnge_tpa_alloc_agg_idx(rxr, agg_id);
> > +     if (unlikely(agg_id =3D=3D INVALID_HW_RING_ID)) {
> > +             netdev_warn(bn->netdev, "Unable to allocate agg ID for ri=
ng %d, agg 0x%x\n",
> > +                         rxr->bnapi->index, TPA_START_AGG_ID(tpa_start=
));
> > +             bnge_sched_reset_rxr(bn, rxr);
> > +             return;
> > +     }
> > +     cons =3D tpa_start->rx_tpa_start_cmp_opaque;
> > +     prod =3D rxr->rx_prod;
> > +     cons_rx_buf =3D &rxr->rx_buf_ring[cons];
> > +     prod_rx_buf =3D &rxr->rx_buf_ring[RING_RX(bn, prod)];
> > +     tpa_info =3D &rxr->rx_tpa[agg_id];
> > +
> > +     if (unlikely(cons !=3D rxr->rx_next_cons ||
> > +                  TPA_START_ERROR(tpa_start))) {
> > +             netdev_warn(bn->netdev, "TPA cons %x, expected cons %x, e=
rror code %x\n",
> > +                         cons, rxr->rx_next_cons,
> > +                         TPA_START_ERROR_CODE(tpa_start1));
> > +             bnge_sched_reset_rxr(bn, rxr);
> > +             return;
>                 ^^^^^^
>
> When this error path is taken, bnge_tpa_alloc_agg_idx() has already set
> a bit in map->agg_idx_bmap but there is no corresponding call to
> bnge_free_agg_idx(). Will this leak the TPA index, eventually
> exhausting the available indices and causing subsequent TPA_START
> events to fail?

Reset logic coming in a later patchset will handle a full re-init (close/op=
en).
This clears all bitmaps and prevents the leak.

>
> > +     }
>
> [ ... ]
>
> > +static void bnge_tpa_agg(struct bnge_net *bn, struct bnge_rx_ring_info=
 *rxr,
> > +                      struct rx_agg_cmp *rx_agg)
> > +{
> > +     u16 agg_id =3D TPA_AGG_AGG_ID(rx_agg);
> > +     struct bnge_tpa_info *tpa_info;
> > +
> > +     agg_id =3D bnge_lookup_agg_idx(rxr, agg_id);
> > +     tpa_info =3D &rxr->rx_tpa[agg_id];
>
> If bnge_lookup_agg_idx() returns a garbage value due to out-of-bounds
> read, does this risk accessing invalid memory here as well?

Same fix applies here. Changing the macro to 0x3ff handles both cases.

Thanks,
Bhargava Marreddy

>
> > +
> > +     tpa_info->agg_arr[tpa_info->agg_count++] =3D *rx_agg;
> > +}

--000000000000ac3e4006491203c4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVdAYJKoZIhvcNAQcCoIIVZTCCFWECAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLhMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBSXVmTiTzhYilthLEW6HLsXZWcqu4nAJjU1t2WIoYZBDAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjMxODA2MjBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAGgpiW
TLP/4A6+CyUN91Rnh6HfbM3CMGhfQ0R8Bgd4FbM8YO/hJOqqimmHY8uF+PQU+s7TJdbwmlZN0U+F
tVZ0lr/+0jqS1Mov4l0GL5WLB4KdHumRWLVYPbeNbMMKwkPFgPyDtXzCvg3e4ikC0b49ulXCA5s6
CgdUZM+tOuYJiG5Bj+p0qfnIHRg9e+dMUrf/7sM/UYIoLVTNJldqVG+Vc3oQG/Eel9nOHq/1CBvw
AXhjDPsspLizwzxTjU6EZSer336lqCPHfQf5jAJTUpxjBEIlv4+R7LUvM5sb1dhGw4+CdRDpTcSg
9OpS7LzIXtl4DgGhuMIMOApY4ZJGGF50
--000000000000ac3e4006491203c4--

