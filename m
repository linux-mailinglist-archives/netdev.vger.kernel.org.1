Return-Path: <netdev+bounces-278207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEHRAS9m3WmydgkAu9opvQ
	(envelope-from <netdev+bounces-278207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:54:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 153643F3A4C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A76F0301151A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43627397E6D;
	Mon, 13 Apr 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q54UUGLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88135397689
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117286; cv=pass; b=RJBBBipWyN4LLxtPg6u9VjsZyU+cvYkVDXo7QZW0PP7Z3ttEtEO9L3BD7Ak3jem/EpZt7b679pUDsPxLHMfR7Rbiq4IdHievQ7eqju05eo63C1AhYuMfzVuibBGu2f1JAbeDEVWViOlL6IqA4XH5YlOVTLOi7Cny+mjSaQqf0CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117286; c=relaxed/simple;
	bh=BBy297Whh7frDe+RlHo7+E1IU2pu1kzk6QEWOII5ObI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d89LxH6m+BiK3+Z3KheY6eqV3Puhj6WIas7HBS+c0smkKFaADzh4Fuypvan1wnLwG5ewWXw90/CQMaC9jombDC/CEeDAMr29oQUFipklaS2fHJLACc7TrJCb65P18XuFjAOPbAJoe0HsdlU3V/AVadAF3dwln7KjtJD1NufwzCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q54UUGLI; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfbd17589so3381523f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776117283; cv=none;
        d=google.com; s=arc-20240605;
        b=ENtAYq3JZ7idOw69GpjHVNx5vdaj5Aqp9egIw1PLxZBL5BCFRBYNpldQZXPX/InO27
         Wl6yczHw6aipssn2nPv29m8JiQVAIsZVIfZqWS661u3wPIjq7PgiLEO7V55YGE4JS8wZ
         jVqq6iVLcK3Cg2PQucciNhTSFccrpPt0YnQPXob8BftN3UC3n2Jsqqv/NLuxgdCJTEvB
         kqj2RH37gcO84X0EMze9heE00FjK+PO+XQE0vz3qbxYkR2NkufxEnuZgiRJmQMOPWUlX
         l9Bva7dHHV0jid/SR9RT4yGC8lYWpEBZQKKBq7NhONAEAJSh9u/RVtLcijnTyxHEUCZ/
         MnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OIvSVDNyRXVMKIryJy1tu7/f3jU7uICWZPfOZkml13I=;
        fh=NsQKL9BuS4iaNQbjGvV99ZiZAF9agMwbtUz3CZuaojE=;
        b=dOrvM2Reutk12LoTtjzH9+4P90SZH7vsVVz4i/zPD0vQgD3Ct67IZygHKooDjGyAsX
         f5QMpx4gBISlRFfcuRBjoLFydFwM4WFt24JNFyCzLLou2snrfxsdFUph5w0ZqqCcAper
         bAJRZX78HyIynm/VqLzvqhya79TjOT3lrKwL/Ic9lmMnXAdrL8cepjMq8Xv0WjneU1I9
         DpPOmx+Qeqz4w7AOz4M+789EIXzBqF9KbOctsBshtxC/h7nUwbRSGXq4LpbXbRWZjyCF
         hXRQ6BJw6f1h524ODQEyTQ2EOrqXG2WQPwXgG07p4Ryy5YIWtaeNAo7hFalq5zrLTCeM
         CkoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776117283; x=1776722083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OIvSVDNyRXVMKIryJy1tu7/f3jU7uICWZPfOZkml13I=;
        b=q54UUGLINpRgxDR5VFMug0N9KZoCUyV1Ic0l3lJ0hu4ymvyxDxzVAKQwDPLg2Sf4iD
         WJBNZAFZ+zrz/e8QFogMMcff1vYzzs3MGd9YCEwWDNQC2m08lREmjwNLTSuLfpmoW+8W
         /lfksaUpi339vC4eAfW37PRvdEm+fSGVKlWPLlAdUBSeqvct7Ve7ZjdKNy3DYJ+30dg6
         uG4exQANDtc65kRgKE/Yo6BCsSPUU2bDcECbMOeyAmDRExZMxxO9JFLM6d7eOmoJEy78
         b7bG8kyekl+36pw+Zanaw4iEUGte0IuT7VhhmlX/ryEk8VuU59DfteUZpwLbarH5oY8T
         Wbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117283; x=1776722083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIvSVDNyRXVMKIryJy1tu7/f3jU7uICWZPfOZkml13I=;
        b=pO3oRxWalcZU/+Rv6VX5aFOwwyAs1zTYjrVIw+9K2u6fP+Z4trAuO2oMppB9soLjFM
         j19T50YNNbtDBBNfA6eOtKHPmz/Kt5AWGt6tF2srJZvSqChyRiCJwBEpodAMMMWxcWOO
         4MVyMjYDlNw/uVxgkEbrTlZJg3dj1xhj6tZgkEPjnKFsyMJYcudsHeQ2IghPi5IfCVZM
         EdmXwASWez/IFuDFwND2NyBJieA7v1+ujoFXuez/p8AM6D2IdiANQq8MrvnWaGQnAtp6
         FYwLIlrjI4h/6ZxZewiv1nAmbpq7shCXBr4xkY8yIw0kN+vMmNGMaJBQGXPtdA7HEud6
         Vpfg==
X-Forwarded-Encrypted: i=1; AFNElJ/1LlqHiahDmLmR4wL9gFhhmYXMU9/LjGDJyFCqY5mQLS2EdDtZxZG/tvqOwAfSXo7lqolSeGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdAlduZ25H2WxwYe4Ei7otFTT5STCFnN5OQpu/Ox4dnMLfsYv
	7ABGeAp01I0vQdwt1+Us5/8KmP7FBnnPafnfuvvNDgFs8exzMf00kxpEWpUeIe9OtmRn++bSFjb
	voDpAJGB4p8meImmfJ8T2zfncnA+wLR4=
X-Gm-Gg: AeBDiev4EwwMV/YEz741mTw0vhDoFpyjrQlYEsgnBVq+UQR5TKuR441qzuJnb4o2BI7
	CJ8XVa9/VKy8KLILM/7944MCYQ4DzmtblMLHW96Zw2z6JyBFGRTMGmzMFjXfYErerwqE4LH6M15
	5CQYOhMGdZY4RKsBbcq8W2UeKT8IqIN7SLs1q0yNsQR5UE+dnhO1T6b9tu/2Mep3qhvgdcEB6lU
	twmINBVPl4sZcA2ysLgei74H+OLZSjZqu+9/aIlN5uBYe71Fq4tt8tztbN7ne0tAJPzvZRtmOo4
	w7Dn+3qg99rGfmzIASbZfxEXwwt7x+ISERKSRrwHwE+J/ETLzuM=
X-Received: by 2002:a5d:5d83:0:b0:43d:5ec9:246 with SMTP id
 ffacd0b85a97d-43d64250a83mr20728904f8f.12.1776117282589; Mon, 13 Apr 2026
 14:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org> <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
In-Reply-To: <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 13 Apr 2026 14:54:30 -0700
X-Gm-Features: AQROBzDMFq1J1BHeTMkIhkt-_OIJqPvCL5sV9otRjtVQgF6B-9x3ogZe80tOPWg
Message-ID: <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278207-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 153643F3A4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026, 11:49 Russell King (Oracle) <linux@armlinux.org.uk> wrote:
>
> On Mon, Apr 13, 2026 at 11:02:22AM -0700, Jakub Kicinski wrote:
> > On Fri, 10 Apr 2026 14:07:51 +0100 Russell King (Oracle) wrote:
> > > Since we are seeing receive buffer exhaustion on several platforms,
> > > let's enable the interrupts so the statistics we publish via ethtool -S
> > > actually work to aid diagnosis. I've been in two minds about whether
> > > to send this patch, but given the problems with stmmac at the moment,
> > > I think it should be merged.
> >
> > Sorry for a under-research response but wasn't there are person trying
> > to fix the OOM starvation issue? Who was supposed to add a timer?
> > Is your problem also OOM related or do you suspect something else?
>
> It is not OOM related. I have this patch applied:
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 131ea887bedc..614d0e10e3e6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5095,14 +5095,18 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>
>                 if (!buf->page) {
>                         buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
> -                       if (!buf->page)
> +                       if (!buf->page) {
> +                               netdev_err(priv->dev, "q%u: no buffer 1\n", queue);
>                                 break;
> +                       }
>                 }
>
>                 if (priv->sph_active && !buf->sec_page) {
>                         buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
> -                       if (!buf->sec_page)
> +                       if (!buf->sec_page) {
> +                               netdev_err(priv->dev, "q%u: no buffer 2\n", queue);
>                                 break;
> +                       }
>
>                         buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
>                 }
>
> and it is silent, so we are not suffering starvation of buffers.
>
> However, the hardware hangs during iperf3, and because it triggers the
> MAC to stream PAUSE frames, and my network uses Netgear GS108 and GS116
> unmanaged switches that always use flow-control between them (there's no
> way not to) it takes down the entire network - as we've discussed
> before. So, this problem is pretty fatal to the *entire* network.
>
> With this patch, the existing statistical counters for this condition
> are incremented, and thus users can use ethtool -S to see what happened
> and report whether they are seeing the same issue.
>
> Without this patch applied, there are no diagnostics from stmmac that
> report what the state is. ethtool -d doesn't list the appropriate
> registers (as I suspect part of the problem is the number of queues
> is somewhat dynamic - userspace can change that configuration through
> ethtool).
>
> Thus, one has to resort to using devmem2 to find out what's happened.
> That's not user friendly.
>
> For me, devmem2 shows:
>
> Channel 0 status register:
> Value at address 0x02491160: 0x00000484
> bit 10: ETI early transmit interrupt - set
> bit 9 : RWT receive watchdog - clear
> bit 8 : RPS receieve process stopped - clear
> bit 7 : RBU receive buffer unavailable - set
> bit 6 : RI  receive interrupt - clear
> bit 2 : TBU transmit buffer unavailable - set
> bit 1 : TPS transmit process stopped - clear
> bit 0 : TI  transmit interrupt - clear
>
> Debug status register:
> Value at address 0x0249100c: 0x00006300
> TPS[3:0] = 6 = Suspended, Tx descriptor unavailable or Tx buffer
>                 underflow
> RPS[3:0] = 3 = Running, waiting for Rx packet
>
> Metal Queue 0 debug register:
> Value at address 0x02490d38: 0x002e0020
> PRXQ[13:0] = 0x2e = 46 packets in receive queue
> RXQSTS[1:0] = 2 = Rx queue fill-level above flow-control activate
>                 threshold
> RRCSTS[1:0] = 0 = Rx Queue Read Controller State = Idle
>
> > Firing interrupts when Rx fill ring runs dry (which IIUC this patches
> > dies?) is not a good idea.
>
> Well, I'm thinking that at least on some platforms, such as the Jetson
> Xavier NX, unless a different solution can be found, we need the RBU
> interrupt to fire off a reset of the stmmac IP when this happens to
> reduce the PAUSE frame flood on the network.

Hi Russell,

Should that reset trigger be RPS, not RBU? My understanding of these
status bits is RBU is just "RxDMA has failed to take a frame from the
RxFIFO" while RPS is "the RxFIFO is full." That would make RBU our
critical threshold to start proactively refilling, and RPS the "too
late, we lose" threshold.

Thinking aloud: Do you suppose the RxDMA waits for a wakeup signal
sent whenever a frame is added to RxFIFO? That might explain why the
former never recovers once the latter is full: a manual wakeup needs
to be sent whenever we resolve RBU. Does the .enable_dma_reception()
op need to be implemented for dwmac5, or have you tried that already?

>
> If we can't do that, then I think stmmac on these platforms needs to be
> marked with CONFIG_BROKEN because right now there doesn't seem to be any
> other viable solution.
>
> My intention with this patch is merely to start collecting the already
> existing statistics so other users can start seeing whether they are
> hitting the same or similar problem. If we're not prepared to do that,
> then we should delete the useless statistics from ethtool -S, but I
> suspect they're now part of the UAPI, even though without this patch
> they will remain stedfastly stuck at zero.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

