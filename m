Return-Path: <netdev+bounces-272338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJBzGR3wxWkkEgUAu9opvQ
	(envelope-from <netdev+bounces-272338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:49:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3D33E801
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FE631FF4AB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C25330676;
	Fri, 27 Mar 2026 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osoo/iwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC93002B3
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774578519; cv=pass; b=Q6LOhmablnG9Kb7KHStAKvMC871Es6v1qlFbR2yr9DapGhKwFdisqG6UbsEr5BtZ1OuAn0/SdYBE0jcCCR0YgD7KKUahwYe8m4sByDVQM93kv94Yk22dW1bjRD4xVgS3xlrHMk8Tsb4qIBAYcnXpcuGxza51ABJt+c1+xujeS8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774578519; c=relaxed/simple;
	bh=HdDqD4u/X6L1QK8GFdtslv9KZE3dAP7uRvJPuX1zDoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6wKNVQ6WfOp9gszuSER/s2gTVGr2S//sLSQ5nQ2leh1E1FdhGcVoUOuuq9ZNe5JB5vWInvkge1c80MKFRp/o/M2YEdtw4Yo4N3D/HuKb9OT/x09NiPHIgwKRSQ8MY1DbrRFD7CKP6K7em1UsXBRvY16A2D2YXK6SmqVEo3kkV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osoo/iwX; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66132b22182so2234793a12.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774578516; cv=none;
        d=google.com; s=arc-20240605;
        b=a+FcsBaNGAuZVEQF36+8Drqc5c745oKPsJ0fNeaekj9Nug6atLiGEh+UiLMmJKdNqB
         /AAidFCbggICPM6Om3fWpMAxSkil4UISwkaYCOwuqoCUvmthlaweVfbVgTJa9kuMcHZF
         de+oCB6xduMIe1qNwB8b2FTbngv8BgueR2QsIHnzTCitw0UY36F35LxU9hZr7i6AmHnH
         t/IV/SsEfxwoOU8S553LS/VRq8kjmwezKC/0F95KilKJG1jwco3qIH9Glt+o6O3C3vEm
         HopzRXT4QS+074O1xy6lrBxK0wzee3GlQKjZX9TICI9hi1OUK9g6siNYqKP24BDfNw3C
         bbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o/QYHaH5lUz5iP49ZKscBpC9M/ZhuP2QIdCxew6sXwY=;
        fh=Bib4zHjZ7uh7m9yHiKtwR313N216XW+ymU5hwk8xq/Q=;
        b=ZKevYKyRjkgLXfxrUWNA33dF1tnl4pSDsPP29EgDIdMMK/Gye16cbP/fnxAr6st1SK
         tryyI4VYJP9VYEPId4uF8KElIgkyLaqS7I8PuosI1m5ahXqTngp7xoCQUrIGMMbzrpWN
         FhXhfACbkz5O0gE0h59ZOPA1tx6tbobmJ3L5u87zmUZLzcDIZ3DHzUVZ7QZLV6jpse6z
         eV6eNekCyVDwZvLijE4xG1NOX2RAyCD2bEQchuk9PKMD6vHYR0dIDqWIAz+pvwo+yEjH
         yYeBLFq0uY4tegfxegklsrU7fShINwo2gzcAaXzdSlrf5j7E3qlB8OZia6vRIvpszVZY
         6dLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774578516; x=1775183316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/QYHaH5lUz5iP49ZKscBpC9M/ZhuP2QIdCxew6sXwY=;
        b=osoo/iwXVRYkFj6XpPsvL4mN0Vw11EYfasWQhfJyT9V40j72sF0l5TQ6nZ7EeGNXul
         /77JDWS3wJ4sbOquxpTOZSFuWHe6SW2Wkjg8ZcPWl7GklvJlycnxU4GCWELCqe5UHkBD
         6Ux56dQQj4SV+ekc2IVkWEd3RRE59kRJkEf3u17E9ot/W6o4DlBMrUuGQzdEJi6sZfbr
         F7exnCSSlxcln7eNc+NxF+0wgfV4DVZb1qMKaSuuAuYV2lSbQSTcLuaL5YFn+aS+g4tU
         MBTfeXySZz+wkRE3r487tC+KB/G73I7vmPnmyqMdS86rsSfAYE6Xy2CjhnGjyo2lF67t
         NVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774578516; x=1775183316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/QYHaH5lUz5iP49ZKscBpC9M/ZhuP2QIdCxew6sXwY=;
        b=KYsf9cIKqgjioZ44EyqBrzS9hTXHltimqlW28fl5L3I6uNh0SIpXCCpmTFmuePH2RZ
         vc5h502ZhT1XYX9AVxtJf+E6ll9cwfVGmaETGrqV7fpBiZJX2SlN9VDtyA45QwbQByQX
         zRA1f6vX18wDoC9Oy16eI+dMm7wx0iSk1Yi0gTZQ/gvb+UYBxnMxsIKr7lL4hfvzO4HM
         S79FdNGtGp7v7kXOjjzqJA9m8FeaJyUG0e3zVbDzWifYKxBhe8bao7NBeeMID6cEuxgR
         02jltG1JWUbHwt70m3v4OCQl/HZXRVEzVf8htEC/vRegslm84UeHF4FRruXTBoXMW1Tt
         qieQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ssQSH8V/nqqa8vVEA2vMa8XWMV/XChtjFh7pyWu41d9MIxIDu/FIR+Gbw9D/4ZOO2ctbTk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPM+PkYmrEnMiK0EMtGEDRnunKJ07Jlkco1hFeeWmskE3Aesw
	my64GxBbaFiVCIPj9ISyvKnJfubR3hWcOlPVOyOg2X2umvnSRoCEKyUF0Y+x5moZaOi227yC7Wn
	BFLJCtazHk4N7cllAQY6qGeS+d7AqaqY=
X-Gm-Gg: ATEYQzxqn3VQxRoFPmDxa9rx+bVSq/BkB4mUmnLexEUv7G5pDkzTozbBaEzRvSJdZZV
	eUD3yq7KhLU8FuvgIm11D27jd/qN0bPlVfyylolrBwcj0wgiAZc4Li0V+ezmZnJnKR9xlILJHtx
	+wxE//aSyhegIpui78a3SgTNoXkfbaZ5J3IbO5fXQFwLtYcxpK08jiiGwOygBLSte1wBERqq2yG
	0Og/anCV4b099qdH+ByRKqjM3ZRly4/z0yoYdthsM6ut93ootBYx9e25eu7pPVMQImthicWHYz9
	muvr
X-Received: by 2002:a05:6402:a0dc:b0:666:d675:e2ed with SMTP id
 4fb4d7f45d1cf-66b28b5d0c3mr265917a12.21.1774578516178; Thu, 26 Mar 2026
 19:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <20260323182823.5813-2-teknoraver@meta.com>
 <IA3PR11MB8986EC18B4FE10649049AF87E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986EC18B4FE10649049AF87E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 27 Mar 2026 03:27:59 +0100
X-Gm-Features: AQROBzBQpBbZY2yB90kykPH3EOXGMHAzeYAHmse7tk-aqdKtuWnq9c8rAoT9-d0
Message-ID: <CAFnufp1H4ptUN0mr1Kq4j2hcOE+pN-XfiHnwh_6=68FD2OzomA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic XDP support
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272338-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC3D33E801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno mar 24 mar 2026 alle ore 09:06 Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> ha scritto:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Matteo Croce
> > Sent: Monday, March 23, 2026 7:28 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> > Bashir <mohsin.bashr@gmail.com>
> > Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic
> > XDP support
> >
> > Add XDP support to the e1000e driver covering the actions defined by
> > NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.
> >
> > Infrastructure:
> > - e1000_xdp_setup() / e1000_xdp() for program attach/detach with
> >   MTU validation and close/open cycle
> > - ndo_bpf support in net_device_ops
> > - xdp_rxq_info registration in setup/free_rx_resources
> >
> > Receive path:
> > - e1000_alloc_rx_buffers_xdp() for page-based Rx buffer allocation
> >   with XDP_PACKET_HEADROOM
> > - e1000_clean_rx_irq_xdp() as the XDP receive handler
> > - e1000_run_xdp() to execute the XDP program on received packets
> > - SKB building via napi_build_skb() for XDP_PASS with metadata,
> >   checksum offload and RSS hash support
> >
> > Transmit path:
> > - e1000_xdp_xmit_ring() to DMA-map and enqueue an XDP frame
> > - e1000_xdp_xmit_back() to convert an xdp_buff to a frame and send it
> > - e1000_finalize_xdp() to flush the TX ring after XDP processing
> > - TX completion via xdp_return_frame() with buffer type tracking
> >
> > Assisted-by: claude-opus-4-6
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > ---
> >  drivers/net/ethernet/intel/Kconfig         |   1 +
> >  drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
> > drivers/net/ethernet/intel/e1000e/netdev.c | 533 ++++++++++++++++++++-
> >  3 files changed, 540 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/Kconfig
> > b/drivers/net/ethernet/intel/Kconfig
> > index 288fa8ce53af..46e37cb68e70 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -63,6 +63,7 @@ config E1000E
> >       depends on PCI && (!SPARC32 || BROKEN)
> >       depends on PTP_1588_CLOCK_OPTIONAL
> >       select CRC32
> > +     select PAGE_POOL
> >       help
> >         This driver supports the PCI-Express Intel(R) PRO/1000
> > gigabit
> >         ethernet family of adapters. For PCI or PCI-X e1000 adapters,
> > diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h
> > b/drivers/net/ethernet/intel/e1000e/e1000.h
> > index 63ebe00376f5..4c1175d4e5cb 100644
> > --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> > +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> > @@ -19,10 +19,13 @@
> >  #include <linux/net_tstamp.h>
> >  #include <linux/ptp_clock_kernel.h>
> >  #include <linux/ptp_classify.h>
>
> ...
>
> > +/**
> > + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> > + * @adapter: board private structure
> > + * @tx_ring: Tx descriptor ring
> > + * @xdpf: XDP frame to transmit
> > + *
> > + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> > **/
> > +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> > +                            struct e1000_ring *tx_ring,
> > +                            struct xdp_frame *xdpf)
> > +{
> > +     struct e1000_buffer *buffer_info;
> > +     struct e1000_tx_desc *tx_desc;
> > +     dma_addr_t dma;
> > +     u16 i;
> > +
> > +     if (e1000_desc_unused(tx_ring) < 1)
> > +             return E1000_XDP_CONSUMED;
> > +
> > +     i = tx_ring->next_to_use;
> Unsynchronized read of next_to_use. ndo_start_xmit on another CPU can be
> reading+writing this same field RIGHT NOW under __netif_tx_lock, which we do NOT hold.
> Isn't it ?
>
> > +     buffer_info = &tx_ring->buffer_info[i];
> > +
> > +     dma = dma_map_single(&adapter->pdev->dev, xdpf->data, xdpf-
> > >len,
> > +                          DMA_TO_DEVICE);
> > +     if (dma_mapping_error(&adapter->pdev->dev, dma))
> > +             return E1000_XDP_CONSUMED;
> > +
> > +     buffer_info->xdpf = xdpf;
> > +     buffer_info->type = E1000_TX_BUF_XDP;
> > +     buffer_info->dma = dma;
> > +     buffer_info->length = xdpf->len;
> > +     buffer_info->time_stamp = jiffies;
> > +     buffer_info->next_to_watch = i;
> > +     buffer_info->segs = 1;
> > +     buffer_info->bytecount = xdpf->len;
> > +     buffer_info->mapped_as_page = 0;
> > +
> > +     tx_desc = E1000_TX_DESC(*tx_ring, i);
> > +     tx_desc->buffer_addr = cpu_to_le64(dma);
> Writing DMA descriptor that ndo_start_xmit may also be writing to
> at the same index - probably causes ring corruption
>
> > +     tx_desc->lower.data = cpu_to_le32(adapter->txd_cmd |
> > +                                        E1000_TXD_CMD_IFCS |
> > +                                        xdpf->len);
> > +     tx_desc->upper.data = 0;
> > +
> > +     i++;
> > +     if (i == tx_ring->count)
> > +             i = 0;
> > +     tx_ring->next_to_use = i;
> Unsynchronized store - races with the identical write in e1000_xmit_frame.
>
> > +
> > +     return E1000_XDP_TX;
> > +}
> > +
>
> ...
>
> >       kfree(adapter->tx_ring);
> >       kfree(adapter->rx_ring);
> >
> > --
> > 2.53.0
>

You're right. I see two solutions here: taking __netif_tx_lock around
the XDP TX, or using a separate TX ring dedicated to XDP.
The latter would be a bigger change for e1000e since it only has one
TX queue, so I'd go with the lock.

Thanks,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

