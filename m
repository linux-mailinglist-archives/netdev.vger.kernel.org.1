Return-Path: <netdev+bounces-252842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hM9oH/lyc2mWvwAAu9opvQ
	(envelope-from <netdev+bounces-252842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:09:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9D76230
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A746B302F38E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEA2F3C10;
	Fri, 23 Jan 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR38wHq2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4792417E0
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173749; cv=none; b=MOE0YjCUf5+PUm9xcniodjjMowye6FKygu6jRLenJ15hvsxCZAcbCrVG2Ul2/4kWpLYSFW5xWk87cRn+hnjr94qfzsnLW2U/kL7OtMAQFat/8tBpbADKIMYXTFWiXbZiuCReJU56ktQjbKt2/xYPKGcGpq24F6WwQdh8xxh/L6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173749; c=relaxed/simple;
	bh=cFpC7v3e2f1s5QcKqpbbp+MFq/K0luTpU66taNYWdOU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFAgF4e8zsYpbUdze8DwndKpbIz9rDQ8XOkuV/SOGRjCPt9XgIOcqZoHZldwg9M+h0abPuRIq9pFXm6Enq/B6L+LzlJPk03kmm9OqiUdNmmeN8ZrLwPVhbIp2mow2A4J//XnBtQwT06GpF5o9vgK4I7fbAqz3v+dcd+XyNa7XWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR38wHq2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso23628385e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 05:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769173746; x=1769778546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0mZ7cxT9Oc18zXyi3CSpw+MXg+25jVdopAgJLZF8Ols=;
        b=iR38wHq2FEItCU6W71zVW44xzhAYS6eRUF31IsomzvlHGKv8nwPsoB9b93LRLE15Ye
         u/r4QyI/4HvD51VifPawjsUecXF4QSfmOPtos6sRivPtSSPQQRNJCmyNJv/eNqwVtUvD
         1BzeKjSIzo6MoXrO8SebpfPk1wN7FpXFxtIGX/OjrnnAkrOEZAFYMiEZL74/WbMeXU+H
         Zst/8X2l/DEGwPFLyPYdzN3YnE917cOl0a3VaFipiiS/FLc76Po7zJwNvtqLu4KeFXEt
         mvi9e28BR8irowMxc0z4Wlb9jBOeZeQIsUdfQM6tYL/VPaXmTgk9sncOaDRKLXEtG6Dw
         DTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769173746; x=1769778546;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mZ7cxT9Oc18zXyi3CSpw+MXg+25jVdopAgJLZF8Ols=;
        b=YkNo+THK+Ph3A2RIOkHus4BCPPlU1bKjsQuLXYrztekdbQbbh98E0bo/PEFuj0Vdqr
         3FVzzcdGIKqfp09YSKmPA+Krgyo2MzVkEufFSttk2Ue8/NMMydh49AsZcpvz09GebLzt
         2JtXFPusWl2uMpYpKld6FUd1emOFXx1JOdUNAluAWbVa2uza/Nm1gAtbIsI7K4Vi1m3o
         GVlDcvza7P1toZMu8uso6r/5fK0CMmeT5kODmc5Igmp5LiRXFO3ZtepADD0RBTHbpjUQ
         Jh5tg6TkjI5ZfapP8c495XysrVC8Z81+wkVM+fxgzIa/HnT6bv+W2IXTg6MfcRwXsRF2
         jYcA==
X-Forwarded-Encrypted: i=1; AJvYcCX8vNiD4YxZ6jntvma39S+j+u2UWDJfEyrXvXuzIENKisP6ThM0TvTOH9m9UgUbhORU9JeUnRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVvHRsu/tyWYgNBE1c+rSndZIGgjg0gpPEknAclUAHMuEe+AA
	+Up/0rZ3TJQal/29KTF7FVrd/JdjotE02CF2G2iZRfGoMiuzz1HL/ul1
X-Gm-Gg: AZuq6aJnZq2vbavlhXZVt2fyG9/+xNTsAudUaHVpxRSXNLjIr5eaG8s7NLtJOzzc/ur
	dgyGAYSuq8Ukd/HyTcEmTzYxteyt/JhoQGgcnR90O96M4eAm2kMYRcoDWSwxEGw4EjKi7Med8rz
	FMwheM/bGOJZ3XoamO1oF/BdKRhlxZiNqX1t0NHz6ogZDLCJVoKlmvxrp3ZH622wutUY6ztN6i9
	PAtQPekJ30KKkpT4MD14D2OKuTQ42EasHw+or2uHyJCSRMz7E57Pb6Rs5b4DXiy7Dl7VFVdtv2u
	ojFszBjUg0qRY+K2KhXCp1t6U81vaZNuiMENVFbcmGoURR7RrvGsZ48G9Kt+B/nU90ZKSBu6rzQ
	OzfFkE704yklw3D7E/YcIkYLmvd40eMoCXVGpWOpPwqlSW/1uRg6bLTSib9p8n2oKgL5FFxRwT1
	p5lvgvH8djnboZcMUYdgqfoGSVP7Ye1iyJsq3EfOI=
X-Received: by 2002:a05:600c:46c5:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-4804f8235f5mr33189985e9.22.1769173746248;
        Fri, 23 Jan 2026 05:09:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71730sm7008672f8f.26.2026.01.23.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 05:09:05 -0800 (PST)
Message-ID: <697372f1.df0a0220.291d22.85ee@mx.google.com>
X-Google-Original-Message-ID: <aXNy7at2k-Am3Kj6@Ansuel-XPS.>
Date: Fri, 23 Jan 2026 14:09:01 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 0/3] net: phy: as21xxx: toggle In Band
 feature support
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
 <aXNmrVgpzvPwoyL1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNmrVgpzvPwoyL1@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252842-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: C4E9D76230
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:16:45PM +0000, Russell King (Oracle) wrote:
> [Please note: gmail.com has become unreliable for email delivery,
> google has too much power to decide what is spam and what isn't, with
> no route for appeal. please consider switching to a different email
> provider.]
>

Thanks for reporting this. I'm also noticing for a while some legit
email from mailing list going to spam. I have a new mail from a long
time but never took the time to actually made the switch for kernel
submission. Also it's mostly new so I guess it needs to earn some cretis
as it will get directly rejected by some service. Chicken Egg problem...

> On Fri, Jan 23, 2026 at 01:00:28PM +0100, Christian Marangi wrote:
> > This is a new variant of the previous submitted patch adding a similar
> > feature.
> > 
> > Old Aeonsemi Firmware permitted only to enable or disable In Band
> > support and it couldn't be disabled after (or there wasn't a
> > way to detect the current state of it)
> > 
> > As suggested by Russell this was bad Implementation. Some talk
> > with Aeonsemi permitted to release a new firmware with correct
> > implementation.
> > 
> > This series adds support for this if new firmware (1.9.1+) is
> > used. On the new firmware, 2 new IPC command are introduced
> > to GET the current state of DPC RA (Rate Adaption) or SET it.
> > (DPC RA is effectively In Band mode)
> > 
> > It was verified on the same scenario and can confirm it works
> > as expected. (Airoha AN7581/AN7583 with and without In Band
> > mode) (If PCS is set to In Band and PHY isn't then no
> > connection, so it's easy to verify correct functionality of
> > this)
> > 
> > The new firmware is currently submitted to linux-firmware
> > awaiting it to be merged.
> > 
> > For old firmware to save on compatibility we still enable
> > In Band by default (this is what the current driver do)
> > 
> > This was discovered to be needed in some scenario as is effectively
> > the most compatible featureset.
> > 
> > On a BananaPi R4 Pro, one of the 2 AS21xxx PHY is connected to
> > one of the Switch port and such switch supports only In Band when
> > set to USXGMII (assuming the Switch expect an SFP module to be
> > attached where in absence of i2c or MDIO line In Band is always
> > required)
> 
> Coupling the PHY's rate adaption with inband support, but not setting
> phydev->rate_matching anywhere in this driver seems wrong, and highly
> suspicious. I'm not sure what to think given what you've said above,
> it just seems completely wrong what has happened here.
> 

Honestly speaking the Rate Adaption thing is what I found in some
strange API c code on the downstream driver where they say that in
DPC_RA RA is Rate Adaption.

My personal idea is that, that thing toggle also other stuff and not only
Rate Adaption.

On the Airoha PCS In Band is controlled by enabling and disabling AN
register (and this also apply to Mediatek PCS)

With AN enabled, DPC RA needs to be enabled or no traffic.
With AN disabled, DPC RA needs to be disabled or not traffic.

This both apply to Airoha and Mediatek PCS.

For the Switch, it's a different story. Everything is controlled by a
Firmware blob and it's only possible to send command to setup the
Serdes mode (USXGMII in this case)
I made lots of test with forcing speed or trying to find a way to make
it work but the only combo I found working was USXGMII + DPC_RA enabled.

For the lack of .get_rate_matching should be set to RATE_MATCH_NONE
AFAIK for this PHY.

To give more info comments in the downstream driver at dpc_ra_enable
have "Set USXGMII mode.".
But I verified that PCS at USXGMII (but no In Band) and DPC_RA off
I have correct link up and traffic. So it's not dropping to 10g base-r
somehow with DPC_RA disabled and if it was the case the PCS should be
configured for that mode (there are specific register for that).

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

