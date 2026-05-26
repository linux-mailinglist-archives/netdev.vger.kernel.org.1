Return-Path: <netdev+bounces-291830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCE+L0DRFWrwcQcAu9opvQ
	(envelope-from <netdev+bounces-291830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C15DA39D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4474F31956CC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8A3128BE;
	Tue, 26 May 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nBpiCCOk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9A1EB1AA;
	Tue, 26 May 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814204; cv=none; b=mqimjYD1tTWg5wG0UYlIhpuWV5k0zx/TEupjmX2a6dVU3uhIiTh870+ldpBWimM0HYXHLM4OsbWgoGggZXYy90SH6c/HaoM7PdQBNxzZRLxnjNp6bg98yd4bZ7wPQRctdXo5ur0DprCpnN7qWEklABB6lpyu8xvrEWFNcTbbSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814204; c=relaxed/simple;
	bh=6OwfhXDtptNG7eJPnkRPF0v1FaZQrgIO8DziUJhG23U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOcu6ltE76ruJrsX1SJTlncXFYC5vek1Rp947W6fNryLdhkTAQ13P1sWRyzQOUz24M+NKwYMounwXgawGLW17NelIe60m6siGI5pwVfmrPRyApYezphF79q2be9rY1AAA4oX+W/sYiKJ/4tbI6rOR2I2NKLC08Q5fzgzWqcTDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nBpiCCOk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=unmmu2yv+CEfRBzA4w8Nl5ZJwrqsCFe4zUedZ/vS0hI=; b=nBpiCCOkf4FzASIWYSd4CvSq1b
	45TkaPRK8BOO2Y12BPOvbwBN+zpYCPd8rXh1bAeNgD0NyQrRQe4tM5yohWfptITTi5BM3c2tL/REc
	CaUj+KSySLbzcswFlK2fSBnarciEi2VlZEMifA2kjwtiJCHn4vPPLRJIBXZg72HGQrek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRuyX-004cNf-BF; Tue, 26 May 2026 18:49:53 +0200
Date: Tue, 26 May 2026 18:49:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
Message-ID: <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526154054.19829-3-thangaraj.s@microchip.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291830-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 313C15DA39D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:10:54PM +0530, Thangaraj Samynathan wrote:
> Enable RMII interface in the lan743x driver for PHY and MAC
> configuration.
> 
> - Select RMII interface in lan743x_phy_interface_select().
> - Update phylink supported_interfaces and MAC capabilities.
> - Enable RMII via RMII_CTL in lan743x_hardware_init().
> - Define RMII_CTL register and enable bit in lan743x_main.h.

> +	case PHY_INTERFACE_MODE_RMII:
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		adapter->phylink_config.lpi_capabilities = 0;

So EEE is not supporting with RMII? This is not mentioned in the
commit message.

Humm, is this an 802.3 limitation, or a limitation of this hardware?
If this is 802.3, then this should be in phylink, not drivers.

	Andrew

