Return-Path: <netdev+bounces-259731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL7xExx7mGnlJAMAu9opvQ
	(envelope-from <netdev+bounces-259731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:17:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A61DC168D2C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F2F30214FB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB1244685;
	Fri, 20 Feb 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NJZqgZ8E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93F86353;
	Fri, 20 Feb 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600665; cv=none; b=JFa3qOtjs1OSz1FjPFmEEQz6mDbTEiRTv7bnomIGxdBnc53lOzqJ/9ICXBos3WEAt8zMYo188eth0vRmk//ZGON0/dx1GeVdlDU1KgEMz84cKy9KVKISZk6whTmnBlH/NiFK/NkOZr+Kt3X66QACtgEH10/JMTf++0r7K/0I5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600665; c=relaxed/simple;
	bh=S5yqVoSFWzyKV6qIPpnAwdJ1wh4eM9kFJTFyktgoSZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOjzTvaQ1yUJzu8PiJsI3Enmc8hwSy5gthpPQjfplLuvS2gxAPKfaCE2wgAhIoaNkXZkbPBetkoRGscq/S5BKFVEqDsC7hEq7xH2UzpRul5LeHZ6tgeA5gebWgiCr8XN/R/sdLi5BikQ7v9f05pd+cBPL2ReXaRaefDJ+uCiXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NJZqgZ8E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lH4duYsaZSQVbMs3WsjXwb9YxquF/KuGSsr/5eOxwGU=; b=NJZqgZ8Ey8H+Fg/5D1Kp+ZXSIo
	uZ949lJLGr9R1H8rE/DDug+gFF9PeU38GX7xbRpz2XSNsuzh5Mc9frjeukUiY5wN9v8farbMwU7GB
	6vt/9+I2XGr4ZZQR7ZhiJZzFGXYoBbWzyUHsA/436hzdgFgbaSCni55/A6NG5jMcQFfc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtSG9-0085QI-2a; Fri, 20 Feb 2026 16:17:37 +0100
Date: Fri, 20 Feb 2026 16:17:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [RFC PATCH 6/8] dt-bindings: net: Add PTP interrupt support
Message-ID: <c9d50d6d-2a3b-443d-94a7-d6930ff15316@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-7-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219054911.2017362-7-srinivas.neeli@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259731-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A61DC168D2C
X-Rspamd-Action: no action

> +      interrupts:
> +        minItems: 1
> +        maxItems: 4
> +        description:
> +          Interrupt specifiers for MAC interrupts. MAC 1 (with PTP support)
> +          requires 4 interrupts (ptp_rx, ptp_tx, mac_irq, ptp_timer).
> +          MAC 2 (without PTP support) requires 3 interrupts (ptp_rx, ptp_tx, mac_irq).

You say 3 or 4 are required, yet have minItems: 1? 3 seems more
appropriate.

You have restraints later, so i don't know if these are even needed
here? I will let the DT Maintainers comment about that.

	Andrew

