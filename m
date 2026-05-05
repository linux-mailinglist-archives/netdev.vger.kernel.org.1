Return-Path: <netdev+bounces-284525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDl1B44n+mmHKQMAu9opvQ
	(envelope-from <netdev+bounces-284525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF74D1FAC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B36530182A0
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972F248B389;
	Tue,  5 May 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExlZqUEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04F480947
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001803; cv=none; b=VIe1FGlifb+tSmRq4/9MNJCATEDVtE0OBwdnQup+UXkpJCNOP3Z1qYMGoOOX8HoySji/jkueptZ4ec2Jj05d80hc8qIZMxsNBnx9A5lXg/2v3b0kMTiZ7pLA0HZZKzXvsciptVlPw4S+nTj2fy5l2muKqzSx+LKIjqvSi6WqyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001803; c=relaxed/simple;
	bh=Y5bLVVloBrHuY31C/zxBnNyepp93KwqIPYKR5Ilb3Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myv+jYvdtpEOQlvncWJXQU/PsTSKAHDY8Qp2/7glBtH4n1Ab70gQ8qR84xaBq+yQrd38CvGXCvr+qz7L8VuyXmIgfFdifhqlVHdzvNMqhvrhmBbJjq7O08tBLni8z1cZWOxG0CAoleV5Cclbkn6+W7IVnfjCkPgz8n/7qnUBrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExlZqUEW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5102582e237so43343721cf.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001801; x=1778606601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8SEhPhIOwl62QRDNb5gW7sJOyHfLJWGfBR0DJXT+P8=;
        b=ExlZqUEW5osa2F2CRVnBNHp1mzi6fwF5E8xi3N1nO1BjHHFqoddiFY8h5zhCMvqE2x
         1NjsMlYoGnXfulv8AfEKXabPhbueBqowuTjFC07mjwVU7ivtqdmflQeGK8Yz2o7mIopi
         XOU/r8/HoJIYqEgGRVMvt8X7kpPLATp7Qbn/YtiLQ2H+MwWFMlRYO9ZSydeDqstIgjVz
         UjHb+wsmEIgCCi7WDEOvWCo4otkysFeXQqu8BJT3q5M4bc7CoGm5E7eJvwHE4pa721tl
         y+p1aMaqOBD9AF6UBE0683Ta69cyPK9j1qRxSH0tKS0iHlVr+fobUMi2YLBP5UGacP1o
         zDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001801; x=1778606601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8SEhPhIOwl62QRDNb5gW7sJOyHfLJWGfBR0DJXT+P8=;
        b=RULPt+JJXg/VVYn1EBlk8ajjiG8fXc/ufgAWdV1jQtaKrBI2tP6akoWt2O/Q86dCq3
         J3rW3rn3/xKebMUvqW3GLmR3/y1vrPvCgE51711tT3YBfSugzgrLPJNpcFDIMq0yBPjK
         +bgQl1YuY1zp0HYIxQijJyU9FE9BOidH14woryviBlg6jYrPtvJFlCCVPa5P8vTOMxJ3
         CJ2OTYFxPLY7j+xdXh86RcEcGy6ZYtcrMQoWnqPlj1VNt7q5/fhq8x4mlcaZTdbEiWBd
         TJgFoW+9XnK1wNJFy8TBl+Y/mop9GHsdwlKI1hsVgOxtT6bIrXfJ2MlL+/OHCklbV9e2
         pv1A==
X-Forwarded-Encrypted: i=1; AFNElJ8Q17ToM0vxSK8ZVglqBYVsq1qySmrFBAD+CHQYY+4X+6xasjaKZ5snQPIZfl6gX5juPSsBofg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY8zgbVnjbFkjxoSrSEduH0JrdzIxLebUxtFHCwAyYEV4hXYL
	3ee7uMz8nAF3g62Vce6isZNyH0ExqtlUyiTpapX9DfZLbruqV8fD0cK/
X-Gm-Gg: AeBDiesWh0iGiHuCf0YJwv/QO0cWnSKcbqO2UEh4+aABOqjjQD6vg/NyqlffVEgbLtf
	ZUCfYe2aQz8CFZSxZf/S0iJvDjdIwg92SGTw2vooQnfDEpDFTpeoZn8okixpSPyA2UX5EdXOE3z
	YLHe99sh0C4dEPWn2yYtsmzJIO2PZZyUO/tjFBAOdRyxsAiNjgHCIt/+hMlHAP++9+1XR3jp7zD
	eOTp3LXK2pYhVJ237Tk5NEuvIBFFthVTXOj0gRFm80Q7Yj84m00TVjpv68hDrG9n6k6zLqw3BUr
	8TMIJTERHIFa3AejogVkspyZVvktpu5A/hLDZFyK3zu1M9A8LuXZY4ljVVgB/ZuTVYN9krPrhHJ
	Awa0x7Izoxxv3ts1BQlkNOS11yp+V+nNAsYwvkChYDoGhYlm5RpZVcQ2yRa2QGwf3kmCUvp3XxY
	U6+9Ydx+BUyvtlC4WXuMDK+dEMqpxwk2qKgk+agk/fFGBW5ZMShpiUAht40JNehRWL+Jg=
X-Received: by 2002:a05:622a:4d43:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5104be2e082mr214591201cf.9.1778001800961;
        Tue, 05 May 2026 10:23:20 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51043c1b8fdsm143087571cf.6.2026.05.05.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:23:20 -0700 (PDT)
Date: Tue, 5 May 2026 13:23:18 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: eth: fbnic: Add pma read and write
 access
Message-ID: <afonhgxwfuv1fYUy@PF5YBGDS.localdomain>
References: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
 <20260430150802.3521-4-mike.marciniszyn@gmail.com>
 <7d657e09-1037-4f0d-b0f6-70228a4acccd@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d657e09-1037-4f0d-b0f6-70228a4acccd@redhat.com>
X-Rspamd-Queue-Id: 81AF74D1FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,gmail.com,armlinux.org.uk,intel.com,trager.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 02:40:18PM +0200, Paolo Abeni wrote:
> On 4/30/26 5:08 PM, mike.marciniszyn@gmail.com wrote:
> > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >
> > Document the MDIO interface topology with an ASCII diagram
> > showing the MAC, PCS (MMD 3), FEC, Separated PMA (MMD 8), and PMD
> > (MMD 1) blocks and their interconnects. The diagram illustrates how
> > 4 lanes connect the MAC through PCS, FEC, and PMA, then narrow to
> > 2 lanes at the PMD.
> >
> > The c45 read and write routines are enhanced to support
> > read and write of the separated PMA for the fbnic.
> >
> > Co-developed-by: Alexander Duyck <alexanderduyck@fb.com>
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> > ---
> > v2:
> >   - no changes
> > v1: https://lore.kernel.org/all/20260428172810.175077-5-mike.marciniszyn@gmail.com/
> >
> >  drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |  1 +
> >  drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 71 ++++++++++++++++++++
> >  2 files changed, 72 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > index 81794bd326e1..64b958df7774 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > @@ -805,6 +805,7 @@ enum {
> >  #define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
> >
> >  #define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
> > +#define FBNIC_RSFEC_CONTROL(n)	(0x10800 + 8 * (n))	/* 0x42000 + 32*n */
>
> Sashiko says:
>
> ---
> With the introduction of the RSFEC memory space at 0x10800, does the bounds
> check in fbnic_mdio_write_pcs() need to be updated to prevent clobbering
> these new registers?
> While not introduced by this patch, fbnic_mdio_write_pcs() currently
> contains:
>     /* Allow access to both halves of PCS for 50R2 config */
>     if (addr > 2)
>         return;
> When addr is 2, FBNIC_PCS_PAGE(2) evaluates to 0x10000 + 0x400 * 2, which
> is 0x10800.
> Since this overlaps with FBNIC_CSR_START_RSFEC, an MDIO write to MMD 3
> (PCS) at address 2 could silently overwrite the newly managed RSFEC
> control registers.
> The read function fbnic_mdio_read_pcs() correctly uses if (addr >= 2) to
> prevent this. Should the write function be updated to match?
> ---
>
> Does not look blocking to me, but a follow-up could be needed.
>
> /P
>

The patch that fixes this issue should have preceded the three patches.

Here is the patchwork link: https://patchwork.kernel.org/project/netdevbpf/patch/20260504135815.44226-2-mike.marciniszyn@gmail.com/

I don't see that you actually pulled that patch or that it has been
accepted?

Mike

