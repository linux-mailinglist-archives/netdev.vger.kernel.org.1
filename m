Return-Path: <netdev+bounces-298646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1BbJGhIALGpOJQQAu9opvQ
	(envelope-from <netdev+bounces-298646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:48:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B69679790
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="Nszp83T/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298646-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298646-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EE903006102
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF553E275E;
	Fri, 12 Jun 2026 12:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98143D88E5
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:48:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268495; cv=none; b=UapZZfpdvGACL83cun5+yOCoyooU/WlaiLZlVIoK1IRMtuQnUKjchXfeIBFJW1PaNIF3duycn9ov7aXUl28qE7K1IgSFEdE6iUZ+yANyu7a8hgd3sDGWC1J2UbDf9efuN8yH/X22pZvoNks3ZaAv4WiD/Uo8tXV0TRwLeQx6628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268495; c=relaxed/simple;
	bh=dgrH4tibqRVzcaGG9HYebar2uYlaqeZqMgjLUv7K3Nc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1qkR83T/MndAQnIvMLsaU1tz3Si4WQqDTGTMWShcfgwPHYMsIhgP9YwSWgZD9cKXtCCRTwFXDFDmTgPv9TmxYV/97odnzxcFNIXQvaxCEXGzCzmxoPyM72CxZUEf5aX1S/S0bQrLVvkit/msU5M0DUq/Si4i5NNdXNcWJzznTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nszp83T/; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so9857875e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781268492; x=1781873292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X07QRTXhx7twtU7TUj4+VDEon2lHZrzRNetg8L7gZYk=;
        b=Nszp83T/JFptBIT/pJYa7yE64kCuWUYyJ279vGA2M54E/7ySA8GeJN3587SRuV7yeF
         4zYpPKIsdfGNny3HuIoMZCf8RbEVSZqcpo164kNAqqpnjNPAsCXR/AjsQlOTw++M7VJj
         H/mUGq0M5U+6WlaovVaBZT+2i5ye6Y/QPVMrDVWbZXEtjo4Pk1JocRgrC80iRND93iTJ
         VtdOMTlMW/wozTCjdGBnR5iEUrlQJ5bamEFqeb+u6rBe+x/bd+wgxlJRHuxsGB5k1xBn
         CIwwngJu69og3dBbYnDh9cStSmU3p69Tgf8Q1dUcTU5bAIXJM/ZHRqMztTfVYbH6eGJ+
         h5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268492; x=1781873292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X07QRTXhx7twtU7TUj4+VDEon2lHZrzRNetg8L7gZYk=;
        b=c/hH1o7UUtES7d/sXqTZGK9LCNIGhx1MveOPv4Po0A28pysQV5C7HPRJfRxOdKV3IK
         hIumPlwDzp1K/6jpJW6FSmY6pGZy9npJY+nbEsshZSDzC3UpV0cyCvj8BrwhoHcfPlum
         eWaggD6ik2ilvMLhEojvwbYnoSsLbu31Wy77HxwEkGuKa/h4S4gANG/x0TPYRBHpp66H
         wMkLcfJ9RS7LHxQwhT8D950pwP4PSmWJA9AFqae+sYTnaMFmFHCFD/05l0Z5shoR/sgj
         casCZpZ/rBfQw+pub4meEh3N2JFJRsxGZUy0nrtY3F7sS32UOywJzxXqL3/JlOWZNiMJ
         LJOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dqq8/rO+3kgsaJrhWxWW2nkhKTOFFwcunniY6R2ff91QWc8qx4gRfvwnNE0FheSO1bmrxQBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCMlX9oNKLHcgDE6nvTpUljuigACb+QkxPwargx0L29JZR+eJ
	zr786CYZjPbwenK+LB9KDF9TI2JUR7PyV8c8Pk0JP4rT7J2fYRgvqe9uBIqnni1ROgw=
X-Gm-Gg: Acq92OH2pLFGL9Tl3sr5CbJfnAne09Ve0/3o7AKknsV5a99rnQ5xU6QVHgCZYaAaXK6
	5W+Ymz7E3twmTBrrZ6tobO/WHhIOC9i/1lL3JKMEZaVzDsq7JksPR09GZgD+xlywCEjJEBALJe0
	krea5O1eFRAchQP31QzuNkec9bY5M+NbNhGpcN1CqLg4XTOlpMkWXQjNgcnOyWxU9Y98VVZu0Ev
	EWRiksl1OOT1BLOyGC431RpMfpw7vEyVzBxgZR5/c0A9i61SFUWiOPsKNPFKZR53eXvoxINQdl6
	V+pGnK8fr+z8sc9N5MkKnNr4h6Vj6eKO5sSzfukzq61N4+u1rW9pkNdUo/BY1XQgCz2h+I8+y6a
	YTL0MeenUmn55CGGeaS1F0gwDTPjJpiK3XPJ4wMkvvRWfYpDzggVYgdHidnQXkWFm5dc9AvL4El
	JKtGvX9lg/QN+HgTUnpZL4
X-Received: by 2002:a05:600c:e547:20b0:490:b58b:a8ca with SMTP id 5b1f17b1804b1-490ec50c366mr24147355e9.27.1781268492311;
        Fri, 12 Jun 2026 05:48:12 -0700 (PDT)
Received: from localhost ([195.94.146.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm5705651f8f.27.2026.06.12.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:48:11 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 12 Jun 2026 14:51:33 +0200
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrea della Porta <andrea.porta@suse.com>, netdev@vger.kernel.org,
	Theo Lebrun <theo.lebrun@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Lukasz Raczylo <lukasz@raczylo.com>,
	Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover from
 lost TSTART write
Message-ID: <aiwA1dD-qXcT3hds@apocalypse>
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
 <dbc25b24865a1ad92555bc826bef4267@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc25b24865a1ad92555bc826bef4267@tipi-net.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:andrea.porta@suse.com,m:netdev@vger.kernel.org,m:theo.lebrun@bootlin.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:lukasz@raczylo.com,m:sjaeckel@suse.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:dkim,suse.com:email,suse.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6B69679790

Hi Nicolai,

On 14:23 Fri 12 Jun     , Nicolai Buchwitz wrote:
> Hi Andrea
> 
> On 12.6.2026 11:01, Andrea della Porta wrote:
> > From: Lukasz Raczylo <lukasz@raczylo.com>
> > 
> > The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> > the TX queue.
> > While the exact root cause is not yet fully understood, it is likely
> > related to a hardware issue where a TSTART write to the NCR register
> > is missed, preventing the transmission from being kicked off.
> > 
> > Implement a timeout callback to handle TX queue stalls, triggering the
> > existing restart mechanism to recover.
> > 
> > Link:
> > https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.com/
> > Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi
> > RP1 ethernet controller")
> > Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> > Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
> > Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
> > Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c
> > b/drivers/net/ethernet/cadence/macb_main.c
> > index a12aa21244e83..615da65d5d68d 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -4522,6 +4522,16 @@ static int macb_setup_tc(struct net_device *dev,
> > enum tc_setup_type type,
> >  	}
> >  }
> > 
> > +static void macb_tx_timeout(struct net_device *dev, unsigned int q)
> > +{
> > +	struct macb *bp = netdev_priv(dev);
> > +
> > +	if (net_ratelimit())
> 
> Do we need the net_ratelimit() check (and message) here? AFAIU the watchdog
> core already prints a message for every timeout.

Correct. I'll drop those two lines.

> 
> > +		netdev_err(dev, "TX stall detected, re-kicking TSTART\n");
> > +	dev->stats.tx_errors++;
> > +	macb_tx_restart(&bp->queues[q]);
> > +}
> > +
> >  static const struct net_device_ops macb_netdev_ops = {
> >  	.ndo_open		= macb_open,
> >  	.ndo_stop		= macb_close,
> > @@ -4540,6 +4550,7 @@ static const struct net_device_ops macb_netdev_ops
> > = {
> >  	.ndo_hwtstamp_set	= macb_hwtstamp_set,
> >  	.ndo_hwtstamp_get	= macb_hwtstamp_get,
> >  	.ndo_setup_tc		= macb_setup_tc,
> > +	.ndo_tx_timeout		= macb_tx_timeout,
> 
> The commit message describes it as RP1 specific, but it gets applied to all
> other variants?

I've seen this issue happening only on RaspberryPi 5, but AFAIK it
could affect also other MACB blocks connected through PCIe, so it
may be widespread (even though it should have probably already been
noticed in the past). In the orginal driver there's no timeout callback
defined and this is much like pretgending the issue causing the timeout
to happen to go away without doing anything (whatever the cause ot the
specific hw are). So in my opinion we can just extend that to all MACB.
Or maybe we should execute the restart conditionally on 
.compatible = "raspberrypi,rp1-gem"?

Thanks,
Andrea

> 
> >  };
> > 
> >  /* Configure peripheral capabilities according to device tree
> 
> Thanks
> Nicolai

