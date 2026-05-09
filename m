Return-Path: <netdev+bounces-286214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNwVBv2V/2lW8AAAu9opvQ
	(envelope-from <netdev+bounces-286214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 22:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1E501521
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 22:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D627C3002B60
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9625381B15;
	Sat,  9 May 2026 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si4/17jT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F7274FDF
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778357750; cv=none; b=tiq9ICfJJayY1V3K/9c+PIEOPDxCSAPij2k8bTqiUH/QnLlz7S+INbLeLCz50VBQDBToALYkuRVLkeLJ4zX8HGzb0PaGti6LYYGEi/89v65K6ZB0dqw/0iM02V3pEgpHWxNlcv1V+jneZ8RYjYlCcQ+nkvEFK+a1SF8tB/OEmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778357750; c=relaxed/simple;
	bh=VbkSU7aW++WW/qyzAiq7KmGE3wsPzpEVNoFPP5Ge5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjLUJUceg2sL3fslsQRgjAwkSwAtVT37cYKrp95kTIITrSt+lye5wIqm1IuXMFNnIcCDqasPwHjLvT6HNU4khPWkmaPU0q7ckae32RWQEp+WlwmtscYb0VedSGiRhd7x/9U/LX40yebjx/jeSnGaszchTNrRAwlWNZAIunm6cNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=si4/17jT; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ec37d52c0dso450842285a.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778357748; x=1778962548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYazW+0Ex+gJykh3CgPYHQcYsxybUb2g7zni8omjRdQ=;
        b=si4/17jT9yFw3PId4u36+7ctji0RJ8kPfnNrLbbaIP4LnZuFIuXff26VOPmCo79QQS
         sfz/WUIwGoyl3X8Fk7rRzTesSRZduuoE80RKkmpvRo66i5ns2mPa5+Fwp4xAPciRJgKA
         nq/XKo++vwu+Tl0Cg7nyp70S0xjpq3dBS+4Bswn+MbG9aOlI26xyzCcHllIz09jTENrd
         loWuBD+upDkwx6d2m39sgT6aafLXoEiJX3DWSkmhgFR0ecmSPjZO5yw5XvJP3h/Bb5L5
         DmaNGuHdunFLP0l+6BJJio5C5wcxOHI/Fy9HxazI/Xxd9RKLIwIsPxnTkCM8TGEZ7NPA
         5qJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778357748; x=1778962548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYazW+0Ex+gJykh3CgPYHQcYsxybUb2g7zni8omjRdQ=;
        b=NTdD4VYEJ5k2jJasZAJm10l1nT45uIO5r8SUUVzSyEhWkYCyt0t9ZHOFSRzMd9oNvl
         GtYgpHE2GikyuTKqPcnyOPMLmBXoBsGZSRBnvSejUnIBufnKUhaq78GcQ9gW3+SiYaSy
         QoA8LmzG6D/QyjJbL/f8gwg+NnA7zYGiqLR5RMmX0thttabVPKWCz3iUKb2uJobH1vQF
         gU1fqOiBRmERrPzpqRjvIJJeSIZi4gi3zY+bNOvnQN9PlqaLfCG0dttXMne8Sjy4NFVa
         VKmhS2HEo3GvsKX+arnnVQzxXV7pAHUNDvMIyhl8txuQqB3OlgffSe6km/CPu64Mw5s5
         xDsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kIOsT99UUqPLIV9b0P1nR5jhOPx5aAoD4iuUb7HXvvVvz7w5MxVngT5ImSIBxP2aA2RhGrpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySeS1MRqunE6giVpZ07wZC+gsCduo2MpZqvnQ0D2kigU58zocf
	KTAwRaQCzmrj23caksOzDV5duolqiRwlPR5qtVwU4tCMh7ddlRZYyyY2
X-Gm-Gg: Acq92OHVwc450LgIV3GCFVEi9Hc6hRHHi0WxTVcKGZQ2ZKsCkgYQ+T/oMPEdoxhPLfb
	X/mn5BclhTQ2lyUNdPqtk0aoLEUo+0QboCuCHe2tr0ee4YbDOmW2PdNVym0TF1JtO8UDo0KWLg9
	OfA6jH0QZZzV5oX0dHgTKlelu8AXFTItb0NZGMWnhhrlvzVbP61mce82Sz+X6OC1bDEpeJ7Ip7o
	nbqInzIohHYt3Q+ulWgegFU2jUkucNjnp8wTQDiam00eu+EPu7OTzzo0c7C0k9LMfQ8LgM7Q90e
	n+TEwUrRLfzxeQ8iPVkF31Wld57+8wQaXlEHCQ/wgjaljDY1zlGH+dsEFnvF/a0ERSBZUZF9mWH
	OZiSE3pxwheE2dT3NsMfIgZ82Q67NfSA8/C4v7xmISqKM3aV7dUSd/vB11m8OYSiHv5VLAtyvUF
	Vd34DSn5SqBvo/YMwFGVH7n1hLU5jork9CW57VnqepwHRHpI7LhryBirgU
X-Received: by 2002:a05:620a:29ca:b0:8e8:ffd2:efa5 with SMTP id af79cd13be357-904d4391f52mr2574866385a.11.1778357747897;
        Sat, 09 May 2026 13:15:47 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c813sm2617121385a.33.2026.05.09.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 13:15:46 -0700 (PDT)
Date: Sat, 9 May 2026 16:15:43 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	alexanderduyck@fb.com, kees@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: Add handling for 4 channel
 rsfec device
Message-ID: <af-V764Y6i4aSNl0@PF5YBGDS.localdomain>
References: <20260506190904.4029-3-mike.marciniszyn@gmail.com>
 <20260509010634.3521341-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509010634.3521341-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 21C1E501521
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,fb.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286214-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 06:06:34PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: pcs: xpcs: Add handling for 4 channel rsfec device
>
> This commit introduces the configuration of vendor-specific registers for
> alignment encoding, PCS Mode, and VL_INTVL over one or two instances. It
> derives encoding tables from the IEEE 8023-2022 specification and handles
> register conflicts for DW_PCS IP.
>
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index 0987621632a70..c42eacafad91e 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
> [ ... ]
> > @@ -1429,21 +1429,94 @@ static int xpcs_get_pma_mmd(struct dw_xpcs *xpcs)
> [ ... ]
> >  static int
> >  xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
> >  {
> > -	int ret = 0, i, pma_mmd;
> > +	int ret = 0, i, vl, pma_mmd;
> >
> >  	pma_mmd = xpcs_get_pma_mmd(xpcs);
> >  	if (pma_mmd < 1)
> >  		return pma_mmd;
> >
> >  	for (i = 0; ret >= 0 && i < v->lanes; i++) {
> > +		/* code word markings */
> > +		for (vl = 0; ret >= 0 && vl < 4; vl++)
> > +			ret = xpcs_config_vl_markers(xpcs, vl, i,
> > +						     !vl ? &v->vl0_markers[0] :
> > +						     &v->vl123_markers[vl - 1]);
> > +		if (ret < 0)
> > +			break;
> > +		/* vendor registers */
> > +		ret = xpcs_write_pcs_prtad(xpcs, i, DW_VR_MII_PCS_VL_INTVL,
> > +					   v->vl_intvl);
>
> Does passing the loop index i directly as the prtad (MDIO port address) here
> overwrite registers of unrelated PHY devices on the shared MDIO bus?
>
> Looking at xpcs_write_pcs_prtad() and xpcs_bus_write(), the address is passed
> directly to mdiobus_c45_write():
>
> xpcs_bus_write(struct dw_xpcs *xpcs, int prtad, int dev, u32 reg, u16 val) {
>     return mdiobus_c45_write(xpcs->mdiodev->bus, prtad, dev, reg, val);
> }
>
> Since i is just the lane index (0 to v->lanes - 1), it appears to disregard
> the actual base address of the device.
>
> Could this be offset by the base address (xpcs->mdiodev->addr) to ensure the
> writes hit the correct XPCS block instead of unrelated PHYs that might happen
> to reside at addresses 0-3 on the bus?
>

I'm going to send a v2 based on the phy_find* helpers that removes
all hardcoded addresses.

To facilitate that change,  the bus probing is now done for addr 0 and addr 1
to ensure the underlying structures support the phy_find* mechanism.

Mike

