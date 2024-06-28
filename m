Return-Path: <netdev+bounces-107785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58591C583
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F72E1F21268
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C31CD5B9;
	Fri, 28 Jun 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W21uMIkL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF51CD5B3
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598416; cv=none; b=YtvmRICkOAxaCqsJvyzP+NqcCwxiZIAxT2xuXzw6zWvlv/cQ5c8xDYRBZ8xNFvhaO2QZ1KIn/nG1qMlvQ/PckRCdvafjlyQF1XjDtgAninzwOBzC5P9zblvjVkTKWGpK4vFJesTuCCsU9iGE6t7pQdJtSF5+otjYYrPRi1WVh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598416; c=relaxed/simple;
	bh=X/RkLWIyetfVIku+8z9H2tYP04XAAs7ehPr1hMM3ojY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFdslYZ7d6lPsytIZrMZ6L2bI5iuvmLqL5A8LwkKI44rC4q0Yt8oxEx+bhZz/flmQganMYXpGS12DjoQOuPTVwWuFVApYxFfqv0uq8xr04/0K4M4j+V2z/FVmqIrj2t7lYq0UQJ5tJm5sWst+Qi6oeXhBBla/WXCkiOWzSNtWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W21uMIkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE2FC32789;
	Fri, 28 Jun 2024 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719598415;
	bh=X/RkLWIyetfVIku+8z9H2tYP04XAAs7ehPr1hMM3ojY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W21uMIkLbvGT3r+inuE56Gcws4mCZKNro/gUMrb4rx1+OEDPpzcv7Ub2u9EV80H9L
	 Kkp5hY7kgJ0qn+g5hEIVX+OvdzfRLgzMYizoNfBr4B2R6H8rvzsqT0Bzmlcmey4BPK
	 EEzr4cjoAZs9nUDxtXvB3J47KhoBz9hIGtDwBFNiXsciTrWB5uIH0eSJb8QeudyaGB
	 nXFAYlA7hJmrdgmEFSGpmWLufwE1dWSUbOEGgquMUmWUYygzBaBisT+lnw/yZa5SwC
	 EfV/7vd8b2I+iEg7Mnd4eikEln6DVkmvwA2Yb5t3c/z0HcrnWy4MbO8DCplUIGc8yg
	 EySvqtQUg+SAg==
Date: Fri, 28 Jun 2024 19:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 09/10] bnxt_en: Increase the max total
 outstanding PTP TX packets to 4
Message-ID: <20240628181332.GD837606@kernel.org>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-10-michael.chan@broadcom.com>
 <20240628170318.GK783093@kernel.org>
 <CACKFLikv==pNi2i9FbpQ-qOJofPxq6eoj5j_9bA_bqRBj+NV2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikv==pNi2i9FbpQ-qOJofPxq6eoj5j_9bA_bqRBj+NV2Q@mail.gmail.com>

On Fri, Jun 28, 2024 at 10:37:19AM -0700, Michael Chan wrote:
> On Fri, Jun 28, 2024 at 10:03 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Wed, Jun 26, 2024 at 09:43:06AM -0700, Michael Chan wrote:
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > index ed2bbdf6b25f..0867861c14bd 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > @@ -457,8 +457,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >       unsigned int length, pad = 0;
> > >       u32 len, free_size, vlan_tag_flags, cfa_action, flags;
> > >       struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
> > > -     u16 prod, last_frag;
> > >       struct pci_dev *pdev = bp->pdev;
> > > +     u16 prod, last_frag, txts_prod;
> > >       struct bnxt_tx_ring_info *txr;
> > >       struct bnxt_sw_tx_bd *tx_buf;
> > >       __le32 lflags = 0;
> > > @@ -526,11 +526,19 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >                       if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off)) {
> > >                               if (vlan_tag_flags)
> > >                                       hdr_off += VLAN_HLEN;
> > > -                             ptp->txts_req.tx_seqid = seq_id;
> > > -                             ptp->txts_req.tx_hdr_off = hdr_off;
> > >                               lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
> > >                               tx_buf->is_ts_pkt = 1;
> > >                               skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> > > +
> > > +                             spin_lock_bh(&ptp->ptp_tx_lock);
> > > +                             txts_prod = ptp->txts_prod;
> > > +                             ptp->txts_prod = NEXT_TXTS(txts_prod);
> > > +                             spin_unlock_bh(&ptp->ptp_tx_lock);
> > > +
> > > +                             ptp->txts_req[txts_prod].tx_seqid = seq_id;
> > > +                             ptp->txts_req[txts_prod].tx_hdr_off = hdr_off;
> > > +                             tx_buf->txts_prod = txts_prod;
> > > +
> > >                       } else {
> > >                               atomic_inc(&bp->ptp_cfg->tx_avail);
> > >                       }
> > > @@ -770,7 +778,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >  tx_kick_pending:
> > >       if (BNXT_TX_PTP_IS_SET(lflags)) {
> > >               atomic64_inc(&bp->ptp_cfg->stats.ts_err);
> > > -             atomic_inc(&bp->ptp_cfg->tx_avail);
> > > +             if (!(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> > > +                     /* set SKB to err so PTP worker will clean up */
> > > +                     ptp->txts_req[txts_prod].tx_skb = ERR_PTR(-EIO);
> >
> > Hi Michael
> >
> > Sparse complains that previously it was assumed that ptp could be NULL,
> > but here it is accessed without checking for that.
> >
> > Perhaps it can't occur, but my brief check leads me to think it might.
> 
> Simon, thanks for the review.  The key is this if statement:
> 
> if (BNXT_TX_PTP_IS_SET(lflags))
> 
> This if statement is true if the lflags have the TX_BD_FLAGS_STAMP
> set.  This flag is set only if ptp is valid because this flag tells
> the hardware to take the timestamp.
> 
> >
> > On line 488 there is the following:
> >
> >         if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
> >                 goto tx_free;
> >
> > Which will lead to the code in the hunk above.
> 
> The lflags will not have the TX_BD_FLAGS_STAMP flag set if we jump from here.
> 
> >
> > Then on line 513 there is a check for ptp being NULL:
> >
> >
> >         if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && ptp &&
> >             ptp->tx_tstamp_en) {
> >
> > And ptp is not set between lines 488 and 513.
> >
> >
> > Sparse also complains that txts_prod may be used uninitaialised.
> > This also seems to be a valid concern as it does seem to be the case
> > on line 488.
> 
> Same explanation for txts_prod.  txts_prod will always be set if
> lflags has TX_BD_FLAGS_STAMP set and this condition is false:
> 
> (bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP)

Hi Michael,

Thanks for your quick response, it is the kind of explanation that
I was looking for, but wasn't sufficiently familiar with the code
to find myself.

