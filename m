Return-Path: <netdev+bounces-271330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDisNSYWw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:54:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D441D31D851
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4884E3001849
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433112E5B21;
	Tue, 24 Mar 2026 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sYrRafxV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B833D6C7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392844; cv=none; b=HdjRLajH4ItSlPlt7wTUZLsDSFSL9lTIA6h2Tm4QJB4F7bXQVPHN6h6M1GVwuFSkrxdukGeDCWqoE+FTce6Nmt5Hy0EVYiR4NINzbQzVjURQtR3JzpNdZmlJnx/4cfif4g8uauVuTQH3YesWwpAE5yzyFS82WejyYSbNOnvVtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392844; c=relaxed/simple;
	bh=ZyuZ9qoGqgdh9poTQRYTQAip35PttZSzvL7YWxUZhpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO055mFL0UqLcRAJlU9J4nX25RWzZGnx9YjDokGmjoYA9/Kjmmh5gnvSLosP2K/vPF3EoruIvrr7HaVyje56+Xa4kUBMZGcByDB5tARvtisRu/Na+MpKq1v9ejZnCB28WzaEggh9DOO8N4Cmf4NbncFCCr+EN40JUwPd1YYjNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sYrRafxV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QxAjp1qOIQ/krE7SDbSIFLiiWtI9H9h0ogzjwCrC7VE=; b=sYrRafxVZRZJCx8MjR6c3tFoVN
	E/imbQBgzAxnfbaudKWfjGSmQZNvLOksSofE+VJxZsKeqGd68OjCLp9uJsC5qv0ZKi2jApbnnW/0s
	20OLoMDW4QTXG9lqdgMOXNsH7q+Ri+0zD2WsFlyMN4Hk6ZdVIGrxXVo0rjL8EgNi7NU2jo6++hBKI
	Nh/Nb8wU7xHoqRVLIDZn4flj7HjeDWX8qIFDFv+/59UJ26/qw6h7ibOYJvgrGTxSv/mqgtFX3MvLU
	z9X6KMlXsjjZlpjBH21iXzfOg2HaMlWUpMetjAD1VN1hUSrn8vXhYlVyxDSNplikNAR0yvMV0oYVg
	ti7waniA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5AdL-000000002g0-0xgk;
	Tue, 24 Mar 2026 22:53:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5AdJ-000000005Sf-0xu7;
	Tue, 24 Mar 2026 22:53:57 +0000
Date: Tue, 24 Mar 2026 22:53:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <acMWBQ8rUm7lpr0h@shell.armlinux.org.uk>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <acKypS845fm_GB0o@shell.armlinux.org.uk>
 <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
 <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch>
 <acLtrOrZe0G89MBy@shell.armlinux.org.uk>
 <CAMsLQxFp4hFxTbjBswM3GqX+VsT9G2Y0uP_fDhQkbzJdhbLD2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMsLQxFp4hFxTbjBswM3GqX+VsT9G2Y0uP_fDhQkbzJdhbLD2A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,broadcom.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	NEURAL_SPAM(0.00)[0.079];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: D441D31D851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:59:02PM +0000, Daniel Wagner wrote:
> > Can you confirm whether bit 0 changes depending whether the PHY has
> > link. I don't know whether that's media link or host-side link, so
> > I suggest checking both.
> 
> Bit 12 does seem to track copper link state in my test:
>   [0s] 0x3107  bit12=1   carrier=1   plugged
>   [4s] 0x2107  bit12=0   carrier=0   unplugged
>   [19s] 0x3107  bit12=1   carrier=0   replugged, PHY sees it
>   [20s] 0x3107  bit12=1   carrier=1   phylib poll catches up
> 
> Bit 0 stayed at 1 through all of that, and through ifdown/ifup too.
> I'm not sure what it is, but it doesn't appear to track either link
> under the conditions I can test.
> 
> Bits[4:1] stayed at 3 through all of it: copper transitions, different
> copper speeds (1G, 2.5G), ifdown/ifup, on both BCM84891 and BCM84892.
> No USXGMII codes.

I suggest this is not the same register bit allocation as on
the bcm84881 in that case.

Also note that phylib's poll "catches up" because the link bit in
BMSR is intentionally sticky-down to ensure that link-down events are
not missed - if the link was down and then comes up, it intentionally
takes two reads to indicate link up to ensure that the link down state
doesn't get lost.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

