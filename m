Return-Path: <netdev+bounces-266671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJEHAMCEsWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:05:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0F265FD7
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E4173138E01
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D72364050;
	Wed, 11 Mar 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qahkyRTV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257D3246EB;
	Wed, 11 Mar 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241202; cv=none; b=ZHYnYI9oY5O9hzY5C+xwj0Jg37/blhS3Ozq+PhP9x0DobzBiyuKg005/pcpqYAv5PbrHBXShr1/iVdpkwtPL/0L5M/qZd+I0kZTKcLO3vcN3wxCzs9I0PJbA1cd5NAfwKOt/nyn3JcTMkdQmnoOssYQoDKCxgFQ35CblXJjbeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241202; c=relaxed/simple;
	bh=mskJaBrWKFkArRgLK+cACtLT+GiY2ZwjdmGfHirXF5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET1GU6n7je9eN2ZPsIxm996VDr6XhMaub8oTLJVquiyoyMV1Qoq5ENS6pJOLvRQAWGw3vSIfmfWYebMeKrYNaFhFMyD+EoQAuB2UXUXtWqc1RNtdmk37OO1j1SDVLZ4FVVXJn3t5EyfGpwTwhFTru0V9NsAdMnn9ccYINUH7s7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qahkyRTV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xPwJgKN6+i2fkhgWXr9ssxGXQOB/c1Bb1Dhnaw7Q/H4=; b=qahkyRTVDsacLrl04M9RmIhn9+
	OI8AZhjjI7pA/18IdUzUXeoQElePPdxJ0w2FDm4PUH1V/2HFfFBEChw2FW3UUOZcXK2lYEHf6DLj9
	Ur2LAWPmWH+ZNt2eNvKvb6FWqhZ3vnX40FHWgPQ+3dqAs1aIfH/MjN9GzT6m2RI3Ib/+o4Z+A4370
	N0RZfcWd6ytwDx6xHQ5bM7xcU0QrSU56uCFhWdADUSD9tjrbhqbHT+P4stpHVujnTPzI8tS/leGDt
	AZnKX3isTUVs1jLxVXdNB3rDcGG2aRGhIa5+VTt38eyUguDZuQNWJ5HQcIPIawu7AxXmaXzZDOnN7
	rgrbzAkA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49286)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0L2T-000000006Wc-1bGq;
	Wed, 11 Mar 2026 14:59:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0L2R-000000006K8-1Qog;
	Wed, 11 Mar 2026 14:59:55 +0000
Date: Wed, 11 Mar 2026 14:59:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 02/15] net: stmmac: helpers for filling
 tx_q->tx_skbuff_dma
Message-ID: <abGDazGzEPAso5gm@shell.armlinux.org.uk>
References: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
 <E1w0GEg-0000000CiSj-2CVA@rmk-PC.armlinux.org.uk>
 <98307b59-c22d-43a6-83a6-ff551941898e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98307b59-c22d-43a6-83a6-ff551941898e@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266671-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.913];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 2CF0F265FD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:57:13PM +0100, Andrew Lunn wrote:
> On Wed, Mar 11, 2026 at 09:52:14AM +0000, Russell King (Oracle) wrote:
> > Add helpers to fill in the transmit queue metadata to ensure that all
> > entries are initialised when preparing to transmit. This avoids clean
> > up code running into surprises.
> > 
> > For example, stmmac_clean_desc3() (which calls clean_desc3() in
> > chain_mode.c or ring_mode.c) looks at the .last_segment, and in the
> > latter case, .is_jumbo members.
> > 
> > stmmac_tso_xmit() was also a problem. If the metadata is not fully
> > cleared when cleaning dirty entries (or, in the case of resume,
> > freeing all entries) then .last_segment may be left set, which then
> > causes:
> > 
> >         stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
> >                                    tx_q->tx_skbuff_dma[first_entry].last_segment+,
> >                                    hdr / 4, (skb->len - proto_hdr_len));
> > 
> > to mark the
> 
> That sentence appear to be unfinished.

Hmm, it's also not relevant anymore because we fixed that problem in a
different way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

