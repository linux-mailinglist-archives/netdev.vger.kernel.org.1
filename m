Return-Path: <netdev+bounces-273759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDgUN646zGlyRgYAu9opvQ
	(envelope-from <netdev+bounces-273759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:20:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4159937190B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698CD305A6C0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AF40711B;
	Tue, 31 Mar 2026 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Sto3VEtO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0C3FFAD0
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991654; cv=none; b=iSW89n0xSvHtJjkXcpRcMXx2E5NtCQMLLW8giHeQoBcpP0MbJTOmlHZ6NwU+y5Qxl1yWNz4sEp6xHex/s3g7ky2ffW7vSSXxh6wDOX7Q8a+0IqapGdiGK/Nugsyu9Wf8dWzkh9sLMl3UAlUPB2raEgWbTf87L2Wpd8MKNGWGJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991654; c=relaxed/simple;
	bh=RodyypEEjn5xc2xKGLUHgsXuF5/nuAgh5MDTpI7TEK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFW1arOlpYN1PxqEKEoCakQs3sp6Q+uu6x6IMwsBXqEbI1HyF6vFDNabz4B9dslVk3DErZrSy3+kMWLk6sHzh7WctHBBuMREZTkT+tEhdmoteSNSwKuF8B8DczGOQKwvy2AW0nEGvvCSoOkgNNt39Oi+NVsuTvb72rr7frS2Wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Sto3VEtO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a655cfab5so5714519b3a.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774991651; x=1775596451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPsDMKl966SWuogi2uoY2AaXGVDeLc7Y72W3efu4G/s=;
        b=Sto3VEtOLPeN+FSQWKuPf0/8+DX6zN4/VMq3ogS5DTYnWFhUlIZKj04G9C/1TwDX0A
         IWVJHzMrvGOZuF3u7uZfDlKAI0Q2SKUXCYjSOiZ2nfTnHzZenhPUbt/D52sDwcbxP5oD
         xgdrORSxMf99k73BbWf6Fl6Ofz3ZiHlm739eMcck8ictMk77w4vEFZIYayIkY8+a4k9I
         z7Qu2yinWO6qAWPt5wEfeyjPIZzsokBhVO0PHoe3k7Vj/Yqq6tQNTgiK3aCV0ctRw+vA
         wjOUL0nf9UFrdGnQYazB9tPmu38rDM30wtL6eNHI62JixqM71h+pE7qmvibXBGkkrOzT
         M3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991651; x=1775596451;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPsDMKl966SWuogi2uoY2AaXGVDeLc7Y72W3efu4G/s=;
        b=QbwViuen5YB0t1Ymr8AdLp0uBSEQp0qfGGn0Cs/HGHszU2fw+MbOPGDYj4Ydiy25Sf
         aNMVMoew+bkayQjUcNV83SIrRzw+BJCDTZHHWtYQfkM+vQDtuMF0Ckqb7b7iGqWzjVsJ
         fEgGRhnJ84fXTHOYiZg+Skcqs2GdtaBj8WvIf4OFV5zDmQ8T+tJQlhonPGKy+RDb+j+M
         3AZwo+W8DWblpx6OX2pAKtp04CeUn+BLugOgQMFZnoiZtBDJPntlv29Ifab8kZviqvto
         m8QHkMaKZHP9ef5vYYezt0EHutfkSMQ84HqEJtWAqzbDHMNcseR8dGspW0wj+mOwc/AU
         weQw==
X-Gm-Message-State: AOJu0Yy9bbFkdaGIreQHg/jTXcW9BG6f3fEgvLfyxFT8O7gyXmRf6F4U
	NFoUagWbgKRbm9niICEwGALBP68aJDwXQYblmhE+QoPovcBR+s7ogIF7XtlvIXBkPIQ=
X-Gm-Gg: ATEYQzzfwp8belxTJJq0xFRLYNjU0sCW2NS9Uius598ZqoK0Cb1esTjF1zUMSx+Wniq
	tYIXBUCWouGzW3X+Tp0EWO4YThHJlFNHXLlhNhxRfZRbyURp/H4u2lnkvz4OZTGYn0O9roEcojV
	vMA31Dg6zoKn1tmQogx4j+t7OWpml4GxnTT2HIqxJdFOREwzM7abbUPPQRPUoKSkXkXkf+u+wzO
	f/NzUnKXqBVvSuRgXLveMGjceiZLI85rprMhKE+BgarPQtX9fV/ntX/Lm3gCNbiAcra7KEnaBxF
	bnym+CO16Qg9ch1dFX07FqFtAgzEHJw67oHZAJE4E24E4pa8BR3Shczki8eloxgOxm7IrCgAXio
	NJ41PIsW75mlHdIPrgjgmKZS0qESwScwZ5uNEOenfq2NVNT3RPMB8i2cs5DZGFkHF8VU1ylcWr2
	Q/6spt7PZmDeo=
X-Received: by 2002:a05:6a00:4195:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-82ce86d78a1mr1034418b3a.0.1774991651111;
        Tue, 31 Mar 2026 14:14:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca849849fsm13712725b3a.26.2026.03.31.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:14:10 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:14:09 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <acw5IWuRiLV0yHVe@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-10-joe@dama.to>
 <20260330165748.2edb501a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330165748.2edb501a@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 4159937190B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:57:48PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:28 -0700 Joe Damato wrote:
> > @@ -4645,6 +4687,10 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
> >  
> >  	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
> >  				   BNXT_MIN_TX_DESC_CNT);
> > +	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
> > +	    (bp->dev->features & NETIF_F_GSO_UDP_L4))
> > +		bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
> > +					   BNXT_SW_USO_MAX_DESCS);
> >  
> >  	for (i = 0; i < bp->tx_nr_rings; i++) {
> >  		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
> > @@ -13832,6 +13878,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
> >  	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
> >  		features &= ~NETIF_F_NTUPLE;
> >  
> > +	if ((features & NETIF_F_GSO_UDP_L4) &&
> > +	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
> > +	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
> > +		features &= ~NETIF_F_GSO_UDP_L4;
> > +
> >  	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
> >  		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
> >  
> > @@ -13877,6 +13928,15 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
> >  	int rc = 0;
> >  	bool re_init = false;
> >  
> > +	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
> > +		if (features & NETIF_F_GSO_UDP_L4)
> > +			bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
> > +						   BNXT_SW_USO_MAX_DESCS);
> > +		else
> > +			bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
> > +						   BNXT_MIN_TX_DESC_CNT);
> 
> Adding extra handling for min ring size all over the place looks a bit
> messy. Can you factor something out of this logic?

Could add something like:

  static int bnxt_min_tx_desc_cnt(struct bnxt *bp)
  {
      if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
          (bp->dev->features & NETIF_F_GSO_UDP_L4))
          return BNXT_SW_USO_MAX_DESCS;
      return BNXT_MIN_TX_DESC_CNT;
  }

and then when setting the tx_wake_thresh, it becomes:

  bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
                             bnxt_min_tx_desc_cnt(bp));

and fix_features can use the same helper.

Question then is just do we still want to bump BNXT_MIN_TX_DESC_CNT (as per
your previous comment)?

