Return-Path: <netdev+bounces-249196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BADD15646
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28ABF3029B86
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084C33BBD2;
	Mon, 12 Jan 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BILu3f2c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C032D45B;
	Mon, 12 Jan 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252286; cv=none; b=gZDsREiP3yTfArFG5TfYQxBYtpfD/LpK6VohJm7dTKWPvzzdsxD/Ni3QidI6x5BfV3fTXNWKq/NkYuam+3I/lwdKx30F6zHbty+IYCv0eGM0M4x0lD3mCwCCvuvmXXyJAE/BbZcoxxuTWbey+BC36xniRj4pZfjRJMIy/vFsJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252286; c=relaxed/simple;
	bh=pBPGUm3JVtFRBP5BVShftC+b7eeNmV8EMXAeBEpzruc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGuYDkF/35rC2Rek7fCvJZMjRSZ9rLdaJrGeG4l7u9QW2P98lJYNoLZgQT8Ygns19lFtJjBwbX0ukaEqwrunQt0yEeXH7lhCEQLXF82nXywr1Zmudc0EWl8VtFVevBTupuc/kQLIWWnpKKlNk2m/7fw6t5O2b7Cjqt1lPgo0Rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BILu3f2c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=CZYeA9t3kES5IBG8wI8pLlH9OXeiqmQpxtFuYdtMcLc=; b=BI
	Lu3f2ci9+i6iTmNeLo9/FzKMTGM2uJiJIGn7cNFKydnodKQ9AVbzhTCiZgGtX+hTqFNuvmWFtDbk3
	j1+AEYvDba6+GRcvX0dh23GakO5omt39dHG3P2e720fiWFxe7/DUpFRPg+arKmson9KtASLc+3Ud2
	FQyERqEjHt5/qR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfPBv-002Xhw-AU; Mon, 12 Jan 2026 22:11:11 +0100
Date: Mon, 12 Jan 2026 22:11:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
Message-ID: <ec0dc3cd-687a-4612-89d9-3c5cdd093ad0@lunn.ch>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com>
 <a3aab7af-3807-4f37-92e0-5ea52df1bd4c@redhat.com>
 <CANXQDtYR6P9+oHXpAzxPk4cE1jSYCFoCbELcWad25h1c6wfmQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXQDtYR6P9+oHXpAzxPk4cE1jSYCFoCbELcWad25h1c6wfmQQ@mail.gmail.com>

On Tue, Jan 13, 2026 at 01:14:33AM +0530, Bhargava Chenna Marreddy wrote:
> On Thu, Jan 8, 2026 at 3:15 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> > > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> > > new file mode 100644
> > > index 000000000000..4da4259095fa
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> > > @@ -0,0 +1,198 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/* Copyright (c) 2025 Broadcom */
> > > +
> > > +#ifndef _BNGE_HW_DEF_H_
> > > +#define _BNGE_HW_DEF_H_
> > > +
> > > +struct tx_bd_ext {
> > > +     __le32 tx_bd_hsize_lflags;
> > > +     #define TX_BD_FLAGS_TCP_UDP_CHKSUM                      (1 << 0)
> >
> > Please use BIT()
> 
> Simon Horman raised a similar point. However, some hardware BD values
> use non-contiguous bits that make BIT() and GENMASK() overly complex.
> We believe the current definitions better reflect the hardware spec.
> Please let us know if you’d still prefer a different approach.

You probably want to use BIT() for all fields which are
contiguous. Doing something different then marks the other fields are
somehow special and need treating with care.

> > > +     #define TX_BD_FLAGS_IP_CKSUM                            (1 << 1)
> > > +     #define TX_BD_FLAGS_NO_CRC                              (1 << 2)
> > > +     #define TX_BD_FLAGS_STAMP                               (1 << 3)
> > > +     #define TX_BD_FLAGS_T_IP_CHKSUM                         (1 << 4)
> > > +     #define TX_BD_FLAGS_LSO                                 (1 << 5)
> > > +     #define TX_BD_FLAGS_IPID_FMT                            (1 << 6)
> > > +     #define TX_BD_FLAGS_T_IPID                              (1 << 7)
> > > +     #define TX_BD_HSIZE                                     (0xff << 16)
> > > +      #define TX_BD_HSIZE_SHIFT                               16
> >
> > I'm quite suprised checkpatch does not complain, but the above
> > indentation is IMHO quite messy.

> > please move the macro definition before the struct and avoid mixing
> > whitespaces and tabs.
> 
> Since these are hardware-defined structs, we kept the #defines with
> their members to make the mapping clear.
> Any concerns with this?

The names should make it clear. The structure member can be called
tx_bd_flags, and the bits are TX_BD_FLAGS_IP_CKSUM etc.

> > > +static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *data,
> > > +                                  unsigned int len, dma_addr_t mapping)
> > > +{
> > > +     struct bnge_net *bn = bnapi->bn;
> > > +     struct bnge_dev *bd = bn->bd;
> > > +     struct sk_buff *skb;
> > > +
> > > +     skb = napi_alloc_skb(&bnapi->napi, len);
> > > +     if (!skb)
> > > +             return NULL;
> > > +
> > > +     dma_sync_single_for_cpu(bd->dev, mapping, bn->rx_copybreak,
> > > +                             bn->rx_dir);
> > > +
> > > +     memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
> > > +            len + NET_IP_ALIGN);
> >
> > This works under the assumption that len <=  bn->rx_copybreak; why
> > syncing the whole 'rx_copybreak' instead of 'len' ?
> 
> Good point. syncing the actual packet length is more precise and
> avoids unnecessary cache maintenance.
> Let us test this on our hardware and get back to you.

When i did this for the FEC, i got a nice performance boost.

     Andrew

