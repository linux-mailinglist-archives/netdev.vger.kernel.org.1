Return-Path: <netdev+bounces-282383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KxOCVIB8mmElwEAu9opvQ
	(envelope-from <netdev+bounces-282383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:02:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833B49467D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17ABB3007BA7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8AE3FB071;
	Wed, 29 Apr 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AKCs1K1W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE43FA5EA;
	Wed, 29 Apr 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467719; cv=none; b=ICZPyPDy8dINa3QmtSTOkTY/ZQJV0u6Uch9qcfeCO70Rtl6r/BU9OfPJu/tTfFNwJWYdTgfxPRUbOgIjMYTQCF9lMA+bkypx4YpkYCahT10eeGvOnu2jRkqryvlTMQptvAqtr0exsN+Dh0S/tmlQEfi06/Ty5N9j1ZQkjPUGa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467719; c=relaxed/simple;
	bh=PkzRrff07UI/la/r11aryFM5Z/CUrRYskJIC28a3/5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPPJVIVM2N3d6AN4C2xxvmlJ/mmqXAdF8MLKni8Iy/GmjDB/qgqTFAzbchgxXsjrxByfU7Jq2ZX2SkttrBfAbN69SgABpws7sIKffQ1BUUychxOoYM+vSamrRF+UqKW5l5MKyHzsyUcaNDxvUJ8tgLc9mh35nLXAt7s6yUdOk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AKCs1K1W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4j5nG6uFXhxeZRIedLLtoZz6H4p5Bh5dieLtLtEdzjI=; b=AKCs1K1WafywHsRMPpih37HAgi
	OZ/hDsNhfmt3TykUTldgj91ThMdzRc4+Nt72Dqx3ranUpmEL9jsEDoo1ckJQgqX9xyCf2v3hyQiHa
	YE52v9jhDyqfF0qgWTvXiv2dZB0fEULUZfKlLt41fLJxMn4x/DtOCVcK4ku0O+72fOHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wI4Xo-000X88-Eq; Wed, 29 Apr 2026 15:01:36 +0200
Date: Wed, 29 Apr 2026 15:01:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 4/4] r8152: Add firmware upload capability for
 RTL8157/RTL8159
Message-ID: <376f2907-55c0-416b-8904-e61888feb3cd@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-4-52d03927b46f@birger-koblitz.de>
 <d9d69a5a-be6e-4566-9ec3-e742f745a530@lunn.ch>
 <877f67bd-6bd8-4d61-8f7b-d206b9125eda@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877f67bd-6bd8-4d61-8f7b-d206b9125eda@birger-koblitz.de>
X-Rspamd-Queue-Id: 2833B49467D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282383-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[lunn.ch:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Wed, Apr 29, 2026 at 06:21:58AM +0200, Birger Koblitz wrote:
> On 29/04/2026 3:57 am, Andrew Lunn wrote:
> > On Tue, Apr 28, 2026 at 05:47:24AM +0200, Birger Koblitz wrote:
> > > The RTL8159 requires firmware for its PHY in order to work at
> > > connection speeds > 5GBit. Add support for uploading firmware for
> > > the PHYs using the existing rtl8152_apply_firmware() function
> > > in r8157_hw_phy_cfg() and set up the correct names for the firmware
> > > files.

> No, since the RTL8157 (RTL_VER_16) also works in my experiments as expected
> without this change, i.e. without any updated firmware, or better the
> possibility to update the firmware. It is only for the RTL8159 where the
> firmware is necessary to even get 10GBit performance, at least for the
> link-partners I use for testing. My understanding of the Realtek "firmware"
> is that it mainly provides updated calibration constants, possibly better
> calibration routines for interoperability. Unlike for many other drivers,
> the firmware is not necessary to make the driver work at all.

O.K. Please could you expand the commit message. Explain why you are
adding code for RTL_VER_16 as well as RTL_VER_17.

	Andrew

