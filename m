Return-Path: <netdev+bounces-282882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKtBOa1l82le2AEAu9opvQ
	(envelope-from <netdev+bounces-282882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763D4A3FE0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B691303029A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B503AEF59;
	Thu, 30 Apr 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TEnDmfpZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524F2417D1;
	Thu, 30 Apr 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558782; cv=none; b=iOuDCR8Iqk2oB8/1bRLDrVm6Mf0O6aWAFuB33IKBo2J0TBVp1uASI/6713Fq1pNdTKsAb+tDkbVHNeUJpPbFXFwsV3tP2VSrb9DbUcTKYHcC9LBJ7Ag4H7mo2jeCN7jZUaGKeXEBXI4Sc3OjoY1pJ8KaJbQ36U8gatybBn1VoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558782; c=relaxed/simple;
	bh=AWX9jAGWykXF91wY2ndunvZcL/XLos2lreupCLe9wis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmtXOcp59uKpDHjO86iIvI5uFI5PLiSgWHx0LNWz+Yguh4HHspS2witv8GD9j4GwanT354/yBZxdLNzHrQlZI0JYAHmyhL8IQVIq6bwhcP95Re8dE3mMKrqiLXYlQkR9FAx5UjqboRQ5mWhecVeA+oihRCzIjts3Gps3C0AisnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TEnDmfpZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zsgPDUbJfBPKH1Tuq2IW5151E1Ba4vIY34mQtMpCrU0=; b=TEnDmfpZooRRGOy812VdIZR9fV
	jmDGZTHBQ5xuWaQj7u3U+nHcwU092ow3Ur6DeL9hkFJrl8Jf4uVl1lZY5+d8BT5fG29TUgvqf7FdK
	g3BLv6VzxS/rP2FbI2ydIAyGpscJR3E6PhVk2f+qU71AsqG769xJRa6BdwvhkEvMya+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wISEk-000h0e-Gf; Thu, 30 Apr 2026 16:19:30 +0200
Date: Thu, 30 Apr 2026 16:19:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Message-ID: <fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
 <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
 <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
 <20260429200214.3e8dee67.michal.pecio@gmail.com>
 <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
X-Rspamd-Queue-Id: 4763D4A3FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,realtek.com];
	TAGGED_FROM(0.00)[bounces-282882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> Also, I only see the issue on slow 5GBit USB-C connections, sometimes with
> the RTL8157, basically every time with the RTL8159, and so far never on a
> 20GBit USB-C connection, so the mitigation is probably some kind of
> interrupt coalescing.

Do you notice any latency changes with this setting in place? Or CPU load.

ping can be a good measure for latency.

If this is interrupt coalescing, it normally means don't interrupt as
soon as one packet has been received. Delay the interrupt, so there
are likely to be more packets in the receive queue. The cost of the
interrupt handling is then spread over a number of packets.

If this register setting is disabling coalescing, you should see the
latency go down, but the CPU load go up.

If you are getting interrupts after the device has been disabled, i
guess it is because the timer for a delayed interrupt is not cancelled
by the firmware. If so you might be able to work around this firmware
bug. Disable the receiver, sleep for 10ms but keep processing
interrupts, and then continue with the tear down.

	Andrew


