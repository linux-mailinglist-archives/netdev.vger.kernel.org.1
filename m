Return-Path: <netdev+bounces-301552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F2uHA4CCO2oLZAgAu9opvQ
	(envelope-from <netdev+bounces-301552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674656BC06F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:08:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OdvSEkBL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301552-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301552-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D743028803
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C238B14D;
	Wed, 24 Jun 2026 07:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F438AC90
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:07:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284866; cv=pass; b=gvKi5IdcvMkHjJQbN89W12Vtgdp/ExCw8/N3ki5YIQsi8o+t3i5Q1kYDWnIlFz5dlBfu/c6/D/YF4qE6Pz6Z6pgXYDJ8JhoVdIC6A5d+An/w/c+I+YcRBWYuOaxQwYW+MJhpSINrye4A4C4RPBMgPlMv39ag/6ef5K6Qy0YsRBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284866; c=relaxed/simple;
	bh=YNs2tdpdfcTpVw0ardkfzLkJzT3qdlvRYfMpTzcbAlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvorC2l6jasPRH+iG9OoGdHAPLwfvRNAjBFdSR0QGtQjx6IiKT9hhJ2LlBIEQQ4/C86uGZrw73HeCt55gqX8cACdB/BceCLIBkdzTrnfjjjc96f5+JgvaVdGhz+iFYzGMkyy/nqHS7UAEkmswnBODZyqkyUrI+q29gxZeZrSwcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdvSEkBL; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697763eeafcso980308a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284863; cv=none;
        d=google.com; s=arc-20240605;
        b=Ism1Ger7nxy74o3xSkbyj9b8goMO5OuP526MqgzEkvo4CeR8QsPaumrxF809qjwVVc
         n3zZBGJ0Cc2Ngq+cUTypRL3b9FKDr+SxqsoPEBulXoQ6eSb1n4X3Sl6F9IszNt9kLL+E
         RowXuirYf8tOMd6M4kMCTiVSXOMNANw6E+9bE8omRw+w8J3xy6guXhSUzt+9sBvKdMVI
         TO56yBVAboo9PXUojsx4/y1M37k/XYVTAy1FrfDLLzEcPAyuOMtRDE9yRlcQSMw5otiX
         nUT/Y7qKHa7rJalXnMnXm7UBczfezSuZwOEsNKRRypMIZ3gMcqz+VCnaBkvNk2nEmAB8
         p3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wvocXq4V+rWU46KpbTHzpxhaL58gr5k8MWByKgZXYHI=;
        fh=6qDia7M3Y9efthqYLtH20j3MHsZgxmpXw9tiNaG+kMU=;
        b=MBwlT+/7NKXMea5geLsj6OzDPsR9oP+p+UZWgqp9OMMtB5VAy3bFB10sjXPiKknAcL
         Txfd//P9Eyz+SkuA+4k+sEkxVQIR8p3uXkYzcRvkpI4g2JhkgXa9z2kdHSlGK6HA9LNW
         6uKCmqQtDcJLkDZ97SCERxG9M3J8df2bZ5RKkJhe8z6MX9cf6RotN2Zy7RJq9aapCb/A
         CjkQCtdoZOdFA/rUhrCVR+aC0CJXWCZA5jU5Jd0TgEMu26OxJfw06k89V7QElY+eZ/kN
         qKgpGY7Fbh+DjJ7OoayQ8fI15fSbb2N1UFTznk3i59yg9ZpukCduSqLDJnH7pny6HXXI
         mRtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284863; x=1782889663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvocXq4V+rWU46KpbTHzpxhaL58gr5k8MWByKgZXYHI=;
        b=OdvSEkBLb0D9WF5dCTQfJUsuPsW5BTCgjQj48KyBnUcf+B5qs1YYbmRBxeLSaZZNNz
         +uzTaJjXOuLWHBdQfHVyN7tsfv+MpsUaQicOZRHvjBIwIQ2FzT4F+lo4lBvPUXsLSw8X
         aA1jP9xYkAAcPFK+s5B6FvQWO9vducJjx2eofWdFT0LfYzT+1/lwd/h++ZXg+EPNq/OH
         B2AUJquVfAgqpcQf1+lRrA9Yn0wuI3EHE3XAu/Io3dh2A4VG+PJg/22UcLw/RvK+VGsR
         JZUiFR28fRTZk+6/4mJ+2OKhRfmAjRGDAmstnbV99M0tIH4rE7naWd3MSG2FNyNu1jwR
         RWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284863; x=1782889663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvocXq4V+rWU46KpbTHzpxhaL58gr5k8MWByKgZXYHI=;
        b=LqHb+YajhNpAN+7WVb+gLOCRrsQ46yVsk03YtgEqI/FzlbcL8CXH10+zjCz7S4fSwJ
         Cv3DvDS6xlcGKR9Lb3q6CWgkBWZg4rxAzG4w3UgpWYtoK8YCoaWyyNvhqPQ/qcagEN7q
         vE0kPLYrW1bG43BUBk0EMFYJzk6aRL6STt4TdwgXAGVq7gDcZlRs5BRP2l9xVfqF8t+4
         TqC5NvhChQqdq6qADRj/BwEU+10VrJSplXoglGXA8lZccJA+rj10qIWHr0pi8A06EvnK
         CuZSl610P904bu8STv8zDGppqve2zvH5+U+F+MvXxZEAdOakEx3oi86O5njC5dQTXy/o
         +Q3A==
X-Forwarded-Encrypted: i=1; AFNElJ+CLq5IGoXfMiwiGlIJGT9OdiLGM7e7FEekbyaMHH4zFtlTtMfK0pudNw7lQcarKA48sTB32Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPmGJb2c5taWTj7lBhQQmr1ZMxKtuuC4a3u628qrYOc2Mlyjw
	2HZr+ATjlZDi0VvmSItaPCHNbDkK8WLCRlQkGQoy6wuJ2woIm2Ur7Ll6NoQi9qlGbO84UR5Q8Ag
	A/cHHrjM+ZzwcSB8ZHxpbBvnPioRNzg==
X-Gm-Gg: AfdE7ckLUncGyDFcFgdxmY7rDjjaGlZeufBJBoHW0nsoMaK480IFBd87NlcAAFuimEF
	2Dabin73bSexCVfc1egayFJOKNWOw6PZ+WcwgJ1U3WzLiJnR7W2tUPuVRQOQoZIf9a6oq6F0PYo
	DKvqZOabIfoXMecn+MH8Ky8+YOAERWBOmAcjrK+PvEU6dDrSX3Uj8yikueZd/JdCMT3MFHL423Q
	TiRq4XF1Hj7j/ZWz3evVCXoQhG6wDhcg0VzkJgoJLLZgxfxfLf5jrwKaCV2anHXdXxF+So+m9dk
	Vk5St+nBASExXwtBUmgAqywT
X-Received: by 2002:a17:906:7956:b0:bf1:1d19:cf98 with SMTP id
 a640c23a62f3a-c119d65d6d7mr85002966b.15.1782284863083; Wed, 24 Jun 2026
 00:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623075405.47120-1-mhun512@gmail.com> <16ca6db2-6cf1-4f49-a77a-62bde8341b50@lunn.ch>
In-Reply-To: <16ca6db2-6cf1-4f49-a77a-62bde8341b50@lunn.ch>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 24 Jun 2026 16:07:30 +0900
X-Gm-Features: AVVi8Cdhcf7-FBya7jmdaLBK0VO56InuhLAg8wkhJWz8_-_7NWQl4zcAh5PfaRM
Message-ID: <CAGEsz8GP0A9VRxpuPgNO3QrByOsSedxC0zHZO5_iovHpj2TBzA@mail.gmail.com>
Subject: Re: [PATCH] atm: fore200e: disable PCI device on DMA mask failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301552-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:3chas3@gmail.com,m:netdev@vger.kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 674656BC06F

Hi Andrew,

Sorry for the noise.

This was against my local torvalds/linux v7.0 tree (028ef9c96e96), not the
current netdev/net-next tree. I missed 6deb53595092 ("net: remove unused AT=
M
protocols and legacy ATM device drivers"), which removes fore200e, so this
patch is obsolete.

Please drop/ignore it. I will subscribe to netdev and check the current
networking trees before sending future networking patches.

Thanks,
Myeonghun


2026=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:56, A=
ndrew Lunn <andrew@lunn.ch>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jun 23, 2026 at 04:53:56PM +0900, Myeonghun Pak wrote:
> > fore200e_pca_detect() enables the PCI device before setting the DMA
> > mask. If dma_set_mask_and_coherent() fails, the current error path
> > returns without disabling the device.
> >
> > Reuse the existing out_disable unwind label for this failure path so
> > pci_disable_device() is called after a successful pci_enable_device().
>
> What tree is this against?
>
> ommit 6deb53595092b1426885f6503d93eedc1e3ece77
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Mon Apr 20 13:42:28 2026 -0700
>
>     net: remove unused ATM protocols and legacy ATM device drivers
>
>     Remove the ATM protocol modules and PCI/SBUS ATM device drivers
>     that are no longer in active use.
>
>     The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
>     drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
>     over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
>     The Solos ADSL2+ PCI driver is also retained.
>
>     Removed ATM protocol modules:
>      - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>      - net/atm/lec.c - LAN Emulation Client (LANE)
>      - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over AT=
M
>
>     Removed PCI/SBUS ATM device drivers (drivers/atm/):
>      - adummy, atmtcp - software/testing ATM devices
>      - eni - Efficient Networks ENI155P (OC-3, ~1995)
>      - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>
>
> Please subscribe to the netdev Mailing list, so you know what is going
> on.
>
>
>     Andrew
>
> ---
> pw-bot: reject
>

