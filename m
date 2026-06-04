Return-Path: <netdev+bounces-295256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9vlHkiCIWq+HgEAu9opvQ
	(envelope-from <netdev+bounces-295256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:48:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0F640820
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:48:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bAKq8rah;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295256-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B863230D42C3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6E47DFB0;
	Thu,  4 Jun 2026 13:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCED47DF80
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:46:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580780; cv=pass; b=HKZ3NKKyZ7Q4PZwwU0gcDLRoFsxzmk7OphRFwyDs+eYSunl8jzVAPGHtoHoav5QpG4ixOoK7pi/ez1vJudt5X+WeYKWaTW5cPzmuFQwH878kQcDycFF+opZsSKzQ+EWMDjLgBabrsjMUMyJAhK1B0SV3H9JQzzlaVUoYFz8HF/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580780; c=relaxed/simple;
	bh=iYme8jFzl2i6imnwPVJ/AP2qxrjAVPMc+7VBvNKbQsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7i6TBDL/iuZoa+J8tN1r6MMXRiPpEIlT5/pZVSGeuRp06PE8k1VxZb5uieY0ppM11rP9FJRX8lhGfQYMs5xQblfgDMHqu6gTUoO5CH932wJpEu7QUvSNVtG8zgW2O4tJcP1BQ+geD2UeyUM/H9EL/ZMH/7KmqBJUg4uBPkGICo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAKq8rah; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e86d46b02dso7611747b3.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780580777; cv=none;
        d=google.com; s=arc-20240605;
        b=llcLIAA2ZE5Hjp+kU+gSmSZFnYtayoUZyKILNRQqMZLhAHsXKv9fwr8sGlMVH32sCE
         8YgWwwJbqymfrUYHbbxzY5rlOCqGxmWbc0zbS4V0hgjOn7Xn/jMxwZbLaKtUl1yX1Q6d
         UYDub10mIV8OW0zqTKh3j/TpvyvTCyfLHIurqbYltSkpVeV6avcipWg+zsqmv/uXVjaw
         CAf+plo6fwe21Re4LhMPsi+5jWeG1JY3E+M+uezIGiFm3fy/sFcIyhZqNIZHeqMOzRgM
         zYaRir26ZFdrJxQbtrtMZevRAa+QLXXDwtsaPq7QnSOqsJa9dpERzWF9FEfJLfmZxQSB
         7Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKmbEqQuIE7hhwfnG8ZqOT6v5fXQBR07PpEbjFiDPbQ=;
        fh=tg4ty6T1XJ4JG5Rim9wLTpEF9mJVSsLGOc5e5BNWzs8=;
        b=Zv4SSuaV93tjFy5wiJczZXCo6LxkoVNLoYYVzXvwqRidfLvyHBs/N5bElw6WvGkHyf
         vV+iih6fsC3Xssp3UOyyvlyH979A/N27rpjEgyOKg3JyioB7GeTiMipL/9e0obftD7uW
         QaciAmVt/VzHp0TDHnFUrP/H2mCdHobLnhJ7RcZck6LhQHqyOR98BXu8lD27ntpSDxyv
         x2eW7zv04vI8OkVjvq3CT/FXd5iZEmERRTkEH8psrZ1URKTIzO9dOqLZ0sx7u9R/NZuS
         kFQQrbdEkZU/DxPyQvoHs5Gn/GCsa+a1dxaKbHpAxExoFwHCrvM070t7ua8TYJ2BTZHQ
         n71Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580777; x=1781185577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKmbEqQuIE7hhwfnG8ZqOT6v5fXQBR07PpEbjFiDPbQ=;
        b=bAKq8rahv0NGGP7euMuF0bI/PNS+umztxgcIhptNOcAhHT2peOB60hZ7AX1WTTqrrS
         RA1z+QCcSRcJVj30oWPDW+Sem4i2Voy9eEIPUsVzIJncVOPE+QbcDZZXgevM1tD+omWL
         iwdd3JpddHlW31nYSbmGHMH/3aNpKGYKmb6KbjINWmTqIi7B4Gz/OB1PKiHfdIkErf+T
         XmEW2cgGNCiIeZ7R3G0KYAWhzNca9E5rQW6KkN7h1ZEEn48KFUz9DQdBXcrPSxiPsBic
         xagh0P1H93NSwN6YUgZmgc9KecluL4xxU0qcqCi2TNW1rfPRIXO0CpZ2cYkJOt1ufVeU
         8lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580777; x=1781185577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKmbEqQuIE7hhwfnG8ZqOT6v5fXQBR07PpEbjFiDPbQ=;
        b=cO7bCqxY19FuAuw/otWcrUBglI7e3ZmKgVCR3ea962UMRQs76v0TBKvZSZQmlYcdZG
         pE+55kHUZADWU5d3d4BeovqmCyP+K4Dso9f5xCTNQFFwJ5HV8mUuSO+nh4ObBzFltha8
         mYosjocXgHjCgadinDUlJU/oGBbhBon2DJNKs7zKfqTMAneg5FE9Vs8QG9cq9Hp5LeuK
         pQJz5dkcjrDCa0WidxWCyY+2YJ2GBwZzD+e2kq3YyDg8LIP3XvElYgqjLmRNubPcymp0
         iVqUG6o+mDw8gmJKQoeksMh/Z7VX/ElGyjWjEAA3ZAklLZDdXw72bMhYwaDkJE69UFcn
         1YiA==
X-Forwarded-Encrypted: i=1; AFNElJ85oXt1spm/CH6ndA5QE0bS0Ui2lWr5x7TcFd1xcuW6EW2mKrUTzb5WVnY9jSQCR8kOGBgcSDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySF+j5MagcOQZEzhDoIMivhBgXV4JK1z0iHu7rXDQ/wKrKjND
	mWq+TtwNCCzWYL2vuZ+vcs9mu+V7Mg5wSkJ7VoUay9ikz/CkBoXAAR1bSqr7RHLtjrIF95axmvZ
	6vqXXOWdpPd0zYxAo4a2aB8PH0dUv86M=
X-Gm-Gg: Acq92OEmUA88cIEB+NV+P5zXZA87Kr77NL3ZRu4o36w7VqYnkKfMxSJjc7e9EK3hj2H
	hnDv0Zriok1al9Mqh5qVwBZxZJebL9nuXYTzKm2LsX2SeObeaMbDyVwFLkuzn96Cnz/YZKejn2R
	b+VQdfcAsqqNmT2ArBXI+aFb9NLBbJzxUG81w52epxnIR/NjCeKFQ9G9nLhaUMG1nJJMl1PzfUZ
	RpY03bVwRgiS0pptv5VdKhWlc78EFDEXM10fHKilnpMxYkqzaBTTuD6mcIQ+HwFSrq8b6lZlKv0
	5luWsOMZbm6mFb30b16a5WBuTQ/a40rPjc6MfDWCNVEvyJBs
X-Received: by 2002:a05:690c:6b8a:b0:7ba:eefe:9fb3 with SMTP id
 00721157ae682-7ea47312561mr70100457b3.2.1780580777600; Thu, 04 Jun 2026
 06:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604112846.1420908-1-lgs201920130244@gmail.com>
In-Reply-To: <20260604112846.1420908-1-lgs201920130244@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 4 Jun 2026 14:46:06 +0100
X-Gm-Features: AVHnY4I9Tv-80eeJdvyCpRZWqPhjjoeWHuRXarM4mq3EjV_ABbs5fEo5cIh_JVQ
Message-ID: <CA+XhMqyzy9B_UFeSC80XG-1ZMh4ckhZiXHT9anNsVutmZdmk0Q@mail.gmail.com>
Subject: Re: [PATCH] net: lan966x: restore XDP RXQ page pool on reload failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-295256-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52D0F640820

On Thu, 4 Jun 2026 at 12:31, Guangshuo Li <lgs201920130244@gmail.com> wrote=
:
>
> lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page pool
> with each port's XDP RXQ. During an FDMA reload, this registration is
> performed before fdma_alloc_coherent() is called.
>
> If fdma_alloc_coherent() fails, lan966x_fdma_rx_alloc() destroys the new
> page pool and returns an error. The reload rollback path restores
> rx->page_pool and rx->fdma to their old values, but it does not restore
> the per-port XDP RXQ mem model registration. As a result, the XDP RXQ
> state can remain associated with the page pool from the failed allocation
> attempt while the RX state has been rolled back to the old page pool.
>
> Restore the old page pool registration for each port's XDP RXQ in the
> reload rollback path before RX is started again, so the XDP RXQ state
> matches the restored RX state.
>
> Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966=
x_fdma_reload()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  .../net/ethernet/microchip/lan966x/lan966x_fdma.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc0..76654b44baf2 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan96=
6x, int new_mtu)
>  restore:
>         lan966x->rx.page_pool =3D page_pool;
>         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> +       /*
> +        * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
> +        * each port's XDP RXQ before the allocation failed. The new pool=
 is
> +        * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool'=
s
> +        * registration before restarting RX.
> +        */
> +       for (int i =3D 0; i < lan966x->num_phys_ports; i++) {
> +               if (!lan966x->ports[i])
> +                       continue;
> +
> +               xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq)=
;
> +               xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> +                                          MEM_TYPE_PAGE_POOL, page_pool)=
;
> +       }
> +
>         lan966x_fdma_rx_start(&lan966x->rx);
>
>         lan966x_fdma_wakeup_netdev(lan966x);
> --
> 2.43.0
>

Hi Guangshuo,

Just one remark. The re-registration fix looks right, but the same
restore path has a related gap.

  Just above the failing alloc we set:

  lan966x->rx.page_order =3D round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
  lan966x->rx.max_mtu =3D new_mtu;

  These aren't rolled back in restore:, so after a failed reload
page_order/max_mtu are new while pages/fdma/page_pool are old.
lan966x_xdp_run() then calls
  xdp_init_buff() with PAGE_SIZE << page_order, advertising a
too-large frame_sz =E2=80=94 for a jumbo MTU that bumps page_order,
bpf_xdp_adjust_tail() could grow past the real
  page.

  Could you save and restore the old page_order/max_mtu too, so the
restored RX state is fully consistent?

Cheers.

