Return-Path: <netdev+bounces-263387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FLuJlE6p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:45:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BB1F64B8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D74A3029250
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D5384241;
	Tue,  3 Mar 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07bSCbLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AC3976B7
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567101; cv=pass; b=s/XbibryMB0dhHifMrzCY7mH6yzKqkDdI4to2WCFADfskkvZLXSYHruL+BrfThuDBLPphvDn9co8cMbxUdOeDYygC0toFGGl9YzyGHRsiD/izl3QRSWa6Etxl6vvfy6fHPERae1XH/VIQTGnwn8f9WW105JeYTGc1axadyEn9q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567101; c=relaxed/simple;
	bh=cpmt+z6lzTjlqfHVlhbcfPCq5b/O0ed+VIH2Y+9rFNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxMk62FNdnIAtaW/iOJJBjf2gyBfWueODfQivweMklmIn2h89/1CpnzmYPlpUILdt6K2BMNz8dPQVmzLejf9OSM0Wkir2Slu/2hc3zIiYh1rOWpBHlB9o9OBTP56+IKhongfMIkoFzgnjC7bZNP4w1w9clNpDcXNpEvPaPElIqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07bSCbLk; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1275750cfc7so893349c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567098; cv=none;
        d=google.com; s=arc-20240605;
        b=MmJ33g9pOUp+ZkkXGZoJy+mcWxAhQFjQzksGdcMLRrLEvnvg/0a/VBHUFtElqhtrbh
         nG+9etjNognHbf1nHIaLCrPujz9QfckrNOoAxel+BxERTpBb28BWf6CKFl8kPI42cuPv
         Gc3xIvU7IpzgkiLNNYSkCqguYrVC+iWdSW0iylGgnFI6+fTzS94Gn8JjdQu8Kuyu1Xbx
         y1/OiulxNmYBxe+NjLYIRPTFl9CRRy5xaAvDHO9UpVpb49EMueAgV633JsE7/gBPvke3
         ROqQ7Caz5OClqFuSWevHHu6c7jYwZK6A0RNz66Wx0grq98FWWeU5mxWZv8N3qqz+4495
         ORFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4o6LTJ8NutkryaJMGJUUr00PI2f87nHxwk9b3ynu0+k=;
        fh=EGyeNjXSLpieMiAW82orPm49MfrRYRuSt5adwcDsbmY=;
        b=Sc2UWX4KsNm+gbLg6enE36ZMIOYdIeuET0wurEbhuFCbKzSSww0ELdYfs0y3RZ5R/g
         4E6uN+UK1QdiRdAktf0HIzqV5tXrUZE0x4olN9CmH/jOJlbCAPhd3GbPOvD981OMVF4d
         ybms5KjrfZHXmfq47mMONeTMdOyA0Ex7M8t1HJbWiz9DZ1VGwrumKy2kvN6vHnPfIIEr
         ywSiXJFLRyOxthCO7lyWVAVaajQdrgbSolmL0oKNVM4o7+aM9Xg3aqej+xIlM5d+65ip
         spnpBWWhwLR85+eyrNeX9dYRisyVYb8fSPGnyp54CnseazHcuNjSGx6MJWKp9p1Ffuct
         diWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567098; x=1773171898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o6LTJ8NutkryaJMGJUUr00PI2f87nHxwk9b3ynu0+k=;
        b=07bSCbLkzYt1uRMoiItGdHx8/NaKp7Z7JuC8FzOxiTRzt0YZ2GNa8VzLMgCPp75z+v
         gzbUVfme5g8r0/GgkpUVqv/73bV5VgXEOOCqwYJf3WBxNxenS2g096ivorybU55QwgnY
         tema1yTaM7f9lul1TAfGwYDCi/RcCrggr7JwD51uJeQcfP+6MqCQB6C6MnndRpbz53A0
         d/F+izbslgu8L5tiZHXwCOdcjmlu1Fw+xPiQXwqPrw8YEt6JdmOiT2HaBzRH3EBmo7+T
         8ivi+ifCh87K+b5wH0vJzQOZkmlxroE1wCzFZqmhsYXsm0+K5CTm22klPGm7a1w7j1Ve
         /6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567098; x=1773171898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4o6LTJ8NutkryaJMGJUUr00PI2f87nHxwk9b3ynu0+k=;
        b=aUwjQj3NP0JbGCRy3TVhijTh/AJhMS18scSfRPeberZVtghfLjHhKfGZHdYWICWjlT
         b0ic+lb/jVA+atl4ZiCveR3txWgIos7sanxvs/2n+kNNmN98aXuk+XyetOwUq53RmxWG
         +eBKJI9Dv05ar1CjL3QP3emR5ocacTmmsiJcKrZ80vC2WVhGQQPlQ6maDI7XU+tIkymS
         WMq0MaWmMbsprTF81jtreq+gn7wUescmL8m+759iIJzn8WQpDdGAzbsSJdTpQUda0m5o
         oYI4P1irZURW8ELZoixyhe3Y5NQGQTnGgHVJafKtNwoCEGyqoSGxhO/e5wMBOqhJ9fbX
         Ac3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy7DUOZiHlTXlgRVWLv5XDZ9OIjySJ2UR2hBHZ4Uduj2//uxrYTI99kS9mdfd2KqT7NkBXtY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Fm1JkYqPzvJHjaEVKgoXj0zvSC9wTnNEQUizo6p2C8IKyaGp
	4/9Is4fdLK74KzXCLaHl6YVPYxAZUp+HyHMrIqEuWgi2rRO618avGE4K7QNQu2nAV1ZgzZGtA+B
	Ug+tg2bnMyhfD7RPKJo8D5Fv7Uuf6vWEwioWUrdtZ
X-Gm-Gg: ATEYQzx4FQHQVsQCUei2eHeE8kD+oz/oTEp5eU9CBx7dKk7o4dUZ/kFDo2KyGLWhzXY
	jSgZTzwLnPak1YziUJKJ0Bloh3L+pzOJGrvLR7AcOlh45IWaLkSIvjV1a59Ddo44nHKDVtRVHD6
	oE4z/UWKbyegOH/PcONHaP+4sM9ZDB4L8d7W0j5ck5ft+d+J1ME9G4IwFmA8wDiXZWYjsRY+k/C
	D75qlgphGO5feqFh+XJ8lVBXnEWbcyCuGlsprUMrm5opk3Cpa3WB+vCFPJA3izcnKt0lKa/iD4W
	Btw+7YbVXPcet0ABw9FmxZSZ35LRp4yNOvRBUvjJhfsOnP9XHTMOpsPNSJI2+CVl4yu3Q0Y5Po4
	+404n
X-Received: by 2002:a05:7022:24a0:b0:11b:9386:7ecf with SMTP id
 a92af1059eb24-1278fd39e53mr7929988c88.44.1772567096881; Tue, 03 Mar 2026
 11:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com> <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
In-Reply-To: <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
From: Steve Rutherford <srutherford@google.com>
Date: Tue, 3 Mar 2026 11:44:19 -0800
X-Gm-Features: AaiRm521Th__xaTNnXE93XdLGaT-9yoWqssZueW9zKUGNuOJyvzZ_SxDnuaYaU4
Message-ID: <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB enabled
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F18BB1F64B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263387-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 7:34=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Steve Rutherford <srutherford@google.com>
> Date: Fri, 27 Feb 2026 20:34:57 +0000
>
> > When SWIOTLB and header split are enabled, IDPF sees empty packets in t=
he
> > rx queue.
> >
> > This is caused by libeth_rx_sync_for_cpu clobbering the synthesized hea=
der
> > in the workaround (i.e. overflow) path. After the header is synthesized=
 by
> > idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
> > effectively zeroing out the buffer.
> >
> > This skips the extra sync in the workaround path in most cases. The one
> > exception is that it calls sync to trigger a recycle the header buffer =
when
> > it fails to find a header in the payload.
> >
> > Fixes: 90912f9f4f2d1 ("idpf: convert header split mode to libeth + napi=
_build_skb()")
> > Signed-off-by: Steve Rutherford <srutherford@google.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.c
> > index 3ddf7b1e85ef..946203a6bd86 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -3007,9 +3007,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_q=
ueue *rxq, int budget)
> >                       u64_stats_update_begin(&rxq->stats_sync);
> >                       u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
> >                       u64_stats_update_end(&rxq->stats_sync);
> > -             }
> >
> > -             if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
> > +                     /* Recycle the hdr buffer if unused.*/
> > +                     if (!hdr_len)
> > +                             libeth_rx_sync_for_cpu(hdr, 0);
> > +             } else if (!libeth_rx_sync_for_cpu(hdr, hdr_len))
> > +                     hdr_len =3D 0;
> > +
> > +             if (hdr_len) {
>
> This is for a very old tree I believe? We now have
> libeth_xdp_process_buff() there for quite some time already.

It is, yeah. I thought I posted a cover letter with more of a description, =
but,
frankly, I may have messed up the process of posting.

From the cover letter -
Found an issue with the IDPF driver when SWIOTLB is enabled. The issue
results in empty headers for packets that hit the split queue workaround
path. It's caused by a spurious sync in that path. The header is synced
from the SWIOTLB even when the header was shoved into the payload.

I cooked up a sample patch, but I'm not an expert in this driver, so I have
no idea if it's the right solution. It did allow my QEMU VM to boot with a
superficially functional passed-through IDPF NIC and SWIOTLB=3Dforce.

The patch was written against COS's 6.12, so I assume that it will not
apply cleanly elsewhere, but I figured a wrong sample patch was better than
a long paragraph describing the same thing. My read of more recent kernels
is that this problem is still present, but could be mistaken.

Thanks,
Steve

