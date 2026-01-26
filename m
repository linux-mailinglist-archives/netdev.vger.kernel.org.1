Return-Path: <netdev+bounces-253566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEnYGYmyd2l2kQEAu9opvQ
	(envelope-from <netdev+bounces-253566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:29:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64068C172
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1B2301DEFF
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032833081D2;
	Mon, 26 Jan 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1oXHcVOE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232A4F881;
	Mon, 26 Jan 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452164; cv=none; b=buLef1AkdMhEwTcTfp+PDDakQVuZ+78becE7jn/Hm/p5R4anNtub/SIkT5KS4u1jXHJ3hzSy1AyHPDJ/Umed83A1yeRlSB6t7Wf59YbeguoWit4AP3MDf66faHBiF8T4JcXIm2fcWdiSL3D3B98iQ8+AHK+vFoHkI7lZU0ghnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452164; c=relaxed/simple;
	bh=RpY/a3YOkPpZowN8J50+3W3QyIgU7NGF+rNzgR3E4L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A70Cb/yafgVVeYOd/jzicZChr/y55Fj8SLyYAsKq+/szdzpLwA9mevuitLWb/u/g3Epsn39a36IEK4Q7yTI0TOuIWWxBvcAT6QdeSLWGb3CfX3qvYLN9Ze9768cIprpNyQ6w5aKkeVmpYnzkcr6BkgQTRgdwbxuEOHPQAR/iDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1oXHcVOE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qh2+4EAwmLQeQZACP33br3DlT9jNVGAtBcqIW3K6GBY=; b=1oXHcVOEbBsPeKtD7teuUoyUKA
	rEBoh0VAB/JUFwdTHamwVXxwBqSyg+KkaZ322sjhe0tRa2s7gqMStIkRCsySN7cZA88CYuQcsSHcC
	j+TqI2EKxYDKw1sNcGyXmSgoTZXLfKB32XKFjCtebURP5xz4/EEQyoTsQwric7NIr0IyMg97NRH5Y
	v+FcwuOtnXLHiujV4gsTpe3Hmt/e8M9mUR5dZFRTH42BRUeA/DlcylNQGh2GVhWuy+m+QMtUSl6ik
	w4uHLniv9u0Vqhat1i6uZLKRlsN0UazPmmom41ZzD8iCUNRvSJFj15FQw+6nX2T4rG7lZK0J1cKuP
	n20j5Y7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkRKr-000000005Ew-2moS;
	Mon, 26 Jan 2026 18:29:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkRKn-0000000059Q-1LXH;
	Mon, 26 Jan 2026 18:29:09 +0000
Date: Mon, 26 Jan 2026 18:29:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Min Lin <linmin@eswincomputing.com>
Cc: Bo Gan <ganboing@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <aXeydXuWEMDz-yVM@shell.armlinux.org.uk>
References: <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
 <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
 <009aefc4-fbc9-4f91-9230-23d18c281bf3@gmail.com>
 <73ea5619.2b71.19bf847c80d.Coremail.linmin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ea5619.2b71.19bf847c80d.Coremail.linmin@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253566-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,eswincomputing.com,vger.kernel.org,davemloft.net,google.com,redhat.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: D64068C172
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:10:12AM +0800, Min Lin wrote:
> Due to chip backend reasons, there is already a ~4-5ns skew between the RX
> clock and data of the eth1 MAC controller inside the silicon.

Let's analyse this.

	TXC / RXC	TXC / RXC
Speed	Clock rate	Clock period
1G	125MHz		8ns
100M	25MHz		40ns
10M	2.5MHz		400ns

The required skew for TXC and RXC at the receiver is specified to be
between 1 and 2.6ns irrespective of the speed. The edge of the clock
is also important: the rising edge indicates the lower 4 bits, and
the falling edge indicates the upper 4 bits.

At 1G speed, with a "4 to 5ns" skew in the chip. If this is accurate,
then inverting the clock and adding 1ns of additional skew by some
means (PCB trace, or at the MAC or PHY) will give the required clock
at the receiver.

The timing table in the RGMII standard (3.3) allows for Tcyc (the
clock rate) to be scaled, but there is no allowance for scaling
TskewR (the required 1 to 2.6ns skew.) This skew parameter is
fixed.

So, at the other speeds, you are completely unable to meet the timing
specification, whether irrespective of the clock inversion. In effect,
the only speed that you can meet the specification is 1G.

Thus, I think this is something that needs a lot more than just "do
we need to invert the clock". You also need to prevent 10M and 100M
being supported IMHO.

I can't get my head around why someone would come up with this crazy,
crippled design, but maybe they didn't bother reading the RGMII
specification and ensuring that their design met the requirements
before implementing the hardware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

