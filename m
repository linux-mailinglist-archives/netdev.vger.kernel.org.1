Return-Path: <netdev+bounces-269710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKCLNcN8vGmOzQIAu9opvQ
	(envelope-from <netdev+bounces-269710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:46:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB02D3A82
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64E5F3005141
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83936D500;
	Thu, 19 Mar 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xneEdz+d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DCF23505E;
	Thu, 19 Mar 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960382; cv=none; b=ZDPsHh190mAcCjw3EX2QvBLMRD7iofv0tFnJnLprDVqEdy7szdUF/VjM5InvQE/K2VgQR51eNzOgUaMg8lndek1ttnsV/fphzdvWDGnxjbV0gBoomcQclLR3bkMl5A8Xn4OaEuP+NOQOhrWDvvzqv85NspDjLsXhpEZ7zkOVjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960382; c=relaxed/simple;
	bh=BQxFj4D7wVPgpF2SbYyhRYvyvH8cSMuzTGIrXZUsklA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIPtuuQO4OCtcUuMclx8M2kCodkpf7LNnZeZ1TBJC0HWGFlNigBZlQDeUnDuHGmcirEXXg9DvPSE2fGTs7FUNPUoj/bFCKVtTNC1/nCBb6ys81jG1UXJOkOECgD5Q7RjVECBC6txrda47HdCsgRcc4bHZlQWSOuHAqmaDKmuGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xneEdz+d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QZM7F3XnooEdLLlxditRMwCf28sq4Ar6a/2urxkspC8=; b=xneEdz+dqk6F5eGtobGVak5BGZ
	vcRWlJvHIo5zDDguGIDOxMwIxY7l3eMd1yTc7ajkKG6AKqsBp65zqavYKIUOHghT+uHlXCzzaWc1E
	EF83uSmorI8T2BU7Lzur0VnwRPNqBLvdBMrMGxLcEQcwSUB0/ihZJ28HPq5XsgoqK2m4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3M7z-00CSsq-4s; Thu, 19 Mar 2026 23:46:07 +0100
Date: Thu, 19 Mar 2026 23:46:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Message-ID: <876af50e-320f-4cec-97c0-a7eb438dc838@lunn.ch>
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
 <2bfede0e-f8d1-472d-80c4-7c3570b5921e@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bfede0e-f8d1-472d-80c4-7c3570b5921e@wp.pl>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269710-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[wp.pl];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82FB02D3A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > @@ -604,6 +604,7 @@ enum spd_duplex {
> >   	FORCE_100M_FULL,
> >   	FORCE_1000M_FULL,
> >   	NWAY_2500M_FULL,
> > +	NWAY_5000M_FULL,
> >   };
> >   /* OCP_ALDPS_CONFIG */
> > @@ -725,6 +726,7 @@ enum spd_duplex {
> >   #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
> >   enum rtl_register_content {
> > +	_5000bps	= BIT(12),
> 
> Based on other Realtek chips, I guess that BIT(11_ corresponds to 2500 Mbps
> over two twisted pairs. Realtek calls this 5G Lite. Similarly, there are
> 2.5G Lite and 1G Lite, offering 1250 Mbps and 500 Mbps, respectively, over
> two pairs of wires.

Oh, that is different. Normally for a -T2 link, you double the clock
frequency, so you keep the normal bandwidth. But you are saying it
does 500Base-T2, 1250Base-T2, 2500Base-T2?

Can it select these modes on its own, if the link partner is another
Realtek device? Many 1G PHYs will detect if a pair is broken and
downshift to 100Mbps, which only require two working pairs. But this
device has the option of downshifting to 500M.

	Andrew

